select * from employees;

set serveroutput on;

declare
    v_id employees.employee_id%type := 100;
    v_name employees.first_name%type;
begin
    dbms_output.put_line('Hello World!');
    select employees.first_name into v_name from employees where v_id = employees.employee_id;
    
    dbms_output.put_line(v_name);
end;
/

declare
    v_id employees.employee_id%type := 100;
    v_name employees.first_name%type;
    v_salary employees.salary%type;
    v_job varchar(20);
begin
    dbms_output.put_line('Hello World!');
    select employees.first_name,employees.salary into v_name,v_salary from employees where v_id = employees.employee_id;
    
    IF v_salary < 20000 then
        v_job := 'Low Level Job';
    ELSIF v_salary > 20000 then
        v_job := 'High Level Job';
    ELSE
        v_job := 'Unemployeed';
    END IF;
    
    DBMS_OUTPUT.PUT_LINE('Salary: ' || v_salary || ', Job:' || v_job);
end;
/

declare
    v_id employees.employee_id%type;
    v_name employees.first_name%type;
begin
    for i in 100..206 loop
        select employees.employee_id,employees.first_name into v_id,v_name from employees where i = employees.employee_id;
        dbms_output.put_line('ID: '||v_id||', Name: '||v_name);
    End loop;
end;
/

declare 
begin
    for user_record in  (select first_name , salary , hire_date from employees where department_id = 80)
    loop
        dbms_output.put_line('user name is ' || user_record.first_name || ' salary is ' || user_record.salary
        || ' and hire date is ' || user_record.hire_date);
    end loop;
end;
/

create or replace procedure salary_increment(
    v_id IN employees.employee_id%type,
    increase_amount IN int
)
IS
    v_salary employees.salary%type;
BEGIN
    v_salary :=  increase_amount* 2;
    update employees set salary = v_salary where employees.employee_id = v_id;
    commit;
END salary_increment;
/

EXEC salary_increment(100,24000);

CREATE OR REPLACE FUNCTION get_annual_salary (
  p_monthly_salary IN int
)
RETURN int
IS
  v_annual_salary NUMBER;
BEGIN
  v_annual_salary := p_monthly_salary * 12;

  RETURN v_annual_salary;
END get_annual_salary;
/

select first_name,get_annual_salary(salary) from employees where employee_id = 103;


create or replace type order_item as object(
    id int,
    name varchar(20),
    quantity int,
    price int,
    member function total_cost return number
);
/
create or replace type body order_item as
member function total_cost return number
is
    v_total number;
begin
    v_total := self.quantity*self.price;
    if self.quantity > 5 then
        v_total := v_total - (v_total * 0.05);
    end if;
    return v_total;
end total_cost;
end;
/

create table order_table of order_item(
    primary key(id)
);

insert into order_table values(1,'Pizza',2,100);
insert into order_table values(2,'Drink',6,200);
insert into order_table values(3,'Fries',7,150);

declare
    cursor item_cursor is
        SELECT VALUE(t) AS item_obj -- VALUE(t) retrieves the object itself from the object table row
        FROM order_table t;
    v_item_obj order_item;
    v_item_cost number;
    v_highest_bill number := 0;
begin
    open item_cursor;
    loop
        fetch item_cursor into v_item_obj;
        exit when item_cursor%NOTFOUND;
        
        v_item_cost := v_item_obj.total_cost();
        DBMS_OUTPUT.PUT_LINE(
            'Item: ' || v_item_obj.name || 
            ' | Qty: ' || v_item_obj.quantity|| 
            ' | Price: ' || v_item_obj.price|| 
            ' | Final Bill: ' || v_item_cost
        );
        
        -- Check for the highest bill amount
        IF v_item_cost > v_highest_bill THEN
            v_highest_bill := v_item_cost;
        END IF;
        
    END LOOP;
    CLOSE item_cursor;
    
    DBMS_OUTPUT.PUT_LINE('Highest Bill Amount: ' || TO_CHAR(v_highest_bill, 'FM99999.00'));
    
END;
/
