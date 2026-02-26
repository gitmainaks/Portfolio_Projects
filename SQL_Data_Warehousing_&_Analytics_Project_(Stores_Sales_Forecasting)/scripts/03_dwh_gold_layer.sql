


-- ddl_gold.sql




/*
===============================================================
Creating Gold Views
===============================================================
*/




-- ============================================================
-- Create Dimension: gold.dim_customers
-- Natural Key: customer_id
-- Attributes: customer_name, segment
-- ============================================================
IF OBJECT_ID('gold.dim_customers', 'V') IS NOT NULL
    DROP VIEW gold.dim_customers;
GO

CREATE VIEW gold.dim_customers AS
SELECT
    customer_id,
    MAX(customer_name) AS customer_name,   -- in case of inconsistencies
    MAX(segment) AS segment
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

-- ============================================================
-- Create Dimension: gold.dim_locations
-- Surrogate Key: location_id (MD5 hash of all location attributes)
-- Attributes: country, city, state_name, postal_code, region
-- ============================================================
IF OBJECT_ID('gold.dim_locations', 'V') IS NOT NULL
    DROP VIEW gold.dim_locations;
GO

CREATE VIEW gold.dim_locations AS
SELECT DISTINCT
    -- Generate surrogate key using MD5 hash of location attributes
    CONVERT(VARCHAR(32), HASHBYTES('MD5',
        CONCAT(ISNULL(country, ''),
               ISNULL(city, ''),
               ISNULL(state_name, ''),
               ISNULL(postal_code, ''),
               ISNULL(region, ''))), 2) AS location_id,
    country,
    city,
    state_name,
    postal_code,
    region
FROM silver.ssf;
GO

-- ====================================================================================
-- Create Fact: gold.fact_sales
-- Grain: One row per order line item
-- Measures: sales, quantity, discount, profit
-- Foreign Keys: customer_id (natural), product_id (natural), location_id (surrogate),
--               order_date, ship_date
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
    CONVERT(VARCHAR(32), HASHBYTES('MD5',
        CONCAT(ISNULL(country, ''),
               ISNULL(city, ''),
               ISNULL(state_name, ''),
               ISNULL(postal_code, ''),
               ISNULL(region, ''))), 2) AS location_id,
    sales,
    quantity,
    discount,
    profit
FROM silver.ssf;
GO

-- ============================================================
-- Creating Denormalized Sales View: gold.vw_sales
-- Joins Fact with all Dimensions for direct reporting
-- ============================================================
IF OBJECT_ID('gold.vw_sales', 'V') IS NOT NULL
    DROP VIEW gold.vw_sales;
GO

CREATE VIEW gold.vw_sales AS
SELECT
    f.row_id,
    f.order_id,
    f.order_date,
    f.ship_date,
    f.ship_mode,
    f.customer_id,
    c.customer_name,
    c.segment,
    f.product_id,
    p.category,
    p.sub_category,
    p.product_name,
    l.country,
    l.city,
    l.state_name,
    l.postal_code,
    l.region,
    f.sales,
    f.quantity,
    f.discount,
    f.profit
FROM gold.fact_sales f
LEFT JOIN gold.dim_customers c ON f.customer_id = c.customer_id
LEFT JOIN gold.dim_products p ON f.product_id = p.product_id
LEFT JOIN gold.dim_locations l ON f.location_id = l.location_id;
GO


