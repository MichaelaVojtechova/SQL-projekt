
/*
 * 4. Existuje rok, ve kterém byl meziroční nárůst cen potravin výrazně vyšší než růst mezd (větší než 10 %)?
 */

SELECT
	b.payroll_year AS `year`,
	b.average_payroll,
	b.average_price,
	round((b.average_payroll - b.pay_prev_year) / b.pay_prev_year * 100, 2) AS pay_percent_growth,
	round((b.average_price - b.price_prev_year) / b.price_prev_year * 100, 2) AS price_percent_growth
FROM (
	SELECT
		a.payroll_year,
		a.average_payroll,
		a.average_price,
		LAG(a.average_payroll) OVER (ORDER BY a.payroll_year) AS pay_prev_year,
		LAG(a.average_price) OVER (ORDER BY a.payroll_year) AS price_prev_year
	FROM (
		SELECT
			prim.payroll_year,
			round(avg(prim.payroll_value), 2) AS average_payroll,
			round(avg(prim.food_price), 2) AS average_price
		FROM t_michaela_vojtechova_project_sql_primary_final prim
		GROUP BY prim.payroll_year) a) b
;
