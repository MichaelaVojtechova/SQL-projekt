-- uživatelské jméno na Discordu Michaela V.#2711 --


CREATE OR REPLACE TABLE t_michaela_vojtechova_project_sql_primary_final AS
SELECT *
FROM (
	SELECT DISTINCT 
		cp.id AS id_payroll,
		cp.value AS payroll_value,
		cp.value_type_code,
		cpvt.name AS value_type_name,
		cp.unit_code,
		cpu.name AS unit_name,
		cp.calculation_code,
		cpc.name AS calculation_name,
		cp.industry_branch_code AS branch_code, 
		cpib.name AS branch_name,
		cp.payroll_year 
	FROM czechia_payroll cp
	JOIN czechia_payroll_value_type cpvt 
		ON cp.value_type_code = cpvt.code
		AND cpvt.code = 5958
	JOIN czechia_payroll_unit cpu 
		ON cp.unit_code = cpu.code
		AND cpu.code = 200
	JOIN czechia_payroll_calculation cpc 
		ON cp.calculation_code = cpc.code
		AND cpc.code = 100
	JOIN czechia_payroll_industry_branch cpib 
		ON cp.industry_branch_code = cpib.code
	WHERE cp.payroll_year >= 2006
		AND cp.payroll_year <= 2018) pay
JOIN (
	SELECT 
		cp2.id AS id_price,
		cp2.value AS food_price,
		cp2.category_code,
		cpc2.name AS food_name,
		cpc2.price_value AS quantity,
		cpc2.price_unit,
		YEAR(cp2.date_from) AS price_year
	FROM czechia_price cp2 
	JOIN czechia_price_category cpc2 
		ON cp2.category_code = cpc2.code
		AND cp2.region_code IS NULL) price
	ON pay.payroll_year = price.price_year
;
