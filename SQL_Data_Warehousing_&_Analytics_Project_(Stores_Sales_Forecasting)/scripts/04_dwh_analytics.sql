


/*
===================================================
1. Database Exploration
===================================================
*/

-- Retrieving a list of all tables in the database
SELECT
    TABLE_CATALOG,
    TABLE_SCHEMA,
    TABLE_NAME,
    TABLE_TYPE
FROM INFORMATION_SCHEMA.TABLES;

-- Retrieving all columns for a specific table (fact_sales)
SELECT
    COLUMN_NAME,
    DATA_TYPE,
    IS_NULLABLE,
    CHARACTER_MAXIMUM_LENGTH
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'fact_sales';


/*
===================================================
2. Dimensions Exploration
===================================================
*/

-- Retrieving a list of unique region from which customers have made purchases
SELECT DISTINCT 
    region
FROM gold.dim_customers
ORDER BY region;

-- Retrieving a list of unique state_name
SELECT DISTINCT 
    state_name
FROM gold.dim_customers
ORDER BY state_name;

-- Retrieving a list of unique city
SELECT DISTINCT 
    city
FROM gold.dim_customers
ORDER BY city;

SELECT DISTINCT
    segment
FROM gold.dim_customers
ORDER BY segment;

SELECT DISTINCT
    sub_category
FROM gold.dim_products
ORDER BY sub_category;


/*
=================================================================
3. Date Range Exploration (To determine the temporal boundaries)
=================================================================
*/

-- Determining the first and last order date and the total duration in months
SELECT
    MIN(order_date) AS first_order_date,
    MAX(order_date) AS last_order_date,
    DATEDIFF(MONTH, MIN(order_date), MAX(order_date)) AS order_range_months
FROM gold.fact_sales;


/*
========================================================
4. Measures Exploration (Key Metrics)
========================================================
*/

-- Finding the Total Sales
SELECT SUM(CAST(sales AS DECIMAL(18,2))) AS total_sales FROM gold.fact_sales;

-- Finding how many items are sold
SELECT SUM(quantity) AS total_quantity FROM gold.fact_sales;

-- Finding the average discount given
SELECT AVG(CAST(unit_price AS DECIMAL(18,2))) AS avg_unit_price FROM gold.fact_sales;

-- Finding the average discount given
SELECT AVG(CAST(discount AS DECIMAL(18,2))) * 100 AS avg_discount FROM gold.fact_sales;   -- in Percentage

-- Finding the Total number of Orders
SELECT COUNT(order_id) AS total_orders FROM gold.fact_sales;
SELECT COUNT(DISTINCT order_id) AS total_orders FROM gold.fact_sales;

-- Finding the total number of Customers
SELECT COUNT(customer_id) AS total_customers FROM gold.fact_sales;

-- Finding the total number of customers that has placed an order
SELECT COUNT(DISTINCT customer_id) AS total_customers FROM gold.fact_sales;

-- Finding the total number of Products
SELECT COUNT(product_id) AS total_products FROM gold.fact_sales;
SELECT COUNT(DISTINCT product_id) AS total_products FROM gold.fact_sales;

-- Generating a Report that shows all key metrics of the business
SELECT 'Total Sales' AS measure_name, SUM(CAST(sales AS DECIMAL(18,2))) AS measure_value FROM gold.fact_sales
UNION ALL
SELECT 'Total Quantity', SUM(quantity) FROM gold.fact_sales
UNION ALL
SELECT 'Average Unit Price', AVG(CAST(unit_price AS DECIMAL(18,2))) FROM gold.fact_sales
UNION ALL
SELECT 'Average Discount', AVG(CAST(discount AS DECIMAL(18,2))) * 100 FROM gold.fact_sales   -- in Percentage
UNION ALL
SELECT 'Total Orders', COUNT(DISTINCT order_id) FROM gold.fact_sales
UNION ALL
SELECT 'Total Customers', COUNT(DISTINCT customer_id) FROM gold.fact_sales
UNION ALL
SELECT 'Total Products', COUNT(DISTINCT product_id) FROM gold.fact_sales;


/*
=======================================================================
5. Magnitude Analysis (To Understand data distribution across categories)
=======================================================================
*/

-- Finding total customers by states
SELECT
    state_name,
    COUNT(DISTINCT customer_id) AS total_customers
FROM gold.dim_customers
GROUP BY state_name
ORDER BY total_customers DESC;

-- Finding total customers by city
SELECT
    city,
    COUNT(DISTINCT customer_id) AS total_customers
