-- Here we will use the database MyProject1
USE MyProject1;

-- Creating table

DROP TABLE IF EXISTS retail_sales;

CREATE TABLE retail_sales (

transactions_id INTEGER PRIMARY KEY,
sale_date DATE,
sale_time TIME, 
customer_id	INTEGER,
gender	VARCHAR(20),
age INTEGER,
category VARCHAR(50),	
quantiy	INTEGER,
price_per_unit FLOAT,
cogs FLOAT, 	
total_sale FLOAT
 
);

-- Alter table data types ( small fixes )

ALTER TABLE dbo.retail_sales
ALTER COLUMN sale_date DATE;

ALTER TABLE dbo.retail_sales
ALTER COLUMN sale_time TIME;

-- Check the table

SELECT * 
FROM dbo.retail_sales;

-- Drop the table

DROP TABLE dbo.retail_sales;