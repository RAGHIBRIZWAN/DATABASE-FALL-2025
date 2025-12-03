create table customers(
    id int primary key,
    name varchar(20),
    balance int
);
create table orders(
    oid int primary key,
    id int REFERENCES customers(id),
    order_amount int,
    order_status varchar(20)
);

SET TRANSACTION NAME 'trans';

insert into customers values(1,'Raghib',10000);

SAVEPOINT customer_added;

insert into orders values(101,1,1500,'Pending');

update customers set balance = balance - 8500 where id = 1;

SAVEPOINT order_added;

DECLARE
    insufficient EXCEPTION;
    customer_balance int;
BEGIN
    select balance into customer_balance from customers where id = 1;
    
    if customer_balance < 0 then
        RAISE insufficient;
    end if;
    
    commit;
EXCEPTION
    when insufficient then
        ROLLBACK TO SAVEPOINT customer_added;
        DBMS_OUTPUT.PUT_LINE('Transaction Rolled Back.');
    when others then
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Transaction Failed and Rolled Back.');
END;
/

select * from customers;
