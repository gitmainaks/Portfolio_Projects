


-- ddl_silver.sql


/*
=======================================================
Creating Silver Table
=======================================================
*/


IF OBJECT_ID('silver.ssf', 'U') IS NOT NULL
    DROP TABLE silver.ssf;

CREATE TABLE silver.ssf (
    row_id          NVARCHAR(50),
    order_id        NVARCHAR(50),
    order_date      DATE,
    ship_date       DATE,
    ship_mode       NVARCHAR(50),
    customer_id     NVARCHAR(50),
    customer_name   NVARCHAR(50),
    segment         NVARCHAR(50),
    country         NVARCHAR(50),
    city            NVARCHAR(50),
    state_name      NVARCHAR(50),
    postal_code     NVARCHAR(50),
    region          NVARCHAR(50),
    product_id      NVARCHAR(50),
    category        NVARCHAR(50),
    sub_category    NVARCHAR(50),
    product_name    NVARCHAR(200),
    sales           FLOAT,
    quantity        INT,
    unit_price      FLOAT,   -- New column for unit price
    discount        FLOAT,
    profit          FLOAT,
    dwh_create_date DATETIME2 DEFAULT GETDATE()
);
GO


SELECT * from silver.ssf



-- proc_load_silver.sql


/*
==================================================================
Creating Stored Procedure to Load Silver Layer (Bronze -> Silver)
==================================================================
*/


CREATE OR ALTER PROCEDURE silver.load_silver AS
BEGIN 
    DECLARE @START_TIME DATETIME, @END_TIME DATETIME, @BATCH_START_TIME DATETIME, @BATCH_END_TIME DATETIME;
    BEGIN TRY
        SET @BATCH_START_TIME = GETDATE();
        PRINT '====================================================';
        PRINT 'Loading Silver Layer';
        PRINT '====================================================';

        PRINT '------------------------------------------------';
        PRINT 'Loading data from Bronze to Silver Table';
        PRINT '------------------------------------------------';

        SET @START_TIME = GETDATE();
        PRINT '>> Truncating Table: silver.ssf';
        TRUNCATE TABLE silver.ssf;
        PRINT '>> Inserting Data Into: silver.ssf';
        INSERT INTO silver.ssf (
            row_id,
            order_id,
            order_date,
            ship_date,
            ship_mode,
            customer_id,
            customer_name,
            segment,
            country,
            city,
            state_name,
            postal_code,
            region,
            product_id,
            category,
            sub_category,
            product_name,
            sales,
            quantity,
            unit_price,   -- New column
            discount,
            profit
        )
        SELECT
            row_id,
            order_id,
            order_date,
            ship_date,
            ship_mode,
            CASE WHEN customer_id IS NOT NULL AND CHARINDEX('-', customer_id) > 0
                THEN TRIM(SUBSTRING(customer_id, CHARINDEX('-', customer_id) + 1, LEN(customer_id)))
                ELSE NULL
            END AS customer_id,
            customer_name,
            segment,
            country,
            city,
            state_name,
            postal_code,
            region,
            CASE WHEN product_id IS NOT NULL 
                      AND CHARINDEX('-', product_id) > 0 
                      AND CHARINDEX('-', product_id, CHARINDEX('-', product_id) + 1) > 0
                 THEN TRIM(SUBSTRING(product_id,
                      CHARINDEX('-', product_id, CHARINDEX('-', product_id) + 1) + 1,
                      LEN(product_id)))
                 ELSE NULL
            END AS product_id,
            category,
            sub_category,
            product_name,
            sales,
            quantity,
            sales/NULLIF(quantity, 0) AS unit_price,   -- Derived unit_price, NULL if quantity is 0
            discount,
            profit
        FROM bronze.ssf;
        SET @END_TIME = GETDATE();
        PRINT '>> Load Duration: ' + CAST(DATEDIFF(SECOND, @START_TIME, @END_TIME) AS NVARCHAR) + ' seconds';
        PRINT '>> --------------';

        SET @BATCH_END_TIME = GETDATE();
        PRINT '===================================================';
        PRINT 'Loading Silver Layer is Completed';
        PRINT '  - Total Load Duration: ' + CAST(DATEDIFF(SECOND, @BATCH_START_TIME, @BATCH_END_TIME) AS NVARCHAR) + ' seconds';
        PRINT '===================================================';
    END TRY
    BEGIN CATCH
        PRINT '===========================================================';
        PRINT 'ERROR OCCURED DURING LOADING SILVER LAYER';
        PRINT 'Error Message: ' + ERROR_MESSAGE();
        PRINT 'Error Number: ' + CAST(ERROR_NUMBER() AS NVARCHAR);
        PRINT 'Error State: ' + CAST(ERROR_STATE() AS NVARCHAR);
        PRINT 'Error Severity: ' + CAST(ERROR_SEVERITY() AS NVARCHAR);
        PRINT 'Error Line: ' + CAST(ERROR_LINE() AS NVARCHAR);
        PRINT '===========================================================';
    END CATCH
END;
GO

EXEC silver.load_silver;
GO






SELECT * FROM silver.ssf;



