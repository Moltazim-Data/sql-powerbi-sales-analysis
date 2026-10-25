-- Run from the repository root with DuckDB.
-- Revenue is net of the illustrative line discount, before tax and shipping.
CREATE OR REPLACE VIEW sales AS
SELECT
  order_id,
  CAST(order_date AS DATE) AS order_date,
  region,
  category,
  product,
  CAST(quantity AS INTEGER) AS quantity,
  CAST(unit_price_eur AS DOUBLE) AS unit_price_eur,
  CAST(discount_pct AS DOUBLE) AS discount_pct,
  quantity * unit_price_eur * (1 - discount_pct) AS net_sales_eur
FROM read_csv_auto('data/sales.csv', header = true);

-- KPI summary
SELECT COUNT(DISTINCT order_id) AS orders,
       SUM(quantity) AS units_sold,
       ROUND(SUM(net_sales_eur), 2) AS net_sales_eur,
       ROUND(SUM(net_sales_eur) / COUNT(DISTINCT order_id), 2) AS average_order_value_eur
FROM sales;

-- Monthly sales trend
SELECT DATE_TRUNC('month', order_date)::DATE AS month,
       ROUND(SUM(net_sales_eur), 2) AS net_sales_eur
FROM sales GROUP BY 1 ORDER BY 1;

-- Category and region breakdowns
SELECT category, ROUND(SUM(net_sales_eur), 2) AS net_sales_eur,
       SUM(quantity) AS units_sold
FROM sales GROUP BY category ORDER BY net_sales_eur DESC;

SELECT region, ROUND(SUM(net_sales_eur), 2) AS net_sales_eur
FROM sales GROUP BY region ORDER BY net_sales_eur DESC;
