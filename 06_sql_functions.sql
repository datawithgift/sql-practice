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
	
-- Format creation time to dd, ddd, dddd, MM, MMM, MMMM

SELECT
	CreationTime,
	FORMAT(CreationTime, 'dd') DD,
	FORMAT(CreationTime, 'ddd') DDD,
	FORMAT(CreationTime, 'dddd') DDDD,
	FORMAT(CreationTime, 'MM') MM,
	FORMAT(CreationTime, 'MMM') MMM,
	FORMAT(CreationTime, 'MMMM') MMMM
FROM Sales.Orders

-- Show creation time using the following format : Day Wed Jan Q1 2025 12:34:56 PM

SELECT
	OrderID,
	CreationTime,
	'Day' + ' ' + FORMAT(CreationTime,'ddd MMM') + ' ' + 'Q' + DATENAME(QUARTER, CreationTime)
	+ ' ' + FORMAT(CreationTime, 'yyyy hh:mm:ss tt') AS Custom_Format
FROM Sales.Orders 

-- Convert string to int, CreationTime to date

SELECT
	CONVERT(INT,'12345') [String to INT],
	CreationTime,
	CONVERT(DATE, CreationTime) Date
FROM Sales.Orders

-- Cast string to int

SELECT 
	CAST('4567' AS INT) String_to_integer,
	CAST('2026-10-8' AS DATETIME) Date_to_datetime,
	CreationTime,
	CAST(CreationTime AS DATE) Datetime_to_date
FROM Sales.Orders

-- Generate date of 3 months later,10 days before & 2 years later

SELECT 
	OrderID,
	OrderDate,
	DATEADD(MONTH,3,Orderdate) [Three Months Later],
	DATEADD(DAY,-10,Orderdate) [Ten Days Before],
	DATEADD(YEAR,3,Orderdate) [2 Years Later]
FROM Sales.Orders

-- Calculate the age of employees

SELECT 
       [EmployeeID]
      ,[FirstName]
      ,[LastName]
      ,[Department]
      ,[BirthDate]
      ,[Gender]
      ,[Salary]
      ,[ManagerID],
	  CAST(GETDATE () AS DATE) TodayDate,
	  DATEDIFF(YEAR,BirthDate,CAST(GETDATE () AS DATE)) EmployeeAge
FROM Sales.Employees 

-- Find the average shipping duration in days for each month

SELECT 
	  DATENAME(MONTH, Orderdate) Month,
	  AVG(DATEDIFF(DAY, OrderDate, ShipDate)) AvgShipDuration
FROM Sales.Orders
GROUP BY DATENAME(MONTH, Orderdate)

-- Time Gap Analysis
-- Find the number of days between each order and the previous order

SELECT
	OrderID,
	OrderDate,
	LAG(OrderDate) OVER ( ORDER BY OrderDate) PreviousOrderDate,
	DATEDIFF(DAY,LAG(OrderDate) OVER ( ORDER BY OrderDate),OrderDate) NrOfDays
FROM Sales.Orders


--  Confirm if its a date or not

SELECT
ISDATE(1234) Check1,
ISDATE(2025-10-8) Check2,
ISDATE(2025-8-10) Check3,
ISDATE(2026) Check4,
ISDATE(07) Check5

-- Find the average scores of the customers

SELECT 
CustomerID,
Score,
AVG(Score) OVER () AvgScore
FROM Sales.Customers

-- Display the full name of customers into a single field
-- by merging their first names and last names
-- and add 10 bonus points to each customers score

SELECT
       [CustomerID],
	   FirstName,
	   LastName,
	   COALESCE(LastName,'') LastNameNew
      ,CONCAT(FirstName, ' ', COALESCE(LastName,'')) FullName
      ,[Country]
      ,[Score] + 10 Score
FROM Sales.Customers	

-- Find the sales price for each order by dividing sales by quantity

SELECT 
	OrderID,
	OrderDate,
	Sales,
	Quantity,
	Sales / NULLIF(Quantity,0) SalesPrice
FROM Sales.Orders


USE MyDatabase

UPDATE customers
SET Score = NULL
WHERE Score = 0

SELECT *
FROM customers

-- Identify the customers who have no score

SELECT *
FROM customers
WHERE Score IS NULL

-- List all customers who have scores

SELECT *
FROM customers
WHERE Score IS NOT NULL

