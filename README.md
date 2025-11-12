**🧠 Northwind Analytics SQL Project**

**📊 Data-Driven Insights Using Advanced SQL Queries**

This project demonstrates end-to-end data analysis and query development using the Northwind sample database, a classic relational dataset representing a trading company’s operations across products, orders, employees, shippers, and customers.

The goal of this project is to showcase SQL proficiency through real-world analytical queries involving data extraction, aggregation, filtering, subqueries, joins, Common Table Expressions (CTEs), and window functions.

**🚀 Project Overview**

The project explores a wide range of business questions to simulate data-driven decision-making in areas such as sales, supply chain, finance, and customer behavior.

Key analytical tasks include:

-Understanding customer demographics and regional sales trends

-Tracking product performance and pricing strategy

-Evaluating employee productivity and sales performance

-Analyzing logistics and shipping efficiency

-Applying window functions to calculate rankings and running totals

-Using CTEs for modular, efficient analytical queries

**🧩 Skills Demonstrated**

-Category	SQL Concept	Example

-Data Retrieval	SELECT, DISTINCT, WHERE	Find U.S. customers or high-value products

-Aggregation	COUNT(), SUM(), AVG()	Calculate total sales, discounts, and freight

-Joins	INNER JOIN, LEFT JOIN	Combine customers with orders and shippers

-Subqueries	Nested queries	Compare products above average price

-CTEs	WITH clause	Compute employee sales > $100K

-Window Functions	RANK(), ROW_NUMBER(), SUM() OVER()	Rank products by price, running total per customer

-Conditional Logic	CASE WHEN	Categorize products as Cheap, Moderate, Expensive

-Data Manipulation	INSERT, UPDATE, DELETE	Simulate data entry and maintenance

**🧠 Highlight Queries**

1. Top 5 Most Expensive Products
   
SELECT *
FROM products
ORDER BY unitPrice DESC
LIMIT 5;

2. Running Total of Sales per Customer
   
WITH SalesCTE AS (
  SELECT o.customerID, o.orderID,
         od.unitPrice * od.quantity * (1 - od.discount) AS sale
  FROM order_details od
  JOIN orders o ON o.orderID = od.orderID
)
SELECT customerID, orderID, sale,
       SUM(sale) OVER (PARTITION BY customerID ORDER BY orderID) AS runningTotalSales
FROM SalesCTE
ORDER BY customerID, orderID;

3. Employee Sales Above $100,000

WITH EmployeeSales AS (
  SELECT e.employeeID, e.employeeName,
         SUM(od.unitPrice * od.quantity * (1 - od.discount)) AS TotalSales
  FROM employees e
  JOIN orders o ON e.employeeID = o.employeeID
  JOIN order_details od ON o.orderID = od.orderID
  GROUP BY e.employeeID, e.employeeName
)
SELECT *
FROM EmployeeSales
WHERE TotalSales > 100000
ORDER BY TotalSales DESC;

**🛠️ Tools & Technologies**

-MySQL

-Northwind Database

-GitHub for Version Control

**🎯 Key Learning Outcomes**

Applied complex joins and subqueries to extract meaningful business insights

Built modular and optimized queries using CTEs

Leveraged window functions for ranking and cumulative analysis

Demonstrated business-oriented analytics through SQL alone

**🌟 Results**

This project highlights SQL expertise across all major query categories, emphasizing not just technical syntax but also analytical thinking and business relevance. It can serve as a strong portfolio example for roles such as Data Analyst, Business Analyst, or BI Developer.

**🧾 License**

This project is open-source and available for educational and portfolio use.