FROM gold.dim_customers
GROUP BY city
ORDER BY total_customers DESC;

-- Finding total customers by region
SELECT
    region,
    COUNT(DISTINCT customer_id) AS total_customers
FROM gold.dim_customers
GROUP BY region
ORDER BY total_customers DESC;

-- Finding total customers by segment
SELECT
    segment,
    COUNT(DISTINCT customer_id) AS total_customers
FROM gold.dim_customers
GROUP BY segment
ORDER BY total_customers DESC;

-- Finding total products by sub_category
SELECT
    sub_category,
    COUNT(DISTINCT product_id) AS total_products
FROM gold.dim_products
GROUP BY sub_category
ORDER BY total_products DESC;

-- The average unit_price in each sub_category
SELECT
    sub_category,
    AVG(CAST(unit_price AS DECIMAL(18,2))) AS avg_unit_price
FROM gold.fact_sales f  
LEFT JOIN gold.dim_products p  
    ON p.product_id = f.product_id
GROUP BY sub_category
ORDER BY avg_unit_price DESC;

-- The average discount by sub_category
SELECT
    sub_category,
    AVG(CAST(discount AS DECIMAL(18,2))) * 100 AS avg_discount
FROM gold.fact_sales f  
LEFT JOIN gold.dim_products p  
    ON p.product_id = f.product_id
GROUP BY sub_category
ORDER BY avg_discount DESC;

-- Total revenue generated for each sub_category
SELECT
    p.sub_category,
    SUM(CAST(f.sales AS DECIMAL(18,2))) AS total_revenue
FROM gold.fact_sales f  
LEFT JOIN gold.dim_products p
    ON p.product_id = f.product_id
GROUP BY p.sub_category
ORDER BY total_revenue DESC;

-- Total revenue generated by each customer
SELECT
    c.customer_id,
    c.customer_name,
    SUM(CAST(f.sales AS DECIMAL(18,2))) AS total_revenue
FROM gold.fact_sales f  
LEFT JOIN gold.dim_customers c  
     ON c.customer_id = f.customer_id
GROUP BY
    c.customer_id,
    c.customer_name
ORDER BY total_revenue DESC;

-- Distribution of sold items across different states
SELECT
    c.state_name,
    SUM(f.quantity) AS total_sold_items
FROM gold.fact_sales f  
LEFT JOIN gold.dim_customers c  
    ON c.customer_id = f.customer_id
GROUP BY state_name
ORDER BY total_sold_items DESC;

-- Distribution of sold items across different cities
SELECT
    c.city,
    SUM(f.quantity) AS total_sold_items
FROM gold.fact_sales f  
LEFT JOIN gold.dim_customers c  
    ON c.customer_id = f.customer_id
GROUP BY city
ORDER BY total_sold_items DESC;


/*
=============================================================
6. Ranking Analysis (To identify top performers 0r laggards)
=============================================================
*/

-- Which 5 products generating the highest revenue? (simple ranking)
SELECT TOP 5
    p.product_name,
    SUM(CAST(f.sales AS DECIMAL(18))) AS total_revenue
FROM gold.fact_sales f  
LEFT JOIN gold.dim_products p  
    ON p.product_id = f.product_id
GROUP BY p.product_name
ORDER BY total_revenue DESC;

-- Using window functions
SELECT * 
FROM (
    SELECT
    p.product_name,
    SUM(CAST(f.sales AS DECIMAL(18))) AS total_revenue,
    RANK() OVER (ORDER BY SUM(CAST(f.sales AS DECIMAL(18))) DESC) AS rank_products
FROM gold.fact_sales f  
LEFT JOIN gold.dim_products p  
    ON p.product_id = f.product_id
GROUP BY p.product_name
) AS ranked_products
WHERE rank_products <= 5;

-- What are the 5 worst-performing products in terms of sales?
SELECT TOP 5
    p.product_name,
    SUM(CAST(f.sales AS DECIMAL(18))) AS total_revenue
FROM gold.fact_sales f  
LEFT JOIN gold.dim_products p  
    ON p.product_id = f.product_id
GROUP BY p.product_name
ORDER BY total_revenue;

-- Find the top 10 customers who have generated the highest revenue
SELECT TOP 10
    c.customer_id,
    c.customer_name,
    SUM(CAST(f.sales AS DECIMAL(18))) AS total_revenue
FROM gold.fact_sales f  
LEFT JOIN gold.dim_customers c  
    ON c.customer_id = f.customer_id
