USE MYDATABASE

-- Retrieve all customers from Germany

SELECT *
FROM Customers
WHERE Country = 'Germany'

-- Retrieve all customers who are not from Germany

SELECT *
FROM Customers
WHERE Country != 'Germany'

-- Retrieve all customers with a score greater than 500

SELECT *
FROM Customers
WHERE Score > 500

-- Retrieve all customers with a score of 500 or more

SELECT *
FROM Customers
WHERE Score >=  500

-- Retrieve all customers with a score less than 500

SELECT *
FROM Customers
WHERE Score < 500

/* Retrieve all customers who are from USA and have a score greater than 500*/

SELECT *
FROM Customers
WHERE Country = 'USA' AND Score > 500

-- Retrieve all customers who are either from USA or have a score greater than 500

SELECT *
FROM Customers
WHERE Country = 'USA'  OR Score > 500

-- Retrieve all customers with a score not less than 500

SELECT * 
FROM Customers
WHERE NOT Score < 500

-- Retrieve all customers whose score falls in the range between 100 and 500

SELECT *
FROM Customers
WHERE Score BETWEEN 100 AND 500

-- Retrieve all customers from either USA or Germany

SELECT *
FROM Customers 
WHERE Country = 'USA' OR Country = 'Germany' 

-- Find all customers whose first name starts with 'M'

SELECT *
FROM Customers
WHERE first_name LIKE 'M%'

-- Find all customers whose first name starts with 'M'

SELECT *
FROM Customers
WHERE first_name LIKE '%N'

-- Find all customers whose first name contains r

SELECT *
FROM Customers 
WHERE First_name LIKE '%r%'

-- Find all customers whose first name has r in the 3rd position

SELECT *
FROM Customers
WHERE First_name LIKE '__R%'
