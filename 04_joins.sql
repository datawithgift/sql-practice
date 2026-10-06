-- SQL PRACTICE : JOINs

USE MYDATABASE

-- Retrieve all data from customers and orders in 2 different results

SELECT *
FROM Customers

SELECT *
FROM Orders

/* Get all customers along with their orders but only for customers who have placed 
an order*/

SELECT 
	c.id,
	c.first_name,
	o.order_id,
	o.sales
FROM Customers c
INNER JOIN Orders o
ON c.id =  o.customer_id

-- Get all customers along with their orders including those without orders

SELECT 
	c.id,
	c.first_name,
	o.order_id,
	o.sales
FROM Customers c
LEFT JOIN Orders o
ON c.id = o.customer_id 

-- Get all orders without matching customers

SELECT *
FROM Orders o
LEFT JOIN Customers c
ON o.customer_id = c. id
WHERE c.id IS NULL


/* Get all customers along with their orders including orders without matching 
customers */

SELECT 
	c.id,
	c.first_name,
	o.order_id,
	o.sales
FROM Customers c
RIGHT JOIN Orders o
ON c.id = o.customer_id

-- Get all customers and all orders, even if there's no match
SELECT *
FROM Customers c
FULL JOIN Orders o
ON c.id = o. customer_id

-- Get all customers without orders and all orders without customers

SELECT *
FROM Customers c
FULL JOIN Orders o
ON c.id = o.customer_id
WHERE o.customer_id IS NULL OR c.id IS NULL

-- Generate all possible combinations of customers and orders

SELECT *
FROM Customers c
CROSS JOIN Orders o

/* Using SalESDB, retrieve a list of all orders, along with the related customer,
product and employee details. For each, display: order id, customer's name, 
product name,sales, price, sales persons's name */

USE SalesDB

SELECT 
	o.OrderID,
	o.Sales,
	Concat (c.FirstName, ' ', c.LastName) AS CustomerName,
	p.Product AS ProductName,
	p.Price,
	Concat (e.FirstName, ' ', e.LastName) AS EmployeeName
FROM Sales.Orders o
LEFT JOIN Sales.Customers c 
ON o.CustomerID = c.CustomerID
LEFT JOIN Sales.Products p
ON o.ProductID = p.ProductID
LEFT JOIN Sales.Employees e
ON o.SalesPersonID = e.EmployeeID
