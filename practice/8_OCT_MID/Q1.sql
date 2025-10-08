--1
select d.department_name, count(e.first_name) from departments d inner join employees e on d.department_id = e.department_id group by department_name 
having count(e.first_name) > 5;
--2
select e.first_name,e.salary,d.department_name, (select AVG(e1.salary) from employees e1 WHERE e1.department_id = e.department_id) AS avg_dept_salary from employees e
inner join departments d on e.department_id = d.department_id where e.salary > (select AVG(e2.salary) from employees e2 where e2.department_id = d.department_id);
--3
select first_name,salary,job_id from (select e.first_name,e.salary,e.job_id from employees e order by (salary) desc) where ROWNUM <= 5;
--4
select e.first_name,e.job_id from employees e where e.job_id = (SELECT job_id FROM employees WHERE first_name = 'Peter' AND last_name = 'Tucker') and  (first_name <> 'Peter' OR last_name <> 'Tucker');
--5
select c.country_name from countries c where c.country_id = (select l.country_id from locations l where l.location_id = (select d.location_id from departments d
where d.department_id = (select e.department_id from employees e group by e.department_id having count(e.first_name) = (SELECT MAX(COUNT(first_name)) 
FROM employees GROUP BY department_id))));
--6
select distinct e.job_id from employees e inner join departments d on e.department_id = d.department_id where (select AVG(e1.salary) from employees e1 where e1.department_id
 = d.department_id) > (select AVG(salary) from employees);
--7
select e.first_name from employees e where e.salary > ANY(select salary from employees e where department_id = (select department_id from departments where department_name = 'Sales'));
--8
SELECT department_name FROM departments WHERE department_id NOT IN (SELECT DISTINCT department_id FROM employees WHERE department_id IS NOT NULL);
--9
select e.first_name,e.hire_date,m.first_name,m.hire_date from employees e inner join employees m on e.manager_id = m.employee_id;
--10
select e.first_name from employees e inner join departments d on e.department_id = d.department_id where 
e.salary < (select AVG(e1.salary) from employees e1 where e1.department_id = d.department_id) and 
e.salary > (select AVG(e2.salary) from employees e2 WHERE e2.job_id = e.job_id);
select * from employees;
select * from departments;
select * from LOCATIONS;
select * from COUNTRIES;
