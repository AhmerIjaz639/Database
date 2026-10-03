create database if not exists  flight_management;

use  flight_management;
-- 1
CREATE TABLE Flight (
    Flight_ID INT PRIMARY KEY,
    Flight_Number VARCHAR(20),
    Airline_Name VARCHAR(100),
    Source VARCHAR(50),
    Destination VARCHAR(50),
    Departure_Date DATE,
    Available_Seats INT
);
-- 2
CREATE TABLE Passenger (
    Passenger_ID INT PRIMARY KEY,
    Passenger_Name VARCHAR(100),
    Gender VARCHAR(10),
    Phone VARCHAR(20),
    Email VARCHAR(100),
    City VARCHAR(50)
);
-- 3
CREATE TABLE Reservation (
    Reservation_ID INT PRIMARY KEY,
    Passenger_ID INT,
    Flight_ID INT,
    Reservation_Date DATE,
    Seat_Number VARCHAR(10),
    Ticket_Price DECIMAL(10,2),
    FOREIGN KEY (Passenger_ID) REFERENCES Passenger(Passenger_ID),
    FOREIGN KEY (Flight_ID) REFERENCES Flight(Flight_ID)
);
-- 4
INSERT INTO Flight
(Flight_ID, Flight_Number, Airline_Name, Source, Destination, Departure_Date, Available_Seats)
VALUES
(1, 'PK-301', 'PIA', 'Lahore', 'Karachi', '2026-10-01', 120),
(2, 'PK-302', 'PIA', 'Islamabad', 'Lahore', '2026-10-02', 100),
(3, 'EK-601', 'Emirates', 'Lahore', 'Dubai', '2026-10-03', 180),
(4, 'QR-629', 'Qatar Airways', 'Islamabad', 'Doha', '2026-10-04', 150),
(5, 'TK-711', 'Turkish Airlines', 'Karachi', 'Istanbul', '2026-10-05', 200);

INSERT INTO Passenger
(Passenger_ID, Passenger_Name, Gender, Phone, Email, City)
VALUES
(1, 'Ali Khan', 'Male', '03001234567', 'ali@gmail.com', 'Lahore'),
(2, 'Sara Ahmed', 'Female', '03111234567', 'sara@gmail.com', 'Islamabad'),
(3, 'Usman Malik', 'Male', '03221234567', 'usman@gmail.com', 'Karachi'),
(4, 'Ayesha Noor', 'Female', '03331234567', 'ayesha@gmail.com', 'Lahore'),
(5, 'Hamza Iqbal', 'Male', '03441234567', 'hamza@gmail.com', 'Islamabad');

INSERT INTO Reservation
(Reservation_ID, Passenger_ID, Flight_ID, Reservation_Date, Seat_Number, Ticket_Price)
VALUES
(1, 1, 1, '2026-09-25', '12A', 25000.00),
(2, 2, 2, '2026-09-26', '15B', 18000.00),
(3, 3, 3, '2026-09-26', '20C', 85000.00),
(4, 4, 4, '2026-09-27', '10D', 95000.00),
(5, 5, 5, '2026-09-28', '25E', 110000.00);

-- 5 
update Flight
set Destination ='Gaza' , Available_Seats= 150
where Flight_ID=1;
select * from Flight;

-- 6 
update Passenger
set Phone='03144300502' ,
    City='Anatolia'
where Passenger_ID=5;
select * 
from Passenger;

-- 7 

select * 
from Reservation
where Reservation_ID=2;
Delete
from Reservation
where Reservation_ID=2;

select * from Reservation;


-- 8 view

create view reservation_details as
select
 Reservation_ID,
 Passenger_Name,
 Flight_Number,
 Airline_Name,
 Source,
 Destination,
 Seat_Number,
 Ticket_Price
 FROM 
    Flight f, 
    Reservation r, 
    Passenger p 
WHERE 
    f.Flight_ID = r.Flight_ID 
    AND p.Passenger_ID = r.Passenger_ID;

 select *
 from reservation_details;

-- index 

create index idx_passenger_email
on Passenger(Email);

create index idx_destination
on Flight(Destination);

show index from Passenger;
show index from Flight;



