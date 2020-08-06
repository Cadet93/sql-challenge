SELECT titles.title, AVG(salaries.salary) AS "Average Salary"
FROM titles
JOIN employees ON titles.emp_title_id = employees.emp_title_id
JOIN salaries ON employees.emp_no = salaries.emp_no
GROUP BY titles.title;