GROUP BY 
    c.customer_id,
    c.customer_name
ORDER BY total_revenue DESC;

-- The 3 customers with the fewest orders placed
SELECT TOP 3
    c.customer_id,
    c.customer_name,
    COUNT(DISTINCT order_id) AS total_orders
FROM gold.fact_sales f  
LEFT JOIN gold.dim_customers c  
    ON c.customer_id = f.customer_id
GROUP BY
    c.customer_id,
    c.customer_name
ORDER BY total_orders;


/*
=============================================================
7. Change Over Time Analysis
=============================================================
*/

-- Analyse sales performance over time (Quick Date functions)
SELECT
    YEAR(order_date) AS order_year,
    MONTH(order_date) AS order_month,
    SUM(CAST(sales AS DECIMAL(18))) AS total_sales,
    COUNT(DISTINCT customer_id) AS total_customers,
    SUM(quantity) AS total_quantity
FROM gold.fact_sales
WHERE order_date IS NOT NULL
GROUP BY YEAR(order_date), MONTH(order_date)
ORDER BY YEAR(order_date), MONTH(order_date);

-- DATETRUNC()
SELECT
    DATETRUNC(MONTH, order_date) AS order_date,
    SUM(CAST(sales AS DECIMAL(18))) AS total_sales,
    COUNT(DISTINCT customer_id) AS total_customers,
    SUM(quantity) AS total_quantity
FROM gold.fact_sales
WHERE order_date IS NOT NULL
GROUP BY DATETRUNC(MONTH, order_date)
ORDER BY DATETRUNC(MONTH, order_date)

-- FORMAT()
SELECT
    FORMAT(order_date, 'yyyy-MMM') AS order_date,
    SUM(CAST(sales AS DECIMAL(18))) AS total_sales,
    COUNT(DISTINCT customer_id) AS total_customers,
    SUM(quantity) AS total_quantity
FROM gold.fact_sales
WHERE order_date IS NOT NULL
GROUP BY FORMAT(order_date, 'yyyy-MMM')
ORDER BY MIN(order_date);


/*
=======================================================
8. Cumulative Analysis
=======================================================
*/

-- Calculate the total sales per month and the running total of sales over time.
SELECT
    order_date,
    total_sales,
    SUM(total_sales) OVER (ORDER BY order_date) AS running_total_sales,
    AVG(avg_unit_price) OVER (ORDER BY order_date) AS moving_average_price
FROM
(
    SELECT
        DATETRUNC(year, order_date) AS order_date,
        SUM(CAST(sales AS DECIMAL(18,2))) AS total_sales,
        AVG(CAST(unit_price AS DECIMAL(18,2))) avg_unit_price
    FROM gold.fact_sales
    WHERE order_date IS NOT NULL
    GROUP BY DATETRUNC(year, order_date)
)t 


/*
==========================================================
9. Performance Analysis
==========================================================
*/

/* Analyze the yearly performance of products by comparing their sales
to both the average sales performance of the product and the previous year's sales */
WITH yearly_product_sales AS (
    SELECT
        YEAR(f.order_date) AS order_year,
        p.product_name,
        SUM(CAST(f.sales AS DECIMAL(18,2))) AS current_sales
    FROM gold.fact_sales f  
    LEFT JOIN gold.dim_products p  
        ON f.product_id = p.product_id
    WHERE f.order_date IS NOT NULL
    GROUP BY 
        YEAR(f.order_date),
        p.product_name
)
SELECT
    order_year,
    product_name,
    current_sales,
    AVG(current_sales) OVER (PARTITION BY product_name) AS avg_sales,
    current_sales - AVG(current_sales) OVER (PARTITION BY product_name) AS diff_avg,
    CASE  
        WHEN current_sales - AVG(current_sales) OVER (PARTITION BY product_name) > 0 THEN 'Above Avg'
        WHEN current_sales - AVG(current_sales) OVER (PARTITION BY product_name) < 0 THEN 'Below Avg'
        ELSE 'Avg'
    END AS avg_change,
    -- Year-over-Year Analysis
    LAG(current_sales) OVER (PARTITION BY product_name ORDER BY order_year) AS py_sales,
    current_sales - LAG(current_sales) OVER (PARTITION BY product_name ORDER BY order_year) AS diff_py,
    CASE
        WHEN current_sales - LAG(current_sales) OVER (PARTITION BY product_name ORDER BY order_year) > 0 THEN 'Increase'
        WHEN current_sales - LAG(current_sales) OVER (PARTITION BY product_name ORDER BY order_year) < 0 THEN 'Decrease'
        ELSE 'No Change'
    END AS py_change
