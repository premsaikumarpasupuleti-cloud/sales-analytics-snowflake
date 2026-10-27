-- Create database/schema and the customer lookup table.
CREATE DATABASE IF NOT EXISTS SALES_ANALYTICS;
CREATE SCHEMA IF NOT EXISTS SALES_ANALYTICS.SALES_SCHEMA;
USE DATABASE SALES_ANALYTICS;
USE SCHEMA SALES_SCHEMA;

CREATE TABLE IF NOT EXISTS CUSTOMERS (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100),
    city VARCHAR(50),
    region VARCHAR(50)
);

-- For a fresh project, run this INSERT once.
INSERT INTO CUSTOMERS (customer_id, customer_name, city, region)
SELECT column1, column2, column3, column4
FROM VALUES
    (1, 'Rahul', 'Hyderabad', 'South'),
    (2, 'Priya', 'Bengaluru', 'South'),
    (3, 'Amit', 'Mumbai', 'West'),
    (4, 'Sneha', 'Delhi', 'North'),
    (5, 'Kiran', 'Chennai', 'South')
WHERE NOT EXISTS (SELECT 1 FROM CUSTOMERS);

-- Then upload data/orders_import.csv using Snowsight Add Data.
-- Set the table name to ORDER_IMPORT.
