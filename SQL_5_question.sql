
/*
 * 5. Má výška HDP vliv na změny ve mzdách a cenách potravin? Neboli, pokud HDP vzroste výrazněji v jednom roce, projeví se to na cenách potravin či mzdách ve stejném nebo následujícím roce výraznějším růstem?
 */

SELECT
	gdp2.payroll_year AS `year`,
	gdp2.average_payroll,
	gdp2.average_price,
	gdp2.gdp,
	round((gdp2.average_payroll - gdp2.pay_prev_year) / gdp2.pay_prev_year * 100, 2) AS pay_percent_growth,
	round((gdp2.average_price - gdp2.price_prev_year) / gdp2.price_prev_year * 100, 2) AS price_percent_growth,
	round((gdp2.gdp - gdp2.gdp_prev_year) / gdp2.gdp_prev_year * 100, 2) AS gdp_percent_growth
FROM ( 
	SELECT
		gdp.payroll_year,
		gdp.average_payroll,
		gdp.average_price,
		gdp.gdp,
		LAG(gdp.average_payroll) OVER (ORDER BY gdp.payroll_year) AS pay_prev_year,
		LAG(gdp.average_price) OVER (ORDER BY gdp.payroll_year) AS price_prev_year,
		LAG(gdp.gdp) OVER (ORDER BY gdp.payroll_year) AS gdp_prev_year
	FROM (
		SELECT
			prim.payroll_year,
			round(avg(prim.payroll_value), 2) AS average_payroll,
			round(avg(prim.food_price), 2) AS average_price,
			sec.GDP
		FROM t_michaela_vojtechova_project_sql_primary_final prim
		JOIN t_michaela_vojtechova_project_sql_secondary_final sec
			ON prim.payroll_year = sec.`year` 
			AND sec.country = 'Czech Republic'
		GROUP BY prim.payroll_year) gdp) gdp2;
		