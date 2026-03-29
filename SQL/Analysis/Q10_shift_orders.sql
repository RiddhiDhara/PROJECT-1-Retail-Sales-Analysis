SELECT 
    shift, 
    COUNT(*) AS number_of_orders
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