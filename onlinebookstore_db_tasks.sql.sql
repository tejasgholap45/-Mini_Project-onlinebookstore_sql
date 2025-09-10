create database onlinebookstore_db;
use onlinebookstore_db;
show tables;
select * from books;
select * from customers;
select * from orders;

-- 1. Retrieve all books in the “Fiction” genre. 
select * from books where Genre = 'Fiction';

-- 2. Find books published after the year 1950. 
select * from books where Published_Year > 1950;

-- 3. List all customers from Canada.
select * from customers where Country = 'Canada';

-- 4. Show orders placed in November 2023.
select * from orders where Order_Date like "2023-11%";

-- 5. Retrieve the total stock of books available.
 select sum(Stock) "Total Stock" from books;
 
-- 6. Find the details of the most expensive book. 
select * from books order by Price desc limit 1;

-- 7. Show all customers who ordered more than 1 quantity of a book. 
select c.Customer_ID, c.Name, o.Quantity from customers c
join orders o on c.Customer_ID = o.Customer_ID
where o.Quantity > 1;

-- 8. Retrieve all orders where the total amount exceeds $20. 
select * from orders where Total_Amount > 20;

-- 9. List all distinct genres in the bookstore. 
select distinct Genre from books;

-- 10. Find the book with the lowest stock available. 
 select * from books order by Stock ASC limit 1;
 
-- 11. Calculate the total revenue from all orders.
select sum(Total_Amount) as total_revenue from orders;

-- Intermediate Level: 
-- 12. Retrieve the total number of books sold for each genre. 
select b.Genre ,sum(o.Quantity) "Total_Book_Sold" from books b join orders o on b.Book_ID = o.Book_Id group by b.Genre;

-- 13. Find the average price of books in the “Fantasy” genre.
select avg(Price) "avg_Fantasy_Price" from books where Genre = 'Fantasy';

-- 14. List customers who have placed at least 2 orders. 
select c.Customer_ID, c.Name, count(o.order_ID) as total_orders from customers c join orders o on c.Customer_ID = o.Customer_ID 
group by c.Customer_ID,c.Name having  count(o.order_ID) >= 2;

-- 15. Find the most frequently ordered book. 
select b.book_ID, b.Title, count(o.Order_ID) as order_count from books b join orders o on b.book_ID = o.book_ID 
group by b.book_ID, b.Title order by order_count desc limit 1;

-- 16. Show the top 3 most expensive books of the “Fantasy” genre.
select book_ID, Title, Price from books where genre = "Fantasy" order by Price desc limit 3;

-- Advanced Level: 
-- 17. Retrieve the total quantity of books sold by each author.
select b.Author, sum(o.Quantity) as total_sold
from books b join orders o on b.book_ID = o.book_ID group by b.Author;

-- 18. List the cities of customers who spent over $30.
select c.City from customers c
join orders o on c.customer_ID = o.customer_ID
join books b on o.book_ID = b.book_ID
group by c.customer_ID, c.City
having SUM(o.Quantity * b.Price) > 30;

-- 19. Find the customer who spent the most on orders. 
select c.customer_ID, c.Name, SUM(o.Quantity * b.Price) as total_spent
from customers c 
join orders o on c.customer_ID = o.customer_ID
join books b on o.book_ID = b.book_ID
group by c.customer_ID, c.Name
order by total_spent desc limit 1;

-- 20. Calculate the stock remaining after fulfilling all orders. 
select b.book_ID, b.Title, b.Stock - ifnull(SUM(o.Quantity), 0) as stock_remaining
from books b
left join orders o on b.book_ID = o.book_ID
group by b.book_ID, b.Title, b.Stock;
