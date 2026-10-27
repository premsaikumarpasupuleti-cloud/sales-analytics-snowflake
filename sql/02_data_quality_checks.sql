USE DATABASE SALES_ANALYTICS;
USE SCHEMA SALES_SCHEMA;

-- 1. Total source rows
SELECT COUNT(*) AS total_orders FROM ORDER_IMPORT;

-- 2. Duplicate order IDs (expected: no rows)
SELECT order_id, COUNT(*) AS duplicate_count
FROM ORDER_IMPORT
GROUP BY order_id
HAVING COUNT(*) > 1;

-- 3. Invalid amounts (expected: no rows)
SELECT order_id, customer_id, amount
FROM ORDER_IMPORT
WHERE amount <= 0;

-- 4. Missing status values (expected: 0)
SELECT COUNT_IF(status IS NULL) AS missing_statuses
FROM ORDER_IMPORT;

-- 5. Missing customer IDs (expected: 0)
SELECT COUNT_IF(customer_id IS NULL) AS missing_customer_ids
FROM ORDER_IMPORT;

-- 6. Orders without a matching customer (expected: order 209)
SELECT o.order_id, o.customer_id, o.amount
FROM ORDER_IMPORT o
LEFT JOIN CUSTOMERS c ON o.customer_id = c.customer_id
WHERE c.customer_id IS NULL;

-- 7. Combined quality summary
SELECT
    COUNT(*) AS total_orders,
    COUNT(DISTINCT order_id) AS unique_order_ids,
    COUNT_IF(amount <= 0) AS invalid_amounts,
    COUNT_IF(status IS NULL) AS missing_statuses,
    COUNT_IF(customer_id IS NULL) AS missing_customer_ids
FROM ORDER_IMPORT;