FROM yearly_product_sales
ORDER BY product_name, order_year;


/*
==================================================================
10. Part-to-Whole Analysis
==================================================================
*/

-- Which sub-categories contribute the most to overall sales?
WITH sub_category_sales AS (
    SELECT
        p.sub_category,
        SUM(CAST(f.sales AS DECIMAL(18,2))) AS total_sales
    FROM gold.fact_sales f  
    LEFT JOIN gold.dim_products p  
        ON p.product_id = f.product_id
    GROUP BY p.sub_category
)
SELECT
    sub_category,
    total_sales,
    SUM(total_sales) OVER () AS overall_sales,
    ROUND((CAST(total_sales AS FLOAT) / SUM(total_sales) OVER ()) * 100, 2) AS percentage_of_total
FROM sub_category_sales
ORDER BY total_sales DESC;


/*
==============================================================
11. Data Segmentation Analysis
==============================================================
*/

/* Segment products into cost ranges and 
count how many products fall into each segment */
WITH product_segments AS (
    SELECT
        p.product_id,
        p.product_name,
        f.unit_price,
        CASE
            WHEN f.unit_price < 50 THEN 'Below 50'
            WHEN f.unit_price BETWEEN 50 AND 100 THEN '50-100'
            WHEN f.unit_price BETWEEN 100 AND 200 THEN '100-200'
            ELSE 'Above 200'
        END AS price_range
    FROM gold.fact_sales f  
    LEFT JOIN gold.dim_products p  
        ON p.product_id = f.product_id
    WHERE f.unit_price IS NOT NULL
)
SELECT
    price_range,
    COUNT(DISTINCT product_id) AS total_products
FROM product_segments
GROUP BY price_range
ORDER BY total_products DESC;

/* Group customers into three segments based on their spending behavior:
    - VIP: Customers with at least 12 months of history and spending more than $1,000.
    - Regular: Customers with at least 12 months of history but spending $1,000 or less.
    - New: Customers with a lifespan less than 12 months.
And find total number of customers by each group. */
WITH customer_spending AS (
    SELECT
        c.customer_id,
        SUM(CAST(f.sales AS DECIMAL(18))) total_spending,
        MIN(order_date) AS first_order_date,
        MAX(order_date) AS last_order_date,
        DATEDIFF(MONTH, MIN(order_date), MAX(order_date)) AS lifespan
    FROM gold.fact_sales f  
    LEFT JOIN gold.dim_customers c  
        ON f.customer_id = c.customer_id
    GROUP BY c.customer_id
)
SELECT
    customer_segment,
    COUNT(customer_id) AS total_customers
FROM (
    SELECT
        customer_id,
        CASE
            WHEN lifespan >= 12 AND total_spending > 1000 THEN 'VIP'
            WHEN lifespan >= 12 AND total_spending <= 1000 THEN 'Regular'
            ELSE 'New'
        END AS customer_segment
    FROM customer_spending
) AS segmented_customers
GROUP BY customer_segment
ORDER BY total_customers DESC;


/*
============================================================
12. Customer Report (gold.report_customers)
============================================================
*/

IF OBJECT_ID('gold.report_customers', 'V') IS NOT NULL
    DROP VIEW gold.report_customers;
GO

CREATE VIEW gold.report_customers AS
WITH base_query AS (
-- Base Query: Retrieves core columns from tables
    SELECT
        f.order_id,
        f.product_id,
        f.order_date,
        COALESCE(CAST(f.sales AS DECIMAL(18,2)), 0) AS sales,   -- Coalesce to treat NULLs as 0
        COALESCE(f.quantity, 0) AS quantity,
        c.customer_id,
        c.customer_name,
        c.segment
    FROM gold.fact_sales f  
    INNER JOIN gold.dim_customers c   -- INNER JOIN to exclude orphaned facts (no matching customer)
        ON c.customer_id = f.customer_id
    WHERE order_date IS NOT NULL),
    latest_customer_info AS (
-- For each customer, picking the name and segment from their most recent order
    SELECT
        customer_id,
        customer_name,
        segment,
        ROW_NUMBER() OVER (PARTITION BY customer_id ORDER BY order_date DESC) AS rn  
    FROM base_query),
    customer_aggregation AS (
-- Customer Aggregations: Summarizes key metrics at the customer level
    SELECT
        customer_id,
        COUNT(DISTINCT order_id) AS total_orders,
        SUM(CAST(sales AS DECIMAL(18,2))) AS total_sales,
        SUM(quantity) AS total_quantity,
        COUNT(DISTINCT product_id) AS total_products,
        MAX(order_date) AS last_order_date,
        DATEDIFF(MONTH, MIN(order_date), MAX(order_date)) AS lifespan
    FROM base_query
    GROUP BY
        customer_id
    )
