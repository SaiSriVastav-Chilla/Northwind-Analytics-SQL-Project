#1 How to select all columns from the products table?
select *
from products;

#2 How to retrieve employee names and the cities they work in?
select employeeName, city
from employees;

#3 How to find customers located in the USA?
select *
from customers
where country = "USA";

#4 Which products have a unit price greater than 20?
select productID, productName, unitPrice
from products
where unitPrice > 20;

#5 What are the distinct job titles of employees?
select distinct title 
from employees;

#6 How to count the total number of orders?
select count(orderID)
from orders;

#7 What is the maximum unit price of products?
select productID, productName, unitPrice
from products
order by unitPrice desc
Limit 1;

select max(unitPrice) as max_unitprice
from products;

#8 What is the minimum freight charge in all orders?
select min(freight)
from orders;

select freight
from orders
order by freight
limit 1;

#9 How to calculate the average quantity per unit for products?
select avg(quantityPerUnit)
from products;

#10 What is the sum of quantities ordered in order details?
select sum(quantity)
from order_details;

#11 How to count the number of orders placed by each customer?
select customerID, count(orderID)
from orders
group by customerID;

#12 What is the total freight charge per shipper?
select shipperID, sum(freight)
from orders
group by shipperID;

#13 Which categories have more than 5 products?
select categoryID, count(productID) as product_count
from products
group by categoryID
having product_count > 5;

#14 How to find the total sales per product?
select productID, sum(quantity*(unitPrice)*(1-discount)) as total_sales
from order_details
group by productID;

#15 How to find total discount per order?
select orderID, sum(discount) as total_discount
from order_details
group by orderID
order by total_discount desc;

#16 How to list orders along with customer names?
select c.customerID, companyName, contactName, orderID
from orders o
left join customers c
on o.customerID = c.customerID;

#17 How to display products with their category names?
select productID, productName, categoryName
from categories c 
inner join products p
on c.categoryID = p.categoryID;

#18 How to get order details showing product names and quantities?
select orderID,  productName, sum(quantity) as quantity
from products p
left join order_details od 
on p.productID = od.productID
group by orderID, productName;

#19 How can employee names be listed along with their manager names?
select e1.employeeName, e2.employeeName as Manager
from employees e1
join employees e2
on e1.reportsTo = e2.employeeID;

#20 How to display orders along with shipper company names?
select o.orderID, companyName as ShipperCompanyNames
from orders o
inner join shippers s
on o.shipperID = s.shipperID;

#21 How to find the top 5 most expensive products?
select *
from products
order by unitPrice desc
limit 5;

#22 How to order employees by country then by city?
select employeeID, employeeName, country, city
from employees
order by country, city;

#23 How to find the latest 10 orders by order date?
select orderID, orderDate
from orders
order by orderDate desc
limit 10;

#24 How to find customers whose company names start with 'A'?
Select *
from customers
where companyName like "A%";

#25 Which orders were placed in July 2013?
Select orderID, orderDate
from orders
where orderDate >= "2013-07-01" && orderDate <= "2013-07-31";

#26 How to extract the year from the order date?
select year(orderDate)
from orders;

# How to find orders shipped late (shippedDate > requiredDate)?
select orderID, shippedDate, requiredDate
from orders
having "shippedDate" > "requiredDate";

#  How to find products where the product name contains 'Chai'?
select productID, productName
from products
where productName like "%Chai%";

# How to categorize product prices as 'Cheap', 'Moderate', or 'Expensive'?
select productID, productName, unitPrice,
case
	when unitPrice < 20 THEN 'Cheap'
    when unitPrice BETWEEN 20 and 50 THEN 'Moderate'
    else 'expensive'
    end as PriceCategory
from products;

# How to calculate total price per order detail line (quantity × unitPrice)?

select orderID, productID, quantity, unitPrice, (unitPrice*quantity) as TotalPrice
from order_details;

# How to calculate net sales per product after discount?
select productID, unitPrice, quantity, discount, (quantity)*(unitPrice)*(1-discount) as NetSales
from order_details;

# How to find products priced higher than the average product price?
select productID, unitPrice
from order_details
where unitPrice > (
	select avg(unitPrice)
    from order_details);
    
