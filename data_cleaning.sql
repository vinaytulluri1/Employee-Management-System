
-- -----------------------------------------------------------------------------------------------
-- -----------------------------------------------------------------------------------------------
-- 									SQL PROJECT: EMPLOYEE MANAGEMENT SYSTEM
-- -----------------------------------------------------------------------------------------------
-- -----------------------------------------------------------------------------------------------

-- -----------------------------------------------------------------------------------------------
--                                        DATA CLEANING
-- -----------------------------------------------------------------------------------------------

USE employee_management;

-- 1. Understanding Data of each table (Data Inpection)

SELECT * FROM JobDepartment LIMIT 10;
SELECT * FROM SalaryBonus LIMIT 10;
SELECT * FROM Employee LIMIT 10;
SELECT * FROM Qualification LIMIT 10;
SELECT * FROM Leaves LIMIT 10;
SELECT * FROM Payroll LIMIT 10;

-- 1. "JobDepartement" Table Data Cleaning

DESCRIBE JobDepartment;

-- a) Fixing 'Null' values

SELECT * FROM JobDepartment
WHERE jobdept IS NULL 
   OR name IS NULL 
   OR description IS NULL 
   OR salaryrange IS NULL;

-- b) Removing '$' symbol from salaryrange of JobDepartment table

SET SQL_SAFE_UPDATES = 0; -- Safe mode 'off'

UPDATE JobDepartment
SET salaryrange = REPLACE(salaryrange, '$', '');

SELECT * FROM JobDepartment LIMIT 10; -- Updated

-- c) Removing extra spaces from the each column

UPDATE JobDepartment
SET 
jobdept = TRIM(jobdept),
name = TRIM(name),
description = TRIM(description),
salaryrange = TRIM(salaryrange);

-- 2. "SalaryBonus" Table Data Cleaning

-- a) checking data types
DESCRIBE SalaryBonus;



SELECT COUNT(*) AS total_rows,
SUM(salary_ID IS NULL) AS salaryID_nulls,
SUM(Job_ID IS NULL) AS jobID_nulls,
SUM(amount IS NULL) AS amount_nulls,
SUM(annual IS NULL) AS annual_nulls,
SUM(bonus IS NULL) AS bonus_nulls
FROM SalaryBonus;

SELECT * FROM SalaryBonus LIMIT 10;

-- b) Removing extra spaces from the each column
UPDATE SalaryBonus
SET 
amount = amount,
annual = annual,
bonus = bonus;   -- No need of TRIM in numeric columns

-- c) Salary consistency check
SELECT * FROM SalaryBonus
WHERE amount < 0 OR bonus < 0;

-- 3. "Employee" Table Data Cleaning

-- a) checking data types
DESCRIBE Employee;

-- b) checking "null" values
SELECT COUNT(*) AS total_rows,
SUM(emp_ID IS NULL) AS empID_nulls,
SUM(firstname IS NULL) AS firstname_nulls,
SUM(lastname IS NULL) AS lastname_nulls,
SUM(gender IS NULL) AS gender_nulls,
SUM(age IS NULL) AS age_nulls,
SUM(contact_add IS NULL) AS contact_nulls,
SUM(emp_email IS NULL) AS email_nulls,
SUM(emp_pass IS NULL) AS password_nulls,
SUM(Job_ID IS NULL) AS jobID_nulls
FROM Employee;

-- c) Removing extra spaces from the each column
UPDATE Employee
SET 
firstname = TRIM(firstname),
lastname = TRIM(lastname),
gender = TRIM(gender),
contact_add = TRIM(contact_add),
emp_email = TRIM(emp_email),
emp_pass = TRIM(emp_pass);

-- d) cleaning emails
UPDATE Employee
SET emp_email = LOWER(emp_email); -- emails in lower case

UPDATE Employee
SET emp_email = REPLACE(emp_email, ' ', '');  -- removed internal spaces

SELECT emp_email, COUNT(*)
FROM Employee
GROUP BY emp_email
HAVING COUNT(*) > 1;   -- checking for duplicates email

SELECT emp_email FROM Employee;  -- final checking


SELECT emp_email, COUNT(*)
FROM Employee
GROUP BY emp_email
HAVING COUNT(*) > 1;

-- 4. "Qualification" Table Data Cleaning

-- a) checking data types
DESCRIBE Qualification;

-- b) checking "null" values
SELECT COUNT(*) AS total_rows,
SUM(QualID IS NULL) AS qualID_nulls,
SUM(Emp_ID IS NULL) AS empID_nulls,
SUM(Position IS NULL) AS position_nulls,
SUM(Requirements IS NULL) AS requirements_nulls,
SUM(Date_In IS NULL) AS date_nulls
FROM Qualification;

-- 5. "Leaves" Table Data Cleaning

-- a) checking data types

DESCRIBE leaves;

-- b) checking "null" values

SELECT COUNT(*) AS total_rows,
SUM(leave_ID IS NULL) AS leaveID_nulls,
SUM(emp_ID IS NULL) AS empID_nulls,
SUM(date IS NULL) AS date_nulls,
SUM(reason IS NULL) AS reason_nulls
FROM Leaves;

-- c) Removing extra spaces from each columns

UPDATE Leaves 
SET reason = TRIM(reason);

-- 6. "Payroll" Table Data Cleaning

-- a) checking data types
DESCRIBE Payroll;

-- b) checking "null" values
SELECT 
COUNT(*) AS total_rows,
SUM(payroll_ID IS NULL) AS payrollID_nulls,
SUM(emp_ID IS NULL) AS empID_nulls,
SUM(job_ID IS NULL) AS jobID_nulls,
SUM(salary_ID IS NULL) AS salaryID_nulls,
SUM(leave_ID IS NULL) AS leaveID_nulls,
SUM(date IS NULL) AS date_nulls,
SUM(report IS NULL) AS report_nulls,
SUM(total_amount IS NULL) AS amount_nulls
FROM Payroll;

-- c) removing extra spaces from each column
UPDATE Payroll
SET 
report = TRIM(report);