1) select first_name,salary from employees where salary > (select AVG(salary) from employees);
3) select e.first_name,e.job_id,e.salary,e.commission_pct from employees e where e.commission_pct > (select AVG(e1.commission_pct) 
from employees e1 where e1.job_id = e.job_id);
4) SELECT e.first_name,e.hire_date,d.department_name FROM employees e JOIN departments d ON e.department_id = d.department_id WHERE
(EXTRACT(YEAR FROM e.hire_date), e.department_id) IN ( SELECT EXTRACT(YEAR FROM hire_date), department_id FROM employees GROUP BY
EXTRACT(YEAR FROM hire_date), department_id HAVING COUNT(employee_id) = ( SELECT MAX(hire_count) FROM ( SELECT COUNT(employee_id) AS hire_count FROM
5)employees GROUP BY EXTRACT(YEAR FROM hire_date), department_id) AS DepartmentYearHires)) ORDER BY d.department_name, e.hire_date;
select d.department_name,count(e.employee_id) as number_of_employees from departments d join employees e on d.DEPARTMENT_ID = e.DEPARTMENT_ID where
e.salary > 5000 group by d.department_name having count(e.employee_id)>3 order by number_of_employees DESC;
