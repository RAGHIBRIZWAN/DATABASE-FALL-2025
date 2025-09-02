-- IN LAB

select sum(salary) as total_salary from employees;
select avg(salary) as average_salary from employees;
select count(*) as number_of_employees from employees group by(manager_id);
select * from employees where salary = (select min(salary) from employees);
select to_char(sysdate,'DD-MM-YYYY') from dual;
select to_char(sysdate,'DAY MONTH YYYY') from dual;
select hire_date from employees where to_char(hire_date,'DAY') = 'WEDNESDAY';
select months_between('01-JAN-2025','01-OCT-2024') from dual;
select first_name, months_between(sysdate,hire_date) as months_worked from employees;
select last_name, substr(last_name,1,5) as first_five_chars from employees;

--POST LAB

select first_name, lpad(first_name,15,'*') as padded from employees;
select ltrim(' oracle') from dual;
select initcap(first_name) from employees;
select next_day('20-AUG-2022','MONDAY') from dual;
select to_char(to_date('25-DEC-2023'),'MM-YYYY') from dual;
select distinct salary from employees order by salary asc;
select first_name,salary,round(salary,-2) as rounded from employees;
select department_id from employees group by department_id having count(employee_id) = ( select max(count(employee_id)) from employees group by department_id);
select department_id, sum(salary) as total_salary from employees group by department_id order by total_salary desc;
select department_id from employees group by department_id having count(employee_id) = ( select max(count(employee_id)) from employees group by department_id);