SELECT
    ca.customer_id,
    lci.customer_name,
    lci.segment,
    CASE 
        WHEN ca.lifespan >= 12 AND ca.total_sales > 1000 THEN 'VIP'   -- Customer segmentation based on lifespan and total sales
        WHEN ca.lifespan >= 12 AND ca.total_sales <= 1000 THEN 'Regular'
        ELSE 'New'
    END AS customer_segment,
    ca.last_order_date,
    DATEDIFF(MONTH, last_order_date, GETDATE()) AS recency,   -- Months since last order (dynamic, based on current date)
    ca.total_orders,
    ca.total_sales,
    ca.total_quantity,
    ca.total_products,
    ca.lifespan,
-- Computing Average Order Value (AOV)
    CASE WHEN ca.total_sales = 0 THEN 0
         ELSE CAST(ca.total_sales / ca.total_orders AS DECIMAL(18,0))
    END AS avg_order_value,
-- Computing Average Monthly Spend
    CASE WHEN ca.lifespan = 0 THEN ca.total_sales
         ELSE ca.total_sales / ca.lifespan
    END AS avg_monthly_spend
FROM customer_aggregation ca  
JOIN latest_customer_info lci
    ON ca.customer_id = lci.customer_id AND lci.rn = 1;
GO

SELECT * FROM gold.report_customers;


/*
============================================================
13. Product Report
============================================================
*/

IF OBJECT_ID('gold.report_products', 'V') IS NOT NULL
    DROP VIEW gold.report_products;
GO

CREATE VIEW gold.report_products AS
-- Base Query: Retrieves core columns from fact_sales and dim_products
WITH base_query AS (
    SELECT
        f.order_id,
        f.order_date,
        f.customer_id,
        f.quantity,
        CAST(f.sales AS DECIMAL(18,0)) AS sales,
        p.product_id,
        p.product_name,
        p.sub_category,
        CAST(f.unit_price AS DECIMAL(18,0)) AS unit_price
    FROM gold.fact_sales f  
    LEFT JOIN gold.dim_products p  
        ON f.product_id = p.product_id
    WHERE order_date IS NOT NULL
),
product_aggregations AS (
-- Product Aggregations: Summarizes key metrics at the product level
    SELECT
        product_id,
        product_name,
        sub_category,
        unit_price,
        DATEDIFF(MONTH, MIN(order_date), MAX(order_date)) AS lifespan,
        MAX(order_date) AS last_sale_date,
        COUNT(DISTINCT order_id) AS total_orders,
        COUNT(DISTINCT customer_id) AS total_customers,
        SUM(CAST(sales AS DECIMAL(18,0))) as total_sales,
        SUM(quantity) AS total_quantity,
        ROUND(AVG(CAST(sales AS FLOAT) / NULLIF(quantity,0)), 1) AS avg_selling_price
    FROM base_query
    GROUP BY
        product_id,
        product_name,
        sub_category,
        unit_price
)
-- Final Query: Combines all product results into one output
SELECT
    product_id,
    product_name,
    sub_category,
    unit_price,
    last_sale_date,
    DATEDIFF(MONTH, last_sale_date, GETDATE()) AS recency_in_months,
    CASE 
        WHEN total_sales > 1000 THEN 'High-Performer'
        WHEN total_sales >= 500 THEN 'Mid-Range'
        ELSE 'Low-Performer'
    END AS product_segment,
    lifespan,
    total_orders,
    total_sales,
    total_quantity,
    total_customers,
    avg_selling_price,
-- Average Order Revenue (AOR)
    CASE 
        WHEN total_orders = 0 THEN 0
        ELSE CAST(total_sales / total_orders AS DECIMAL(18,0))
    END AS avg_order_revenue,
-- Average Monthly Revenue
    CASE 
        WHEN lifespan = 0 THEN total_sales
        ELSE total_sales / lifespan
    END AS avg_monthly_revenue
FROM product_aggregations;
GO

SELECT * FROM gold.report_products;



