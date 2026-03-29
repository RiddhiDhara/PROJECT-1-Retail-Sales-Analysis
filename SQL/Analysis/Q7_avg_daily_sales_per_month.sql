SELECT 
    YEAR(sale_date) AS years, 
    MONTH(sale_date) AS months, 
    AVG(daily_total) AS average_daily_sale_per_month 
FROM (
    SELECT 
        sale_date,
        SUM(total_sale) AS daily_total
    FROM dbo.retail_sales
    GROUP BY sale_date
) t
GROUP BY YEAR(sale_date), MONTH(sale_date)
ORDER BY years, months;