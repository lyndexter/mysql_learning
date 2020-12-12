USE labor_sql;

SELECT name, launched, displacement
FROM Classes RIGHT JOIN ships ON classes.class=ships.class
WHERE type = 'bb' AND launched>1922 AND displacement>35000;
