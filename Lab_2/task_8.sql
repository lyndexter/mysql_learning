USE labor_sql;
SELECT maker, AVG(screen) 
FROM laptop LEFT JOIN product ON laptop.model=product.model
GROUP BY maker