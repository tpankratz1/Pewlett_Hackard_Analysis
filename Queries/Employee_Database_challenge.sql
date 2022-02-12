-- Module 7 Challenge: Deliverable 1 Queries

-- Create a Retirement Titles table for employees who are born between January 1, 1952 and December 31, 1955.

SELECT * FROM employees e;

SELECT
e.emp_no,
e.first_name,
e.last_name,
t.title,
t.from_date,
t.to_date
INTO retirement_titles
FROM employees AS e
LEFT JOIN titles AS t
ON (e.emp_no = t.emp_no)
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY emp_no, to_date ASC
;

SELECT * FROM retirement_titles;


-- Create a Unique Titles table that contains the employee number, first and last name, and most recent title. Use Distinct with Orderby to remove duplicate rows.

SELECT DISTINCT ON (rt.emp_no) rt.emp_no,
rt.first_name,
rt.last_name,
rt.title
INTO unique_titles
FROM retirement_titles AS rt
WHERE to_date = '9999-01-01'
ORDER BY emp_no, to_date DESC
;

SELECT * FROM unique_titles;


-- Create a Retiring Titles table that contains the number of titles filled by employees who are retiring.

SELECT COUNT(ut.title),
ut.title
INTO retiring_titles
FROM unique_titles as ut
GROUP BY title
ORDER BY count DESC
;

SELECT * FROM retiring_titles;



-- Module 7 Challenge: Deliverable 2 Queries

-- Create a Mentorship Eligibility table for current employees who were born between January 1, 1965 and December 31, 1965.

SELECT DISTINCT ON (e.emp_no) e.emp_no,
e.first_name,
e.last_name,
e.birth_date,
de.from_date,
de.to_date,
t.title
INTO mentorship_eligibilty
FROM employees AS e
INNER JOIN dept_emp AS de
ON (e.emp_no = de.emp_no)
INNER JOIN titles as t
ON (e.emp_no = t.emp_no)
WHERE (de.to_date = '9999-01-01')
AND (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
ORDER BY e.emp_no
;

SELECT * FROM mentorship_eligibilty;


-- Summary queries

-- Total roles that will need to filled

SELECT COUNT(unique_titles.title) from unique_titles;


-- Eligible mentors by title

SELECT COUNT(me.title),
me.title
FROM mentorship_eligibilty as me
GROUP BY title
ORDER BY count DESC
;