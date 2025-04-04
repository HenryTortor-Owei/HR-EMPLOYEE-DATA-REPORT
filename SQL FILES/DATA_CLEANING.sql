SELECT * FROM hr;

UPDATE hr
SET birthdate = CASE
WHEN birthdate LIKE '%/%' THEN STR_TO_DATE(birthdate, '%m/%d/%Y')
WHEN birthdate LIKE '%-%' THEN STR_TO_DATE(birthdate, '%m-%d-%Y')
ELSE null
END;

UPDATE hr
SET hire_date = CASE
WHEN hire_date LIKE '%/%' THEN STR_TO_DATE(hire_date, '%m/%d/%Y')
WHEN hire_date LIKE '%-%' THEN STR_TO_DATE(hire_date, '%m-%d-%Y')
ELSE null
END;

SET sql_mode = 'ALLOW_INVALID_DATES';
UPDATE hr
SET termdate = IF(termdate IS NOT NULL AND termdate != '', date(str_to_date(termdate, '%Y-%m-%d %H:%i:%s UTC')),'0000-00-00')
WHERE true;

UPDATE hr
SET ï»¿id = REPLACE(ï»¿id, '-', '');

ALTER TABLE hr
CHANGE COLUMN ï»¿id emp_id INT PRIMARY KEY,
MODIFY COLUMN first_name VARCHAR(20),
MODIFY COLUMN last_name VARCHAR(25),
MODIFY COLUMN birthdate DATE,
MODIFY COLUMN gender VARCHAR(6),
MODIFY COLUMN race VARCHAR(50),
MODIFY COLUMN department VARCHAR(30),
MODIFY COLUMN jobtitle VARCHAR(45),
MODIFY COLUMN location VARCHAR(20),
MODIFY COLUMN hire_date DATE,
MODIFY COLUMN termdate DATE,
MODIFY COLUMN location_city VARCHAR(20),
MODIFY COLUMN location_state VARCHAR(20);
DESCRIBE hr;