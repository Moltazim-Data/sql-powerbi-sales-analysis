-- Run from the repository root with DuckDB.
-- Sales is the supplied line-level sales amount; do not multiply by quantity again.
CREATE OR REPLACE VIEW sales AS
SELECT
  CAST(OrderID AS VARCHAR) AS order_id,
  CAST(OrderDate AS DATE) AS order_date,
  Country AS country,
  City AS city,
  Category AS category,
  Product AS product,
  CAST(Sales AS DOUBLE) AS sales_amount,
  CAST(Quantity AS INTEGER) AS quantity
FROM read_csv_auto('data/sales.csv', header = true);

-- KPI summary
SELECT COUNT(DISTINCT order_id) AS orders,
       SUM(quantity) AS units_sold,
       ROUND(SUM(sales_amount), 2) AS sales_amount,
       ROUND(SUM(sales_amount) / COUNT(DISTINCT order_id), 2) AS average_sales_per_order
FROM sales;

-- Monthly sales trend
SELECT DATE_TRUNC('month', order_date)::DATE AS month,
       ROUND(SUM(sales_amount), 2) AS sales_amount
FROM sales GROUP BY 1 ORDER BY 1;

-- Category and country breakdowns
SELECT category, ROUND(SUM(sales_amount), 2) AS sales_amount,
       SUM(quantity) AS units_sold
FROM sales GROUP BY category ORDER BY sales_amount DESC;

SELECT country, ROUND(SUM(sales_amount), 2) AS sales_amount
FROM sales GROUP BY country ORDER BY sales_amount DESC;
