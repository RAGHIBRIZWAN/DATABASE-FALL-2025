Q1)
CREATE TABLE bank_accounts(
    account_no VARCHAR2(10),
    holder_name VARCHAR2(50),
    balance NUMBER
);

INSERT INTO bank_accounts VALUES ('A', 'Raghib', 20000);
INSERT INTO bank_accounts VALUES ('B', 'Rizwan', 15000);
INSERT INTO bank_accounts VALUES ('C', 'Rabani', 30000);
COMMIT;

UPDATE bank_accounts
SET balance = balance - 5000
WHERE account_no = 'A';

UPDATE bank_accounts
SET balance = balance + 5000
WHERE account_no = 'B';

UPDATE bank_accounts
SET balance = 0   -- mistake
WHERE account_no = 'C';

ROLLBACK;
SELECT * FROM bank_accounts;

Q2)
CREATE TABLE inventory(
    item_id NUMBER,
    item_name VARCHAR2(30),
    quantity NUMBER
);
INSERT INTO inventory VALUES (1,'Keyboard',50);
INSERT INTO inventory VALUES (2,'Mouse',70);
INSERT INTO inventory VALUES (3,'Monitor',30);
INSERT INTO inventory VALUES (4,'USB Cable',100);
COMMIT;

UPDATE inventory SET quantity = quantity - 10 WHERE item_id = 1;
SAVEPOINT sp1;
UPDATE inventory SET quantity = quantity - 20 WHERE item_id = 2;
SAVEPOINT sp2;
UPDATE inventory SET quantity = quantity - 5 WHERE item_id = 3;
ROLLBACK TO sp1;
COMMIT;

Q3)
CREATE TABLE fees(
    student_id NUMBER,
    name VARCHAR2(50),
    amount_paid NUMBER,
    total_fee NUMBER
);

INSERT INTO fees VALUES (1,'Daniyal',10000,30000);
INSERT INTO fees VALUES (2,'Babar',15000,30000);
INSERT INTO fees VALUES (3,'Raghib',5000,30000);
COMMIT;

UPDATE fees SET amount_paid = amount_paid + 5000 WHERE student_id = 1;
SAVEPOINT halfway;
UPDATE fees SET amount_paid = amount_paid + 7000 WHERE student_id = 2;
ROLLBACK TO halfway;
COMMIT;

Q4)
CREATE TABLE products(
    product_id NUMBER,
    product_name VARCHAR2(50),
    stock NUMBER
);

CREATE TABLE orders(
    order_id NUMBER,
    product_id NUMBER,
    quantity NUMBER
);

INSERT INTO products VALUES (1,'Laptop',20);
INSERT INTO products VALUES (2,'Mouse',100);
COMMIT;

UPDATE products SET stock = stock - 2 WHERE product_id = 1;
INSERT INTO orders VALUES (101,1,2);
DELETE FROM products WHERE product_id = 2;  -- mistake
ROLLBACK;
UPDATE products SET stock = stock - 2 WHERE product_id = 1;
INSERT INTO orders VALUES (101,1,2);
COMMIT;

Q5)
CREATE TABLE employees(
    emp_id NUMBER,
    emp_name VARCHAR2(50),
    salary NUMBER
);

INSERT INTO employees VALUES (1, 'Ali', 50000);
INSERT INTO employees VALUES (2, 'Talha', 60000);
INSERT INTO employees VALUES (3, 'Rahman', 55000);
INSERT INTO employees VALUES (4, 'Sara', 45000);
INSERT INTO employees VALUES (5, 'Raghib', 70000);
COMMIT;

UPDATE employees SET salary = salary + 5000 WHERE emp_id = 1;
SAVEPOINT A;
UPDATE employees SET salary = salary + 3000 WHERE emp_id = 2;
SAVEPOINT B;
UPDATE employees SET salary = salary + 4000 WHERE emp_id = 3;
ROLLBACK TO A;
COMMIT;
