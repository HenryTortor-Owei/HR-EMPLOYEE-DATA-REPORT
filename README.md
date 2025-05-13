# HR-EMPLOYEE-DATA-REPORT

This project analyzes HR data to uncover insights about employee demographics, turnover, tenure, and departmental distribution. The analysis is performed using SQL queries to clean the data and extract meaningful patterns.

## Table of Contents
- [Data Cleaning](#data-cleaning)
- [Questions Explored](#questions-explored)
- [Key Findings](#key-findings)
- [Technical Setup](#technical-setup)

## Data Cleaning

The following data cleaning steps were performed to prepare the dataset for analysis:

1. **Date Format Standardization**:
   - Converted `birthdate` from various formats (MM/DD/YYYY and MM-DD-YYYY) to a standard DATE format
   - Converted `hire_date` from various formats (MM/DD/YYYY and MM-DD-YYYY) to a standard DATE format
   - Reformatted `termdate` from UTC timestamp to standard DATE format, setting empty values to '0000-00-00'

2. **ID Field Cleaning**:
   - Removed hyphens from employee ID values

3. **Schema Optimization**:
   - Renamed column `ï»¿id` to `emp_id` and set as primary key
   - Modified data types for all columns to appropriate types:
     - `emp_id`: INT
     - `first_name`, `last_name`, `gender`, `race`, `department`, `jobtitle`, `location`, `location_city`, `location_state`: VARCHAR
     - `birthdate`, `hire_date`, `termdate`: DATE

4. **Data Integrity**:
   - Set SQL mode to 'ALLOW_INVALID_DATES' to handle date-related operations and avoid errors
   - Filtered analysis to include only employees aged 18 or older

## Questions Explored

1. **Workforce Overview**:
   - How many current employees are in the company?

2. **Employee Demographics**:
   - What is the gender breakdown of current employees?
   - What is the racial distribution of employees?
   - How are employees distributed across age brackets?
   - How does age distribution vary by gender?

3. **Employment Patterns**:
   - What is the average length of employment for terminated employees?
   - What departments have the most employees?
   - How are genders distributed across departments?

4. **Turnover and Retention**:
   - Which departments have the highest layoff/turnover rates?
   - What is the company's retention rate by year?
   - What is the average tenure by department?

5. **Geographic Distribution**:
   - Which states have the most employees?
   - How are departments distributed across different states?
   - Do most employees work remote or at Headquarters

## Key Findings


### Workforce Overview
- **Current Workforce**: The total number of active employees was found to be 17482

### Employee Demographics
- **Gender Distribution**: It was found here that there are more men at the company than women at 8911 vs 8090. A difference of nearly a thousand. Non-Conforming came to 481.
- **Racial Diversity**: The races skewed very white. The full distribution can be seen in the dashboard but the top three are White, Two or More Races and Black or African American.
- **Age Brackets**: Most of the employees in the organisation are 30-39 at 5057, followed by 40-49 at 4851. Third is 20-29 at 4167 and the least is >50 at 3407.
- **Age by Gender**: This follows a similar pattern to the results from Age brackets and Gender distribution.

### Employment Patterns
- **Department Size**: The top three departmnets by employee count here are Engineering, Accounting and Human Resources
- **Gender by Department**:  For most departments, there are more men with the exception of Research and Development as well as marketing which had slightly more women

### Turnover and Retention
- **Departmental Turnover**: Departmentment turnover is the number of fired employees divided by retained employees.The top three here are Auditing, Legal, Training with 0.1800, 0.1538, 0.1313 respectively.
- **Overall Employee Retention**: From 2005 all the way to 2020, the company had a steady increase in retention rate from 82% to 96%. In the 5 years prior however, the number fluctuated.
- **Departmental Tenure**: Average tenure by department in years, specifically for terminated employees, highlighting which departments retain employees longest.

### Geographic Distribution
- **State Concentration**: Overwhelmingly, concentration is in Ohio which is the company headquarters.
- **Headquarters vs remote**: 75% of employees work from headquarters while the rest work remotely.

## Technical Setup

This project uses:
- MySQL database
- SQL queries for data manipulation and analysis
- Custom SQL techniques including:
  - CASE statements for categorization
  - Window functions for advanced calculations
  - Subqueries for complex metrics
  - Date manipulation functions
    
 - POWER BI to build a dashboard
