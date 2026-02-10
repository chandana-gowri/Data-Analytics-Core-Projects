
-- Task 4: SQL Intermediate – JOINS

-- Customers table
-- customer_id (PK)

-- Orders table
-- order_id (PK), customer_id (FK)

-- Products table
-- product_name (PK), category_name (FK)

-- Categories table
-- category_name (PK)

-- 1. INNER JOIN: Orders with Customers
SELECT o.order_id, o.order_date, c.customer_first_name, c.customer_last_name, c.customer_region
FROM orders o
INNER JOIN customers c
ON o.customer_id = c.customer_id;

-- 2. LEFT JOIN: Customers with no orders
SELECT c.customer_id, c.customer_first_name, c.customer_last_name
FROM customers c
LEFT JOIN orders o
ON c.customer_id = o.customer_id
WHERE o.order_id IS NULL;

-- 3. Orders + Products: Revenue per product
SELECT p.product_name, SUM(o.sales_per_order) AS total_revenue
FROM orders o
INNER JOIN products p
ON o.product_name = p.product_name
GROUP BY p.product_name;

-- 4. Products + Categories: Category-wise revenue
SELECT cat.category_name, SUM(o.sales_per_order) AS category_revenue
FROM orders o
INNER JOIN products p ON o.product_name = p.product_name
INNER JOIN categories cat ON p.category_name = cat.category_name
GROUP BY cat.category_name;

-- 5. Business condition: Sales in region between dates
SELECT o.order_id, c.customer_region, o.order_date, o.sales_per_order
FROM orders o
INNER JOIN customers c ON o.customer_id = c.customer_id
WHERE c.customer_region = 'East'
AND o.order_date BETWEEN '2022-01-01' AND '2022-12-31';
