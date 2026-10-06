-- SQL PRACTICE

USE SalesDB

-- Retrieve each customer's name, country and score

SELECT
	Concat (FirstName, ' ', LastName) AS Name,
	Country,
	Score
FROM Sales.Customers

-- Retrieve customers with a score not equal to 0

SELECT
	FirstName,
	Score
From Sales.Customers
Where Score != 0

/* Retrieve all customers and sort the results by country and then by highest score*/

SELECT *
FROM Sales.Customers
ORDER BY country ASC,score DESC

-- Find the total score for each country
SELECT
	Country,
	SUM (Score) AS TotalScore
FROM Sales.Customers
GROUP BY Country

-- Find the total score and total number of customers for each country

SELECT
	Country,
	COUNT (CustomerID) AS TotalNumbOfCountry,
	SUM (Score) AS TotalScore
FROM Sales.Customers
GROUP BY Country

/* Find the average score for each country 
considering only customers with a score not equal to 0
and return only those countries with an average score greater than 430*/

SELECT	
	Country,
	AVG (Score) AS AVG_Score
FROM Sales.Customers
WHERE Score != 0
GROUP BY Country
Having AVG (Score) > 430

-- Return unique list of all countries 

SELECT DISTINCT 
	Country
FROM Sales.Customers

-- Retrieve only 3 customers 

SELECT TOP 3 *
FROM Sales.Customers

-- Retrieve the top 3 customers with the highest score

SELECT TOP 3 *
FROM Sales.Customers
ORDER BY Score DESC

-- Get the 2 most recent orders

SELECT TOP 2 *
FROM Sales.Orders
ORDER BY OrderDate DESC
