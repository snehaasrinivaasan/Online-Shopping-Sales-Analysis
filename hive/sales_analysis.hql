-- ===============================================================
-- Online Shopping Sales Analysis - Hive Script
-- Purpose: Create Hive tables over the Pig output (and raw data),
--          then run queries for best-selling products & revenue.
-- ===============================================================

CREATE DATABASE IF NOT EXISTS bda_project;
USE bda_project;

-- ---------------------------------------------------------------
-- 1) Raw sales table (points directly at the CSV on HDFS)
-- ---------------------------------------------------------------
DROP TABLE IF EXISTS raw_sales;
CREATE EXTERNAL TABLE raw_sales (
    order_id     INT,
    order_date   STRING,
    product_id   STRING,
    product_name STRING,
    category     STRING,
    quantity     INT,
    unit_price   DOUBLE,
    customer_id  STRING,
    city         STRING
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
STORED AS TEXTFILE
LOCATION '/bda_project/input/'
TBLPROPERTIES ("skip.header.line.count"="1");

-- ---------------------------------------------------------------
-- 2) Table over the Pig output: best-selling products
-- ---------------------------------------------------------------
DROP TABLE IF EXISTS best_selling_products;
CREATE EXTERNAL TABLE best_selling_products (
    product_name   STRING,
    total_qty_sold INT,
    total_revenue  DOUBLE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
STORED AS TEXTFILE
LOCATION '/bda_project/output/best_selling_products';

-- ---------------------------------------------------------------
-- 3) Table over the Pig output: monthly revenue
-- ---------------------------------------------------------------
DROP TABLE IF EXISTS monthly_revenue;
CREATE EXTERNAL TABLE monthly_revenue (
    month         STRING,
    total_revenue DOUBLE,
    total_units   INT
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
STORED AS TEXTFILE
LOCATION '/bda_project/output/monthly_revenue';

-- ---------------------------------------------------------------
-- 4) Sample analysis queries
-- ---------------------------------------------------------------

-- Top 5 best-selling products by quantity
SELECT product_name, total_qty_sold, total_revenue
FROM best_selling_products
ORDER BY total_qty_sold DESC
LIMIT 5;

-- Revenue trend month by month
SELECT month, total_revenue, total_units
FROM monthly_revenue
ORDER BY month;

-- Category-wise revenue directly from raw data (cross-check using HiveQL alone)
SELECT category,
       SUM(quantity * unit_price) AS category_revenue,
       SUM(quantity)              AS category_units
FROM raw_sales
GROUP BY category
ORDER BY category_revenue DESC;

-- City-wise order counts and revenue
SELECT city,
       COUNT(order_id)            AS num_orders,
       SUM(quantity * unit_price) AS city_revenue
FROM raw_sales
GROUP BY city
ORDER BY city_revenue DESC;
