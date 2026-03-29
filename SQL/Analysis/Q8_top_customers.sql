SELECT TOP 5 
    customer_id, 
    SUM(total_sale) AS total_purchase
FROM dbo.retail_sales
GROUP BY customer_id
ORDER BY total_purchase DESC;