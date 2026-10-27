# Sales Analytics & Data Quality with Snowflake

## Project overview
A beginner portfolio project built in Snowflake SQL. It loads sample order data, validates data quality, summarizes customer and regional sales, and exposes reusable reporting views.

## Tech stack
- Snowflake
- SQL
- CSV

## Sample data
`data/orders_import.csv` contains nine fictional orders. Order 209 intentionally uses customer ID 6, which is absent from the sample `CUSTOMERS` table, to demonstrate orphan-record validation.

## Snowflake objects
Database/schema: `SALES_ANALYTICS.SALES_SCHEMA`

Run the SQL files in the `sql/` folder in order:
1. `01_setup_and_source_tables.sql`
2. `02_data_quality_checks.sql`
3. `03_sales_analytics.sql`
4. `04_reporting_views.sql`

Upload `data/orders_import.csv` through Snowsight's Add Data workflow and name the table `ORDER_IMPORT`.

## What the project demonstrates
- CSV loading into Snowflake
- Data quality checks for duplicate order IDs, missing values, invalid amounts, and unmatched customer IDs
- Customer and regional sales summaries
- `ROW_NUMBER()` and `QUALIFY` for highest-value order per customer
- `CASE` expressions for sales categories
- Reusable reporting views

## Important limitations
This is a learning project using a manually loaded CSV and SQL transformations. It is not yet an automated AWS-to-Snowflake pipeline. `CUSTOMER_SALES_SUMMARY` is a snapshot and must be recreated/refreshed to reflect new source orders. `CUSTOMER_SALES_LIVE` recalculates its results from the source tables when queried. Unmatched orders are checked separately and are not included in customer-level summaries.

## Future improvements
- Automate ingestion from cloud storage
- Add orchestration and monitoring
- Add incremental loading and broader data tests
- Connect a BI dashboard
