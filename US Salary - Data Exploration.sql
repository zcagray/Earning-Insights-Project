/* 
	US Salary Data Exploration
*/

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


-- Question 1: What industries have the highest salaries for each age group? Which states?
-- Looking at average salaries based on industry and age 

SELECT industry, age, ROUND(AVG(annual_salary)) AS average_salary
FROM survey
WHERE annual_salary IS NOT NULL
GROUP BY industry, age
ORDER BY age;

-- Looking at average salaries based on industry, age and state 

SELECT industry, age, us_state, ROUND(AVG(annual_salary)) AS average_salary
FROM survey
WHERE annual_salary IS NOT NULL
GROUP BY industry, age, us_state
ORDER BY age;


-- Question 2: Do race and gender play less or more of a factor for salary in certain cities or states? Do they play less or more of a factor in certain industries?
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
  AND education = 'your_desired_education_level'
  AND years_prof_work = 'your_desired_years_of_experience'
GROUP BY race, gender, us_state, city
ORDER BY us_state, city;


-- Looking to see how race and gender affect salaries in each industry

SELECT race, gender, industry, ROUND(AVG(annual_salary)) AS average_salary
FROM survey
WHERE annual_salary IS NOT NULL
  AND education = 'your_desired_education_level'
  AND years_prof_work = 'your_desired_years_of_experience'
GROUP BY race, gender, industry
ORDER BY industry;

-- These last two query results should be compared to the first two under 'Question 2'
-- The insight will be found by comparing the average salary of each race and gender against the state, city and industry average


-- Question 3: Is there a correlation between education level, years of professional experience in the field, and salary? 
-- (cont'd) Specifically, do two people with the same amount of professional experience have different salaries based on the highest degree they have earned? 
-- (cont'd) And in what industries are there the biggest discrepancies?

-- Looking to see how education and years of professional experience affect salaries 

SELECT education, years_prof_work, ROUND(AVG(annual_salary)) AS average_salary
FROM survey
WHERE annual_salary IS NOT NULL
  AND us_state = 'desired_state'
  AND city = 'desired_city'
GROUP BY education, years_prof_work
ORDER BY education, years_prof_work;

-- Looking to see how education and years of professional experience affect salaries per industry

SELECT education, years_prof_work, industry, ROUND(AVG(annual_salary)) AS average_salary
FROM survey
WHERE annual_salary IS NOT NULL
  AND us_state = 'desired_state'
  AND city = 'desired_city'
GROUP BY education, years_prof_work, industry
ORDER BY industry;

