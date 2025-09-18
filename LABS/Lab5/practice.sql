create table Faculty(
    id int primary key,
    name varchar(20)
);
insert into faculty values(1,'Sir Talha');
insert into faculty values(2,'Sir Rafi');
insert into faculty values(3,'Sir Bilal');
insert into faculty values(4,'Sir Omar');
insert into faculty values(5,'Miss Rafia');
insert into Departments values(3,'CYS');
insert into Departments values(2,'DS');
insert into Departments values(1,'SE');
insert into students values(7,'Fahad','Fahad@gmail.com','20','500000','Tandoadam',3,4);
insert into students values(9,'Umar','Umar@gmail.com','21','50000','karachi',2,5);
insert into students values(11,'Talha','Talha@gmail.com','19','200000','Shahdadpur',1,3);
insert into students values(13,'Abdul Rahman','AR@gmail.com','20','100000','Karachi',1,2);
insert into students values(15,'Ali','Ali@gmail.com','21','100000','Karachi',2,null);

select * from faculty;
select * from students;
select * from departments;

alter table students add(f_id int,constraint fk Foreign Key(f_id) references faculty(id));
update students set f_id = 5 where id = 5;
update students set city = 'Karachi' where city = 'karachi';

-- inner join
select s.id, s.std_name, s.salary, s.city, f.name from students s inner join faculty f on s.f_id = f.id where s.city = 'Karachi';
-- left join
select s.*, f.name from students s left join faculty f on s.f_id = f.id where s.city = 'Karachi';
-- right join
select s.*, f.name from students s right join faculty f on s.f_id = f.id;

alter table faculty add mentor_id int;
update faculty set mentor_id = 1 where id in (2,3);

-- self join
select f.id, f.name as faculty_name, m.name as mentor_name from faculty f inner join faculty m on f.mentor_id = m.id;
-- full outer join
select s.*, f.name from students s full join faculty f on s.f_id = f.id;
-- cross join
select s.*, f.name from students s cross join faculty f; -- Multiply both tables number of rows