# Which customers have placed orders?
select distinct c.customerID,c.companyname
from customers c
join orders o
on c.customerID = o.customerID
;

# How to find customers with orders shipped by 'Speedy Express'?
select distinct o.customerID, c.companyName, s.companyName
from customers c
join orders o 
on c.customerID = o.customerID
join shippers s
on o.shipperID = s.shipperID
where s.companyName = 'Speedy Express';

# How to insert a new product into the products table?
INSERT INTO Products (ProductID, productName, quantityPerUnit, unitPrice, discontinued, categoryID)
VALUES ( 78, 'Fish', 25, 18.00, 0, 0);

# How to update the price of all non-discontinued products by 10%?
update products
set unitPrice = 1.1*unitPrice
where discontinued = 0;

# How to delete all discontinued products?
delete from products
where discontinued = 1;

# How to count how many distinct products have been ordered?
select count(distinct productID)
from order_details;

# How to count how many employees work in each city?
select city, count(employeeID)
from employees
group by city;

# How to find the total freight cost per customer country?
select country, sum(freight) as totalFreight
from orders o
join customers c
on o.customerID = c.customerID
group by country;

# Find all orders where the freight cost is above the average freight cost
select orderID, customerID, orderDate, freight
from orders
where freight > (select avg(freight)
				from orders)
order by freight desc; 

# Show customers and their latest order date 
with latestorders as ( 
select customerID, max(orderDate) as latestorderdate
from  orders
group by customerID)
select c.customerID, c.companyName, lo.latestorderdate
from customers c
join latestorders lo
on c.customerID = lo.customerID;

select c.customerID, c.companyName, (select max(o.orderDate) from orders o where o.customerID = c.customerID) as latestorderdate
from customers c;

# Use a CTE to get all orders from 2013 and then select the top 5 by freight
with ordersafter2013 as (select orderID, orderDate from orders where orderDate > "2013-12-31")
select orderID, orderDate, freight
from orders
order by freight desc
limit 5;

# For each product, show its price and whether it is “Above Average” or “Below Average”
select productID, productName, unitPrice,
 CASE 
 when unitPrice > (select avg(unitPrice) from products) then "Above Average"
 when unitPrice < (select avg(unitPrice) from products) then "Below Average"
 else "Equal"
 END as pricecomparison
from products;

with AvgPrice as (
select avg(unitprice) as avg_price
from products)
select productID, productName, unitPrice,
CASE 
 when unitPrice > avg_price then "Above Average"
 when unitPrice < avg_price then "Below Average"
 else "Equal"
 END as pricecomparison
 from products p
 cross join AvgPrice a;
 
 # Retrieve the second highest unit price among products
select unitPrice from products order by unitPrice desc limit 1 offset 1;

select max(unitPrice) as Secondhighestprice
from products
where unitPrice < (select max(unitPrice) from products);

# Use a window function to show order IDs, order dates, and a ROW_NUMBER() per customer sorted by order date.
select orderID, orderDate, customerID, row_number() over (order by orderDate)
from orders;

#  Show a running total of sales per customer using SUM() OVER (PARTITION BY … ORDER BY …)
with SalesCTE as (
select o.customerID,
o.orderID,
od.Unitprice * od.quantity * (1-od.discount) as sale
from order_details od 
join orders o
on o.orderID = od.orderID)
select customerID, orderID, sale, sum(sale) over (partition by customerID order by orderID) as runningtotalsales
from SalesCTE
order by customerID, orderID;

# Use a RANK() function to rank products by price within each category.
select productID, productName, CategoryID, unitPrice, RANK() over(partition by categoryID order by unitPrice desc) as priceRank
from products
order by categoryID, priceRank;

# Create a CTE to calculate the total sales per employee, then select employees who made sales above $100,000.
with employeesales as (
select e.employeeID, e.employeeName, sum(od.unitPrice*od.Quantity*(1-od.Discount)) as TotalSales
from employees e
join orders o
on e.employeeID = o.employeeID
join order_details od
on o.orderID = od.orderID
group by e.employeeID, e.employeeName)
select employeeID, employeeName, TotalSales
from employeesales
where TotalSales > 100000
order by TotalSales DESC;