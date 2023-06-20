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