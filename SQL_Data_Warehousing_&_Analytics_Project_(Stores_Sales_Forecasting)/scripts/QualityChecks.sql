

/*
=====================================================
Quality Checks 
=====================================================
*/



-----------------------------------------------------
-- Checking 'bronze.ssf'
-----------------------------------------------------

-- Check for Nulls or Duplicates in Primary Key
SELECT
    row_id,
    COUNT(*)
FROM bronze.ssf
GROUP BY row_id
HAVING COUNT(*) > 1 OR row_id IS NULL;

-- Checks for unwanted spaces in string columns
SELECT *
FROM bronze.ssf
WHERE 
    (row_id IS NOT NULL AND row_id != TRIM(row_id))
    OR (order_id IS NOT NULL AND order_id != TRIM(order_id))
    OR (ship_mode IS NOT NULL AND ship_mode != TRIM(ship_mode))
    OR (customer_id IS NOT NULL AND customer_id != TRIM(customer_id))
    OR (customer_name IS NOT NULL AND customer_name != TRIM(customer_name))
    OR (segment IS NOT NULL AND segment != TRIM(segment))
    OR (country IS NOT NULL AND country != TRIM(country))
    OR (city IS NOT NULL AND city != TRIM(city))
    OR (state_name IS NOT NULL AND state_name != TRIM(state_name))
    OR (postal_code IS NOT NULL AND postal_code != TRIM(postal_code))
    OR (region IS NOT NULL AND region != TRIM(region))
    OR (product_id IS NOT NULL AND product_id != TRIM(product_id))
    OR (category IS NOT NULL AND category != TRIM(category))
    OR (sub_category IS NOT NULL AND sub_category != TRIM(sub_category))
    OR (product_name IS NOT NULL AND product_name != TRIM(product_name));

SELECT customer_name
FROM bronze.ssf
WHERE customer_name LIKE ' %' OR customer_name LIKE '% ';

-- Data Standardization & Consistency Checks
SELECT DISTINCT ship_mode
FROM bronze.ssf;

SELECT DISTINCT segment
FROM bronze.ssf;

SELECT DISTINCT country
FROM bronze.ssf;

SELECT DISTINCT region
FROM bronze.ssf;

SELECT DISTINCT category
FROM bronze.ssf;

SELECT DISTINCT sub_category
FROM bronze.ssf;

SELECT DISTINCT city
FROM bronze.ssf;

SELECT DISTINCT state_name
FROM bronze.ssf;

SELECT DISTINCT product_id
FROM bronze.ssf;

SELECT DISTINCT customer_id
FROM bronze.ssf;

-- Checking for nulls and negative numbers
SELECT TRY_CAST(sales AS FLOAT) AS sales
FROM bronze.ssf
WHERE TRY_CAST(sales AS FLOAT) < 0 OR TRY_CAST(sales AS FLOAT) IS NULL;

SELECT TRY_CAST(quantity AS FLOAT) AS quantity
FROM bronze.ssf
WHERE TRY_CAST(quantity AS FLOAT) < 0 OR TRY_CAST(quantity AS FLOAT) IS NULL;

SELECT TRY_CAST(discount AS FLOAT) AS discount
FROM bronze.ssf
WHERE TRY_CAST(discount AS FLOAT) < 0 OR TRY_CAST(discount AS FLOAT) IS NULL;

SELECT TRY_CAST(profit AS FLOAT) AS profit
FROM bronze.ssf
WHERE TRY_CAST(profit AS FLOAT) < 0 OR TRY_CAST(profit AS FLOAT) IS NULL;

-- Checking for invalid date order
SELECT 
* 
FROM bronze.ssf 
WHERE TRY_CAST(order_date AS DATE) > TRY_CAST(ship_date AS DATE)


