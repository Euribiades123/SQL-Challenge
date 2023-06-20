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
	
