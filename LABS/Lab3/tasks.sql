-- IN LAB

-- Q1
create table employees(
    emp_id int primary key,
    emp_name varchar(20),
    salary int check (salary > 20000),
    dept_id int
);

select * from employees;

-- Q2
alter table employees rename column emp_name to full_name;

-- Q3
alter table employees drop column salary;
alter table employees add salary int;
insert into employees(emp_id,full_name,salary,dept_id) values(1,'Raghib',5000,5);

-- Q4
create table departments(
    dept_id int primary key,
    dept_name varchar(20) unique
);

insert into departments (dept_id, dept_name) values (101, 'HR');
insert into departments (dept_id, dept_name) values (102, 'IT');
insert into departments (dept_id, dept_name) values (103, 'Finance');
select * from departments;

-- Q5
alter table employees add constraint fk_dept_id foreign key (dept_id) references departments(dept_id);

-- Q6
alter table employees add bonus number(6,2) default 1000;

-- Q7
alter table employees add city varchar(20) default 'karachi';
alter table employees add age int check(age > 18);

-- Q8
insert into employees(emp_id,full_name,salary,dept_id) values(2,'Fahad',10000,2);
insert into employees(emp_id,full_name,salary,dept_id) values(3,'Talha',15000,3);
delete from employees where emp_id IN(1,3);

-- Q9
alter table employees modify full_name varchar(20);
alter table employees modify city varchar(20);

-- Q10
alter table employees add email varchar(20) unique;

-- POST LAB

-- Q11
alter table employees add constraint unique_bonus unique(bonus);
insert into employees (emp_id, full_name, salary, dept_id, bonus, age) values (2, 'Sara', 30000, 101, 2000, 25);
insert into employees (emp_id, full_name, salary, dept_id, bonus, age) values (3, 'Raghib', 40000, 102, 2000, 20);

-- Q12
alter table employees add (dob DATE);
alter table employees add constraint check_dob check (dob <= date '2007-01-01');

-- Q13
select * from employees;
insert into employees (emp_id,full_name,dept_id,salary,bonus,city,dob) values (13,'Rabani',103,45000,2500,'Islamabad',TO_DATE('2020-01-01', 'YYYY-MM-DD'));

-- Q14
alter table employees drop CONSTRAINT fk_dept_id;
insert into employees (emp_id, full_name, salary, dept_id, bonus, age, dob) values (5, 'Rizwan', 28000, 999, 4000, 22, '1998-05-05');
alter table employees add CONSTRAINT fk_dept_id FOREIGN KEY (dept_id) REFERENCES departments(dept_id);

-- Q15
alter table employees drop column age;
alter table employees drop column city;

-- Q16
select d.dept_id, d.dept_name,e.emp_id, e.full_name from departments d join employees e on d.dept_id = e.dept_id;

-- Q17
alter table employees rename column salary to monthly_salary;

-- Q18
select * from departments d where d.dept_id NOT IN(SELECT dept_id FROM employees e where d.dept_id = e.dept_id);

-- Q19
delete from students;

-- Q20
select dept_id,emp_count from (SELECT dept_id,count(*) as emp_count FROM employees group by (dept_id)order by emp_count desc) where rownum = 1 ;
