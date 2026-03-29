SELECT 
    category,
    gender,
    COUNT(transactions_id) AS transaction_count
FROM dbo.retail_sales
GROUP BY category, gender
ORDER BY category, gender;