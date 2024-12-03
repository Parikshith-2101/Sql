USE db_1;
CREATE TABLE employee (
    employee_id INT PRIMARY KEY, 
    first_name NVARCHAR(50),
    last_name NVARCHAR(50),
    department NVARCHAR(50),
    salary DECIMAL(18, 2)
);

INSERT INTO employee (employee_id, first_name, last_name, department, salary)
VALUES 
(1, 'John', 'Doe', 'IT', 75000.00),
(2, 'Jane', 'Smith', 'HR', 65000.00),
(3, 'Michael', 'Johnson', 'Finance', 80000.00),
(4, 'Emily', 'Davis', 'Marketing', 70000.00),
(5, 'Chris', 'Martinez', 'Sales', 72000.00),
(6, 'Sarah', 'Garcia', 'IT', 77000.00),
(7, 'David', 'Lopez', 'HR', 68000.00),
(8, 'Anna', 'Wilson', 'Finance', 79000.00),
(9, 'James', 'Taylor', 'Marketing', 71000.00),
(10, 'Linda', 'Anderson', 'Sales', 73000.00);


SELECT * FROM employee;

--Stored procedure--

CREATE PROCEDURE GetEmployeeDetails @department varchar(10)
AS
BEGIN
    SELECT *
    FROM employee
    WHERE department = @department;
END;

EXEC GetEmployeeDetails @department = 'IT';

drop procedure GetEmployeeDetails;

--function--

CREATE FUNCTION GetEmployeesByDepartment (@Department NVARCHAR(50))
RETURNS TABLE
AS
RETURN
(
    SELECT employee_id, first_name, last_name, salary
    FROM employee
    WHERE department = @Department
);

SELECT * FROM dbo.GetEmployeesByDepartment('HR');

--trigger--

CREATE TRIGGER EmployeeSalaryUpdate
ON employee
AFTER UPDATE
AS
BEGIN
    PRINT 'Employee salary has been updated.';
END;

--cursor--

DECLARE my_cursor CURSOR SCROLL FOR
SELECT employee_id, first_name, last_name
FROM employee
WHERE department = 'HR';

OPEN my_cursor;

FETCH FIRST FROM my_cursor;

FETCH ABSOLUTE 2 FROM my_cursor;

DEALLOCATE my_cursor;