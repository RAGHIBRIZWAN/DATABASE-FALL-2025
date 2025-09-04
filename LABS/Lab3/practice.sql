create table students(
    id int primary key,
    std_name varchar(3),
    email varchar(20),
    age int,
    check(age >= 18)
);

select * from students;
alter table students add salary int;
alter table students add (city varchar(20) default 'Karachi', dept_id int);
-- Add Single Constraint
alter table students add constraint unique_email unique(email);
-- modify multiple columns
alter table students modify(std_name varchar(20) not null, email varchar(20) not null);
-- Add multiple constraints
alter table students add(constraint check_age check(age between 18 and 30), constraint unique_email unique(email));

create table departments(
    id int primary key,
    dept_name varchar(20) not null
);

select * from departments;
insert into DEPARTMENTS(id, dept_name) values(4,'AI');

alter table students drop column dept_id;
select * from students;

alter table students add(dept_id int, foreign key(dept_id) references departments(id));
insert into students(id,std_name,email,age,salary,dept_id) values(1,'Raghib','Raghib@gmail.com',20,500000,4);
alter table students rename column stdEmail to std_email;
delete from students where id = 1;
insert into students(id,std_name,std_email,age,salary,dept_id) values(5,'Raghib','Raghib@gmail.com',20,500000,4);
