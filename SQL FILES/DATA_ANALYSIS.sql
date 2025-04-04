SELECT * FROM hr;

SELECT COUNT(*) legal_guys FROM hr WHERE age >= 18;

use hr3;
SET sql_mode = 'ALLOW_INVALID_DATES';
SELECT count(*) no_of_current_employees
FROM hr
WHERE age >= 18 AND termdate = '0000-00-00';

#Gender breakdown
SELECT gender, COUNT(*) count
FROM hr
WHERE age >= 18 AND termdate = '0000-00-00'
GROUP BY gender;

#Race count, top 3 but look at distict values
SELECT race, COUNT(*) count FROM hr
WHERE age >= 18 AND termdate = '0000-00-00'
GROUP BY race
ORDER BY 2 desc;

#age distribution
SELECT CASE 
WHEN age > 50 THEN '50-59'
WHEN age >= 40 AND age < 50 THEN '40-49'
WHEN age >= 30 AND age < 40 THEN '30-39'
#WHEN age < 30 THEN '<30'
ELSE '20-29'
END Age_bracket, COUNT(*) count
FROM hr
WHERE age >= 18 AND termdate = '0000-00-00'
GROUP BY 1
ORDER BY 1 desc;

#age distribution by gender
SELECT CASE 
WHEN age > 50 THEN '50-59'
WHEN age >= 40 AND age < 50 THEN '40-49'
WHEN age >= 30 AND age < 40 THEN '30-39'
#WHEN age < 30 THEN '<30'
ELSE '20-29'
END Age_bracket, gender ,COUNT(*) count
FROM hr
WHERE age >= 18 AND termdate = '0000-00-00'
GROUP BY 1, 2
ORDER BY 1 desc, 2;

# average length of employment for terminated employees
SELECT round(avg(TIMESTAMPDIFF(YEAR, hire_date, termdate))) avg_emp_length,
round(stddev(TIMESTAMPDIFF(YEAR, hire_date, termdate))) stddev_emp_length,
max(TIMESTAMPDIFF(YEAR, hire_date, termdate)) max_emp_length,
min(TIMESTAMPDIFF(YEAR, hire_date, termdate)) min_emp_length
FROM hr
WHERE termdate != '0000-00-00' AND termdate < CURDATE() AND age >= 18;

#Count of the largest employee department, top 5
SELECT department, COUNT(*) FROM hr
WHERE age >= 18 AND termdate = '0000-00-00'
GROUP BY department;


#Count of the largest jobtitle, top 10
SELECT jobtitle, COUNT(*) count ,
avg(COUNT(*)) over() average
FROM hr
WHERE age >= 18 AND termdate = '0000-00-00'
GROUP BY jobtitle
ORDER BY 2 desc
Limit 10;

# gender distribution accross departments?
SELECT department, gender, COUNT(*) count
FROM hr
WHERE age >= 18 AND termdate = '0000-00-00'
GROUP BY department, gender
ORDER BY department, gender;

# Most departments with layoffs?
SELECT department, (SELECT COUNT(*) FROM hr WHERE age >= 18 AND termdate != '0000-00-00' AND termdate <= CURDATE() AND department = a.department)/COUNT(*) turnover_rate
FROM hr as a
WHERE age >= 18 #AND termdate = '0000-00-00'
GROUP BY department
ORDER BY 2 desc;

# Alternative neater way to use subqueries
SELECT
department,
total_count,
terminated_count,
terminated_count/total_count turnover_rate,
(terminated_count/total_count)*100 turnover_rate_percent
FROM(
	SELECT department,
    COUNT(*) total_count,
    SUM(CASE WHEN termdate != '0000-00-00' AND termdate <= CURDATE() THEN 1 ELSE 0 END) terminated_count
    FROM hr
    WHERE age >= 18
    GROUP BY DEPARTMENT) as turnover
ORDER BY 4 desc;


# distribution of department/job title with location
use hr3;
SET sql_mode = 'ALLOW_INVALID_DATES';
SELECT department, location_state, COUNT(*) count
FROM hr
WHERE age >= 18 AND termdate = '0000-00-00'
GROUP BY department, location_state
ORDER BY 1 asc;


#Most employees work in what city, state
SELECT location_state, count(*) count
FROM hr
WHERE age >= 18 AND termdate = '0000-00-00'
GROUP BY location_state
ORDER BY 2 desc;


#how has employee count changed over time with hire and term date
SELECT
year,
hires,
fires,
(hires - fires) total,
(hires - fires)/hires AS retention_rate,
round(((hires - fires)/hires)*100,0) AS retention_rate_percent
FROM(
	SELECT year(hire_date) year,
    COUNT(*) hires,
    SUM(CASE WHEN termdate != '0000-00-00' AND termdate <= CURDATE() THEN 1 ELSE 0 END) fires
    FROM hr
    WHERE age >= 18
    GROUP BY year(hire_date)) AS hires1
ORDER BY 1 asc;


# tenure rate of each department
SELECT department, round(avg(timestampdiff(YEAR,hire_date,termdate)),0) avg_tenure_year
FROM hr
WHERE age >= 18 AND termdate != '0000-00-00'AND termdate < curdate()
GROUP BY department
ORDER BY 2 desc