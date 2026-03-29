SELECT 
    category, 
    SUM(total_sale) AS total_sale_per_category
FROM dbo.retail_sales
GROUP BY category
ORDER BY category;