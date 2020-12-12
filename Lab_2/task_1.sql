USE labor_sql;

SELECT model, type, price 
FROM printer
WHERE price<300
ORDER BY type DESC;