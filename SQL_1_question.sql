
/*
 * 1. Rostou v průběhu let mzdy ve všech odvětvích, nebo v některých klesají?
 */

SELECT 
	pay.branch_name,
	pay.payroll_year,
	pay.average_payroll,
	round((pay.average_payroll - pay2.average_payroll) / pay2.average_payroll * 100, 2) AS percent_year_growth
FROM (
	SELECT
		prim.branch_name,
		prim.payroll_year,
		round(avg(prim.payroll_value)) AS average_payroll
	FROM t_Michaela_Vojtechova_project_SQL_primary_final prim
	GROUP BY prim.branch_name, prim.payroll_year) pay
LEFT JOIN (
	SELECT
		prim.id_payroll,
		prim.branch_name,
		prim.payroll_year,
		round(avg(prim.payroll_value)) AS average_payroll
	FROM t_Michaela_Vojtechova_project_SQL_primary_final prim
	GROUP BY prim.branch_name, prim.payroll_year) pay2
	ON pay.branch_name = pay2.branch_name
	AND pay.payroll_year = pay2.payroll_year + 1;

