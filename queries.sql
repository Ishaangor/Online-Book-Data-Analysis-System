create database ishaansqlprojectdb;
use ishaansqlprojectdb;


DROP TABLE IF EXISTS Books;
CREATE TABLE Books (
    Book_ID SERIAL PRIMARY KEY,
    Title VARCHAR(100),
    Author VARCHAR(100),
    Genre VARCHAR(50),
    Published_Year INT,
    Price NUMERIC(10, 2),
    Stock INT
);
DROP TABLE IF EXISTS customers;
CREATE TABLE Customers (
    Customer_ID SERIAL PRIMARY KEY,
    Name VARCHAR(100),
    Email VARCHAR(100),
    Phone VARCHAR(15),
    City VARCHAR(50),
    Country VARCHAR(150)
);
DROP TABLE IF EXISTS orders;
CREATE TABLE Orders (
    Order_ID SERIAL PRIMARY KEY,
    Customer_ID INT REFERENCES Customers(Customer_ID),
    Book_ID INT REFERENCES Books(Book_ID),
    Order_Date DATE,
    Quantity INT,
    Total_Amount NUMERIC(10, 2)
);

SELECT * FROM Books;
SELECT * FROM Customers;
SELECT * FROM Orders;


LOAD DATA INFILE 'C:/Users/DELL/Desktop/SQL Project/Books.csv'
INTO TABLE ishaansqlprojectdb.Books
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

LOAD DATA INFILE 'C:/Users/DELL/Desktop/SQL Project/Customers.csv'
INTO TABLE ishaansqlprojectdb.Customers
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(Customer_ID, Name, Email, Phone, City, Country);

LOAD DATA INFILE 'C:/Users/DELL/Desktop/SQL Project/Orders.csv'
INTO TABLE ishaansqlprojectdb.Orders
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(Order_ID, Customer_ID, Book_ID, Order_Date, Quantity, Total_Amount);

show databases;

select * from Books
where Genre='Fiction';

select * from Books
where Published_Year> 1950;

select * from Customers 
where Country = 'Canada';

select * from Orders
where Order_Date between 2023-11-01 and 2023-11-30;

select sum(Stock) AS Total_Stock
from books;

select * from Books
order by price desc
limit 1;

select customer_id from Orders
where quantity > 1;

select * from Orders
where Total_amount > 20;

select distinct genre from Books;

select * from Books 
order by stock asc
limit 1;

select sum(Total_amount) as Revenue_generated
from Orders;

SELECT b.Genre, SUM(o.Quantity) AS Total_books_sold
FROM Orders o
JOIN Books b 
ON b.Book_ID = o.Book_ID
GROUP BY b.Genre;

select avg(price) 
from Books
where genre='Fantasy';

select c.customer_id , c.name 
from Customers c
join Orders o 
on c.customer_id=o.customer_id
where o.quantity>2;

select b.Book_ID,b.title 
from Books b
join Orders o 
on b.Book_ID=o.Book_ID
order by o.order_ID desc
limit 1;

SELECT o.Book_id, b.title, COUNT(o.order_id) AS ORDER_COUNT
FROM orders o
JOIN books b ON o.book_id=b.book_id
GROUP BY o.book_id, b.title
ORDER BY ORDER_COUNT DESC LIMIT 1;

select * from Books
where genre='Fantasy'
order by price limit 3;

select distinct b.author , o.quantity 
from books b 
join orders o 
on b.book_ID=o.book_ID

select  c.city , o.Total_amount
from Customers c
join Orders o 
on c.customer_id=o.customer_id
where o.total_amount > 30;

SELECT c.customer_id, c.name, SUM(o.total_amount) AS Total_Spent
FROM orders o
JOIN customers c ON o.customer_id=c.customer_id
GROUP BY c.customer_id, c.name
ORDER BY Total_spent Desc LIMIT 1;

