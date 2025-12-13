-- SQL + Power BI Sales Analysis
-- Dataset: data/sales.csv
-- Notes:
-- - Works in DuckDB (recommended) and many SQL engines with small adjustments.

-- 1) Preview
SELECT * FROM sales LIMIT 5;

-- 2) Total Revenue + Total Quantity
SELECT
  SUM(Sales)    AS total_sales,
  SUM(Quantity) AS total_quantity
FROM sales;

-- 3) Sales by Country
SELECT
  Country,
  SUM(Sales) AS revenue
FROM sales
GROUP BY Country
ORDER BY revenue DESC;

-- 4) Sales by Category
SELECT
  Category,
  SUM(Sales) AS revenue
FROM sales
GROUP BY Category
ORDER BY revenue DESC;

-- 5) Top 10 Products by Revenue
SELECT
  Product,
  SUM(Sales) AS revenue
FROM sales
GROUP BY Product
ORDER BY revenue DESC
LIMIT 10;

-- 6) Monthly Revenue Trend
-- If your engine supports DATE_TRUNC:
--   DATE_TRUNC('month', OrderDate)
-- DuckDB: DATE_TRUNC('month', CAST(OrderDate AS DATE))
SELECT
  strftime(date_trunc('month', CAST(OrderDate AS DATE)), '%Y-%m') AS year_month,
  SUM(Sales) AS revenue
FROM sales
GROUP BY year_month
ORDER BY year_month;

-- 7) Average Order Value (AOV)
SELECT
  AVG(order_total) AS avg_order_value
FROM (
  SELECT OrderID, SUM(Sales) AS order_total
  FROM sales
  GROUP BY OrderID
) t;

-- 8) Top Cities by Revenue
SELECT
  City,
  SUM(Sales) AS revenue
FROM sales
GROUP BY City
ORDER BY revenue DESC
LIMIT 10;

