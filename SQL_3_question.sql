
/*
 * 3.Která kategorie potravin zdražuje nejpomaleji (je u ní nejnižší percentuální meziroční nárůst)?
 */

SELECT
	price.food_name,
	price.price_year,
	price.avg_price,
	round((price.avg_price - price2.avg_price) / price2.avg_price * 100, 2) AS percent_year_growth
FROM (
	SELECT
		prim.food_name,
		prim.price_year,
		round(avg(prim.food_price), 2) AS avg_price
	FROM t_michaela_vojtechova_project_sql_primary_final prim
	GROUP BY prim.food_name, prim.price_year) price
LEFT JOIN (
	SELECT
		prim.food_name,
		prim.price_year,
		round(avg(prim.food_price), 2) AS avg_price
	FROM t_michaela_vojtechova_project_sql_primary_final prim
	GROUP BY prim.food_name, prim.price_year) price2
	ON price.food_name = price2.food_name
	AND price.price_year = price2.price_year + 1;

-- ekvivalentní --

SELECT
	prim.food_name,
	prim.price_year,
	round(avg(prim.food_price), 2) AS avg_price,
	LAG(round(avg(prim.food_price), 2), 1) OVER (PARTITION BY prim.food_name ORDER BY prim.price_year) AS price_previous_year,
	round((round(avg(prim.food_price), 2) - LAG(round(avg(prim.food_price), 2), 1) OVER (PARTITION BY prim.food_name ORDER BY prim.price_year) ) / LAG(round(avg(prim.food_price), 2), 1) OVER (PARTITION BY prim.food_name ORDER BY prim.price_year) * 100, 2) AS price_growth
FROM t_michaela_vojtechova_project_sql_primary_final prim
GROUP BY prim.food_name, prim.price_year
-- ORDER BY price_growth ASC
;