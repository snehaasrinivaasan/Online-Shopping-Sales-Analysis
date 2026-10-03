-- ===============================================================
-- Online Shopping Sales Analysis - Apache Pig Script
-- Purpose: Clean raw sales CSV, compute revenue per order,
--          find best-selling products and monthly revenue totals.
-- Input : /bda_project/input/online_sales.csv  (on HDFS)
-- Output: /bda_project/output/best_selling_products
--         /bda_project/output/monthly_revenue
-- ===============================================================

-- Load raw data from HDFS
raw_sales = LOAD '/bda_project/input/online_sales.csv'
    USING PigStorage(',')
    AS (order_id:int, order_date:chararray, product_id:chararray,
        product_name:chararray, category:chararray, quantity:int,
        unit_price:double, customer_id:chararray, city:chararray);

-- Remove header row
sales = FILTER raw_sales BY order_id != 0 AND order_id IS NOT NULL AND product_id != 'product_id';

-- Add a revenue column (quantity * unit_price)
sales_with_revenue = FOREACH sales GENERATE
    order_id, order_date, product_id, product_name, category,
    quantity, unit_price, (double)(quantity * unit_price) AS revenue,
    customer_id, city,
    SUBSTRING(order_date, 0, 7) AS order_month;

-- ---------------------------------------------------------------
-- 1) Best-selling products (by total quantity sold and revenue)
-- ---------------------------------------------------------------
grouped_by_product = GROUP sales_with_revenue BY product_name;

product_summary = FOREACH grouped_by_product GENERATE
    group AS product_name,
    SUM(sales_with_revenue.quantity) AS total_qty_sold,
    SUM(sales_with_revenue.revenue) AS total_revenue;

best_selling_products = ORDER product_summary BY total_qty_sold DESC;

STORE best_selling_products INTO '/bda_project/output/best_selling_products'
    USING PigStorage(',');

-- ---------------------------------------------------------------
-- 2) Monthly revenue totals
-- ---------------------------------------------------------------
grouped_by_month = GROUP sales_with_revenue BY order_month;

monthly_revenue = FOREACH grouped_by_month GENERATE
    group AS month,
    SUM(sales_with_revenue.revenue) AS total_revenue,
    SUM(sales_with_revenue.quantity) AS total_units;

monthly_revenue_sorted = ORDER monthly_revenue BY month ASC;

STORE monthly_revenue_sorted INTO '/bda_project/output/monthly_revenue'
    USING PigStorage(',');

-- Optional: dump to console for quick check when running interactively
-- DUMP best_selling_products;
-- DUMP monthly_revenue_sorted;
