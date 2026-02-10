
-- SQL Basics

CREATE TABLE sales_data (
    order_number INT,
    order_date DATE,
    status VARCHAR(50),
    customer_name VARCHAR(100),
    product_line VARCHAR(50),
    product_code VARCHAR(50),
    quantity_ordered INT,
    price_each DECIMAL(10,2),
    sales DECIMAL(12,2),
    territory VARCHAR(50),
    country VARCHAR(50),
    deal_size VARCHAR(20)
);

SELECT COUNT(*) AS total_records FROM sales_data;

SELECT * FROM sales_data LIMIT 10;

SELECT *
FROM sales_data
WHERE product_line = 'Classic Cars'
ORDER BY sales DESC;

SELECT product_line,
       COUNT(*) AS order_count,
       SUM(sales) AS total_sales,
       AVG(sales) AS avg_sales
FROM sales_data
GROUP BY product_line;

SELECT product_line,
       SUM(sales) AS total_sales
FROM sales_data
GROUP BY product_line
HAVING SUM(sales) > 100000;

SELECT *
FROM sales_data
WHERE order_date BETWEEN '2003-01-01' AND '2003-01-31';

SELECT *
FROM sales_data
WHERE customer_name LIKE '%Auto%';

SELECT customer_name,
       SUM(sales) AS total_spend
FROM sales_data
GROUP BY customer_name
ORDER BY total_spend DESC
LIMIT 5;
