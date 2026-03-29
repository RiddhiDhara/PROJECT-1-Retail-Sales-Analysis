-- Here we will use the database MyProject1
USE MyProject1;

-- Viewing the table
SELECT TOP 10 *
FROM dbo.retail_sales;

-- Data analysis and business key problems and answers

-------------------- My Analysis & Findings
-------------------------------------------

-- Q1. Write a SQL query to retrieve all columns for sales made on '2022-11-05'

SELECT *
FROM dbo.retail_sales
WHERE sale_date = '2022-11-05';

-- Q2. Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 10 in the month of Nov-2022

SELECT *
FROM dbo.retail_sales
WHERE category = 'Clothing' AND 
      quantity > 3 AND
      sale_date >= '2022-11-01' AND
      sale_date < '2022-12-01';

-- Q3. Write a SQL query to calculate the total sales (total_sale) for each category

SELECT category, SUM(total_Sale) AS total_sale_per_category
FROM dbo.retail_sales
GROUP BY category
ORDER BY category;

-- Q4. Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category

SELECT category, AVG(age) AS average_age
FROM dbo.retail_sales
GROUP BY category
HAVING category = 'Beauty';

-- OR

SELECT AVG(age) AS average_age
FROM dbo.retail_sales
WHERE category = 'Beauty';

-- Q5. Write a SQL query to find all transactions where the total_sale is greater than 1000

SELECT *
FROM dbo.retail_sales
WHERE total_sale > 1000;

-- Q6. Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category

SELECT COUNT(transactions_id) AS transaction_count,
       category,
       gender
FROM dbo.retail_sales
GROUP BY category, gender;

-- Q7. Write a SQL query to calculate the average sale for each month and identify the best selling month in each year

SELECT YEAR(sale_date) AS years, MONTH(sale_date) AS months, AVG(daily_total) AS average_daily_sale_per_month 
FROM (
SELECT sale_date,
       SUM(total_sale) AS daily_total
FROM dbo.retail_sales
GROUP BY sale_Date
)t
GROUP BY YEAR(sale_date), MONTH(sale_date)
ORDER BY years, months;

-- Q8. Write a SQL query to find the top 5 customers based on the highest total sales

SELECT TOP 5 customer_id, SUM(total_sale) AS total_purchase
FROM dbo.retail_sales
GROUP BY customer_id
ORDER BY total_purchase DESC;

-- Q9. Write a SQL query to find the number of unique customers who purchased items from each category

SELECT category, COUNT(DISTINCT(customer_id)) AS unique_customers
FROM dbo.retail_sales
GROUP BY category;

-- Q10.Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)

SELECT shift, COUNT(*) AS number_of_orders
FROM (
    SELECT 
        CASE 
            WHEN DATEPART(HOUR, sale_time) < 12 THEN 'Morning'
            WHEN DATEPART(HOUR, sale_time) < 17 THEN 'Afternoon'
            ELSE 'Evening'
        END AS shift
    FROM dbo.retail_sales
) t
GROUP BY shift
ORDER BY shift;


-- END OF ANALYSIS