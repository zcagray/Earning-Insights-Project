/* 
	US Salary Data Exploration
*/
/* The purpose of these queries is to gain an initial understanding of the data's content */
/* They also give me potential hypotheses for the proposed analysis questions */

-- Creating a table for the data

CREATE TABLE survey
(
	tstamp TIMESTAMP,
	age VARCHAR,
	gender VARCHAR,
	race VARCHAR,
	industry VARCHAR,
	title VARCHAR,
	title_extra VARCHAR,
	annual_salary INT,
	addition_wages INT,
	currency VARCHAR,
	alt_currency VARCHAR,
	currency_extra VARCHAR,
	country VARCHAR,
	us_state VARCHAR,
	city VARCHAR,
	years_prof_work VARCHAR,
	years_field_work VARCHAR,
	education VARCHAR
);

-- Checking that the data was imported properly

SELECT * 
FROM survey
LIMIT 50;

-- Looking at average salaries based on state and industry 

SELECT us_state, industry, ROUND(AVG(annual_salary)) AS average_salary
FROM survey
WHERE annual_salary IS NOT NULL
GROUP BY us_state, industry
ORDER BY industry, average_salary DESC;

-- Looking at average salaries based on industry, age and state 

SELECT industry, age, us_state, ROUND(AVG(annual_salary)) AS average_salary
FROM survey
WHERE annual_salary IS NOT NULL
GROUP BY industry, age, us_state
ORDER BY age;

-- Looking at average salaries for each US state and city

SELECT us_state, city, ROUND(AVG(annual_salary)) AS average_salary
FROM survey
WHERE annual_salary IS NOT NULL
GROUP BY us_state, city
ORDER BY us_state;

-- Looking at average salaries for each industry

SELECT industry, ROUND(AVG(annual_salary)) AS average_salary
FROM survey
WHERE annual_salary IS NOT NULL
GROUP BY industry
ORDER BY industry;

-- Looking to see how race and gender affect salaries regionally

SELECT race, gender, us_state, city, ROUND(AVG(annual_salary)) AS average_salary
FROM survey
WHERE annual_salary IS NOT NULL
  AND education = '%education%'
  AND years_prof_work = '%years_field_work%'
GROUP BY race, gender, us_state, city
ORDER BY us_state, city;

-- Looking to see how race and gender affect salaries in each industry

SELECT race, gender, industry, ROUND(AVG(annual_salary)) AS average_salary
FROM survey
WHERE annual_salary IS NOT NULL
  AND education = '%education%'
  AND years_prof_work = '%years_field_work%'
GROUP BY race, gender, industry
ORDER BY industry;

-- These last two query results should be compared to the query results of lines 55 & 63
-- The insight will be found by comparing the average salary of each race and gender against the state, city and industry average


-- Looking to see how education and years of professional experience affect salaries 

SELECT education, years_prof_work, ROUND(AVG(annual_salary)) AS average_salary
FROM survey
WHERE annual_salary IS NOT NULL
  AND us_state = '%state%'
  AND city = '%city%'
GROUP BY education, years_prof_work
ORDER BY education, years_prof_work;

-- Looking to see how education and years of professional experience affect salaries per industry

SELECT education, years_prof_work, industry, ROUND(AVG(annual_salary)) AS average_salary
FROM survey
WHERE annual_salary IS NOT NULL
  AND us_state = '%state%'
  AND city = '%city%'
GROUP BY education, years_prof_work, industry
ORDER BY industry;


-- Creating views for future queries

CREATE View avg_state_salary as
SELECT us_state, ROUND(AVG(annual_salary)) AS average_salary
FROM survey
WHERE annual_salary IS NOT NULL
GROUP BY us_state
ORDER BY us_state;

CREATE View avg_industry_salary as
SELECT industry, ROUND(AVG(annual_salary)) AS average_salary
FROM survey
WHERE annual_salary IS NOT NULL
GROUP BY industry
ORDER BY industry;


