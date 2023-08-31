/* 
    Queries + the analysis questions they attempt to answer 
*/

-- Question 1: What states have the highest salaries within each industry?

SELECT us_state, industry, ROUND(AVG(annual_salary)) AS avg_salary
FROM survey
WHERE us_state IS NOT NULL
GROUP BY us_state, industry
ORDER BY industry, avg_salary DESC;

-- Question 2: Which industries offer the highest average salaries within each age group?

SELECT age, industry, ROUND(AVG(annual_salary)) AS avg_salary
FROM survey
WHERE industry IS NOT NULL
GROUP BY age, industry
ORDER BY age, avg_salary DESC;

-- Question 3: Does gender have a varying impact on salary in specific states and industries?

SELECT us_state, gender, ROUND(AVG(annual_salary)) AS avg_salary
FROM survey
WHERE us_state IS NOT NULL
AND gender LIKE 'Man'
OR gender LIKE 'Woman'
GROUP BY us_state, gender
ORDER BY us_state;


SELECT industry, gender, ROUND(AVG(annual_salary)) AS avg_salary
FROM survey
WHERE industry IS NOT NULL
AND gender LIKE 'Man'
OR gender LIKE 'Woman'
GROUP BY industry, gender
ORDER BY industry;

-- Question 4: Is there a correlation between education level, years of professional experience and salary? 
-- (cont'd) Specifically, does the highest degree earned correlate with salary differences among individuals with equal professional experience?

SELECT education, years_prof_work, ROUND(AVG(annual_salary)) AS avg_salary
FROM survey
WHERE education IS NOT NULL
GROUP BY years_prof_work, education
ORDER BY years_prof_work, avg_salary DESC;


/* Deeper Analysis */


-- calculating the average salary for men and women in each state

SELECT us_state,
       CAST (AVG(CASE WHEN gender = 'Man' THEN annual_salary END) AS INT) AS avg_man_salary,
       CAST (AVG(CASE WHEN gender = 'Woman' THEN annual_salary END) AS INT) AS avg_woman_salary
FROM survey
WHERE us_state IS NOT NULL
GROUP BY us_state;

-- calculating the Gender Pay Gap ratio in each state using the average salary of men and women

SELECT us_state,
       CAST((AVG(CASE WHEN gender = 'Woman' THEN annual_salary END) / AVG(CASE WHEN gender = 'Man' THEN annual_salary END)) * 100 AS INT) AS gender_pay_gap_ratio
FROM survey
WHERE us_state IS NOT NULL
GROUP BY us_state
ORDER BY gender_pay_gap_ratio;

-- comparing the national Gender Pay Gap ratio to each state's GPG ratio

SELECT s.us_state,
       CAST(s.gender_pay_gap_ratio AS INT) AS gender_pay_gap_ratio,
       CAST(n.national_avg_man_salary AS INT) AS national_avg_man_salary,
       CAST(n.national_avg_woman_salary AS INT) AS national_avg_woman_salary,
       CAST(n.national_gender_pay_gap_ratio AS INT) AS national_gender_pay_gap_ratio
FROM (
    SELECT us_state,
           (AVG(CASE WHEN gender = 'Woman' THEN annual_salary END) / AVG(CASE WHEN gender = 'Man' THEN annual_salary END)) * 100 AS gender_pay_gap_ratio
    FROM survey
    GROUP BY us_state
) AS s
JOIN (
    SELECT CAST(AVG(CASE WHEN gender = 'Man' THEN annual_salary END) AS INT) AS national_avg_man_salary,
           CAST(AVG(CASE WHEN gender = 'Woman' THEN annual_salary END) AS INT) AS national_avg_woman_salary,
           CAST((AVG(CASE WHEN gender = 'Woman' THEN annual_salary END) / AVG(CASE WHEN gender = 'Man' THEN annual_salary END)) * 100 AS INT) AS national_gender_pay_gap_ratio
    FROM survey
) AS n
ON 1=1;

-- creating a new table to store the Gender Pay Gap ratios

CREATE TABLE gender_pay_gap_ratios (
    us_state VARCHAR(50) PRIMARY KEY,
    state_gpgr INT,
    national_gpgr INT
);

-- populating that table with the state and national GPG ratios

INSERT INTO gender_pay_gap_ratios (us_state, state_gpgr)
SELECT us_state,
       CAST((AVG(CASE WHEN gender = 'Woman' THEN annual_salary END) / AVG(CASE WHEN gender = 'Man' THEN annual_salary END)) * 100 AS INT) AS gender_pay_gap_ratio
FROM survey
WHERE us_state IS NOT NULL
GROUP BY us_state;


UPDATE gender_pay_gap_ratios
SET national_gpgr = 77;


