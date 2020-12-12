USE labor_sql;

SELECT class
FROM ships
GROUP BY class
HAVING count(class) = 1
UNION SELECT ship
FROM outcomes
WHERE EXISTS(SELECT * FROM classes WHERE classes.class = outcomes.ship) 
AND NOT EXISTS(SELECT * FROM ships WHERE ships.name = outcomes.ship)
GROUP BY ship
HAVING count(ship) = 1