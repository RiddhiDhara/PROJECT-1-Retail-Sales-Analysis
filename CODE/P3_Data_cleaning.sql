-- Here we will use the database MyProject1
USE MyProject1;

-- Check the table

SELECT TOP 10 * 
FROM dbo.retail_sales;

-- Checking the no. of rows imported

SELECT COUNT(*) AS Count
FROM dbo.retail_sales;

-- Check for NULL rows

SELECT *
FROM dbo.retail_sales
WHERE sale_date IS NULL OR
      sale_time IS NULL OR
      customer_id IS NULL OR
      gender IS NULL OR
      age IS NULL OR
      category IS NULL OR
      quantity IS NULL OR
      price_per_unit IS NULL OR
      cogs IS NULL OR
      total_sale IS NULL;

-- Setting age null to AVERAGE age

UPDATE dbo.retail_sales
SET age = ( SELECT cast( AVG(age) AS INT ) FROM dbo.retail_sales WHERE age IS NOT NULL)
WHERE age IS NULL;

-- Check for negative age, negative quantity, negative cogs, negative total_sale

SELECT 
    COUNT(age) AS age_count,
    COUNT(quantity) AS quantity_count,
    COUNT(price_per_unit) AS price_count,
    COUNT(cogs) AS cogs_count,
    COUNT(total_sale) AS sales_count
FROM dbo.retail_sales
WHERE age < 0 OR
      quantity < 0 OR
      price_per_unit < 0 OR
      cogs < 0 OR
      total_sale < 0;

-- check if there are inconsistent values in categorical columns (e.g., gender spelling variations)?

SELECT COUNT(gender) AS invalid_gender
FROM dbo.retail_sales
WHERE gender NOT IN ('male', 'female');

-- Does total_sale = quantity × price_per_unit for all rows?

SELECT COUNT(*) 
FROM dbo.retail_sales
WHERE total_sale != quantity * price_per_unit;

-- Dropping rows with null values

DELETE FROM dbo.retail_sales
WHERE quantity IS NULL OR
      price_per_unit IS NULL OR
      cogs IS NULL OR
      total_sale IS NULL;

