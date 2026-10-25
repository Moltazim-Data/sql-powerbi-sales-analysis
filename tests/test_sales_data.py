from pathlib import Path
import csv

ROOT = Path(__file__).resolve().parents[1]
DATA = ROOT / "data" / "sales.csv"

def test_sales_data_has_unique_orders_and_valid_values():
    with DATA.open(newline="", encoding="utf-8") as handle:
        rows = list(csv.DictReader(handle))
    assert len(rows) >= 30
    order_ids = [row["order_id"] for row in rows]
    assert len(order_ids) == len(set(order_ids))
    for row in rows:
        assert int(row["quantity"]) > 0
        assert float(row["unit_price_eur"]) > 0
        assert 0 <= float(row["discount_pct"]) < 1
