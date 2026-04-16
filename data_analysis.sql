
-- -------------------------------------------------------------------------------------------------------------
-- -------------------------------------------------------------------------------------------------------------
-- 									SQL PROJECT: EMPLOYEE MANAGEMENT SYSTEM
-- -------------------------------------------------------------------------------------------------------------
-- -------------------------------------------------------------------------------------------------------------

-- -------------------------------------------------------------------------------------------------------------
-- -------------------------------------------------------------------------------------------------------------
-- 													ANALYSIS QUERIES
-- -------------------------------------------------------------------------------------------------------------
-- -------------------------------------------------------------------------------------------------------------

USE employee_management;

-- -------------------------------------------------------------------------------------------------------------
-- 												SECTION-01: EMPLOYEE INSIGHTS
-- -------------------------------------------------------------------------------------------------------------


-- a) How many unique employees are currently in the system?

SELECT COUNT(*) AS total_employees
FROM Employee;

-- Insights:
-- The organization has a total of 60 employees, indicating the overall workforce size.

-- b) Which departments have the highest number of employees?

SELECT jd.jobdept, COUNT(e.emp_ID) AS total_emp
FROM Employee e
JOIN JobDepartment jd ON e.Job_ID = jd.Job_ID
GROUP BY jd.jobdept
ORDER BY total_emp DESC;

-- Insights:
-- Finance and IT departments have the highest number of employees, showing higher resource allocation in these areas.

-- c) What is the average salary per department?

SELECT jd.jobdept,
AVG(sb.amount) AS avg_salary
FROM Employee e
JOIN JobDepartment jd
ON e.Job_ID = jd.Job_ID
JOIN SalaryBonus sb
ON jd.Job_ID = sb.Job_ID
GROUP BY jd.jobdept
ORDER BY avg_salary DESC;

-- Insights:
-- The Legal and Engineering departments have the highest average salaries, indicating higher compensation in these roles.

-- d) Who are the top 5 highest-paid employees?

SELECT
e.emp_ID, e.firstname, e.lastname,
sb.amount FROM Employee e
JOIN SalaryBonus sb 
ON e.Job_ID = sb.Job_ID
ORDER BY sb.amount DESC
LIMIT 5;

-- Insights:
-- The top 5 highest-paid employees are from high-paying roles, highlighting key talent with premium compensation.

-- e) What is the total salary expenditure across the company?

SELECT SUM(sb.amount)
AS total_salary
FROM SalaryBonus sb;

-- Insights:
-- The total salary expenditure of the company is 4,321,000, reflecting the overall cost of employee compensation.


-- -----------------------------------------------------------------------------------------------------------------------
-- 											SECTION-02: JOB ROLE AND DEPARTMENT ANALYSIS
-- -----------------------------------------------------------------------------------------------------------------------


-- a) How many different job roles exist in each department?

SELECT jobdept, COUNT(*) 
AS total_roles
FROM JobDepartment
GROUP BY jobdept;

-- Insights:
-- Finance and IT departments have the highest number of job roles, indicating more role diversity in these areas.

-- b) What is the average salary range per department?

SELECT jobdept,
       AVG(CAST(SUBSTRING_INDEX(salaryrange, '-', 1)
       AS UNSIGNED)) AS avg_min_salary,
       AVG(CAST(SUBSTRING_INDEX(salaryrange, '-', -1)
       AS UNSIGNED)) AS avg_max_salary
FROM JobDepartment
GROUP BY jobdept;

-- Insight:
-- Legal and Engineering departments offer higher salary ranges, showing better pay scales compared to other departments.

-- c) Which job roles offer the highest salary?

SELECT jd.name, MAX(sb.amount)
AS highest_salary
FROM SalaryBonus sb
JOIN JobDepartment jd
ON sb.Job_ID = jd.Job_ID
GROUP BY jd.name
ORDER BY highest_salary DESC;

-- Insights:
-- Finance Director role offers the highest salary, followed by Engineering and Marketing Directors,
-- indicating leadership roles have top compensation.

-- d) Which departments have the highest total salary allocation?

SELECT jd.jobdept, SUM(sb.amount) AS total_salary
FROM SalaryBonus sb
JOIN JobDepartment jd ON sb.Job_ID = jd.Job_ID
GROUP BY jd.jobdept
ORDER BY total_salary DESC;

-- Insight:
-- Finance and IT departments have the highest total salary allocation, showing higher budget and investment in these areas.


-- -----------------------------------------------------------------------------------------------------------------------
-- 										SECTION-03: QUALIFICATION AND SKILLS ANALYSIS
-- -----------------------------------------------------------------------------------------------------------------------


-- a) How many employees have at least one qualification listed?

SELECT COUNT(DISTINCT Emp_ID)
AS qualified_employees
FROM Qualification;

