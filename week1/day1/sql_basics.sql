/*
Day 1 - SQL Fundamentals
Learning focus:
- SELECT
- WHERE
- GROUP BY
- ORDER BY
- PARTITION BY
- Aggregations
*/

-- Create table
CREATE TABLE sales (
    id SERIAL PRIMARY KEY,
    customer_name VARCHAR(100),
    product VARCHAR(100),
    amount NUMERIC,
    sale_date DATE
);

-- Insert test data into table
INSERT INTO sales (customer_name, product, amount, sale_date) VALUES
('Anna', 'Laptop', 1200, '2025-01-10'),
('Ben', 'Phone', 800, '2025-01-12'),
('Anna', 'Mouse', 40, '2025-01-15'),
('Clara', 'Laptop', 1200, '2025-01-18'),
('Ben', 'Keyboard', 100, '2025-01-20');

-- Show all sales
SELECT * FROM sales;

-- Show only customer and amount
SELECT customer_name, amount FROM sales;

-- Sales greater than 500
SELECT *
FROM sales
WHERE amount > 500;

-- Total revenue per product
SELECT product, SUM(amount) AS total_revenue
FROM sales
GROUP BY product;

-- Total revenue per customer
SELECT customer_name, SUM(amount) AS total_revenue
FROM sales
GROUP BY customer_name;

-- Total revenue of a specific customer
SELECT customer_name, SUM(amount)
FROM sales
WHERE customer_name = 'Anna'
GROUP BY customer_name;

-- Customer with highest revenue
SELECT customer_name, SUM(amount)
FROM sales
GROUP BY customer_name
ORDER BY SUM(amount) DESC
LIMIT 1;

-- Total sales per product
SELECT product, COUNT(*)
FROM sales
GROUP BY product;

-- Average revenue of all products combined
SELECT AVG(amount)
FROM sales;

-- All sales of a specific month
SELECT *
FROM sales
WHERE EXTRACT(MONTH FROM sale_date) = 1;

-- Customer percentage of total revenue 
SELECT customer_name, SUM(amount) AS total_revenue, 
ROUND(SUM(amount) / (SELECT SUM(amount) FROM sales) * 100, 2) AS percentage_of_total
FROM sales
GROUP BY customer_name;

-- Ranking the sales of each customer
SELECT 
    customer_name,
    product,
    amount,
    RANK() OVER (
        PARTITION BY customer_name 
        ORDER BY amount DESC
    ) AS rank_within_customer
FROM sales;
