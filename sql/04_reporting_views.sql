USE DATABASE SALES_ANALYTICS;
USE SCHEMA SALES_SCHEMA;

-- View based on the summary snapshot.
CREATE OR REPLACE VIEW CUSTOMER_SALES_REPORT AS
SELECT
    customer_id,
    customer_name,
    region,
    total_orders,
    total_sales,
    CASE
        WHEN total_sales >= 4000 THEN 'High Value'
        WHEN total_sales >= 2000 THEN 'Medium Value'
        ELSE 'Low Value'
    END AS sales_category
FROM CUSTOMER_SALES_SUMMARY;

-- Live view recalculates customer totals from source tables when queried.
CREATE OR REPLACE VIEW CUSTOMER_SALES_LIVE AS
SELECT
    c.customer_id,
    c.customer_name,
    c.region,
    COUNT(o.order_id) AS total_orders,
    COALESCE(SUM(o.amount), 0) AS total_sales
FROM CUSTOMERS c
LEFT JOIN ORDER_IMPORT o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name, c.region;

SELECT * FROM CUSTOMER_SALES_LIVE ORDER BY total_sales DESC;
