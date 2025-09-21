-- Q3

CREATE Table Patient(
    Patient_ID INT PRIMARY KEY,
    Name VARCHAR(20) NOT NULL,
    Gender CHAR(1) CHECK(GENDER IN('M','F')),
    DOB DATE DEFAULT CURRENT_DATE,
    Email VARCHAR(30) UNIQUE,
    Phone VARCHAR(15),
    Address VARCHAR(255),
    Username VARCHAR(50),
    Password VARCHAR(100)
);

CREATE Table Doctor(
    Doctor_ID INT PRIMARY KEY,
    Name VARCHAR(100),
    Specialization VARCHAR(100),
    Username VARCHAR(50),
    Password VARCHAR(100)
);

CREATE Table Appointment(
    Appointment_ID INT PRIMARY KEY,
    Appointment_Date DATE,
    Appointment_Time VARCHAR(10),
    Status VARCHAR(20),
    Clinic_Number INT,
    Patient_ID INT,
    Doctor_ID INT,
    FOREIGN KEY (Patient_ID) REFERENCES Patient(Patient_ID),
    FOREIGN KEY (Doctor_ID) REFERENCES Doctor(Doctor_ID)
);

CREATE Table Prescription (
    Prescription_ID INT PRIMARY KEY,
    Dates DATE,
    Doctor_Advice VARCHAR(100),
    Followup_Required VARCHAR(10),
    Patient_ID INT,
    Doctor_ID INT,
    FOREIGN KEY (Patient_ID) REFERENCES Patient(Patient_ID),
    FOREIGN KEY (Doctor_ID) REFERENCES Doctor(Doctor_ID)
);

CREATE Table Invoice (
    Invoice_ID INT PRIMARY KEY,
    Invoice_Date DATE,
    Amount INT,
    Payment_Status VARCHAR(20),
    Payment_Method VARCHAR(50),
    Patient_ID INT,
    FOREIGN KEY (Patient_ID) REFERENCES Patient(Patient_ID)
);

CREATE Table Test (
    Test_ID INT PRIMARY KEY,
    Blood_Test CHAR(1),
    X_Ray CHAR(1),
    MRI CHAR(1),
    CT_Scan CHAR(1)
);

Drop Table Tests;

insert into patient values(1,'Raghib','M',TO_DATE('2005-06-30','YYYY-MM-DD'),'Raghib@gmailcom','03341458796','Nazimabad,Karachi','RRR','RRR123');
insert into patient values(2,'Fahad','M',TO_DATE('2005-05-20','YYYY-MM-DD'),'Fahad@gmailcom','03344587458','Safoora,Karachi','SFS','SFS123');
insert into patient values(3,'Adina','F',TO_DATE('2005-10-31','YYYY-MM-DD'),'Adina@gmailcom','03158479568','DHA,Karachi','AF','AF123');
insert into patient values(4,'Ali Khan','M',TO_DATE('2005-10-31','YYYY-MM-DD'),'Ali@gmailcom','03158479854','Clifton,Karachi','AK','A123');
insert into invoice values(1,TO_DATE(SYSDATE),5000,'Unpaid','Cash',1);
insert into invoice values(2,TO_DATE(SYSDATE),13000,'Paid','Cash',2);
insert into invoice values(3,TO_DATE(SYSDATE),1400,'Refunded','Cash',3);
insert into doctor values(1,'Shaheen','Cardio','Shaheen@gmail.com','S123');
insert into doctor values(2,'Shahzou','Derma','Shahzou@gmail.com','SA123');
insert into doctor values(3,'Batool','Physio','Batool@gmail.com','B123');
insert into appointment values(1,TO_DATE('2024-09-25','YYYY-MM-DD'),'10:50 PM','Booked',5,1,3);
insert into appointment values(2,TO_DATE('2024-09-28','YYYY-MM-DD'),'8:00 PM','Cancelled',4,2,1);
insert into appointment values(3,TO_DATE('2024-09-30','YYYY-MM-DD'),'9:00 PM','Booked',3,3,2);
insert into invoice values(3,TO_DATE(SYSDATE),1400,'Unpaid','Card',2);
insert into test values(1,'Y','N','N','N');
insert into test values(2,'Y','N','N','N');
insert into test values(3,'N','Y','N','N');
insert into prescription(Prescription_ID,Dates,Patient_ID,Doctor_ID) values(1,TO_DATE('2025-09-02','YYYY-MM-DD'),1,3);
insert into prescription(Prescription_ID,Dates,Patient_ID,Doctor_ID) values(2,TO_DATE('2025-09-05','YYYY-MM-DD'),3,2);
insert into prescription(Prescription_ID,Dates,Patient_ID,Doctor_ID) values(4,TO_DATE('2025-09-05','YYYY-MM-DD'),2,2);
insert into prescription(Prescription_ID,Dates,Patient_ID,Doctor_ID) values(5,TO_DATE('2025-09-02','YYYY-MM-DD'),3,1);
insert into prescription(Prescription_ID,Dates,Patient_ID,Doctor_ID) values(3,TO_DATE(SYSDATE),1,2);
insert into prescription(Prescription_ID,Dates,Patient_ID,Doctor_ID) values(6,TO_DATE(SYSDATE),4,3);
select * from patient;
select * from invoice;
select * from doctor;
select * from appointment;
select * from prescription;

update prescription set Followup_Required = 'Yes' where prescription_ID = 2;
update prescription set Followup_Required = 'Yes' where prescription_ID = 4;

-- DML QUERIES
-- a)
update patient set phone = '03214789514',email = 'RRR@gmail.com' where Patient_ID = 1;
-- b)
update invoice set payment_status = 'Paid' where Invoice_ID = 1;
-- c)
delete from appointment where status = 'Cancelled';
-- d)
delete from invoice where payment_status = 'Refunded';
-- e)
select * from appointment where status = 'Booked';
-- f)
select * from invoice where payment_status = 'Unpaid';
-- g)
select * from test where blood_test = 'Y';
-- h)
select * from prescription where Dates = TO_DATE('2025-09-02','YYYY-MM-DD');

-- ADVANCE SQL
-- a)
select p.Name,d.Name from patient p join appointment a on p.patient_id = a.patient_id join doctor d on a.doctor_id = d.doctor_id where status = 'Booked';
-- b)
select p.Name,d.Name,t.test_id from patient p join appointment a on p.patient_id = a.patient_id join doctor d on a.doctor_id = d.doctor_id join test t on t.test_ID = a.appointment_id;
-- c)
select p.* from prescription p where p.patient_id IN(select patient_ID from patient where name = 'Ali Khan');
-- d)
select p.*,d.name from prescription p join doctor d on p.doctor_ID = d.doctor_ID where p.Followup_Required = 'Yes';
