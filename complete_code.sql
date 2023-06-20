------------------------------------------------------------------------------------------------------------------
/* -------------------------------  DATA ENGINEERING  ------------------------------------------------------------
Use the provided information to create a table schema for each of the six CSV files. Be sure to do the following:
Remember to specify the data types, primary keys, foreign keys, and other constraints.
For the primary keys, verify that the column is unique. Otherwise, create a composite keyLinks to an external site., 
	which takes two primary keys to uniquely identify a row.
Be sure to create the tables in the correct order to handle the foreign keys.
Import each CSV file into its corresponding SQL table.*/


/*Drop table departments;
Drop table employees;
drop table dept_emp;
drop table dept_manager;
drop table salaries;
drop table titles;*/

--Creating table departments
Create Table departments(
	dept_no varchar PRIMARY KEY NOT NULL,
	dept_name varchar(20)
);

--Creating table titles 
Create Table titles(
	title_id varchar PRIMARY KEY NOT NULL,
	title varchar
);

-- Creating table employees
Create Table employees(
	emp_no int PRIMARY KEY NOT NULL,
	emp_title_id varchar,
	birth_date date,
	first_name varchar(20),
	last_name varchar(20),
	sex char(1),
	hire_date date,
	FOREIGN KEY (emp_title_id) REFERENCES titles(title_id)
);

-- Creating table department employees
Create Table dept_emp(
	emp_no int NOT NULL,
	dept_no varchar NOT NULL,
	PRIMARY KEY (emp_no, dept_no),
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no),
	FOREIGN KEY (dept_no) REFERENCES departments(dept_no)
);

-- Creating table department managers
Create Table dept_manager(
	dept_no varchar NOT NULL,
	emp_no int NOT NULL,
	PRIMARY KEY  (dept_no, emp_no),
	FOREIGN KEY (dept_no) REFERENCES departments(dept_no),
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no)
);

--Creating table salaries
Create Table salaries(
	emp_no int,
	salary int NOT NULL,
	PRIMARY KEY (emp_no),
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no)
);

--Checking tables 
SELECT * FROM departments;
SELECT * FROM titles;
SELECT * FROM employees;
SELECT * FROM dept_emp;
SELECT * FROM dept_manager;
SELECT * FROM salaries;
	
----------------------------------------------------------------------------------------------
--*********************** DATA ANALYSIS  *****************************************************
----------------------------------------------------------------------------------------------

--List the employee number, last name, first name, sex, and salary of each employee (2 points)
SELECT 
    employees.emp_no,
    employees.last_name,
    employees.first_name,
    employees.sex,
    salaries.salary
FROM
    employees
JOIN
    salaries ON employees.emp_no = salaries.emp_no;

--List the first name, last name, and hire date for the employees who were hired in 1986 (2 points)
SELECT 
	first_name,
	last_name,
	hire_date
FROM
	employees 
WHERE 
	hire_date >= '1986-01-01' AND hire_date <= '1986-12-31';

--List the manager of each department along with their department number, department name, employee number, last name, and first name (2 points)
SELECT
	departments.dept_no,
	departments.dept_name,
	dept_manager.emp_no,
	employees.last_name,
	employees.first_name
FROM
	departments 
JOIN
	dept_manager ON departments.dept_no = dept_manager.dept_no
JOIN
	employees ON dept_manager.emp_no = employees.emp_no;
--List the department number for each employee along with that employee’s employee number, last name, first name, and department name (2 points)
SELECT 
	dept_emp.dept_no,
	dept_emp.emp_no,
	employees.last_name,
	employees.first_name,
	departments.dept_name
FROM
	employees
JOIN
	dept_emp on employees.emp_no = dept_emp.emp_no
JOIN
	departments on dept_emp.dept_no = departments.dept_no;
--List first name, last name, and sex of each employee whose first name is Hercules and whose last name begins with the letter B (2 points)
SELECT 
	first_name,
	last_name,
	sex
FROM
	employees
WHERE
	first_name = 'Hercules' AND	last_name LIKE 'B%';
--List each employee in the Sales department, including their employee number, last name, and first name (2 points)
SELECT
	departments.dept_name,
	employees.emp_no,
	employees.last_name,
	employees.first_name
FROM
	employees
JOIN
	dept_emp on employees.emp_no = dept_emp.emp_no
JOIN
	departments on dept_emp.dept_no = departments.dept_no 
WHERE 
	departments.dept_no = 'd007'; 
--List each employee in the Sales and Development departments, including their employee number, last name, first name, and department name (4 points)
SELECT
	departments.dept_name,
	employees.emp_no,
	employees.last_name,
	employees.first_name
FROM
	employees
JOIN
	dept_emp on employees.emp_no = dept_emp.emp_no
JOIN
	departments on dept_emp.dept_no = departments.dept_no 
WHERE 
	departments.dept_name IN ( 'Sales', 'Development');
--List the frequency counts, in descending order, of all the employee last names (that is, how many employees share each last name) (4 points)
SELECT
	last_name, COUNT(*) AS frequency
FROM 
	employees
GROUP BY
	last_name
ORDER BY
	frequency DESC;