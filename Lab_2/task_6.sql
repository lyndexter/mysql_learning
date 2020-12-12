USE labor_sql;
SELECT concat('code: ', code) code , concat("model: ", model) model,
 concat("speed: ", speed) speed, concat("ram: ", ram) ram,
 concat("hd: ", hd) hd, concat("cd: ", cd) cd, concat("price: ", price) price
FROM PC