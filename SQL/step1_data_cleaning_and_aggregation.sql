-- Step 1: Clean and standardize patient registration data
WITH cleaned_healthtail_reg_cards AS (
  SELECT
    DISTINCT patient_id,
    owner_id,
    TRIM(owner_name) AS owner_name,  -- Remove extra spaces from names
    LOWER(pet_type) AS pet_type,       -- Standardize pet type to lowercase
    LOWER(IF(breed IS NULL OR TRIM(breed) = '', 'Unknown', breed)) AS breed,         -- Replace missing/empty breed with 'Unknown'
    INITCAP(patient_name) AS patient_name,
    gender,                              -- Capitalize patient name
    -- Categorize patient age into age groups
    CASE
      WHEN patient_age BETWEEN 0 AND 1 THEN "0-1 age"
      WHEN patient_age BETWEEN 2 AND 4 THEN "2-4 age"
      WHEN patient_age BETWEEN 5 AND 10 THEN "5-10 age"
      WHEN patient_age BETWEEN 11 AND 20 THEN "10-15 age"
    END AS patient_age,
    REGEXP_REPLACE(owner_phone, r'\D', '') AS owner_phone_cleaned  -- Remove non-digit characters from phone numbers
  FROM `healthtail-460009.healthtail_m_g1.healthtail_reg_cards`
  WHERE patient_id IS NOT NULL AND owner_id IS NOT NULL
),

-- Step 2: Aggregate visit-level data by patient
visit_details AS (
  SELECT
    patient_id, diagnosis as diseases,
    med_prescribed AS med_name,
    EXTRACT(MONTH FROM visit_datetime) AS visit_month,
    COUNT(DISTINCT visit_id) AS total_visits,      -- Total number of visits
    COUNT(DISTINCT doctor) AS unique_doctors,       -- Number of different doctors seen
    SUM(med_dosage) AS total_dosage,           -- Total dosage cost across visits
    SUM(med_cost) AS total_med_cost            -- Total medication cost across visits
  FROM `healthtail-460009.healthtail_m_g1.visits`
  GROUP BY patient_id, diseases,med_prescribed, visit_month
),

--Create stock-in records (medications purchased)
stock_in AS (
  SELECT 
    EXTRACT(MONTH FROM month_invoice) AS month,
    med_name,
    ROUND(SUM(packs)) AS total_packs,
    ROUND(SUM(total_price)) AS total_value,
    'stock in' AS stock_movement
  FROM `healthtail-460009.healthtail_m_g1.invoices`
  GROUP BY month, med_name
),

--Create stock-out records (medications used for patients)
stock_out AS (
  SELECT 
    EXTRACT(MONTH FROM visit_datetime) AS month,
    med_prescribed AS med_name,
    ROUND(SUM(med_dosage)) AS total_packs,
    ROUND(SUM(med_cost)) AS total_value,
    'stock out' AS stock_movement
  FROM `healthtail-460009.healthtail_m_g1.visits`
  GROUP BY month, med_name
),
--Create monthly revenue
med_monthly_revenue AS (
  SELECT
    med_name,
    EXTRACT(MONTH FROM month_invoice) AS month,
    SUM(total_price) AS total_revenue
  FROM `healthtail-460009.healthtail_m_g1.invoices`
  GROUP BY med_name, month
)

-- Combine all patient data into a flat summary
SELECT
  c.patient_id,
  c.owner_id,
  c.owner_name,
  c.pet_type,
  c.breed,
  c.patient_name,
  c.gender,
  c.patient_age,
  c.owner_phone_cleaned,

  vd.visit_month,
  vd.diseases,
  vd.med_name,
  vd.total_visits,
  vd.unique_doctors,
  vd.total_dosage,
  vd.total_med_cost,

  si.total_packs AS stock_in_packs,
  si.total_value AS stock_in_value,
  so.total_packs AS stock_out_packs,
  so.total_value AS stock_out_value,

  COALESCE(mr.total_revenue, 0) AS med_monthly_revenue

FROM cleaned_healthtail_reg_cards c
LEFT JOIN visit_details vd
  ON c.patient_id = vd.patient_id
LEFT JOIN stock_in si
  ON vd.med_name = si.med_name AND vd.visit_month = si.month
LEFT JOIN stock_out so
  ON vd.med_name = so.med_name AND vd.visit_month = so.month
LEFT JOIN med_monthly_revenue mr
  ON vd.med_name = mr.med_name AND vd.visit_month = mr.month
ORDER BY c.patient_id, vd.visit_month;
