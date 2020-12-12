USE labor_sql;

SELECT tabl.name, tabl.numGuns, bore,displacement,type,country,launched,tabl.class
FROM (
	SELECT s.name, numGuns, bore,displacement,type,country,launched, s.class,
		CASE WHEN c.numGuns = 9 THEN 1 ELSE 0 END AS conditional_1,
		CASE WHEN  c.bore= 9  THEN 1 ELSE 0 END AS conditional_2,
		CASE WHEN c.displacement= 46000 THEN 1 ELSE 0 END AS conditional_3,
		CASE WHEN c.type= 'bb' THEN 1 ELSE 0 END AS conditional_4,
		CASE WHEN  c.country= "Japan" THEN 1 ELSE 0 END AS conditional_5,
		CASE WHEN  s.launched = 1916 THEN 1 ELSE 0 END AS conditional_6,
		CASE WHEN s.class = "Revenge" THEN 1 ELSE 0 END AS conditional_7

 FROM ships s INNER JOIN classes c ON s.class = c.class
) tabl
WHERE (conditional_1+conditional_2+conditional_3+conditional_4+conditional_5+conditional_6+conditional_7)>=3;



 