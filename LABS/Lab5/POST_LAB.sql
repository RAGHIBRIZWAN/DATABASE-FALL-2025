-- POST LAB
-- Q11
select * from students s inner group by e.salaryjoin teachers t on s.departments
-- Q12
select * from employees e left join employees em on e.manager_id = em.emp_id;
-- Q13
select * from employees e left join departments d on e.dept_id = d.dept_id where e.dept_id IS NULL;
-- Q14
select d.dept_name,AVG(e.salary) as Avg_Salary from departments d inner join employees e on d.dept_id = e.dept_id group by d.dept_name having AVG(e.salary) > 50000;
-- Q15
select * from employees e join departments d on e.dept_id = d.dept_id where e.salary > ( select AVG(salary) from Employees where dept_id = e.dept_id);
-- Q16
select distinct d.dept_name from departments d inner join employees e on d.dept_id = e.dept_id where d.dept_id NOT IN(select em.dept_id from employees em where em.salary < 30000);
-- Q17
select * from students s inner join courses c on s.course_id = c.course_id where s.city = 'Lahore';
-- Q18
select e.emp_name,m.emp_name,d.dept_name from employees e inner join DEPARTMENTS d on e.dept_id = d.dept_id inner join employees m on e.manager_id = m.emp_id
where e.hire_date between to_date('01-01-2020','DD-MM-YYYY') and to_date('01-01-2023','DD-MM-YYYY'); -- Babar is dropped because his dept_is is NULL and Rizwan is dropped because his manager_id is NULL.
-- Q19
select * from students s inner join teachers t on s.course_id = t.course_id where teacher_name = 'Sir Ali';
-- Q20
select * from employees e inner join employees m on e.manager_id = m.emp_id where e.dept_id = m.dept_id;
