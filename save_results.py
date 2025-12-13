import duckdb
from pathlib import Path

DATA_PATH = Path("data/sales.csv")
RESULTS_DIR = Path("results")
RESULTS_DIR.mkdir(exist_ok=True)

con = duckdb.connect()

# Load CSV into table
con.execute(f"""
CREATE OR REPLACE TABLE sales AS
SELECT * FROM read_csv_auto('{DATA_PATH}');
""")

# --- Queries we want to save ---
queries = {
    "preview": """
        SELECT * FROM sales LIMIT 10
    """,
    "kpis": """
        SELECT
          SUM(Sales)    AS total_sales,
          SUM(Quantity) AS total_quantity,
          COUNT(DISTINCT OrderID) AS total_orders
        FROM sales
    """,
    "revenue_by_country": """
        SELECT Country, SUM(Sales) AS revenue
        FROM sales
        GROUP BY Country
        ORDER BY revenue DESC
    """,
    "revenue_by_category": """
        SELECT Category, SUM(Sales) AS revenue
        FROM sales
        GROUP BY Category
        ORDER BY revenue DESC
    """,
    "top_products": """
        SELECT Product, SUM(Sales) AS revenue
        FROM sales
        GROUP BY Product
        ORDER BY revenue DESC
        LIMIT 10
    """,
    "monthly_revenue": """
        SELECT
          strftime(date_trunc('month', CAST(OrderDate AS DATE)), '%Y-%m') AS year_month,
          SUM(Sales) AS revenue
        FROM sales
        GROUP BY year_month
        ORDER BY year_month
    """,
    "top_cities": """
        SELECT City, SUM(Sales) AS revenue
        FROM sales
        GROUP BY City
        ORDER BY revenue DESC
        LIMIT 10
    """,
    "avg_order_value": """
        SELECT AVG(order_total) AS avg_order_value
        FROM (
          SELECT OrderID, SUM(Sales) AS order_total
          FROM sales
          GROUP BY OrderID
        ) t
    """,
}

# --- Run & save ---
for name, sql in queries.items():
    df = con.execute(sql).fetchdf()
    out = RESULTS_DIR / f"{name}.csv"
    df.to_csv(out, index=False)
    print(f"✅ saved: {out}")

print("\n🎉 All results saved in /results")

