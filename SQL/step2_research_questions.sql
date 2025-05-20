  --What med did we spend the most money on in total
SELECT
  med_name,
  SUM(total_value) AS total_spend
FROM
  `healthtail_m_g1.med_audit`
WHERE
  stock_movement='stock out'
GROUP BY
  med_name
ORDER BY
  total_spend DESC
LIMIT
  1;
  --What med had the highest monthly total_value spent on patients?
SELECT
  med_name,
  EXTRACT(MONTH
  FROM
    month) AS month,
  SUM(total_value) AS total_spend
FROM
  `healthtail_m_g1.med_audit`
WHERE
  stock_movement='stock out'
GROUP BY
  med_name,
  EXTRACT(MONTH
  FROM
    month)
ORDER BY
  total_spend DESC
LIMIT
  1;
  --What month was the highest in packs of meds spent in vet clinic?
SELECT
  EXTRACT(MONTH
  FROM
    month) AS month,
  SUM(total_packs) AS total_packs
FROM
  `healthtail-460009.healthtail_m_g1.med_audit`
WHERE
  stock_movement='stock out'
GROUP BY
  month
ORDER BY
  total_packs DESC
LIMIT
  1;
  --What’s an average monthly spent in packs of the med that generated the most revenue?
WITH top_med AS (
  SELECT med_name,
    EXTRACT(MONTH FROM month) AS month,
    SUM(total_value) AS total_revenue
  FROM `healthtail-460009.healthtail_m_g1.med_audit`
  WHERE stock_movement='stock out'
  GROUP BY month, med_name
  ORDER BY total_revenue DESC
  LIMIT 1 ),
  monthly_packs_spend AS (
  SELECT
    EXTRACT(MONTH FROM month) AS month,
    SUM(total_packs) AS monthly_packs
  FROM `healthtail-460009.healthtail_m_g1.med_audit`
  WHERE stock_movement='stock out'
  GROUP BY month
  ORDER BY monthly_packs DESC
  LIMIT 1
   )
  SELECT (SELECT med_name FROM top_med) as med_name,
   AVG(monthly_packs) AS avg_monthly_packs
  FROM monthly_packs_spend













