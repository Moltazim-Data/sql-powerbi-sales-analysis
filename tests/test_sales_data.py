from pathlib import Path
import csv

ROOT = Path(__file__).resolve().parents[1]
DATA = ROOT / "data" / "sales.csv"

def test_sales_data_has_unique_orders_and_valid_values():
    with DATA.open(newline="", encoding="utf-8") as handle:
        rows = list(csv.DictReader(handle))
    assert len(rows) >= 30
    assert {"OrderID", "OrderDate", "Country", "Category", "Product", "Sales", "Quantity"} <= set(rows[0])
    order_ids = [row["OrderID"] for row in rows]
    assert len(order_ids) == len(set(order_ids))
    for row in rows:
        assert float(row["Sales"]) >= 0
        assert int(row["Quantity"]) > 0
        assert len(row["OrderDate"]) == 10
