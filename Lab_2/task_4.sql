USE labor_sql;

SELECT DISTINCT maker 
FROM product
WHERE type="PC" 
	AND NOT "Laptop" = SOME( SELECT type FROM product s WHERE s.maker=product.maker); 