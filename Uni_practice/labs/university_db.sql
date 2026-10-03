create database if not exists university_db;

use university_db;
create table departments(
department_id int primary key auto_increment,
department_name varchar(100) not null unique,
location varchar(100)
);

create table students(
stu_id int primary key auto_increment,
stu_name varchar(100) not null,
stu_email varchar(150) not null unique,
age int,
department_id int,

foreign key (department_id)
     references departments(department_id)

);

create table courses(
course_id int primary key auto_increment,
course_code varchar(100) not null unique,
course_name varchar(100) not null,
credits_hrs int not null
);


create table enrollments(
enrollment_id int primary key auto_increment,
stu_id int not null,
course_id int not null,
enrollment_date DATE not null,
grade decimal(5,2),
foreign key(stu_id)
references students(stu_id),
foreign key (course_id)
references courses(course_id),
unique(stu_id,course_id)
);

INSERT INTO departments
(department_name, location)
VALUES
('Computer Science', 'C Block'),
('Management Sciences', 'D Block'),
('Humanities', 'N Block');


INSERT INTO courses
(course_code, course_name, credits_hrs)
VALUES
('CSC312', 'Machine Learning Fundamentals', 3),
('CSC323', 'Operating Systems', 3),
('CSC316', 'Theory of Automata', 3),
('CSC315', 'Advanced Database Systems', 3),
('CSC314', 'Web Technologies', 3);


INSERT INTO students
(stu_name, stu_email, age, department_id)
VALUES
('Ali Khan', 'ali@gmail.com', 21, 1),
('Ahmed Raza', 'ahmed@gmail.com', 22, 1),
('Sara Ahmed', 'sara@gmail.com', 20, 2);


INSERT INTO enrollments
(stu_id, course_id, enrollment_date, grade)
VALUES
(1, 1, '2026-09-13', 85.50),
(1, 2, '2026-09-13', 78.00),
(1, 3, '2026-09-13', 90.00);

create table  cs_students AS
select* 
from students 
where department_id=1;

