# MySQL Cheat Sheet

> Help with SQL commands to interact with a MySQL databaseToday 1:33 PM
teach me advance creating inserting database

Bilkul. Since tum MySQL already practice kar rahe ho, Advanced Database Creation + Insertion ko practical way mein karte hain.

Main assume kar raha hoon tumhe basic CREATE DATABASE, CREATE TABLE, INSERT, SELECT already aata hai. So ab hum real-world database design ki taraf jayenge.

1. Advanced Database ka overall structure

Real project mein flow usually:

Database
   ↓
Tables
   ↓
Primary Keys
   ↓
Foreign Keys
   ↓
Constraints
   ↓
Relationships
   ↓
Indexes
   ↓
Insert data
   ↓
Queries
Part 1 — Database create karna

Basic:

CREATE DATABASE university_db;

Advanced way:

CREATE DATABASE IF NOT EXISTS university_db
CHARACTER SET utf8mb4
COLLATE utf8mb4_unicode_ci;

Then:

USE university_db;
Why IF NOT EXISTS?

Agar database already exist karta hai:

CREATE DATABASE university_db;

error de sakta hai.

But:

CREATE DATABASE IF NOT EXISTS university_db;

safe hai.

Part 2 — Multiple related tables

Suppose university system hai:

Department
    ↓
Students
    ↓
Enrollments
    ↓
Courses

Ek student multiple courses le sakta hai aur ek course multiple students ka ho sakta hai.

Ye many-to-many relationship hai.

We'll create 4 tables.

Department
CREATE TABLE departments (
    department_id INT PRIMARY KEY AUTO_INCREMENT,
    department_name VARCHAR(100) NOT NULL UNIQUE,
    location VARCHAR(100)
);

Important:

PRIMARY KEY

har department ko unique identify karegi.

UNIQUE

duplicate department names prevent karega.

NOT NULL

value required banata hai.

Part 3 — Student table
CREATE TABLE students (
    student_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(150) NOT NULL UNIQUE,
    age INT,
    department_id INT,

    FOREIGN KEY (department_id)
        REFERENCES departments(department_id)
);

Relationship:

departments
     │
     │ department_id
     ↓
students

Agar department 1 exist nahi karta:

INSERT INTO students
(name, email, age, department_id)
VALUES
('Ali', 'ali@gmail.com', 21, 999);

MySQL foreign-key error dega.

Why?

Because department 999 exist nahi karta.

Part 4 — Courses
CREATE TABLE courses (
    course_id INT PRIMARY KEY AUTO_INCREMENT,
    course_code VARCHAR(20) NOT NULL UNIQUE,
    course_name VARCHAR(100) NOT NULL,
    credit_hours INT NOT NULL
);

Example:

CSC312 → Machine Learning
CSC323 → Operating Systems
CSC316 → Theory of Automata
Part 5 — Enrollment table

Ab interesting part.

Student:

Ali

courses:

Machine Learning
Operating Systems
Automata

Ek student multiple courses le raha hai.

Aur:

Machine Learning

multiple students le rahe hain.

Therefore:

students          enrollments          courses

Student 1 ─────── Enrollment ─────── Course 1
Student 1 ─────── Enrollment ─────── Course 2
Student 2 ─────── Enrollment ─────── Course 1
Student 3 ─────── Enrollment ─────── Course 1

Table:

CREATE TABLE enrollments (
    enrollment_id INT PRIMARY KEY AUTO_INCREMENT,

    student_id INT NOT NULL,
    course_id INT NOT NULL,

    enrollment_date DATE NOT NULL,

    grade DECIMAL(5,2),

    FOREIGN KEY (student_id)
        REFERENCES students(student_id),

    FOREIGN KEY (course_id)
        REFERENCES courses(course_id),

    UNIQUE(student_id, course_id)
);
Important:
UNIQUE(student_id, course_id)

iska matlab:

Ali ko same course mein dobara enroll nahi kar sakte.

Part 6 — Advanced INSERT
Single row
INSERT INTO departments
(department_name, location)
VALUES
('Computer Science', 'C Block');
Multiple rows

Better approach:

INSERT INTO departments
(department_name, location)
VALUES
('Computer Science', 'C Block'),
('Management Sciences', 'D Block'),
('Humanities', 'N Block');

One query → three rows.

Part 7 — Insert courses
INSERT INTO courses
(course_code, course_name, credit_hours)
VALUES
('CSC312', 'Machine Learning Fundamentals', 3),
('CSC323', 'Operating Systems', 3),
('CSC316', 'Theory of Automata', 3),
('CSC315', 'Advanced Database Systems', 3),
('CSC314', 'Web Technologies', 3);

