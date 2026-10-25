-- ============================================================
-- GOLD LAYER: BUSINESS GROWTH ANALYSIS
-- ============================================================
-- Purpose:
--   Final reusable Gold-layer views for the Business Growth analysis.
--
-- Source:
--   Silver.orders
--
-- Views created:
--   1. Gold.business_growth_summary
--   2. Gold.monthly_business_growth
--   3. Gold.monthly_revenue_growth
--   4. Gold.yearly_revenue_growth
--
-- Grain:
--   business_growth_summary  -> one row for the entire business
--   monthly_business_growth  -> one row per month
--   monthly_revenue_growth   -> one row per month
--   yearly_revenue_growth    -> one row per year
-- ============================================================


-- ============================================================
-- 1. BUSINESS GROWTH SUMMARY
-- ============================================================
-- Overall business KPIs:
--   Gross Revenue
--   Total Orders
--   Average Order Value (AOV)
--   Total COGS
--   Gross Profit
--   Gross Margin
--
-- Grain: one row for the entire business.
-- ============================================================

CREATE OR REPLACE VIEW Gold.business_growth_summary AS
SELECT
    SUM(price_usd) AS gross_revenue,
    COUNT(*) AS total_orders,
    SUM(price_usd) / COUNT(*) AS avg_order_value,
    SUM(cogs_usd) AS total_cogs,
    SUM(price_usd) - SUM(cogs_usd) AS gross_profit,
    (
        (SUM(price_usd) - SUM(cogs_usd))
        / SUM(price_usd)
    ) * 100 AS gross_margin
FROM Silver.orders;


-- ============================================================
-- 2. MONTHLY BUSINESS GROWTH
-- ============================================================
-- Monthly business performance:
--   Revenue
--   Orders
--   AOV
--   Customers
--   Orders per Customer
--
-- Grain: one row per year + month.
-- ============================================================

CREATE OR REPLACE VIEW Gold.monthly_business_growth AS
SELECT
    MONTH(created_at) AS month_num,
    MONTHNAME(created_at) AS month_name,
    YEAR(created_at) AS year,
    SUM(price_usd) AS revenue,
    COUNT(*) AS total_orders,
    SUM(price_usd) / COUNT(*) AS aov,
    COUNT(DISTINCT user_id) AS customers,
    COUNT(*) / COUNT(DISTINCT user_id) AS orders_per_customer
FROM Silver.orders
GROUP BY
    YEAR(created_at),
    MONTH(created_at),
    MONTHNAME(created_at);


-- ============================================================
-- 3. MONTHLY REVENUE GROWTH
-- ============================================================
-- Monthly revenue trend:
--   Current Month Revenue
--   Previous Month Revenue
--   Month-over-Month (MoM) Growth
--   Cumulative Revenue
--
-- Grain: one row per year + month.
--
-- LAG() compares each month with the immediately preceding
-- month, while the cumulative SUM() tracks revenue accumulated
-- throughout the dataset period.
-- ============================================================

CREATE OR REPLACE VIEW Gold.monthly_revenue_growth AS
WITH monthly_revenue AS (
    SELECT
        MONTH(created_at) AS month_num,
        MONTHNAME(created_at) AS month_name,
        YEAR(created_at) AS year,
        SUM(price_usd) AS revenue
    FROM Silver.orders
    GROUP BY
        YEAR(created_at),
        MONTH(created_at),
        MONTHNAME(created_at)
),
revenue_lag AS (
    SELECT
        *,
        LAG(revenue) OVER (
            ORDER BY year, month_num
        ) AS previous_month_revenue
    FROM monthly_revenue
),
cumulative_revenue_sum AS (
    SELECT
        *,
        SUM(revenue) OVER (
            ORDER BY year, month_num
        ) AS cumulative_revenue
    FROM revenue_lag
)
SELECT
    month_num,
    month_name,
    year,
    revenue,
    previous_month_revenue,
    (revenue - previous_month_revenue)
        / previous_month_revenue AS mom_growth,
    cumulative_revenue
FROM cumulative_revenue_sum;


-- ============================================================
-- 4. YEARLY REVENUE GROWTH
-- ============================================================
-- Yearly revenue trend:
--   Revenue
--   Previous Year Revenue
--   Year-over-Year (YoY) Growth
--
-- Grain: one row per year.
-- ============================================================

CREATE OR REPLACE VIEW Gold.yearly_revenue_growth AS
WITH yearly_revenue AS (
    SELECT
        YEAR(created_at) AS year,
        SUM(price_usd) AS revenue
    FROM Silver.orders
    GROUP BY YEAR(created_at)
),
revenue_lag AS (
    SELECT
        *,
        LAG(revenue) OVER (
            ORDER BY year
        ) AS previous_year_revenue
    FROM yearly_revenue
)
SELECT
    year,
    revenue,
    previous_year_revenue,
    (revenue - previous_year_revenue)
        / previous_year_revenue AS yoy_growth
FROM revenue_lag;


-- ============================================================
-- END OF BUSINESS GROWTH ANALYSIS
-- ============================================================