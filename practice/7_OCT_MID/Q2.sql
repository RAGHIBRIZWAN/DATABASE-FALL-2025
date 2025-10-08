--create table Doctors(
--    doctor_id int primary key,
--    first_name varchar(20),
--    last_name varchar(20),
--    specialization varchar(20),
--    email varchar(30) UNIQUE NOT NULL
--);
--
--create table Patients(
--    patient_id int primary key,
--    first_name varchar(20),
--    last_name varchar(20),
--    dob NUMBER NOT NULL check(dob >= 0),
--    phone int UNIQUE
--);
--
--create table Appointments(
--    appointment_id int primary key,
--    doctor_id int,
--    patient_id int,
--    appointment_date DATE,
--    status varchar(20) check (status IN ('Scheduled', 'Completed', 'Cancelled')),
--    constraint fk_doctor foreign key (doctor_id) references Doctors(doctor_id),
--    constraint fk_patient foreign key (patient_id) references Patients(patient_id)
----    constraint chk_future_date 
--);
--
--create table Prescriptions(
--    prescription_id int primary key,
--    appointment_id int,
--    medicine_name varchar(30),
--    dosage varchar(20),
--    duration_days int check(duration_days >= 1),
--    constraint fk_appointment foreign key (appointment_id) references Appointments(appointment_id)
--);
--
--insert into Doctors values (1,'Raghib','Rizwan','Cardiology','Raghib@gmail.com');
--insert into Patients values (1,'Fahad','Shah',20,03344589657);
--insert into Appointments values (1,1,1,to_char(to_date('2023-08-01','YYYY-MM-DD')),'Scheduled');
--insert into Prescriptions values (1,1,'Amoxicillin','500mg',7);
--update Appointments set status = 'Completed' where status = 'Scheduled';
--select p.first_name from patients p inner join appointments a on p.patient_id = a.patient_id inner join doctors d on a.doctor_id = d.doctor_id where d.specialization = 'Cardiology';
--select a.*,p.* from appointments a inner join prescriptions p on a.appointment_id = p.appointment_id;
--select p.medicine_name from Prescriptions p group by p.medicine_name having Count(p.medicine_name) = 
--(select MAX(COUNT(*)) from PRESCRIPTIONS p1 group by medicine_name);

-- Q1: Create Table - Customers
CREATE TABLE Customers (
    customer_id NUMBER PRIMARY KEY,
    first_name VARCHAR2(50) NOT NULL,
    last_name VARCHAR2(50) NOT NULL,
    email VARCHAR2(100) NOT NULL,
    phone VARCHAR2(20) UNIQUE
);

-- Q2: Create Table - Products
CREATE TABLE Products (
    product_id NUMBER PRIMARY KEY,
    product_name VARCHAR2(100) NOT NULL,
    price NUMBER CHECK (price > 0),
    stock_quantity NUMBER CHECK (stock_quantity >= 0)
);

-- Q3: Create Table - Orders
CREATE TABLE Orders (
    order_id NUMBER PRIMARY KEY,
    customer_id NUMBER,
    order_date DATE NOT NULL,
    status VARCHAR2(20) CHECK (status IN ('Pending', 'Shipped', 'Delivered', 'Cancelled')),
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

-- Q4: Create Table - OrderItems
-- Option 1: Store price at order time and calculate subtotal
CREATE TABLE OrderItems (
    order_item_id NUMBER PRIMARY KEY,
    order_id NUMBER,
    product_id NUMBER,
    quantity NUMBER CHECK (quantity >= 1),
    price NUMBER NOT NULL,  -- Store price at time of order
    subtotal NUMBER GENERATED ALWAYS AS (price * quantity) VIRTUAL,
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);
 

insert into Customers values (1,'Ali','Raza','Ali@gmail.com',02541485967);
insert into Products values (1,'Laptop',100000,10);
insert into Orders values (1,1,to_date(SYSDATE,'YYYY-MM-DD'),'Pending');
update Products set stock_quantity = 20 where stock_quantity = 10;
update Orders set status = 'Shipped' where order_id = 1;