-- Insight:
-- All 60 employees have at least one qualification, indicating a fully skilled workforce.

-- b) Which positions require the most qualifications?

SELECT Position, COUNT(*)
AS total_requirements
FROM Qualification
GROUP BY Position
ORDER BY total_requirements DESC;

-- Insight:
-- All positions have equal qualification requirements, showing uniform skill expectations across roles.

-- c) Which employees have the highest number of qualifications?

SELECT Emp_ID, COUNT(*)
AS total_qualifications
FROM Qualification
GROUP BY Emp_ID
ORDER BY total_qualifications DESC;

-- Insight:
-- All employees have an equal number of qualifications, indicating a consistent skill distribution across the workforce.


-- -----------------------------------------------------------------------------------------------------------------------
-- 													SECTION 4: LEAVE & ABSENCE PATTERNS
-- -----------------------------------------------------------------------------------------------------------------------

-- a) Which year had the most employees taking leaves?

SELECT YEAR(date) AS year,
COUNT(DISTINCT emp_ID) AS total_employees
FROM Leaves
GROUP BY YEAR(date)
ORDER BY total_employees DESC;

-- Insight:
-- The year 2024 has the highest number of employees taking leaves, indicating peak leave activity in that year.

-- b) What is the average number of leave days taken by its employees per department?

SELECT jd.jobdept,
       AVG(leave_count) AS avg_leaves
FROM (
    SELECT emp_ID, COUNT(*)
    AS leave_count
    FROM Leaves
    GROUP BY emp_ID
) l
JOIN Employee e ON l.emp_ID = e.emp_ID
JOIN JobDepartment jd ON e.Job_ID = jd.Job_ID
GROUP BY jd.jobdept;

-- Insight:
-- All departments have an average of 1 leave per employee, showing uniform leave distribution across the organization.

-- c) Which employees have taken the most leaves?

SELECT emp_ID, COUNT(*)
AS total_leaves
FROM Leaves
GROUP BY emp_ID
ORDER BY total_leaves DESC;

-- Insight:
-- All employees have taken equal number of leaves, indicating no significant variation in leave patterns.

-- d) What is the total number of leave days taken company-wide?

SELECT COUNT(*)AS total_leave_days
FROM Leaves;

-- Insight:
-- The company has a total of 60 leave days, reflecting overall employee absence during the period.

-- e) How do leave days correlate with payroll amounts?

SELECT e.emp_ID,
       COUNT(l.leave_ID) AS total_leaves,
       AVG(p.total_amount) AS avg_salary
FROM Employee e
LEFT JOIN Leaves l ON e.emp_ID = l.emp_ID
JOIN Payroll p ON e.emp_ID = p.emp_ID
GROUP BY e.emp_ID
ORDER BY total_leaves DESC;

-- Insight:
-- Leave days show no significant impact on payroll amounts, as all employees have similar leave counts with varying salaries.


-- -----------------------------------------------------------------------------------------------------------------------
-- 										SECTION-05: PAYROLL AND COMPENSATION ANALYSIS
-- -----------------------------------------------------------------------------------------------------------------------

-- a) What is the total monthly payroll processed?

SELECT DATE_FORMAT(date, '%Y-%m') AS month,
       SUM(total_amount) AS total_payroll
FROM Payroll
GROUP BY DATE_FORMAT(date, '%Y-%m')
ORDER BY month;

-- Insight:
-- The total monthly payroll for April 2024 is 2,778,000, showing the overall salary payout for that period.

-- b) What is the average bonus given per department?

SELECT jd.jobdept,
AVG(sb.bonus) AS avg_bonus
FROM SalaryBonus sb
JOIN JobDepartment jd
ON sb.Job_ID = jd.Job_ID
GROUP BY jd.jobdept
ORDER BY avg_bonus DESC;

-- Insight:
-- The Legal and Engineering departments receive the highest average bonuses,
-- indicating higher incentives in these areas.

-- c) Which department receives the highest total bonuses?

SELECT jd.jobdept, SUM(sb.bonus) AS total_bonus
FROM SalaryBonus sb
JOIN JobDepartment jd ON sb.Job_ID = jd.Job_ID
GROUP BY jd.jobdept
ORDER BY total_bonus DESC
LIMIT 1;

-- Insight:
-- The Finance department receives the highest total bonuses, indicating strong incentive allocation in this area.

-- d) What is the average value of total_amount after considering leave deductions?

SELECT AVG(total_amount)
AS avg_net_salary
FROM Payroll;

-- Insight:
-- The average net salary after deductions is 46,300, reflecting the typical employee take-home pay.

-- -----------------------------------------------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------------------------
-- 											CTE (Common Table Expression)
-- 											used when queries get complex
-- ------------------------------------------------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------------------------

-- 1) Top Paid Employees using CTE

