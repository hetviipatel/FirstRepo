use RISEJULY

create table Customers
(CustomerID int primary key identity(1,1),
CustomerName varchar(255),
Address varchar(255),
City varchar(255),
State varchar(255),
Country varchar(255))

create table Products
(ProductID int primary key identity(1,1),
ProductName varchar(255),
CategoryID int,
Price int,
InStock varchar(255))

create table Orders1
(OrderID int primary key identity,
OrderDate date,
CustomerID int foreign key references Customers(CustomerID),
ProductID int foreign key references Products(ProductID),
Quantity int,
Price decimal (10,2),
ShippingAddress varchar(255))

insert into Customers values
('Hetvi Patel', 'Shivaji Nagar', 'Vadodara', 'Gujarat', 'India'),
('Ayushi Patel', 'Gandhi Road', 'Surat', 'Gujarat', 'India'),
('Nidhi Jethva', 'agore Street', 'Ahmedabad', 'Gujarat', 'India'),
('Riya Tailor', 'Nehru Lane', 'Rajkot', 'Gujarat', 'India'),
('Krina Mistry', 'Patel Chowk', 'Anand', 'Gujarat', 'India')

insert into Products values
('Laptop', 1, 60000.00, 20),
('Mobile', 1, 35000.00, 30),
('Earbuds', 2, 2000.00, 50),
('Smartwatch', 2, 5000.00, 25),
('Laptop', 3, 7000.00, 15)

insert into Orders1 values
('2025-07-27', 1, 5, 5, 1800, 'Vadodara'),
('2024-06-18', 2, 3, 2, 36000, 'Gurgaon'),
('2023-05-09', 3, 4, 4, 3600, 'Mumbai'),
('2022-04-27', 4, 2, 3, 4500, 'Navi Mumbai'),
('2021-03-18', 5, 1, 1, 36000, 'Jaipur')

select * from Customers
select * from Products
select * from Orders1


--2.Find the total quantity and revenue for each product.
select p.ProductName, SUM(o.Quantity*o.price) AS Total_revenue
from orders1 o
JOIN products p
on o.ProductID = p.ProductID
group by p.ProductName

--3.Find the top 5 customers with the highest total spending.
select top 5 c.CustomerName, (o.Quantity*o.Price) AS Highest_spending
from orders1 o
JOIN customers c
on o.CustomerID = c.CustomerID
order by Highest_spending DESC

--4.Calculate the average order value for each state.
select c.state, AVG(o.Quantity*o.Price) AS Avg_Order_Value
from customers c
left JOIN orders1 o
on c.CustomerID = o.CustomerID
group by c.state

--5.Find the products that have been ordered more than once.
select p.ProductName, COUNT(p.ProductID) AS Order_more_than_One
from products p
join orders1 o
on p.ProductID = o.ProductID
group by p.ProductName
having COUNT(p.ProductID) > 1

--6.Find the products that have been ordered by the most customers.
select p.ProductName, COUNT(p.ProductID) AS Most_Order
from products p
join orders1 o
on p.ProductID = o.ProductID
group by p.ProductName
order by Most_Order DESC

--7.Create an index on the OrderDate column of the Orders table.
create index IX_Orders_OrderDate
on orders1 (OrderDate DESC) 

--8.Using Subquery Find products that have never been ordered.
select ProductName FROM products 
where productid not in (select distinct ProductID from orders1)