-- Q1
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
