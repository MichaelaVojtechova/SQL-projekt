
/*
 * 4. Existuje rok, ve kterém byl meziroční nárůst cen potravin výrazně vyšší než růst mezd (větší než 10 %)?
 */

SELECT
	a.payroll_year,
	a.average_pay_value,
	a.average_price_value,
	round((a.average_pay_value - b.average_pay_value) / b.average_pay_value * 100, 2) AS percent_pay_growth,
	round((a.average_price_value - b.average_price_value) / b.average_price_value * 100, 2) AS percent_price_growth
FROM (
	SELECT
	prim.branch_code,
	prim.payroll_year,
	round(avg(prim.payroll_value), 2) AS average_pay_value,
	round(avg(prim.food_price), 2) AS average_price_value
	FROM t_michaela_vojtechova_project_sql_primary_final prim
	WHERE prim.payroll_value IS NOT NULL 
		AND prim.food_price IS NOT NULL 
	GROUP BY prim.payroll_year) a
LEFT JOIN (
	SELECT
	prim.branch_code,
	prim.payroll_year,
	round(avg(prim.payroll_value), 2) AS average_pay_value,
	round(avg(prim.food_price), 2) AS average_price_value
	FROM t_michaela_vojtechova_project_sql_primary_final prim
	WHERE prim.payroll_value IS NOT NULL 
		AND prim.food_price IS NOT NULL 
	GROUP BY prim.payroll_year) b 
	ON a.branch_code = b.branch_code
	AND a.payroll_year = b.payroll_year + 1
;
