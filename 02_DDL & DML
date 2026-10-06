-- DDL & DML

USE SALESDB

/* Create a table called persons with columns: 
Id, person_name, birth_date,and phone */

CREATE Table Persons (
ID INT NOT NULL,
Person_Name VARCHAR (50) NOT NULL,
Birth_Date DATE,
Phone VARCHAR (15) NOT NULL,
CONSTRAINT pk_persons PRIMARY KEY (ID)
)

SELECT *
FROM Persons

-- Add a new column called email to the persons table

ALTER Table Persons
ADD Email VARCHAR (50) NOT NULL

SELECT *
FROM Persons

-- Insert data from Sales.Customers into persons

INSERT INTO Persons (ID,Person_Name, Birth_Date, Phone)
Select 
	CustomerID,
	CONCAT (FirstName, ' ', LastName),
	Null,
	'UNKNOWN'
FROM Sales.Customers 

-- Delete all data from table persons

TRUNCATE Table Persons

SELECT *
FROM Persons

-- Change the score of customer 2 to 0

UPDATE Sales.Customers
SET Score = 0
WHERE CustomerID = 2

SELECT *
FROM Sales.Customers

-- Change the score of customer 5 to 100 and change country to UK

UPDATE Sales.Customers
SET Score = 100, 
    Country = 'UK'
WHERE CustomerID = 5

SELECT *
FROM Sales.Customers

USE SalesDB

-- Delete Table persons

DROP Table Persons
