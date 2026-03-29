SELECT 
    category, 
    COUNT(DISTINCT customer_id) AS unique_customers
FROM dbo.retail_sales
GROUP BY category
ORDER BY category;