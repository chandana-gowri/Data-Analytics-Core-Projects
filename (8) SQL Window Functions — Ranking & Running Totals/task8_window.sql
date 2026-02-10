
-- TASK 8: SQL Window Functions

-- Base aggregation
SELECT "Customer Name", SUM("Sales") AS total_sales
FROM ecommerce_sales
GROUP BY "Customer Name";

-- Ranking customers by region
SELECT
    "Region",
    "Customer Name",
    SUM("Sales") AS total_sales,
    ROW_NUMBER() OVER (PARTITION BY "Region" ORDER BY SUM("Sales") DESC) AS row_number,
    RANK() OVER (PARTITION BY "Region" ORDER BY SUM("Sales") DESC) AS rank,
    DENSE_RANK() OVER (PARTITION BY "Region" ORDER BY SUM("Sales") DESC) AS dense_rank
FROM ecommerce_sales
GROUP BY "Region", "Customer Name";

-- Running total sales
SELECT
    "Order Date",
    "Sales",
    SUM("Sales") OVER (ORDER BY "Order Date") AS running_total_sales
FROM ecommerce_sales;

-- Month-over-Month growth
WITH monthly_sales AS (
    SELECT
        DATE_TRUNC('month', "Order Date") AS month,
        SUM("Sales") AS total_sales
    FROM ecommerce_sales
    GROUP BY month
)
SELECT
    month,
    total_sales,
    LAG(total_sales) OVER (ORDER BY month) AS previous_month_sales,
    ROUND(
        (total_sales - LAG(total_sales) OVER (ORDER BY month))
        * 100.0 / LAG(total_sales) OVER (ORDER BY month),
        2
    ) AS mom_growth_percentage
FROM monthly_sales;

-- Top 3 products per category
WITH ranked_products AS (
    SELECT
        "Category",
        "Product Name",
        SUM("Sales") AS total_sales,
        DENSE_RANK() OVER (
            PARTITION BY "Category"
            ORDER BY SUM("Sales") DESC
        ) AS product_rank
    FROM ecommerce_sales
    GROUP BY "Category", "Product Name"
)
SELECT *
FROM ranked_products
WHERE product_rank <= 3;
