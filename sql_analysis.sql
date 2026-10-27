--CREATE DATABASE Ecommerce_Database
USE Ecommerce_Database

SELECT item_key, item_name, unit_price
FROM item_dim_cleaned
WHERE unit_price > 10
ORDER BY unit_price DESC;

SELECT SUM(total_price) AS total_revenue
FROM fact_table_cleaned;

SELECT SUM(quantity) AS total_quantity_sold, AVG(unit_price) AS avg_unit_price
FROM fact_table_cleaned;

SELECT COUNT(*) AS total_transactions, COUNT(DISTINCT coustomer_key) AS unique_customers
FROM fact_table_cleaned;

SELECT MIN(unit_price) AS min_price, MAX(unit_price) AS max_price
FROM item_dim_cleaned;

SELECT s.division, SUM(f.total_price) AS total_revenue, SUM(f.quantity) AS total_quantity
FROM fact_table_cleaned f
JOIN store_dim_cleaned s ON f.store_key = s.store_key
GROUP BY s.division
ORDER BY total_revenue DESC;

SELECT s.district, SUM(f.total_price) AS total_revenue
FROM fact_table_cleaned f
JOIN store_dim_cleaned s ON f.store_key = s.store_key
GROUP BY s.district
HAVING SUM(f.total_price) > 1000000
ORDER BY total_revenue DESC;

SELECT f.item_key, i.item_name, SUM(f.quantity) AS total_quantity_sold
FROM fact_table_cleaned f
JOIN item_dim_cleaned i ON f.item_key = i.item_key
GROUP BY f.item_key, i.item_name
ORDER BY total_quantity_sold DESC;

SELECT f.item_key, i.item_name, SUM(f.total_price) AS total_revenue
FROM fact_table_cleaned f
JOIN item_dim_cleaned i ON f.item_key = i.item_key
GROUP BY f.item_key, i.item_name
ORDER BY total_revenue DESC;

SELECT supplier, COUNT(*) AS item_count
FROM item_dim_cleaned
GROUP BY supplier
HAVING COUNT(*) > 5
ORDER BY item_count DESC;

SELECT man_country, COUNT(*) AS item_count, AVG(unit_price) AS avg_price
FROM item_dim_cleaned
GROUP BY man_country
ORDER BY item_count DESC;

SELECT t.trans_type, COUNT(*) AS transaction_count, SUM(f.total_price) AS total_revenue
FROM fact_table_cleaned f
JOIN trans_dim_cleaned t ON f.payment_key = t.payment_key
GROUP BY t.trans_type
ORDER BY total_revenue DESC;

SELECT t.bank_name, SUM(f.total_price) AS total_revenue, COUNT(*) AS transaction_count
FROM fact_table_cleaned f
JOIN trans_dim_cleaned t ON f.payment_key = t.payment_key
WHERE t.trans_type = 'card' AND t.bank_name <> 'None'
GROUP BY t.bank_name
ORDER BY total_revenue DESC;

SELECT tm.year, SUM(f.total_price) AS total_revenue, COUNT(*) AS transaction_count
FROM fact_table_cleaned f
JOIN time_dim_cleaned tm ON f.time_key = tm.time_key
where tm.year < 2021
GROUP BY tm.year
ORDER BY tm.year;

SELECT tm.quarter, SUM(f.total_price) AS total_revenue
FROM fact_table_cleaned f
JOIN time_dim_cleaned tm ON f.time_key = tm.time_key
WHERE tm.year = 2018
GROUP BY tm.quarter
ORDER BY tm.quarter;

SELECT f.coustomer_key, c.name, SUM(f.total_price) AS total_spent, COUNT(*) AS num_transactions
FROM fact_table_cleaned f
JOIN customer_dim_cleaned c ON f.coustomer_key = c.coustomer_key
GROUP BY f.coustomer_key, c.name
ORDER BY total_spent DESC;

SELECT f.store_key, COUNT(*) AS num_transactions, AVG(f.total_price) AS avg_transaction_value
FROM fact_table_cleaned f
GROUP BY f.store_key
HAVING COUNT(*) > 500
ORDER BY avg_transaction_value DESC;

SELECT tm.hour, COUNT(*) AS transaction_count
FROM fact_table_cleaned f
JOIN time_dim_cleaned tm ON f.time_key = tm.time_key
GROUP BY tm.hour
ORDER BY transaction_count DESC;


-- Advanced SQL Analysis --

-- =========================================
-- 1- Customer Revenue Contribution
-- How much does each customer contribute
-- to the total revenue?
-- =========================================

SELECT f.coustomer_key,c.name,

    -- Total money spent by the customer
    SUM(f.total_price) AS total_spent,

    -- Percentage of total revenue
    CONCAT(
    ROUND(
        SUM(f.total_price) * 100.0 /
        SUM(SUM(f.total_price)) OVER (),2) , '%') AS revenue_percentage 

FROM fact_table_cleaned f

JOIN customer_dim_cleaned c
    ON f.coustomer_key = c.coustomer_key

GROUP BY f.coustomer_key, c.name

ORDER BY total_spent DESC;


-- Know Range of Total Revenue Percentage
WITH customer_sales AS
(
    SELECT
        f.coustomer_key,
        SUM(f.total_price) AS total_spent
    FROM fact_table_cleaned f
    GROUP BY f.coustomer_key
),
customer_pct AS
(
    SELECT
        coustomer_key,
        total_spent * 100.0 /
        SUM(total_spent) OVER () AS revenue_percentage
    FROM customer_sales
)
SELECT
    MIN(revenue_percentage) AS MinPct,
    MAX(revenue_percentage) AS MaxPct
FROM customer_pct;

-- =========================================
-- 2- Customer Spending Segmentation
-- Divide customers into 3 groups based on
-- their actual spending distribution
-- =========================================

