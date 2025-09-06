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
