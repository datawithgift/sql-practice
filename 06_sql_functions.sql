-- SQL FUNCTIONS

-- STRING FUNCTIONS

-- Show a list of customer's first names together with their country in one column

USE MyDatabase

SELECT 
	first_name,
	country,
	Concat ( first_name, ' ', country) AS name_country
FROM Customers

-- Transform customer's first name to lowercase

SELECT 
	first_name,
	LOWER (first_name) AS name_lower
FROM Customers

-- Transform customer's first name to uppercase

SELECT 
	first_name,
	UPPER (first_name) AS name_upper
FROM Customers

-- Find customers whose first name contain leading or trailing spaces

SELECT
	first_name,
	LEN(first_name) name_len,
	LEN(TRIM(first_name)) trimmed_name_len,
	LEN(first_name) - LEN(TRIM(first_name)) AS flag
FROM Customers
WHERE LEN(first_name) != LEN(TRIM(first_name))

 -- OR

SELECT
first_name
FROM Customers
WHERE first_name != TRIM (first_name)

-- Remove dashes from a phone number

SELECT 
	'234-903-443-2360' phone,
	REPLACE ('234-903-443-2360', '-', '') new_phone

-- Replace file extension from txt to csv

SELECT 
	'div.txt' doc,
	REPLACE ('div.txt', 'txt','csv') new_doc

-- Calculate the length of each customer's first name

SELECT
	first_name,
	LEN(first_name) before_trim_len,
	TRIM(first_name) name_trim,
	LEN(TRIM(first_name)) after_trim_len
FROM Customers

-- Retrieve the first two characters for each fist name

SELECT 
	first_name, 
	TRIM(first_name) name_trim,
	LEFT(TRIM(first_name),2) first_2_char
FROM Customers

-- Retrieve the last two characters of each first name

SELECT 
	first_name,
	RIGHT(first_name,2) right_2_char
FROM Customers

-- Retrieve a list of customer's first names after removing the first character

SELECT 
	first_name,
	SUBSTRING(TRIM(first_name),2,LEN(first_name)) sub_name
FROM Customers

-- NUMBER FUNCTIONS

-- Round up the number to 2,1 and 0 decimal places

SELECT 
'3.516' numb,
ROUND(3.516,2) rnd_2,
ROUND(3.516,1) rnd_1,
ROUND(3.516,0) rnd_0

-- DATE & TIME FUNCTIONS

-- Add today's date to the orders table

USE SalesDB

SELECT
	OrderID,
	OrderDate,
	CreationTime,
	GETDATE () Today
FROM Sales.Orders

-- Get the year, month, day, hour, quater, week from the creation time

SELECT
	OrderID,
	OrderDate,
	CreationTime,
	YEAR(CreationTime) Year,
	MONTH(CreationTime) Month,
	DATEPART(HOUR,CreationTime) Hour,
	DATEPART(QUARTER,CreationTime) Quater,
	DATEPART(WEEK,CreationTime) Week,
--  Get the month name and weeekday from the creation time
	DATENAME(MONTH,CreationTime) Month_Name,
	DATENAME(WEEKDAY,CreationTime) Day_Name,
-- Datetrunc examples
	DATETRUNC(MINUTE,CreationTime) Min,
-- Eomonth examples
EOMONTH(CreationTime) Last_Day_Month
FROM Sales.Orders

-- How many orders were placed each year

SELECT
	YEAR(OrderDate) Year,
	COUNT(OrderID) NrOfOrders
FROM Sales.Orders
GROUP BY YEAR(OrderDate)

-- How many orders were placed each month

SELECT 
	DATENAME (MONTH, OrderDate) Month,
	COUNT(OrderID) NrOfOrders
FROM Sales.Orders
GROUP BY DATENAME (MONTH, OrderDate)

-- Show all orders that were placed during the month of february

SELECT 
        OrderID
      ,[ProductID]
      ,[CustomerID]
      ,[SalesPersonID]
      ,MONTH(OrderDate) OrderDate_Month
      ,[ShipDate]
      ,[OrderStatus]
      ,[ShipAddress]
      ,[BillAddress]
      ,[Quantity]
      ,[Sales]
      ,[CreationTime]
FROM Sales.Orders
WHERE MONTH(OrderDate) = 2

-- FORMATTING & CASTING

