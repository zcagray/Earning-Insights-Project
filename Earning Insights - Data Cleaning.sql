/* 
	Earning Insights Data Cleaning
*/
/* Excel was also used throughout this process (see README for details) */

-- Fixing spelling, spacing, and capitalization mistakes in the country column

UPDATE survey
SET country = 'US'
WHERE LOWER (country) LIKE '%u.s%' OR 
      LOWER (country) LIKE '%united s%' OR
      LOWER (country) LIKE '%us%' OR
	  LOWER (country) LIKE '%tates%' OR
	  LOWER (country) LIKE '%america%' OR
	  LOWER (country) LIKE '%the u%' OR
	  LOWER (country) LIKE '%u. s%' OR
	  LOWER (country) LIKE '%usa%' OR
	  LOWER (country) LIKE '%uni%tate%';

-- Removing any submissions from outside of the US

DELETE FROM survey
WHERE country != 'US';

-- Decided to perform imputation for blank state values using city information in Excel

SELECT DISTINCT city
FROM survey
WHERE country = 'US'
AND us_state IS NULL;


UPDATE survey
SET currency = 'USD'
WHERE alt_currency = 'USD';

	  
DELETE
FROM survey
WHERE country = 'US'
AND currency != 'USD'
AND us_state IS NULL;


SELECT DISTINCT city
FROM survey 
WHERE us_state IS NULL;

-- Dropping columns that won't be used in analysis

ALTER TABLE survey
DROP COLUMN title_extra,
DROP COLUMN addition_wages,
DROP COLUMN alt_currency,
DROP COLUMN currency_extra;

-- Removing the outliers from the salary column (excluding rows based on standard deviation)

DELETE FROM survey
WHERE annual_salary < 10000;

DELETE FROM survey
WHERE annual_salary > (SELECT AVG(annual_salary) + 3 * STDDEV(annual_salary) FROM survey);