Check:

SELECT * FROM courses;
Part 8 — Insert students
INSERT INTO students
(name, email, age, department_id)
VALUES
('Ali Khan', 'ali@gmail.com', 21, 1),
('Ahmed Raza', 'ahmed@gmail.com', 22, 1),
('Sara Ahmed', 'sara@gmail.com', 20, 2);

Notice:

department_id = 1

means student belongs to department whose ID is 1.

Part 9 — Insert enrollment

Suppose:

Ali = student_id 1

ML = course_id 1
OS = course_id 2
Automata = course_id 3

Then:

INSERT INTO enrollments
(student_id, course_id, enrollment_date, grade)
VALUES
(1, 1, '2026-09-13', 85.50),
(1, 2, '2026-09-13', 78.00),
(1, 3, '2026-09-13', 90.00);
Part 10 — INSERT ... SELECT

This is a more advanced and very important technique.

Instead of manually entering data:

INSERT INTO some_table (...)
SELECT ...
FROM another_table;

Example:

CREATE TABLE cs_students AS
SELECT *
FROM students
WHERE department_id = 1;

This creates a new table containing CS students.

Or:

INSERT INTO cs_students
SELECT *
FROM students
WHERE department_id = 1;

Difference:

CREATE TABLE AS SELECT
        ↓
creates table + copies data

INSERT INTO SELECT
        ↓
existing table mein data insert
Part 11 — Default values

You can make MySQL automatically insert values.

