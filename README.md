# SQL + Power BI Sales Analysis

A portfolio project space for demonstrating a reproducible sales analytics workflow using SQL for data preparation and KPI analysis, then Power BI for communicating results.

> **Status note:** This repository currently has only a short project description. It should not be treated as a completed analysis until the SQL scripts, source data or data-source instructions, dashboard artifact/screenshots, and validated findings are committed.

## Intended workflow

1. Document the source dataset, grain, fields, and any licensing or attribution requirements.
2. Profile the raw data and define data-quality checks.
3. Use SQL to calculate sales, order volume, product/category performance, and time trends.
4. Define KPI formulas and denominators clearly; distinguish sales from profit and orders from line items.
5. Build a Power BI report with a data model, measures, useful filters, and readable visuals.
6. Validate dashboard totals against SQL outputs and publish screenshots plus a short findings report.

## Recommended repository structure

```text
sql-powerbi-sales-analysis/
├── data/                 # Small permitted sample, or documented download steps
├── sql/                  # Reproducible queries in execution order
├── powerbi/               # DAX measures, build guide, preview/screenshots
├── reports/               # Validated findings and recommendations
├── docs/                  # Data dictionary and KPI definitions
└── README.md
```

## Completion checklist

- [ ] Dataset source and license/attribution documented
- [ ] SQL scripts run from a clean setup
- [ ] KPI definitions and null/cancellation handling documented
- [ ] Power BI dashboard screenshot or preview included
- [ ] SQL totals reconciled to dashboard values
- [ ] Findings supported by actual query outputs
- [ ] Setup and reproduction steps tested

Do not add invented metrics or claim a native `.pbix`, live refresh, or completed dashboard until the corresponding artifact exists and has been tested.
