create database if not exists company_db;

use company_db;
create table departments(
dept_id int primary key auto_increment,
dept_name varchar(100) not null unique,
dept_location varchar(100) not null 

);

create table employees(
empl_id int primary key auto_increment,
empl_name varchar(100) not null,
empl_email varchar(100) not null unique,
empl_salary decimal(10,2) check (empl_salary>0),
empl_age int not null check(empl_age>18),
dept_id int not null,
foreign key (dept_id)
references departments(dept_id)
);

create table projects(
project_id int primary key auto_increment,
project_name varchar(200) not null unique,
budget decimal(10,2)  not null 
);

create table empl_projects(
project_id int not null,
empl_id int not null,
assigned_date date not null ,
primary key(empl_id,project_id),
foreign key(project_id)
references projects(project_id),
foreign key(empl_id)
references employees(empl_id)
);


INSERT INTO departments
(dept_name, dept_location)
VALUES
('Computer Science', 'C Block'),
('Management Sciences', 'D Block'),
('Humanities', 'N Block');

INSERT INTO employees
(empl_name, empl_email, empl_salary, empl_age, dept_id)
VALUES
('Ali Khan', 'ali@gmail.com', 75000, 22, 1),
('Ahmed Raza', 'ahmed@gmail.com', 85000, 24, 1),
('Sara Ahmed', 'sara@gmail.com', 65000, 21, 2),
('Usman Ali', 'usman@gmail.com', 55000, 25, 3),
('Hamza Shah', 'hamza@gmail.com', 90000, 27, 1);

INSERT INTO projects
(project_name, budget)
VALUES
('University Management System', 8000),
('Cyber Security Dashboard', 9500),
('AI Student Assistant', 7000);

INSERT INTO empl_projects
(empl_id, project_id, assigned_date)
VALUES
(1, 1, '2026-09-01'),
(1, 2, '2026-09-02'),
(2, 1, '2026-09-01'),
(2, 3, '2026-09-03'),
(3, 3, '2026-09-04'),
(5, 2, '2026-09-05');

create table managements_sciences_empl
select * 
from employees
where dept_id=2
;
select* from managements_sciences_empl;



select 
e.empl_name,d.dept_name,project_name
from employees e
join departments d
on e.dept_id=d.dept_id
join empl_projects ep
on e.empl_id=ep.empl_id
join projects p
on ep.project_id=p.project_id
where d.dept_id=2;













START TRANSACTION;

UPDATE employees
SET empl_salary = empl_salary + 5000
WHERE dept_id = 1;

SELECT empl_id, empl_name, empl_salary
FROM employees
WHERE dept_id = 1;

ROLLBACK;

SELECT empl_id, empl_name, empl_salary
FROM employees
WHERE dept_id = 1;