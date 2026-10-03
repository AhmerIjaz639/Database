create database if not exists hospital_db;

use hospital_db;

create table doctor(
doctor_id int primary key auto_increment,
doctor_name varchar(100) not null,
doctor_salary decimal(10,2) not null ,
doctor_profession varchar(100) not null ,
dept_no int not null ,
doctor_comm decimal(10,2) not null
);


INSERT INTO doctor
(doctor_name, doctor_salary, doctor_profession, dept_no, doctor_comm)
VALUES
('Dr.Hassan Shah', 55000, 'Radiologist', 3, 12000),
('Dr.Kamran', 42000, 'Radiologist', 5, 8000),
('Dr.Talha Shah', 38000, 'Radiologist', 6, 15000),
('Dr.Saad', 45000, 'Radiologist', 7, 7000),

('Dr.Fahad Shah', 60000, 'Cardiologist', 5, 18000),
('Dr.Usman', 35000, 'Dermatologist', 4, 4500),
('Dr.Hamza Shah', 48000, 'Dermatologist', 6, 9000),
('Dr.Ali', 32000, 'Neurologist', 7, 6000),

('Dr.Zain Shah', 52000, 'Neurologist', 7, 14000),
('Dr.Bilal', 28000, 'Orthopedic', 5, 2500),
('Dr.Arsalan Shah', 47000, 'Orthopedic', 6, 11000),
('Dr.Waqas', 40000, 'Surgeon', 7, 20000),

('Dr.Shahzaib Shah', 58000, 'Surgeon', 5, 16000),
('Dr.Adeel', 33000, 'Pediatrician', 6, 3500),
('Dr.Muneeb Shah', 44000, 'Pediatrician', 7, 10000);


INSERT INTO doctor
(doctor_name, doctor_salary, doctor_profession, dept_no, doctor_comm)
VALUES
('Dr.Muneeb',250000,'Dentist',8,9999),
('Dr.Amjab',100001,'Dentists',5,12000);

INSERT INTO doctor
(doctor_name, doctor_salary, doctor_profession, dept_no, doctor_comm)
VALUES
('Dr.Mujeed',250000,'Neurologist',6,1999),
('Dr.Ammar',100001,'Neurologist',5,12000);


INSERT INTO doctor
(doctor_name, doctor_salary, doctor_profession, dept_no, doctor_comm)
VALUES
('Dr.Tanveer',250000,'Cardiologist',6,1999),
('Dr.Usman',100001,'Cardiologist',5,12000);




