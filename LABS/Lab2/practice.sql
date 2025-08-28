select count(*) as total_emp from EMPLOYEES;
select count(*) as total_emp, manager_id from EMPLOYEES group by(manager_id);
select distinct manager_id from employees;
select manager_id from employees group by(manager_id);
select sum(salary) from employees;
select sum(salary)as salary, manager_id from employees group by(manager_id);
select max(salary) as salary from employees;
select max(salary) as salary, manager_id from employees group by (manager_id);
select min(salary) as salary, manager_id from employees group by (manager_id);
select min(salary) as salary from employees;
select avg(salary) as salary from employees;
select avg(salary) as salary, manager_id from employees group by (manager_id);
select * from EMPLOYEES;
select manager_id from employees where salary = (select max(salary) from employees);
select first_name || ' ' || salary as concatenate from employees; 
select salary from employees order by (salary) desc;
select salary as salary,manager_id from employees order by (manager_id) desc;
select salary from employees order by (salary) asc;
select salary as salary,manager_id from employees order by (manager_id) asc;
select distinct manager_id as manager_id from employees order by(manager_id) asc;
select count(*) as total from employees where first_name like 'A%';
select first_name as total from employees where first_name like 'A__t%';

-- Dual Table

select * from dual;
select abs(-20) from dual;
select ceil(2.3) from dual;
select floor(2.9) from dual;
select round(2.5) from dual;
select trunc(8580.58,1) from dual;
select greatest(10,20,30) from dual;
select least(10,20,30) from dual;

-- String functions

select lower('RAGHIB') from dual;
select upper('raghib') from dual;
select first_name, lower(first_name) from employees;
select first_name, upper(first_name) from employees;
select initcap('the Soap') from dual;
select length('Raghib') from dual;
select ltrim('    Raghib Rizwan') from dual;
select rtrim('Raghib Rizwan    ') from dual;
select substr('Raghib Rizwan',8,4) from dual;
select rpad('hell',5,'*') from dual;

-- Date Functions

select add_months('30-JUN-2005',2) from dual;
select months_between('30-OCT-2005','30-JUN-2005') from dual;
select next_day('30-JUN-2005','Friday') from dual;

-- Conversion Functions

select to_char(sysdate, 'DD-MM-YY') from dual;
select to_char(sysdate) from dual;
select to_char(sysdate, 'DAY') from dual;
select * from employees where to_char(hire_date,'DAY') like 'SATURDAY%';       
select to_char(hire_date,'DAY') from employees;
