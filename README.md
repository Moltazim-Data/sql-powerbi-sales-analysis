# SQL + Power BI Sales Analysis

Analyze a sample sales dataset with DuckDB SQL, then use the same source to design an interactive Power BI report.

## Included
- `data/sales.csv` — sample order-level sales data.
- `sql/sales_analysis.sql` — KPI, monthly, category and country queries.
- `tests/test_sales_data.py` — source-data checks.
- `results/` — generated query outputs.
- `powerbi/` — planned report assets and build notes.

## Run the SQL analysis
Python 3.10+ recommended.
```bash
python -m pip install -r requirements.txt
python -m pytest -q
```
The SQL file can be run in DuckDB against the provided CSV. The supplied sales field is treated as an amount; do not multiply it by quantity unless the source definition confirms it is a unit price.

## Power BI build
Import `data/sales.csv`, check data types, define sales amount/order count/average sales consistently, build monthly/category/country visuals, and reconcile totals to the SQL outputs. The repo currently provides SQL analysis and validation; add the DAX measures, screenshot and native `.pbix` after the report is built and verified.

## Data note
Confirm dataset source, license, currency and metric definitions before using results beyond this practice exercise.
