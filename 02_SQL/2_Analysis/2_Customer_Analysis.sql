-- ============================================================
-- GOLD LAYER: CUSTOMER ANALYSIS
-- ============================================================
-- Purpose:
--   Final reusable Gold-layer views for the Customer Analysis.
--
-- Source:
--   Silver.orders
--
-- Views created:
--   1. Gold.monthly_customer_analysis
--   2. Gold.customer_returning_summary
--   3. Gold.customer_first_order
--   4. Gold.customer_order_sequence
--   5. Gold.returning_customer_orders
--   6. Gold.customer_order_intervals
--
-- Grain:
--   monthly_customer_analysis -> one row per year + month
--   customer_returning_summary -> one row for the entire business
--   customer_first_order -> one row per order/customer record
--   customer_order_sequence -> one row per order
--   returning_customer_orders -> one row per order number (> 1)
--   customer_order_intervals -> one row per repeat order
-- ============================================================


-- ============================================================
-- 1. MONTHLY CUSTOMER ANALYSIS
-- ============================================================
-- Monthly customer behavior:
--   Customers
--   Orders per Customer
--   Revenue per Customer
--
-- Grain: one row per year + month.
-- ============================================================

CREATE OR REPLACE VIEW Gold.monthly_customer_analysis AS
SELECT
    MONTH(created_at) AS month_num,
    MONTHNAME(created_at) AS month_name,
    YEAR(created_at) AS year,
    COUNT(DISTINCT user_id) AS customers,
    COUNT(*) / COUNT(DISTINCT user_id) AS orders_per_customer,
    SUM(price_usd) / COUNT(DISTINCT user_id) AS revenue_per_customer
FROM Silver.orders
GROUP BY
    YEAR(created_at),
    MONTH(created_at),
    MONTHNAME(created_at);


-- ============================================================
-- 2. CUSTOMER RETURNING SUMMARY
-- ============================================================
-- Overall customer-returning metrics:
--   Returning Users
--   Total Users
--   Returning Rate
--
-- Grain: one row for the entire business.
--
-- A returning user is defined as a user_id with more than one
-- order in Silver.orders.
-- ============================================================

CREATE OR REPLACE VIEW Gold.customer_returning_summary AS
WITH customer_order_counts AS (
    SELECT
        user_id,
        COUNT(created_at) AS order_count
    FROM Silver.orders
    GROUP BY user_id
),
returning_users AS (
    SELECT
        COUNT(*) AS returning_users
    FROM customer_order_counts
    WHERE order_count > 1
),
total_users AS (
    SELECT
        COUNT(DISTINCT user_id) AS total_users
    FROM Silver.orders
)
SELECT
    returning_users.returning_users,
    total_users.total_users,
    returning_users.returning_users / total_users.total_users AS returning_rate
FROM returning_users
CROSS JOIN total_users;


-- ============================================================
-- 3. FIRST ORDER PER CUSTOMER
-- ============================================================
-- Identifies the first order date for each customer while
-- retaining the original order-level records.
--
-- Grain: one row per order.
-- ============================================================

CREATE OR REPLACE VIEW Gold.customer_first_order AS
SELECT
    user_id,
    created_at,
    MIN(created_at) OVER (
        PARTITION BY user_id
    ) AS first_order
FROM Silver.orders;


-- ============================================================
-- 4. ORDER NUMBER FOR EACH CUSTOMER
-- ============================================================
-- Assigns a chronological order number to every order made by
-- each customer.
--
-- Example:
--   First order  -> 1
--   Second order -> 2
--   Third order  -> 3
--
-- Grain: one row per order.
-- ============================================================

CREATE OR REPLACE VIEW Gold.customer_order_sequence AS
SELECT
    user_id,
    created_at,
    ROW_NUMBER() OVER (
        PARTITION BY user_id
        ORDER BY created_at
    ) AS order_number
FROM Silver.orders;


-- ============================================================
-- 5. RETURNING CUSTOMER ORDERS
-- ============================================================
-- Shows the number of orders occurring after a customer's
-- first order, grouped by order number.
--
-- Grain: one row per order number greater than 1.
--
-- This preserves the original analysis used to understand how
-- many customers/orders reach the second, third, fourth, etc.
-- order position.
-- ============================================================

CREATE OR REPLACE VIEW Gold.returning_customer_orders AS
WITH customer_order_sequence AS (
    SELECT
        user_id,
        created_at,
        ROW_NUMBER() OVER (
            PARTITION BY user_id
            ORDER BY created_at
        ) AS order_number
    FROM Silver.orders
)
SELECT
    order_number,
    COUNT(user_id) AS customers
FROM customer_order_sequence
WHERE order_number > 1
GROUP BY order_number;


-- ============================================================
-- 6. DAYS BETWEEN CUSTOMER ORDERS
-- ============================================================
-- Measures the number of days between consecutive orders for
-- each customer.
--
-- The first order for each customer is excluded because it has
-- no previous order.
--
-- Grain: one row per repeat order.
-- ============================================================

CREATE OR REPLACE VIEW Gold.customer_order_intervals AS
WITH customer_orders AS (
    SELECT
        user_id,
        created_at AS order_created_at,
        LAG(created_at) OVER (
            PARTITION BY user_id
            ORDER BY created_at
        ) AS previous_order
    FROM Silver.orders
)
SELECT
    user_id,
    order_created_at,
    previous_order,
    TIMESTAMPDIFF(
        DAY,
        previous_order,
        order_created_at
    ) AS days_between_orders
FROM customer_orders
WHERE previous_order IS NOT NULL;


-- ============================================================
-- END OF CUSTOMER ANALYSIS
-- ============================================================