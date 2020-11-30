-- Get those employees who are born between 1952 and 1955
SELECT e.emp_no,
    e.first_name,
e.last_name,
t.title,
t.from_date,
t.to_date
INTO retirement_titles
FROM employees as e
INNER JOIN titles as t
ON (e.emp_no = t.emp_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY emp_no ASC;

-- Remove duplicates from retirement_titles (those who have moved jobs within the organization)
SELECT DISTINCT ON (emp_no) emp_no,
first_name,
last_name,
title
INTO unique_titles
FROM retirement_titles as rt
ORDER BY emp_no ASC, rt.to_date DESC;

-- Create a view of unique titles grouped by job title and sorted by count descending
SELECT title, COUNT(title)
INTO retiring_titles
FROM unique_titles
GROUP BY title
ORDER BY COUNT(title) DESC;
