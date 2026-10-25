# SQL + Power BI Sales Analysis

This project analyzes a sample sales dataset using SQL (DuckDB) and documents how to build an interactive Power BI report from the same source data.

## Current assets

- `data/sales.csv` — sample order-level dataset with order date, country, city, category, product, sales amount, and quantity.
- `sql/sales_analysis.sql` — SQL queries for KPI summary, monthly trend, category performance, and country performance.
- `tests/test_sales_data.py` — basic source-data validation.
- `powerbi/` — planned location for DAX measures, report screenshots, and build guide; add these artifacts after creating and validating the report.

## Run the SQL analysis

Python 3.10+ recommended.

```bash
python -m pip install -r requirements.txt
python - <<'PY'
import duckdb
con = duckdb.connect()
con.execute(open("sql/sales_analysis.sql", encoding="utf-8").read())
print(con.sql("SELECT COUNT(*) AS rows, SUM(sales_amount) AS sales_amount FROM sales").df())
PY
```

Run commands from the repository root. The `Sales` field is treated as the supplied sales amount; do **not** multiply it by quantity again unless the source definition confirms that it is a unit price.

## Run tests

```bash
python -m pytest -q
```

GitHub Actions runs the data checks on pushes and pull requests.

## Power BI build checklist

- [ ] Import `data/sales.csv` and confirm data types.
- [ ] Define sales amount, order count, and average sales per order consistently.
- [ ] Build monthly trend, category performance, and country performance visuals.
- [ ] Validate dashboard totals against the SQL queries.
- [ ] Commit a readable dashboard screenshot and DAX measures.
- [ ] Add a brief insight report based on actual query results.

## Data and scope note

Treat this dataset as a practice sample until its source, license, and metric definitions are documented. The repository currently contains SQL analysis and validation scaffolding; it does not claim a completed native Power BI `.pbix` or a deployed dashboard.
