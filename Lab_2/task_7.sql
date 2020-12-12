USE labor_sql;

SELECT battle, Classes.country, count(Outcomes.battle) count
FROM Outcomes LEFT JOIN Battles ON Battles.name=Outcomes.battle 
	JOIN Ships on Outcomes.Ship=Ships.name LEFT JOIN Classes ON Ships.class=Classes.class 
GROUP BY Battle
 
