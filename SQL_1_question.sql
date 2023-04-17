
/*
 * 1. Rostou v průběhu let mzdy ve všech odvětvích, nebo v některých klesají?
 */

SELECT 
	prim.branch_name,
	prim.payroll_year,
	round(avg(prim.payroll_value)) AS avg_payroll
FROM t_Michaela_Vojtechova_project_SQL_primary_final prim
GROUP BY prim.branch_name, prim.payroll_year;

