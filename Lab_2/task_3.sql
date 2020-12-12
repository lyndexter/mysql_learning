USE labor_sql;

SELECT name,ships.class,launched,country
FROM Classes,Ships
WHERE classes.class=ships.class;