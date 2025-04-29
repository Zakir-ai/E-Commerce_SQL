--E-Commerce Sales Analysis Using SQL


-- Create raw_orders Table
CREATE TABLE raw_orders (
    InvoiceNo VARCHAR(50),
    StockCode VARCHAR(50),
    Description TEXT,
    Quantity INT,
    InvoiceDate TIMESTAMP,
    UnitPrice FLOAT,
    CustomerID VARCHAR(50),
    Country VARCHAR(50)
);

SELECT * FROM raw_orders LIMIT 5;

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Drop the table if it already exists (optional safety)
DROP TABLE IF EXISTS cleaned_orders;

-- Create the new cleaned_orders table with renamed columns + calculated amount
CREATE TABLE cleaned_orders AS
SELECT
    invoiceno   AS order_id,
    stockcode   AS product_id,
    description AS description,
    quantity    AS quantity,
    invoicedate AS order_date,
    unitprice   AS unit_price,
    customerid  AS customer_id,
    country     AS country,
    (quantity * unitprice)::DECIMAL(12,2) AS amount
FROM raw_orders
WHERE
    quantity > 0
    AND unitprice > 0
    AND invoiceno NOT LIKE 'C%';

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- View sample records
SELECT * FROM cleaned_orders LIMIT 10;

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Total transactions
SELECT COUNT(order_id) AS total_transactions FROM cleaned_orders;

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Unique customers
SELECT COUNT(DISTINCT customer_id) AS unique_customers FROM cleaned_orders;

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Unique products
SELECT COUNT(DISTINCT product_id) AS unique_products FROM cleaned_orders;

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- List countries
SELECT DISTINCT country FROM cleaned_orders;

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Check for NULLs
SELECT * FROM cleaned_orders
WHERE order_id IS NULL
   OR product_id IS NULL
   OR quantity IS NULL
   OR unit_price IS NULL
   OR customer_id IS NULL
   OR order_date IS NULL
   OR country IS NULL
   OR amount IS NULL;
   
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Delete All Rows with NULLs
DELETE FROM cleaned_orders
WHERE order_id IS NULL
   OR product_id IS NULL
   OR quantity IS NULL
   OR unit_price IS NULL
   OR customer_id IS NULL
   OR order_date IS NULL
   OR country IS NULL
   OR amount IS NULL;
   
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Main Sales Trend Analysis

-- Monthly Revenue + Order Volume
SELECT
    EXTRACT(YEAR FROM order_date) AS year,
    EXTRACT(MONTH FROM order_date) AS month,
    SUM(amount) AS monthly_revenue,
    COUNT(DISTINCT order_id) AS order_volume
FROM cleaned_orders
GROUP BY year, month
ORDER BY year, month;

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Monthly Average Order Value
SELECT
    EXTRACT(YEAR FROM order_date) AS year,
    EXTRACT(MONTH FROM order_date) AS month,
    ROUND(SUM(amount) / COUNT(DISTINCT order_id), 2) AS avg_order_value
FROM cleaned_orders
GROUP BY year, month
ORDER BY year, month;

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--  Product & Customer Insights

--  Top 10 Best-Selling Products
SELECT
    product_id,
    description,
    SUM(quantity) AS total_units_sold,
    SUM(amount) AS total_revenue
FROM cleaned_orders
GROUP BY product_id, description
ORDER BY total_units_sold DESC
LIMIT 10;

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Most Loyal Customers
SELECT
    customer_id,
    SUM(amount) AS total_spent
FROM cleaned_orders
GROUP BY customer_id
ORDER BY total_spent DESC
LIMIT 10;

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--  Country-Based Analysis

-- Revenue by Country
SELECT
    country,
    SUM(amount) AS total_revenue
FROM cleaned_orders
GROUP BY country
ORDER BY total_revenue DESC;

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Unique Customers by Country
SELECT
    country,
    COUNT(DISTINCT customer_id) AS unique_customers
FROM cleaned_orders
GROUP BY country
ORDER BY unique_customers DESC;

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Time-Based Behavior

-- Sales by Time of Day
SELECT
    CASE
        WHEN EXTRACT(HOUR FROM order_date) BETWEEN 6 AND 11 THEN 'Morning'
        WHEN EXTRACT(HOUR FROM order_date) BETWEEN 12 AND 17 THEN 'Afternoon'
        WHEN EXTRACT(HOUR FROM order_date) BETWEEN 18 AND 23 THEN 'Evening'
        ELSE 'Night'
    END AS time_shift,
    COUNT(*) AS orders_count
FROM cleaned_orders
GROUP BY time_shift
ORDER BY orders_count DESC;

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Anomaly Detection
SELECT * FROM cleaned_orders
WHERE quantity >= 1000
ORDER BY quantity DESC;

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Monthly Revenue and Order Volume for 2011
SELECT
    EXTRACT(YEAR FROM order_date) AS year,
    EXTRACT(MONTH FROM order_date) AS month,
    SUM(amount) AS monthly_revenue,
    COUNT(DISTINCT order_id) AS order_volume
FROM cleaned_orders
WHERE EXTRACT(YEAR FROM order_date) = 2011  -- 🔍 Filter for specific time period
GROUP BY year, month
ORDER BY year, month;

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------






