-- Table 1: PRODUCTS (To hold product details)
CREATE TABLE PRODUCTS (
    product_id   NUMBER PRIMARY KEY,
    product_name VARCHAR2(100) NOT NULL,
    price        NUMBER(10, 2) NOT NULL
);

-- Table 2: INVENTORY (To track stock level of products)
CREATE TABLE INVENTORY (
    product_id    NUMBER PRIMARY KEY,
    stock_quantity NUMBER DEFAULT 0 NOT NULL,
    CONSTRAINT fk_product_inventory FOREIGN KEY (product_id) REFERENCES PRODUCTS(product_id)
);

-- Table 3: ORDERS (To track placed orders)
CREATE TABLE ORDERS (
    order_id      NUMBER PRIMARY KEY,
    product_id    NUMBER NOT NULL,
    order_quantity NUMBER NOT NULL,
    order_date    DATE DEFAULT SYSDATE,
    CONSTRAINT fk_product_order FOREIGN KEY (product_id) REFERENCES PRODUCTS(product_id)
);

SET TRANSACTION NAME 'trans';

insert into products values(1,'mobile',10000);

savepoint sp1;

insert into inventory values(1,10);

savepoint sp2;

insert into orders values(1,1,5,to_date('02/12/2025','DD/MM/YYYY'));

update inventory set stock_quantity = stock_quantity-5 where product_id = 1;

savepoint sp3;

declare    
    unavailable EXCEPTION;
    stock int;
begin
    select stock_quantity into stock from inventory where product_id = 1;
    
    if stock <= 0 then
        RAISE unavailable;
    end if;
    commit;
    
EXCEPTION
    when unavailable then
        ROLLBACK TO SAVEPOINT sp2;
        DBMS_OUTPUT.PUT_LINE('Transaction Rolled Back.');
    when others then
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Transaction Failed and Rolled Back.');
END;
/    
