import duckdb
from pathlib import Path

# Paths
DATA_PATH = Path("data/sales.csv")
SQL_PATH = Path("sql/analysis_queries.sql")

# Connect to DuckDB (in-memory)
con = duckdb.connect()

# Load CSV into a table
con.execute(f"""
CREATE OR REPLACE TABLE sales AS
SELECT * FROM read_csv_auto('{DATA_PATH}');
""")

print("✅ Loaded data\n")

# Read SQL file
sql_text = SQL_PATH.read_text(encoding="utf-8")

# Remove comments and split queries
lines = [line for line in sql_text.splitlines() if not line.strip().startswith("--")]
clean_sql = "\n".join(lines)
queries = [q.strip() for q in clean_sql.split(";") if q.strip()]

# Execute queries
for i, query in enumerate(queries, start=1):
    print(f"\n--- Query {i} ---")
    try:
        df = con.execute(query).fetchdf()
        print(df)
    except Exception as e:
        print("❌ Error:", e)

print("\n🎉 SQL analysis completed")

