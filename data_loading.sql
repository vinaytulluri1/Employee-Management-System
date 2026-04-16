
-- -----------------------------------------------------------------------------------------------------------------------
-- -----------------------------------------------------------------------------------------------------------------------
-- 									SQL PROJECT: EMPLOYEE MANAGEMENT SYSTEM
-- -----------------------------------------------------------------------------------------------------------------------
-- -----------------------------------------------------------------------------------------------------------------------

-- -----------------------------------------------------------------------------------------------------------------------
-- 													DATA LOADING INTO TABLE
-- -----------------------------------------------------------------------------------------------------------------------

USE employee_management;

-- Loading data into each tables (in CSV files) into the each tables

-- checking path
SHOW VARIABLES LIKE 'secure_file_priv';

-- 1. JobDepartment Data Load
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/JobDepartment.csv'
INTO TABLE JobDepartment
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

-- 2. SalaryBonus Table Data Load
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Salary_Bonus.csv'
INTO TABLE SalaryBonus
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

-- 3. Employee Data Load
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Employee.csv'
INTO TABLE Employee
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

-- 4. Qualification Data Load
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Qualification.csv'
INTO TABLE Qualification
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

-- 5. Leaves Data Load
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Leaves.csv'
INTO TABLE Leaves
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

-- 6. Payroll Data Load
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Payroll.csv'
INTO TABLE Payroll
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;