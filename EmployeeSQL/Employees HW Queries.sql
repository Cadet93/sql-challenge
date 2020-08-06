DROP TABLE titles;
CREATE TABLE titles (
	emp_title_id VARCHAR(30),
	title VARCHAR(100),
	PRIMARY KEY (emp_title_id)
);

SELECT * FROM titles;

CREATE TABLE departments (
	dept_no VARCHAR(100),
	dept_name VARCHAR(100),
	PRIMARY KEY (dept_no)
);

SELECT * FROM departments;

DROP TABLE employees;
CREATE TABLE employees (
	emp_no INTEGER NOT NULL,
	emp_title_id VARCHAR(30) NOT NULL,
	birth_date VARCHAR(10) NOT NULL,
	first_name VARCHAR(100) NOT NULL,
	last_name VARCHAR(100) NOT NULL,
	sex VARCHAR(1) NOT NULL,
	hire_date VARCHAR(10) NOT NULL,
	PRIMARY KEY (emp_no),
	FOREIGN KEY (emp_title_id) REFERENCES titles(emp_title_id)
);

SELECT * FROM EMPLOYEES;

CREATE TABLE dept_manager_junction (
	dept_no VARCHAR(30),
    emp_no INTEGER,
	PRIMARY KEY (emp_no, dept_no),
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no),
	FOREIGN KEY (dept_no) REFERENCES departments(dept_no)
);

SELECT * FROM dept_manager_junction;

CREATE TABLE dept_emp_junction (
	emp_no INTEGER,
	dept_no VARCHAR(30),
    PRIMARY KEY (emp_no, dept_no),
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no),
	FOREIGN KEY (dept_no) REFERENCES departments(dept_no)
);

SELECT * FROM dept_emp_junction;

CREATE TABLE salaries (
	emp_no INT,
	salary INT,
	PRIMARY KEY (emp_no),
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no)
);

SELECT * FROM salaries;

--analysis #1
SELECT e.emp_no, e.last_name, e.first_name, e.sex, s.salary
FROM employees e
INNER JOIN salaries s ON
e.emp_no = s.emp_no
ORDER BY e.emp_no;

--analysis #2
SELECT first_name, last_name, hire_date
FROM employees
WHERE hire_date LIKE '%1986%'
ORDER BY last_name;

--analysis #3
SELECT departments.dept_no, departments.dept_name, employees.emp_no, employees.last_name, employees.first_name
FROM dept_manager_junction
JOIN employees ON dept_manager_junction.emp_no = employees.emp_no
JOIN departments on dept_manager_junction.dept_no = departments.dept_no;

--analysis #4
SELECT employees.emp_no, employees.last_name, employees.first_name, departments.dept_name
FROM dept_emp_junction
LEFT JOIN departments ON dept_emp_junction.dept_no = departments.dept_no
LEFT JOIN employees ON dept_emp_junction.emp_no = employees.emp_no;

--analysis #5
SELECT first_name, last_name, sex
FROM employees
WHERE first_name = 'Hercules' AND  last_name LIKE 'B%'
ORDER BY last_name;

--analysis #6
SELECT employees.emp_no, employees.last_name, employees.first_name, departments.dept_name
FROM dept_emp_junction
LEFT JOIN departments ON dept_emp_junction.dept_no = departments.dept_no
LEFT JOIN employees ON dept_emp_junction.emp_no = employees.emp_no
WHERE departments.dept_name = 'Sales'
ORDER BY last_name;

--analysis #7
SELECT employees.emp_no, employees.last_name, employees.first_name, departments.dept_name
FROM dept_emp_junction
LEFT JOIN departments ON dept_emp_junction.dept_no = departments.dept_no
LEFT JOIN employees ON dept_emp_junction.emp_no = employees.emp_no
WHERE departments.dept_name IN ('Sales', 'Development')
ORDER BY last_name;

--analysis #8
SELECT last_name, COUNT(last_name) AS "Total of Employee Last Names"
FROM employees
GROUP BY last_name
ORDER BY "Total of Employee Last Names" DESC;
ORDER BY last_name DESC;

--searching my employee id
SELECT e.emp_no, e.first_name, e.last_name, s.salary, t.title
FROM employees e
LEFT JOIN salaries s ON e.emp_no = s.emp_no
LEFT JOIN titles t ON e.emp_title_id = t.emp_title_id
WHERE e.emp_no = 499942;

