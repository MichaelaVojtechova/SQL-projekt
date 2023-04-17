
/*
 * 2.Kolik je možné si koupit litrů mléka a kilogramů chleba za první a poslední srovnatelné období v dostupných datech cen a mezd?
 */

SELECT 
	prim.payroll_year,
	prim.food_name,
	round(avg(prim.payroll_value)/avg(prim.food_price),2) AS amount_of_goods
FROM t_michaela_vojtechova_project_sql_primary_final prim 
WHERE prim.payroll_year IN (
	SELECT 
		prim.payroll_year 
	FROM t_michaela_vojtechova_project_sql_primary_final prim
	WHERE prim.payroll_year = '2006'
		OR prim.payroll_year = '2018')
	AND prim.food_name IN (
	SELECT 
		prim.food_name 
	FROM t_michaela_vojtechova_project_sql_primary_final prim 
	WHERE prim.food_name LIKE '%chléb%'
		OR prim.food_name LIKE '%mléko%')
GROUP BY prim.payroll_year, prim.food_name;