WITH customer_sales AS
(
    SELECT f.coustomer_key, c.name,

        -- Total spending for each customer
        SUM(f.total_price) AS total_spent

    FROM fact_table_cleaned f

    JOIN customer_dim_cleaned c
        ON f.coustomer_key = c.coustomer_key

    GROUP BY f.coustomer_key, c.name), customer_groups AS
(
    SELECT coustomer_key,name, total_spent,

        -- Divide customers into 3 groups
        -- based on their spending
        NTILE(3) OVER
        (
            ORDER BY total_spent
        ) AS spending_group

    FROM customer_sales
)

SELECT coustomer_key,name,total_spent,

    -- Give each group a meaningful business name
    CASE
        WHEN spending_group = 1
            THEN 'Low Value'

        WHEN spending_group = 2
            THEN 'Medium Value'

        WHEN spending_group = 3
            THEN 'High Value'
    END AS customer_segment

FROM customer_groups

ORDER BY total_spent DESC;


-- =========================================
-- 3-Summary of Customer Segments
-- =========================================

WITH customer_sales AS
(
    SELECT f.coustomer_key,
        SUM(f.total_price) AS total_spent

    FROM fact_table_cleaned f

    GROUP BY f.coustomer_key),customer_groups AS
(
    SELECT coustomer_key, total_spent,

        NTILE(3) OVER
        (
            ORDER BY total_spent
        ) AS spending_group

    FROM customer_sales
)

SELECT
    CASE
        WHEN spending_group = 1 THEN 'Low Value'
        WHEN spending_group = 2 THEN 'Medium Value'
        WHEN spending_group = 3 THEN 'High Value'
    END AS customer_segment,

    COUNT(*) AS customer_count,
    SUM(total_spent) AS total_revenue

FROM customer_groups

GROUP BY spending_group

ORDER BY spending_group;

-- ==================================================================================================== --

-- =========================================
-- 4- Year-over-Year Revenue Growth
-- Compare each year with the previous year
-- =========================================

WITH yearly_sales AS
(
    SELECT tm.year,

        -- Total revenue for each year
        SUM(f.total_price) AS total_revenue

    FROM fact_table_cleaned f

    JOIN time_dim_cleaned tm
        ON f.time_key = tm.time_key

    WHERE tm.year < 2021

    GROUP BY tm.year
)

SELECT year,total_revenue,

    -- Revenue of the previous year
      LAG(total_revenue) OVER
    (
        ORDER BY year
    ) AS previous_year_revenue,

    -- Difference between current and previous year
    total_revenue
    - LAG(total_revenue) OVER
    (
        ORDER BY year
    ) AS revenue_change

FROM yearly_sales

ORDER BY year;


-- Orders count for each year --
SELECT year, COUNT(*) AS orders_count
FROM fact_table_cleaned f
JOIN time_dim_cleaned t
    ON f.time_key = t.time_key
WHERE year < 2021

GROUP BY year
ORDER BY year;


-- =========================================
-- 5 - Monthly Revenue Growth
-- Compare each month with the previous month
-- =========================================

WITH monthly_sales AS
(
    SELECT t.year,t.month,
   
        -- Total revenue for each month
        SUM(f.total_price) AS monthly_revenue

    FROM fact_table_cleaned f

    JOIN time_dim_cleaned t
        ON f.time_key = t.time_key

    WHERE t.year < 2021

    GROUP BY t.year,t.month
),

monthly_comparison AS
(
    SELECT year,month,monthly_revenue,

        -- Revenue from the previous month
        LAG(monthly_revenue) OVER
        (
            ORDER BY year, month
        ) AS previous_month_revenue

    FROM monthly_sales
)

SELECT year,month,monthly_revenue,previous_month_revenue,

    -- Calculate the change in revenue
    monthly_revenue - previous_month_revenue
        AS revenue_change,

    -- Calculate percentage growth
   CONCAT( ROUND(
        (monthly_revenue - previous_month_revenue)
        * 100.0
        / NULLIF(previous_month_revenue, 0),
        2
    ),'%') AS growth_percentage

FROM monthly_comparison

ORDER BY year,month;

-- Orders count for each month in each year 
SELECT t.year,t.month,
    COUNT(*) AS orders_count
FROM fact_table_cleaned f
JOIN time_dim_cleaned t
    ON f.time_key = t.time_key
WHERE t.year < 2021
GROUP BY t.year,t.month
ORDER BY t.year,t.month;

-- =================================================================================================== --

-- =========================================
-- 6- Product Performance
-- Compare sales volume with revenue
-- =========================================

SELECT f.item_key, i.item_name,

    -- Number of units sold
    SUM(f.quantity) AS total_quantity,

    -- Revenue generated
    SUM(f.total_price) AS total_revenue,

    -- Average revenue generated per sold unit
    ROUND(
        SUM(f.total_price) * 1.0 /
        NULLIF(SUM(f.quantity), 0),
        2
    ) AS revenue_per_unit

FROM fact_table_cleaned f

JOIN item_dim_cleaned i
    ON f.item_key = i.item_key

GROUP BY
    f.item_key,
    i.item_name

ORDER BY total_revenue DESC;


-- =========================================
-- 7- Product Revenue Contribution
-- Identify whether revenue is concentrated
-- in a few products or distributed across
-- the product portfolio
-- =========================================

SELECT i.item_name,
    SUM(f.total_price) AS total_revenue,

    ROUND(
        SUM(f.total_price) * 100.0 /
        SUM(SUM(f.total_price)) OVER (),
        2
    ) AS revenue_percentage

FROM fact_table_cleaned f
JOIN item_dim_cleaned i
    ON f.item_key = i.item_key

GROUP BY i.item_name

ORDER BY total_revenue DESC;
