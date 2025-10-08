select * from employees;
select * from departments;
select * from locations;
select * from countries;

--1
select e.first_name,e.job_id,d.department_name,l.city from employees e inner join departments d on e.department_id = d.department_id 
inner join locations l on d.location_id = l.location_id;
--2
select e.employee_id,e.first_name,e.salary,e.department_id from employees e inner join departments d on e.department_id = d.department_id
where e.salary > (select AVG(e1.salary) from employees e1 where e1.department_id = d.department_id);
--3
select e.employee_id,e.first_name,d.department_name from employees e inner join departments d on e.department_id = d.department_id
where e.department_id = (select e1.department_id from employees e1 where e1.first_name = 'Steven' and last_name = 'King') and 
(first_name <> 'Steven' OR last_name <> 'King');
--4
select d.department_name,e.first_name,e.salary from departments d inner join employees e on d.department_id = e.department_id
where e.salary = (select (MAX(e1.salary)) from employees e1 where e1.department_id = d.department_id);
--5
select l.city from locations l inner join departments d on l.location_id = d.location_id inner join employees e on d.department_id = e.department_id
group by l.city having count(e.first_name) = (SELECT MAX(COUNT(*)) FROM employees e2 INNER JOIN departments d2 ON e2.department_id = d2.department_id
INNER JOIN locations l2 ON d2.location_id = l2.location_id GROUP BY l2.city);
-- 5(2)
select l.city from locations l where l.location_id = (select d.location_id from departments d where d.department_id = 
(select e.department_id from employees e group by e.department_id having count(e.first_name) = (select MAX(count(*)) from employees e1 group by 
e1.department_id)));
--6
select d.department_name, m.first_name,COUNT(e.first_name) from departments d inner join employees m on d.department_id = m.department_id inner join
employees e on m.employee_id = e.manager_id group by d.department_name,m.first_name;
--7
select e.first_name, e.hire_date, m.first_name from employees e inner join employees m on e.manager_id = m.employee_id where e.hire_date < m.hire_date;
--8
select e.job_id, AVG(e.salary) as avg_salary from employees e group by e.job_id having AVG(e.salary) > 10000;
--9
select d.department_id,d.department_name from departments d where d.department_id 
NOT IN(select e.department_id from employees e where e.department_id = d.department_id);
--10
select e.first_name,e.salary,e.commission_pct from employees e where e.commission_pct = (select MAX(e1.commission_pct) from employees e1);
