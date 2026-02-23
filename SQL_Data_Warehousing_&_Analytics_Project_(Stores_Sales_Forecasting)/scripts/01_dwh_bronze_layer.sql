

/* ----- STORE SALES FORCASTING Data Warehouse Project ----- */





-- init_database.sql


/*
=============================================
Creating Database and Schemas
=============================================
*/

USE master;
GO

-- Dropping and recreating the 'StoreSalesForecastingDWH' database
IF EXISTS (SELECT 1 FROM sys.databases WHERE name = 'StoreSalesForecastingDWH')
BEGIN
    ALTER DATABASE StoreSalesForecastingDWH SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE StoreSalesForecastingDWH;
END;
GO

-- Creating the 'StoreSalesForecastingDWH' database
CREATE DATABASE StoreSalesForecastingDWH;
GO

USE StoreSalesForecastingDWH;
GO

-- Creating Schemas
CREATE SCHEMA bronze;
GO

CREATE SCHEMA silver;
GO

CREATE SCHEMA gold;
GO





-- ddl_bronze.sql


/*
=============================================
Creating Bronze Table
=============================================
*/


IF OBJECT_ID('bronze.ssf', 'U') IS NOT NULL
    DROP TABLE bronze.ssf;
GO

CREATE TABLE bronze.ssf (
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
    discount        FLOAT,
    profit          FLOAT
);
GO





-- proc_load_bronze.sql


/*
==============================================================
Stored Procedure: Loading Bronze Layer (Source -> Bronze)
==============================================================
*/

CREATE OR ALTER PROCEDURE bronze.load_bronze AS
BEGIN
    DECLARE @start_time DATETIME, @end_time DATETIME, @batch_start_time DATETIME, @batch_end_time DATETIME;
    BEGIN TRY
        SET @batch_start_time = GETDATE();
        PRINT '========================================================';
        PRINT 'Loading Bronze Layer';
        PRINT '========================================================';

        PRINT '========================================================';
        PRINT 'Loading Table from Source File';
        PRINT '========================================================';

        SET @start_time = GETDATE();
        PRINT '>> Truncating Table: bronze.ssf';
        TRUNCATE TABLE bronze.ssf;

        PRINT '>> Inserting Data Into: bronze.ssf';

        -- Setting date format to match CSV (MM/DD/YYYY)
        SET DATEFORMAT mdy;

        BULK INSERT bronze.ssf
        FROM 'D:\sql_data\StoresSalesForecasting.csv'
        WITH (
            FIRSTROW = 2,             -- skip header row
            FIELDTERMINATOR = ',',    -- comma delimiter
            ROWTERMINATOR = '\n',     -- new line delimiter
            FIELDQUOTE = '"',         -- handle quoted fields containing commas
            CODEPAGE = '65001',       -- UTF-8 encoding
            TABLOCK
        );
        SET @end_time = GETDATE();
        PRINT '>> Load Duration: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' seconds';
        PRINT '>>----------------';

        SET @batch_end_time = GETDATE();
        PRINT '===================================';
        PRINT 'Loading Bronze Layer is Completed';
        PRINT '   - Total Load Duration: ' + CAST(DATEDIFF(SECOND, @batch_start_time, @batch_end_time) AS NVARCHAR) + ' seconds';
        PRINT '===================================';
    END TRY
    BEGIN CATCH
        PRINT '===========================================';
        PRINT 'ERROR OCCURED DURING LOADING BRONZE LAYER';
        PRINT 'Error Message' + ISNULL(ERROR_MESSAGE(), 'No message');
        PRINT 'Error Number' + CAST(ERROR_NUMBER() AS NVARCHAR);
        PRINT 'Error State' + CAST(ERROR_STATE() AS NVARCHAR);
        PRINT '===========================================';
    END CATCH
END;
GO

EXEC bronze.load_bronze;
GO





SELECT * FROM bronze.ssf