-- List all details for customers who have not placed any order

USE SalesDB

SELECT 
c.*,
o.OrderID
FROM Sales.Customers c
LEFT JOIN Sales.Orders o
ON c.CustomerID = o.CustomerID
WHERE o.CustomerID IS NULL

-- Case Statement

/*  Create report showing total sales for each of the following categories;
High (sales over 50), Medium (sales 21-50), and low (sales 20 or less).
Sort the categories from highest sales to lowest */

SELECT
       Category,
	   SUM(Sales) TotalSales
FROM(
SELECT 
       [OrderID],
       [Sales],
CASE
      WHEN Sales >50 THEN 'High'
	  WHEN Sales BETWEEN 21 AND 50 THEN 'Medium'
	  ELSE 'Low'
END Category	  
FROM Sales.Orders
)t
GROUP BY Category
ORDER BY TotalSales DESC

-- Retrieve employees details with gender displayed as full text

SELECT 
       [EmployeeID]
      ,[FirstName]
      ,[LastName]
      ,[Department]
      ,[BirthDate]
      ,[Gender],
CASE
     WHEN Gender = 'F' THEN 'Female'
	 WHEN Gender = 'M' THEN 'Male'
	 ELSE 'n/a'
	 END GenderFulText
FROM Sales.Employees

-- Retrieve customer details with abbreviated country code

SELECT DISTINCT
Country
FROM Sales.Customers

SELECT 
       [CustomerID]
      ,[FirstName]
      ,[LastName]
      ,[Country]
      ,
CASE 
    WHEN Country = 'Germany' THEN 'DE'
	WHEN Country = 'USA' THEN 'US'
	ELSE 'UK'
END CountryAbbr
FROM Sales.Customers

-- Find the average score of customers and treat nulls as 0
-- Additionally provide details such as CustomerID and Lastname

SELECT
       [CustomerID]
      ,[LastName],
	   [Score],
COALESCE([Score],0) NewScore,
AVG(COALESCE([Score],0)) OVER () AvgScore
FROM Sales.Customers 
 
 -- OR

SELECT 
	 CustomerID,
	 LastName,
	 Score,
CASE 
     WHEN Score IS NULL THEN 0
	 ELSE Score
END NewScore,
AVG(CASE 
     WHEN Score IS NULL THEN 0
	 ELSE Score
END) OVER () AvgScore
FROM Sales.Customers

/* Count how many times each customer has made an order with sales greater than
30*/

SELECT 
	CustomerID,
Count(*) NrOfOrders
FROM Sales.Orders
WHERE Sales > 30
GROUP BY CustomerID

-- AGGREGATE FUNCTIONS IN SQL / GROUP BY FUNCTIONS & SQL WINDOW FUNCTIONS

-- Find the highest & lowest sales of all orders
-- Find the number of orders & average sales

SELECT 
MAX(Sales) HighestSales,
MIN(Sales) LowestSales,
COUNT(*) NroFOrders,
AVG(Sales) AvgSales
FROM Sales.Orders

-- Find the total sales for each product

SELECT 
	ProductID,
	SUM(Sales) TotalSales
FROM Sales.Orders
GROUP BY ProductID

-- Find the total sales for each product
-- Additionally provide details such as orderid & order date

SELECT 
	OrderID,
	OrderDate,
	ProductID,
	SUM(Sales) OVER (PARTITION BY ProductID) TotalSales
FROM Sales.Orders

-- Find the total sales across all orders
-- Find the total sales for each product
-- Additionally provide details such as orderid and orderdate

SELECT 
OrderID,
OrderDate,
ProductID,
Sales,
SUM(Sales) OVER () TotalSales,
SUM(Sales) OVER (PARTITION BY ProductID) TotalSalesByProducts
FROM Sales.Orders

-- Find the total sales across all orders
-- Find the total sales for each product
-- Find the total sales for each combination of product and order status
-- Additionally provide details such as orderid and orderdate

SELECT 
OrderID,
ProductID,
OrderDate,
OrderStatus,
Sales,
SUM(Sales) OVER () TotalSales,
SUM(Sales) OVER (PARTITION BY ProductID, OrderStatus) TotalSalesByProductsAndOrderStatus,
SUM(Sales) OVER (PARTITION BY ProductID) TotalSalesByProducts
FROM Sales.Orders

-- RANKING WINDOW FUNCTIONS


