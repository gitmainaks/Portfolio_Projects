


-- ddl_gold.sql




/*
===============================================================
Creating Gold Views
===============================================================
*/




-- ============================================================
-- Create Dimension: gold.dim_customers
-- Natural Key: customer_id
-- Attributes: customer_name, segment, location attributes
-- ============================================================
IF OBJECT_ID('gold.dim_customers', 'V') IS NOT NULL
    DROP VIEW gold.dim_customers;
GO

CREATE VIEW gold.dim_customers AS
SELECT
    customer_id,
    MAX(customer_name) AS customer_name,   -- in case of inconsistencies
    MAX(segment) AS segment,
    MAX(country) AS country,
    MAX(city) AS city,
    MAX(state_name) AS state_name,
    MAX(postal_code) AS postal_code,
    MAX(region) AS region
FROM silver.ssf
GROUP BY customer_id;
GO

-- ============================================================
-- Create Dimension: gold.dim_products
-- Natural Key: product_id
-- Attributes: product_name, category, sub_category
-- ============================================================
IF OBJECT_ID('gold.dim_products', 'V') IS NOT NULL
    DROP VIEW gold.dim_products;
GO

CREATE VIEW gold.dim_products AS
SELECT
    product_id,
    MAX(product_name) AS product_name,
    MAX(category) AS category,
    MAX(sub_category) AS sub_category
FROM silver.ssf
GROUP BY product_id;
GO

-- ====================================================================================
-- Create Fact: gold.fact_sales
-- Measures: sales, quantity, discount, profit
-- Foreign Keys: customer_id (natural), product_id (natural)
-- ====================================================================================
IF OBJECT_ID('gold.fact_sales', 'V') IS NOT NULL
    DROP VIEW gold.fact_sales;
GO 

CREATE VIEW gold.fact_sales AS
SELECT
    row_id,
    order_id,
    customer_id,
    product_id,
    order_date,
    ship_date,
    ship_mode,
    sales,
    quantity,
    unit_price,
    discount,
    profit
FROM silver.ssf;
GO