CREATE TABLE users (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(50) NOT NULL,
    status VARCHAR(20) DEFAULT 'active',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

Now:

INSERT INTO users (username)
VALUES ('ahmer');

MySQL automatically gives:

status     → active
created_at → current date/time
Part 12 — CHECK constraints

You can restrict invalid data.

CREATE TABLE employees (
    employee_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    age INT CHECK (age >= 18),
    salary DECIMAL(10,2) CHECK (salary > 0)
);

This:

INSERT INTO employees
(name, age, salary)
VALUES
('Ali', 15, 50000);

should fail because:

age >= 18
Part 13 — Important production habit

Don't do this:

INSERT INTO students
VALUES
(1, 'Ali', 'ali@gmail.com', 21, 1);

Prefer:

INSERT INTO students
(name, email, age, department_id)
VALUES
('Ali', 'ali@gmail.com', 21, 1);

Why?

Because if table structure changes:

id
name
email
age
department
phone

your first query can break.

Named columns are safer and clearer.

Your mini challenge 🔥

Create this database yourself:

company_db

Tables:

departments
employees
projects
employee_projects

Relationships:

departments 1 ──────── * employees

employees * ───────── * projects
              ↑
      employee_projects
Requirements

departments

department_id
department_name
location

employees

employee_id
name
email
salary
department_id

projects

project_id
project_name
budget

employee_projects

employee_id
project_id
assigned_date

Use:

PRIMARY KEY
AUTO_INCREMENT
NOT NULL
UNIQUE
FOREIGN KEY
CHECK
DEFAULT
multi-row INSERT

Don't look up the solution yet. Try writing the 4 CREATE TABLE statements and the inserts yourself. Then send me your SQL, and I'll review it like a database instructor.

Yes dude. Based on what you've learned, your SQL skill is now around solid intermediate, but I would not call you advanced SQL yet.

Your current SQL skill map
Area	Level
Database / table creation	🟢 Good
Constraints	🟢 Good
INSERT / UPDATE / DELETE	🟢 Good
SELECT / filtering	🟢 Good
JOINs	🟢 Good
GROUP BY / HAVING	🟢 Good
Aggregate functions	🟢 Good
Subqueries	🟢 Good
CTAS / INSERT SELECT	🟢 Good
Views	🟢 Good
Indexes	🟡 Understands fundamentals
Transactions / ACID	🟡 Understands fundamentals
Stored Procedures	🟡 Understands fundamentals
Functions	🟡 Understands fundamentals
Triggers	🟡 Concept understood
Normalization	🔴 Not covered yet
Complex SQL optimization	🔴 Not covered
Window functions	🔴 Not covered
CTEs	🔴 Not covered
So your actual level

I'd rate you approximately:

SQL: 6.5–7/10 → Intermediate

You can now comfortably handle typical junior backend/database tasks:

Python/FastAPI
      ↓
     SQL
      ↓
MySQL
      ↓
Tables → JOINs → Queries → Transactions

But for your Advanced Database Systems course, don't stop here.

The biggest remaining SQL topics I'd recommend are:

Normalization — 1NF, 2NF, 3NF, BCNF
CTEs — WITH
Window Functions — ROW_NUMBER, RANK, DENSE_RANK, LAG, LEAD
Query optimization / EXPLAIN
More advanced indexing
Complex nested queries
Database design + normalization problems

And importantly, you don't need to spend more time on triggers right now if they're not part of your immediate course/project needs.

So yes: your SQL foundation is now strong enough to move into Advanced Database concepts.

out of 100 ?

Dude, I’d rate you around 70/100 in SQL right now.

70/100: solid intermediate foundation
80–85: strong intermediate / junior backend-ready
90+: advanced SQL, including window functions, CTEs, optimization, complex queries, normalization, execution plans, etc.

Your 70 isn't because you don't know the basics—you've covered a lot. The missing 30 is mainly the deeper/advanced stuff and lots of problem-solving practice.

nice now i have to learn fast api and with db  come to the new chat habibi and then goes to the numpy and panda and then tensor and ml  

😂 Habibi, perfect sequence.

We’ll do it like this:

SQL          → 70/100 ✅
     ↓
FastAPI + MySQL
     ↓
Backend projects / APIs
     ↓
NumPy
     ↓
Pandas
     ↓
TensorFlow
     ↓
Machine Learning

For FastAPI, we’ll connect directly with the SQL knowledge you just built: CRUD → relationships → joins → validation → transactions → proper API + MySQL architecture.

And yes, new chat mein continue karte hain. Bas wahan likhna:

“Habibi, start FastAPI + MySQL bootcamp. My SQL is 70/100.”

I'll pick it up from there.

## MySQL Locations
* Mac             */usr/local/mysql/bin*
* Windows         */Program Files/MySQL/MySQL _version_/bin*
* Xampp           */xampp/mysql/bin*

## Add mysql to your PATH

```bash
# Current Session
export PATH=${PATH}:/usr/local/mysql/bin
# Permanantly
echo 'export PATH="/usr/local/mysql/bin:$PATH"' >> ~/.bash_profile
```

On Windows - https://www.qualitestgroup.com/resources/knowledge-center/how-to-guide/add-mysql-path-windows/

## Login

```bash
mysql -u root -p
```

## Show Users

```sql
SELECT User, Host FROM mysql.user;
```

## Create User

```sql
CREATE USER 'someuser'@'localhost' IDENTIFIED BY 'somepassword';
```

## Grant All Priveleges On All Databases

```sql
GRANT ALL PRIVILEGES ON * . * TO 'someuser'@'localhost';
FLUSH PRIVILEGES;
```

## Show Grants

```sql
SHOW GRANTS FOR 'someuser'@'localhost';
```

## Remove Grants

```sql
REVOKE ALL PRIVILEGES, GRANT OPTION FROM 'someuser'@'localhost';
```

## Delete User

```sql
DROP USER 'someuser'@'localhost';
```

## Exit

```sql
exit;
```

## Show Databases

```sql
SHOW DATABASES
```

## Create Database

```sql
CREATE DATABASE acme;
```

## Delete Database

```sql
DROP DATABASE acme;
```

## Select Database

```sql
USE acme;
```

## Create Table

```sql
CREATE TABLE users(
id INT AUTO_INCREMENT,
   first_name VARCHAR(100),
   last_name VARCHAR(100),
   email VARCHAR(50),
   password VARCHAR(20),
   location VARCHAR(100),
   dept VARCHAR(100),
   is_admin TINYINT(1),
   register_date DATETIME,
   PRIMARY KEY(id)
);
```

## Delete / Drop Table

```sql
DROP TABLE tablename;
```

## Show Tables

```sql
SHOW TABLES;
```

## Insert Row / Record

```sql
INSERT INTO users (first_name, last_name, email, password, location, dept, is_admin, register_date) values ('Brad', 'Traversy', 'brad@gmail.com', '123456','Massachusetts', 'development', 1, now());
```

## Insert Multiple Rows

```sql
INSERT INTO users (first_name, last_name, email, password, location, dept,  is_admin, register_date) values ('Fred', 'Smith', 'fred@gmail.com', '123456', 'New York', 'design', 0, now()), ('Sara', 'Watson', 'sara@gmail.com', '123456', 'New York', 'design', 0, now()),('Will', 'Jackson', 'will@yahoo.com', '123456', 'Rhode Island', 'development', 1, now()),('Paula', 'Johnson', 'paula@yahoo.com', '123456', 'Massachusetts', 'sales', 0, now()),('Tom', 'Spears', 'tom@yahoo.com', '123456', 'Massachusetts', 'sales', 0, now());
```

## Select

```sql
SELECT * FROM users;
SELECT first_name, last_name FROM users;
```

## Where Clause

```sql
SELECT * FROM users WHERE location='Massachusetts';
SELECT * FROM users WHERE location='Massachusetts' AND dept='sales';
SELECT * FROM users WHERE is_admin = 1;
SELECT * FROM users WHERE is_admin > 0;
```

## Delete Row

```sql
DELETE FROM users WHERE id = 6;
```

## Update Row

```sql
UPDATE users SET email = 'freddy@gmail.com' WHERE id = 2;

```

## Add New Column

```sql
ALTER TABLE users ADD age VARCHAR(3);
```

## Modify Column

```sql
ALTER TABLE users MODIFY COLUMN age INT(3);
```

## Order By (Sort)

```sql
SELECT * FROM users ORDER BY last_name ASC;
SELECT * FROM users ORDER BY last_name DESC;
```

## Concatenate Columns

```sql
SELECT CONCAT(first_name, ' ', last_name) AS 'Name', dept FROM users;

```

## Select Distinct Rows

```sql
SELECT DISTINCT location FROM users;

```

## Between (Select Range)

```sql
SELECT * FROM users WHERE age BETWEEN 20 AND 25;
```

## Like (Searching)

```sql
SELECT * FROM users WHERE dept LIKE 'd%';
SELECT * FROM users WHERE dept LIKE 'dev%';
SELECT * FROM users WHERE dept LIKE '%t';
SELECT * FROM users WHERE dept LIKE '%e%';
```

## Not Like

```sql
SELECT * FROM users WHERE dept NOT LIKE 'd%';
```

## IN

```sql
SELECT * FROM users WHERE dept IN ('design', 'sales');
```

## Create & Remove Index

```sql
CREATE INDEX LIndex On users(location);
DROP INDEX LIndex ON users;
```

## New Table With Foreign Key (Posts)

```sql
CREATE TABLE posts(
id INT AUTO_INCREMENT,
   user_id INT,
   title VARCHAR(100),
   body TEXT,
   publish_date DATETIME DEFAULT CURRENT_TIMESTAMP,
   PRIMARY KEY(id),
   FOREIGN KEY (user_id) REFERENCES users(id)
);
```

## Add Data to Posts Table

```sql
INSERT INTO posts(user_id, title, body) VALUES (1, 'Post One', 'This is post one'),(3, 'Post Two', 'This is post two'),(1, 'Post Three', 'This is post three'),(2, 'Post Four', 'This is post four'),(5, 'Post Five', 'This is post five'),(4, 'Post Six', 'This is post six'),(2, 'Post Seven', 'This is post seven'),(1, 'Post Eight', 'This is post eight'),(3, 'Post Nine', 'This is post none'),(4, 'Post Ten', 'This is post ten');
```

## INNER JOIN

```sql
SELECT
  users.first_name,
  users.last_name,
  posts.title,
  posts.publish_date
FROM users
INNER JOIN posts
ON users.id = posts.user_id
ORDER BY posts.title;
```

## New Table With 2 Foriegn Keys

```sql
CREATE TABLE comments(
	id INT AUTO_INCREMENT,
    post_id INT,
    user_id INT,
    body TEXT,
    publish_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY(id),
    FOREIGN KEY(user_id) references users(id),
    FOREIGN KEY(post_id) references posts(id)
);
```

## Add Data to Comments Table

```sql
INSERT INTO comments(post_id, user_id, body) VALUES (1, 3, 'This is comment one'),(2, 1, 'This is comment two'),(5, 3, 'This is comment three'),(2, 4, 'This is comment four'),(1, 2, 'This is comment five'),(3, 1, 'This is comment six'),(3, 2, 'This is comment six'),(5, 4, 'This is comment seven'),(2, 3, 'This is comment seven');
```

## Left Join

```sql
SELECT
comments.body,
posts.title
FROM comments
LEFT JOIN posts ON posts.id = comments.post_id
ORDER BY posts.title;

```

## Join Multiple Tables

```sql
SELECT
comments.body,
posts.title,
users.first_name,
users.last_name
FROM comments
INNER JOIN posts on posts.id = comments.post_id
INNER JOIN users on users.id = comments.user_id
ORDER BY posts.title;

```

## Aggregate Functions

```sql
SELECT COUNT(id) FROM users;
SELECT MAX(age) FROM users;
SELECT MIN(age) FROM users;
SELECT SUM(age) FROM users;
SELECT UCASE(first_name), LCASE(last_name) FROM users;

```

## Group By

```sql
SELECT age, COUNT(age) FROM users GROUP BY age;
SELECT age, COUNT(age) FROM users WHERE age > 20 GROUP BY age;
SELECT age, COUNT(age) FROM users GROUP BY age HAVING count(age) >=2;

```
