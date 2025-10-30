set SERVEROUTPUT on;
create table students(
    std_id int primary key,
    name varchar(20) not null,
    h_pay int,
    y_pay int
);
insert into students(std_id,name) values(3,'Sana');
insert into students(std_id,name) values(4,'Raghib');
select * from students;
-- DML Trigger
-- Before insert 
create or replace trigger insert_data
before insert on students
for each row
begin
if :new.h_pay is null then
:new.h_pay := 250;
end if;
end;
/
-- Before update
create or replace trigger update_data
before update on students
for each row
begin
:New.y_pay := :NEW.h_pay * 1920;
end;
/

update students set h_pay = 200;

-- Delete

create or replace trigger prevent_table
before delete on students
for each row 
begin
if :old.name = 'Raghib' then
RAISE_APPLICATION_ERROR(-20000,'You cannot delete record.');
end if;
end;
/
delete from students where name = 'Raghib';

-- Logs
create table logs(
    id int,
    name varchar(20),
    inserted_by varchar(20),
    inserted_on date
);

create or replace trigger after_ins
after insert on students
for each row
begin
insert into LOGS values (:NEW.std_id,:NEW.name,SYS_CONTEXT('USERENV','SESSION_USER'),SYSDATE);
end;
/
insert into students(std_id,name,h_pay) values(2,'Fahad',300);

-- Q1 (Class Activity)

create table deleted_logs(
    id int,
    name varchar(20),
    h_pay int,
    y_pay int,
    deleted_by varchar(20),
    deleted_on date
);

create or replace trigger after_del
after delete on students
for each row
begin
insert into deleted_logs values (:OLD.std_id,:OLD.name,:OLD.h_pay,:OLD.y_pay,SYS_CONTEXT('USERENV','SESSION_USER'),SYSDATE);
end;
/
delete from students where std_id = 3;

select * from students;
select * from logs;
select * from deleted_logs;

-- DDL Triggers
-- PREVENT TABLE TO DROP
create or replace trigger drop_table
before drop on database
begin
RAISE_APPLICATION_ERROR(
    num => -20000,
    msg => 'Cannot drop object'
);
end;
/
--DROP TABLE STUDENTS;
create table schema_audit(
    ddl_date date,
    ddl_user varchar(20),
    object_created varchar(20),
    ibject_name varchar(20),
    ddl_operation varchar(20)
);

-- Q2
create or replace trigger deleting
before drop on schema
begin
if ora_dict_obj_name = 'STUDENTS' and ora_dict_obj_type = 'TABLE'
then
RAISE_APPLICATION_ERROR(
    num => -20000,
    msg => 'Cannot drop object'
);
end if;
end;
/
drop table students;
