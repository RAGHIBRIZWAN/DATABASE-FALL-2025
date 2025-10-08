create table Doctors(
    doctor_id int primary key,
    first_name varchar(20),
    last_name varchar(20),
    specialization varchar(20),
    email varchar(30) UNIQUE NOT NULL
);

create table Patients(
    patient_id int primary key,
    first_name varchar(20),
    last_name varchar(20),
    dob NUMBER NOT NULL check(dob >= 0),
    phone int UNIQUE
);

create table Appointments(
    appointment_id int primary key,
    doctor_id int,
    patient_id int,
    appointment_date DATE,
    status varchar(20) check (status IN ('Scheduled', 'Completed', 'Cancelled')),
    constraint fk_doctor foreign key (doctor_id) references Doctors(doctor_id),
    constraint fk_patient foreign key (patient_id) references Patients(patient_id)
--    constraint chk_future_date 
);

create table Prescriptions(
    prescription_id int primary key,
    appointment_id int,
    medicine_name varchar(30),
    dosage varchar(20),
    duration_days int check(duration_days >= 1),
    constraint fk_appointment foreign key (appointment_id) references Appointments(appointment_id)
);

insert into Doctors values (1,'Raghib','Rizwan','Cardiology','Raghib@gmail.com');
insert into Patients values (1,'Fahad','Shah',20,03344589657);
insert into Appointments values (1,1,1,to_char(to_date('2023-08-01','YYYY-MM-DD')),'Scheduled');
insert into Prescriptions values (1,1,'Amoxicillin','500mg',7);
update Appointments set status = 'Completed' where status = 'Scheduled';
select p.first_name from patients p inner join appointments a on p.patient_id = a.patient_id inner join doctors d on a.doctor_id = d.doctor_id where d.specialization = 'Cardiology';
select a.*,p.* from appointments a inner join prescriptions p on a.appointment_id = p.appointment_id;
select p.medicine_name from Prescriptions p group by p.medicine_name having Count(p.medicine_name) = 
(select MAX(COUNT(*)) from PRESCRIPTIONS p1 group by medicine_name);
