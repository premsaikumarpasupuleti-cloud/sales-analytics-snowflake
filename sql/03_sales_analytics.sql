USE DATABASE SALES_ANALYTICS;
USE SCHEMA SALES_SCHEMA;

-- 1. Customer sales summary table (snapshot; rerun to refresh)
CREATE OR REPLACE TABLE CUSTOMER_SALES_SUMMARY AS
SELECT
    c.customer_id,
    c.customer_name,
    c.region,
    COUNT(o.order_id) AS total_orders,
    COALESCE(SUM(o.amount), 0) AS total_sales
FROM CUSTOMERS c
LEFT JOIN ORDER_IMPORT o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name, c.region;

-- 2. Regional sales report
SELECT
    region,
    COUNT(*) AS total_customers,
    SUM(total_orders) AS total_orders,
    SUM(total_sales) AS total_sales
FROM CUSTOMER_SALES_SUMMARY
GROUP BY region
ORDER BY total_sales DESC;

-- 3. Highest-value order per customer
SELECT c.customer_name, o.order_id, o.amount
FROM ORDER_IMPORT o
INNER JOIN CUSTOMERS c ON o.customer_id = c.customer_id
QUALIFY ROW_NUMBER() OVER (
    PARTITION BY c.customer_id ORDER BY o.amount DESC
) = 1
ORDER BY o.amount DESC;

-- 4. Customer sales categories
SELECT
    customer_name,
    region,
    total_sales,
    CASE
        WHEN total_sales >= 4000 THEN 'High Value'
        WHEN total_sales >= 2000 THEN 'Medium Value'
        ELSE 'Low Value'
    END AS sales_category
FROM CUSTOMER_SALES_SUMMARY
ORDER BY total_sales DESC;
