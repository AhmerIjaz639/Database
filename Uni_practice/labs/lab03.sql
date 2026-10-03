create database if not exists Market;

use Market;
-- task 01  
CREATE TABLE Customer (
    c_id INT,
    c_name VARCHAR(20),
    city VARCHAR(30),
    address VARCHAR(50),
    gender VARCHAR(10)
);

INSERT INTO Customer (c_id, c_name, city, address, gender)
VALUES
(101, 'Ali', 'Lahore', 'DHA Lahore', 'Male'),
(102, 'Ahmed', 'Islamabad', 'F-8 Islamabad', 'Male'),
(103, 'Sara', 'Karachi', 'Gulshan Karachi', 'Female'),
(104, 'Ayesha', 'Lahore', 'Johar Town', 'Female'),
(105, 'Usman', 'Multan', 'Cantt Multan', 'Male');



CREATE TABLE Vendors_details (
    vendor_id INT,
    vendor_name VARCHAR(30),
    city VARCHAR(30),
    phone VARCHAR(10)
);

INSERT INTO Vendors_details
(vendor_id, vendor_name, city, phone)
VALUES
(201, 'ABC Traders', 'Lahore', '0300123456'),
(202, 'XYZ Suppliers', 'Karachi', '0311123456'),
(203, 'Tech World', 'Islamabad', '0322123456'),
(204, 'Smart Traders', 'Multan', '0333123456'),
(205, 'Global Suppliers', 'Lahore', '0344123456');

-- TASK 02
ALTER TABLE Customer
ADD phone VARCHAR(10);

-- TASK 03
-- A 
ALTER TABLE Customer
modify city varchar (30) not null;
-- B
ALTER TABLE Customer
modify c_name varchar(30);
-- C
ALTER TABLE Customer
ADD email VARCHAR(50);

-- TASK 04
RENAME TABLE Customer TO Vendors;

-- TASK 05
CREATE TABLE old_customer (
    c_id INT,
    c_name VARCHAR(30),
    city VARCHAR(30),
    address VARCHAR(50),
    gender VARCHAR(10),
    phone VARCHAR(10),
    email VARCHAR(50)
);

DROP TABLE old_customer;

-- TASK 06
truncate table vendors_details;




