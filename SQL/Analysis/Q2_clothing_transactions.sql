SELECT *
FROM dbo.retail_sales
WHERE category = 'Clothing' 
  AND quantity > 3
  AND sale_date >= '2022-11-01' 
  AND sale_date < '2022-12-01';