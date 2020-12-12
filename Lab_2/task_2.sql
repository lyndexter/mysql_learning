USE labor_sql;

SELECT name
FROM battles
WHERE name LIKE '% %' AND name NOT LIKE '%c'