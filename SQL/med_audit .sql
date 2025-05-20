
WITH stock_in as (
  SELECT month_invoice as month,
 med_name as med_name,
 ROUND(SUM(packs)) as total_packs,
 ROUND(SUM(total_price)) as total_value,
 'stock in' AS stock_movement
 FROM `healthtail-460009.healthtail_m_g1.invoices`
 GROUP BY month_invoice, med_name
), stock_out AS(
SELECT visit_datetime as month,
 med_prescribed as med_name,
 ROUND(SUM(med_dosage)) as total_packs,
 ROUND(SUM(med_cost)) as total_value,
'stock out' AS stock_movement
FROM `healthtail-460009.healthtail_m_g1.visits`
GROUP BY visit_datetime,med_prescribed
)
SELECT *
FROM stock_in
UNION ALL
SELECT *
FROM stock_out

