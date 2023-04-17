

CREATE TABLE t_Michaela_Vojtechova_project_SQL_secondary_final AS
SELECT 
	c.country,
	c.continent,
	e.population,
	round(e.GDP, 2) AS GDP,
	e.gini,
	e.`year` 
FROM countries c 
JOIN economies e 
	ON c.country = e.country
WHERE e.`year` >= 2006
	AND e.`year` <= 2018;
	