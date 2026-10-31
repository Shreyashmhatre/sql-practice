# SQL Practice

A reproducible SQLite exercise set using a small, fictional electronics store.
Practice joins, aggregation, CTEs, window functions, and data-quality checks with
results that can be verified automatically.

## Run

Python 3.12+ includes SQLite; no database server or packages required.

```bash
python run_exercises.py --check
python run_exercises.py --exercise 05_monthly_revenue
python -m unittest discover -s tests -v
```

The runner creates a fresh **in-memory database** each time. It never modifies an
existing database. Queries are in [`queries/`](queries/); expected results are in
[`expected_results.json`](expected_results.json).

## Data model

```text
customers 1 ─── N orders 1 ─── N order_items N ─── 1 products
```

Four customers, three products, six orders, and eight line items are seeded from
[`data/seed.sql`](data/seed.sql). All records are invented. Prices are integer
**paise** (INR × 100), not floating-point money. `order_items.unit_price_paise`
captures the price at order time. Only `completed` orders count toward revenue.

## Exercises

| Query | Question / concept |
| --- | --- |
| `01_order_totals` | What is each completed order worth? GROUP BY and joins |
| `02_customer_spend` | Which customers spent money? Multi-table aggregation |
| `03_customers_without_sales` | Who has no completed purchase? NOT EXISTS |
| `04_product_sales` | Units and revenue by product; exclude cancelled/pending sales |
| `05_monthly_revenue` | Revenue by calendar month; date grouping |
| `06_customer_rank` | Rank customers by completed spend; CTE + DENSE_RANK |
| `07_running_revenue` | Running total in a deterministic date/ID order |
| `08_quality_checks` | Are there orphaned line items or invalid amounts? |

For this fixture, total completed revenue is **675,000 paise (₹6,750)**. A customer
with a pending or cancelled order is not necessarily a paying customer; that distinction
is intentionally tested.

## How to practice

Read a query's leading question, write your own SQL, then compare it with the expected
rows. Add data to challenge assumptions: tied ranks, missing customers, multiple lines
per order, or a second year of revenue. Use `EXPLAIN QUERY PLAN` to inspect index usage.

SQLite syntax is used deliberately (`strftime`, integer storage); do not assume every
query runs unchanged on PostgreSQL or MySQL. This is an introductory practice dataset,
not a production schema or a performance benchmark.