WITH salary_data AS (
    SELECT e.emp_ID,
           e.firstname,
           e.lastname,
           sb.amount
    FROM Employee e
    JOIN SalaryBonus sb
    ON e.Job_ID = sb.Job_ID
)
SELECT * FROM salary_data
ORDER BY amount DESC
LIMIT 5;

-- Insight:
-- The highest-paid employee earns 170,000,
-- followed by others earning 160,000 and 150,000, showing a clear salary gap at the top level.

-- 2) Identifying Above-average salary earners

WITH avg_salary AS (
    SELECT AVG(amount)
    AS avg_sal FROM SalaryBonus
)
SELECT e.emp_ID, e.firstname, sb.amount
FROM Employee e
JOIN SalaryBonus sb
ON e.Job_ID = sb.Job_ID, avg_salary
WHERE sb.amount > avg_salary.avg_sal;

-- Insight:
-- Employees earning above average have salaries ranging from 85,000 to 115,000,
-- indicating a group of consistently high-performing and well-compensated employees.

-- -----------------------------------------------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------------------------
-- 													WINDOW FUNCTIONS
-- 										used for Ranking, comparison and analytics
-- ------------------------------------------------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------------------------

-- 1) Rank Employees by Salary

SELECT e.emp_ID,
       e.firstname,
       sb.amount,
       RANK() OVER (ORDER BY sb.amount DESC)
       AS salary_rank
FROM Employee e
JOIN SalaryBonus sb ON e.Job_ID = sb.Job_ID;

-- Insight:
-- The highest-paid employee earns 170,000 and is ranked 1,
-- followed by others with slightly lower salaries, showing a clear salary hierarchy.
-- Employees with the same salary share the same rank, indicating tie handling in ranking (e.g., rank 3 appears twice).

-- 2) Dense Rank (No gaps)

SELECT e.emp_ID,
       e.firstname,
       sb.amount,
       DENSE_RANK() OVER (ORDER BY sb.amount DESC) AS rank_dense
FROM Employee e
JOIN SalaryBonus sb ON e.Job_ID = sb.Job_ID;

-- 3) Department-wise Ranking

SELECT jd.jobdept,
       e.emp_ID,
       sb.amount,
       RANK() OVER (PARTITION BY jd.jobdept
       ORDER BY sb.amount DESC)
       AS dept_rank
FROM Employee e
JOIN JobDepartment jd
ON e.Job_ID = jd.Job_ID
JOIN SalaryBonus sb
ON jd.Job_ID = sb.Job_ID;

-- Insight:
-- In each department, employees are ranked based on salary, helping identify top performers within each department.
-- For example,
-- in Engineering and Finance, the top-ranked employees earn significantly higher than others,
-- showing salary variation within departments.

-- -----------------------------------------------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------------------------
-- 													SUBQUERIES (Nested Queries)
-- ------------------------------------------------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------------------------

-- 1) Employees earning more than avg

SELECT e.emp_ID, e.firstname,
sb.amount
FROM Employee e
JOIN SalaryBonus sb
ON e.Job_ID = sb.Job_ID
WHERE sb.amount > (
    SELECT AVG(amount)
    FROM SalaryBonus);


-- Insight:
-- mployees earning above average have salaries ranging from 80,000 to 115,000,
-- showing a group of high-performing and well-compensated employees.
-- This indicates a salary gap between average earners and top performers.

-- 2) Employees with max leaves
        
SELECT emp_ID, COUNT(*) AS total_leaves
FROM Leaves
GROUP BY emp_ID
HAVING COUNT(*) = (
    SELECT MAX(leave_count)
    FROM (
        SELECT COUNT(*) AS leave_count
        FROM Leaves
        GROUP BY emp_ID
    ) AS sub);

-- Insight:
-- All listed employees have taken the same maximum number of leaves (1),
-- indicating no single employee has significantly higher leave usage.
-- This shows a uniform leave pattern across employees.

-- -----------------------------------------------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------------------------
-- 															BONUS
-- ------------------------------------------------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------------------------

-- 1) Salary vs Leaves Impact

SELECT e.emp_ID,
       sb.amount AS base_salary,
       COUNT(l.leave_ID) AS total_leaves,
       (sb.amount - (COUNT(l.leave_ID) * 100)) AS estimated_salary
FROM Employee e
JOIN SalaryBonus sb ON e.Job_ID = sb.Job_ID
LEFT JOIN Leaves l ON e.emp_ID = l.emp_ID
GROUP BY e.emp_ID, sb.amount;

-- Insights:
-- All employees have taken 1 leave each, resulting in a fixed deduction of 100 from their base salary.
-- This shows a direct and consistent impact of leaves on salary, where each leave reduces the salary by a fixed amount.







-- ------------------------------------------------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------------------------
