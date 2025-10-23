set SERVEROUTPUT on;

declare
sec_name varchar(20) := 'SEC-5A';
course_name varchar(20) := 'Database Lab';

Begin
DBMS_OUTPUT.PUT_LINE('Welcome ' || sec_name || ' to the ' || course_name);
END;
/ -- Comments out below code
declare
a int := 10;
b int := 20;
c int;
f real;

begin
c := a+b;
DBMS_OUTPUT.put_line('Value of c is ' || c);
f := 70.0/3.0;
DBMS_OUTPUT.put_line('Value of f is ' || f);
end;
/
declare
nums1 number := 12;
nums2 number := 23;

begin
DBMS_OUTPUT.put_line('Value: '||nums1);
DBMS_OUTPUT.put_line('Value: '||nums2);

declare
n1 number := 62;

begin
DBMS_OUTPUT.put_line('Value: '||n1);
end;
end;
/
declare
e_name varchar(20);
begin
select first_name into e_name from employees where employee_id = 101;
dbms_output.put_line('Name: '||e_name);
Exception
When
NO_DATA_FOUND Then
dbms_output.put_line('No employee found!');
end;
/
begin
update employees set salary = salary*1.10 where department_id = 
(select department_id from departments where department_name = 'Administration');
dbms_output.put_line('Salary Updated Successfully.');
end;
/
declare
e_id Employees.Employee_ID%TYPE; -- Employees.Employee_ID%TYPE gives datatype of the column in the table
e_name Employees.first_name%TYPE;
d_name Departments.department_name%TYPE;
begin
select employee_id, first_name, department_name into e_id,e_name,d_name from employees
inner join departments on employees.department_id = departments.department_id where
employee_id = 100;

dbms_output.put_line('E_ID: '||e_id);
dbms_output.put_line('E_NAME: '||e_name);
dbms_output.put_line('D_NAME: '||d_name);

end;
/
declare 
e_id Employees.Employee_ID%TYPE := 100;
e_salary Employees.salary%TYPE;
e_did employees.department_id%TYPE;

begin
select salary,department_id into e_salary,e_did from employees where employee_id = e_id;

case e_did

when 90 then
update employees set salary = e_salary+100 where employee_id = e_id;
    dbms_output.put_line('Salary updated: '||e_salary);
when 50 then
update employees set salary = e_salary+200 where employee_id = e_id;
    dbms_output.put_line('Salary updated: '||e_salary);
when 40 then
update employees set salary = e_salary+300 where employee_id = e_id;
    dbms_output.put_line('Salary updated: '||e_salary);
else
dbms_output.put_line('No such record found!');
end case;
end;
/
