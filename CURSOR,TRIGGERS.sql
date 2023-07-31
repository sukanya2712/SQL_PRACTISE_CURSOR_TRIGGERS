------------------------------------------------------triggers---------------------------------------------------------

CREATE TABLE employeeTriggers (
  employee_id INT PRIMARY KEY,
  first_name VARCHAR(50) NOT NULL,
  last_name VARCHAR(50) NOT NULL,
  email VARCHAR(100) NOT NULL,
  hire_date DATE NOT NULL,
  salary DECIMAL(10, 2) NOT NULL,
  department VARCHAR(100) NOT NULL
);

INSERT INTO employeeTriggers (employee_id, first_name,last_name, email, hire_date, salary, department)
VALUES
  (1,'John', 'Doe', 'john.doe@example.com', '2023-01-15', 55000.00, 'Human Resources');
  

  INSERT INTO employeeTriggers (employee_id, first_name,last_name, email, hire_date, salary, department)
VALUES
  (2,'John', 'Doe', 'john.doe@example.com', '2023-01-15', 25000.00, 'Human Resources');

CREATE TRIGGER employeetrigger 
ON employeeTriggers
AFTER INSERT
AS
  declare @emp_SALARY INT;
 
  select @emp_SALARY =i.salary from inserted i;


if @emp_SALARY<30000
   BEGIN 
   PRINT 'less salary'
   ROLLBACK
   END
ELSE 
   BEGIN
   PRINT 'salary INSERTED SUCEEFULLY'
   END


   -----------------------------------------------ddl triggers DATABSE USE=> PROBLEMSOL-------------------------
   CREATE TRIGGER DDLTRIGGER
   ON DATABASE
   FOR CREATE_TABLE
   AS
   BEGIN
   PRINT 'cannot create table in this database'
   ROLLBACK TRANSACTION
   END

   CREATE TABLE EMPLOYEEDDL(
   EMP_ID INT ,
   EMP_NAME VARCHAR(50),
   EMP_DEPT VARCHAR(50));

   ---------------------------------------
   CREATE TRIGGER trgServerAll
   ON ALL SERVER
   FOR DDL_TABLE_EVENTS
   AS 
   BEGIN 
   PRINT 'YOU CANNOT create,alter,drop a table in database'
   ROLLBACK TRANSACTION 
   END


   CREATE TRIGGER trgTableAll
   ON DATABASE
   FOR DDL_TABLE_EVENTS
   AS 
   BEGIN 
   PRINT 'YOU CANNOT create,alter,drop a table in database'
   ROLLBACK TRANSACTION 
   END

   

   -----------------------------------------------------cursors-------------------------------

   CREATE TABLE employeescursor (
  employee_id INT PRIMARY KEY,
  first_name VARCHAR(50) NOT NULL,
  last_name VARCHAR(50) NOT NULL,
  department VARCHAR(100) NOT NULL,
  salary DECIMAL(10, 2) NOT NULL
);

INSERT INTO employeescursor (employee_id, first_name,last_name, department, salary)
VALUES
  (1,'John', 'Doe', 'HR', 55000.00),
  (2,'Jane', 'Smith', 'Marketing', 62000.00),
  (3,'Michael', 'Johnson', 'Sales', 72000.00),
  (4,'Emily', 'Williams', 'Finance', 60000.00);



  DECLARE @emp_id INT;
DECLARE @first_name VARCHAR(50);
DECLARE @last_name VARCHAR(50);
DECLARE @dept VARCHAR(100);
DECLARE @emp_salary DECIMAL(10, 2);

-- Declare the cursor
DECLARE emp_cursor CURSOR FOR
  SELECT employee_id, first_name, last_name, department, salary
  FROM employeescursor;

-- Open the cursor
OPEN emp_cursor;

-- Fetch the first row
FETCH NEXT FROM emp_cursor INTO @emp_id, @first_name, @last_name, @dept, @emp_salary;

-- Loop through the cursor
WHILE @@FETCH_STATUS = 0
BEGIN
  -- Display employee data
  SELECT CONCAT('ID: ', @emp_id, ', Name: ', @first_name, ' ', @last_name, ', Department: ', @dept, ', Salary: ', @emp_salary);  

  -- Fetch the next row
  FETCH NEXT FROM emp_cursor INTO @emp_id, @first_name, @last_name, @dept, @emp_salary;
END;

-- Close the cursor
CLOSE emp_cursor;

-- Deallocate the cursor
DEALLOCATE emp_cursor;
