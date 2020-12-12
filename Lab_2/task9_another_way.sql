SELECT t.name
FROM
(
    SELECT s.name,
        CASE WHEN c.numGuns = 8 THEN 1 ELSE 0 END AS c1,
        CASE WHEN c.bore = 15 THEN 1 ELSE 0 END AS c2,
        CASE WHEN c.displacement = 32000 THEN 1 ELSE 0 END AS c3,
        CASE WHEN c.type = 'bb' THEN 1 ELSE 0 END AS c4,
        CASE WHEN s.launched = 1915 THEN 1 ELSE 0 END AS c5,
        CASE WHEN c.class = 'Kongo' THEN 1 ELSE 0 END AS c6,
        CASE WHEN c.country = 'USA' THEN 1 ELSE 0 END AS c7
    FROM ships s INNER JOIN classes c ON s.class = c.class
) t
WHERE (t.c1 + t.c2 + t.c3 + t.c4 + t.c5 + t.c6 + t.c7) >= 3;