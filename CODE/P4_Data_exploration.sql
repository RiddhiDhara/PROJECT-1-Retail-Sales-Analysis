-- Here we will use the database MyProject1
USE MyProject1;

-- How many sales we have

SELECT COUNT(*) AS Total_rows
FROM dbo.retail_sales;

-------------------- Descriptive Statistics
-------------------------------------------

-- What is the total revenue and average transaction value per year ?

SELECT Year,
       SUM(daily_total) AS Total_revenue_per_year,
       AVG(daily_total) AS Average_daily_sale,
       MIN(daily_total) AS Minimum_daily_sale,
       MAX(daily_total) AS Maximum_daily_sale
FROM (
    SELECT sale_date,
           YEAR(sale_date) AS Year,
           SUM(total_sale) AS daily_total
    FROM dbo.retail_sales
    GROUP BY sale_date
) t
GROUP BY Year
ORDER BY Year ASC;

-- What is the average quantity per transaction?

SELECT AVG(quantity) AS avg_quantity_per_transaction
FROM dbo.retail_sales;

-- What is the distribution of customer age?

SELECT age, COUNT(*) AS No_of_Customers
FROM dbo.retail_sales
GROUP BY age
ORDER BY age ASC;

-------------------- Time-Based Analysis
----------------------------------------

-- Day wise spreadout

SELECT DAY(sale_date) AS Day, SUM(total_sale) AS Total_sale_per_day
FROM dbo.retail_sales
GROUP BY DAY(sale_Date)
ORDER BY DAY(sale_date);

-- Month wise spreadout

SELECT MONTH(sale_date) AS MONTH, SUM(total_sale) AS Total_sale_per_month
FROM dbo.retail_sales
GROUP BY MONTH(sale_Date)
ORDER BY MONTH(sale_date);

-- Year wise spreadout

SELECT YEAR(sale_date) AS YEAR, SUM(total_sale) AS Total_sale_per_year
FROM dbo.retail_sales
GROUP BY YEAR(sale_Date)
ORDER BY YEAR(sale_date);

-------------------- Customer Analysis
--------------------------------------

-- How many unique customers are there?

SELECT COUNT(DISTINCT customer_id) AS total_customers
FROM dbo.retail_sales;


-- Who are the top 10 customers by revenue?

SELECT TOP 10 customer_id,
       SUM(total_sale) AS total_revenue
FROM dbo.retail_sales
GROUP BY customer_id
ORDER BY total_revenue DESC;


-- What is the average spend per customer?

SELECT customer_id,
       AVG(total_sale) AS avg_spend
FROM dbo.retail_sales
GROUP BY customer_id;


-- Gender-wise revenue distribution

SELECT gender,
       SUM(total_sale) AS total_revenue
FROM dbo.retail_sales
GROUP BY gender;

-------------------- Product / Category Analysis
-----------------------------------------------

-- Which category generates the highest revenue?

SELECT category,
       SUM(total_sale) AS total_revenue
FROM dbo.retail_sales
GROUP BY category
ORDER BY total_revenue DESC;


-- Which category sells the highest quantity?

SELECT category,
       SUM(quantity) AS total_quantity
FROM dbo.retail_sales
GROUP BY category
ORDER BY total_quantity DESC;


-- Average price per unit per category

SELECT category,
       AVG(price_per_unit) AS avg_price
FROM dbo.retail_sales
GROUP BY category;


-------------------- Profitability Analysis
-------------------------------------------

-- Total profit

SELECT SUM(total_sale - cogs) AS total_profit
FROM dbo.retail_sales;


-- Profit by category

SELECT category,
       SUM(total_sale - cogs) AS total_profit
FROM dbo.retail_sales
GROUP BY category
ORDER BY total_profit DESC;


-- Profit margin per category

SELECT category,
       SUM(total_sale - cogs) * 1.0 / SUM(total_sale) AS profit_margin
FROM dbo.retail_sales
GROUP BY category
ORDER BY profit_margin DESC;


-------------------- Data Validation Checks
-------------------------------------------

-- Check if total_sale matches quantity * price_per_unit

SELECT *
FROM dbo.retail_sales
WHERE total_sale <> quantity * price_per_unit;


-- Count of invalid records

SELECT COUNT(*) AS invalid_records
FROM dbo.retail_sales
WHERE total_sale <> quantity * price_per_unit;


-------------------- Anomaly Detection
--------------------------------------

-- Transactions with unusually high sales (3x average)

SELECT *
FROM dbo.retail_sales
WHERE total_sale > (
    SELECT AVG(total_sale) * 3 FROM dbo.retail_sales
);


-- Transactions with zero or negative values

SELECT *
FROM dbo.retail_sales
WHERE quantity <= 0
   OR price_per_unit <= 0
   OR total_sale <= 0;


-------------------- Advanced Time Insights
-------------------------------------------

-- Sales by day of week

SELECT DATENAME(WEEKDAY, sale_date) AS day_name,
       SUM(total_sale) AS total_revenue
FROM dbo.retail_sales
GROUP BY DATENAME(WEEKDAY, sale_date)
ORDER BY total_revenue DESC;


-- Peak sales hour

SELECT DATEPART(HOUR, sale_time) AS hour,
       SUM(total_sale) AS total_revenue
FROM dbo.retail_sales
GROUP BY DATEPART(HOUR, sale_time)
ORDER BY total_revenue DESC;


-------------------- Business Insights
--------------------------------------

-- Top 5 revenue generating days

SELECT TOP 5 sale_date,
       SUM(total_sale) AS total_revenue
FROM dbo.retail_sales
GROUP BY sale_date
ORDER BY total_revenue DESC;


-- Bottom 5 revenue generating days

SELECT TOP 5 sale_date,
       SUM(total_sale) AS total_revenue
FROM dbo.retail_sales
GROUP BY sale_date
ORDER BY total_revenue ASC;


-- Customer purchase frequency

SELECT customer_id,
       COUNT(*) AS purchase_count
FROM dbo.retail_sales
GROUP BY customer_id
ORDER BY purchase_count DESC;


