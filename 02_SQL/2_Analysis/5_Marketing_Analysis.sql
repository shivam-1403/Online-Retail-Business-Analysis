-- ============================================================
-- GOLD LAYER: MARKETING ANALYSIS
-- ============================================================
-- Purpose:
--   Final reusable Gold-layer views for the completed Marketing
--   Analysis.
--
-- Source tables:
--   Silver.website_sessions
--   Silver.orders
--
-- Views created:
--   1. Gold.marketing_source_performance
--   2. Gold.marketing_campaign_performance
--   3. Gold.marketing_content_performance
--   4. Gold.marketing_device_performance
--   5. Gold.marketing_source_yearly_performance
--
-- Grain:
--   marketing_source_performance  -> one row per UTM source
--   marketing_campaign_performance-> one row per UTM campaign
--   marketing_content_performance -> one row per UTM content
--   marketing_device_performance  -> one row per device type
--   marketing_source_yearly_performance -> one row per year + UTM source
--
-- Metrics:
--   Users
--   Orders
--   Revenue
--   COGS
--   Gross Profit
--   Conversion Rate
--   Corresponding rankings where included in the original analysis
-- ============================================================


-- ============================================================
-- 1. MARKETING PERFORMANCE BY SOURCE
-- ============================================================
-- Answers:
--   Where are customers coming from?
--   Which sources generate the most orders/revenue/profit?
--   Which sources convert best?
--
-- Grain: one row per UTM source.
-- ============================================================

CREATE OR REPLACE VIEW Gold.marketing_source_performance AS
SELECT
    ws.utm_source,
    COUNT(DISTINCT ws.user_id) AS users,
    RANK() OVER (
        ORDER BY COUNT(DISTINCT ws.user_id) DESC
    ) AS users_rank,
    COUNT(DISTINCT o.order_id) AS orders,
    RANK() OVER (
        ORDER BY COUNT(DISTINCT o.order_id) DESC
    ) AS orders_rank,
    SUM(o.price_usd) AS revenue,
    SUM(o.cogs_usd) AS cogs,
    SUM(o.price_usd) - SUM(o.cogs_usd) AS gross_profit,
    RANK() OVER (
        ORDER BY SUM(o.price_usd) - SUM(o.cogs_usd) DESC
    ) AS profit_rank,
    COUNT(DISTINCT o.order_id)
        / COUNT(DISTINCT ws.website_session_id) AS conversion_rate,
    RANK() OVER (
        ORDER BY
            COUNT(DISTINCT o.order_id)
            / COUNT(DISTINCT ws.website_session_id) DESC
    ) AS conversion_rank
FROM Silver.website_sessions ws
LEFT JOIN Silver.orders o
    ON ws.website_session_id = o.website_session_id
GROUP BY ws.utm_source;


-- ============================================================
-- 2. MARKETING PERFORMANCE BY CAMPAIGN
-- ============================================================
-- Grain: one row per UTM campaign.
-- ============================================================

CREATE OR REPLACE VIEW Gold.marketing_campaign_performance AS
SELECT
    ws.utm_campaign,
    COUNT(DISTINCT ws.user_id) AS users,
    RANK() OVER (
        ORDER BY COUNT(DISTINCT ws.user_id) DESC
    ) AS users_rank,
    COUNT(DISTINCT o.order_id) AS orders,
    RANK() OVER (
        ORDER BY COUNT(DISTINCT o.order_id) DESC
    ) AS orders_rank,
    SUM(o.price_usd) AS revenue,
    SUM(o.cogs_usd) AS cogs,
    SUM(o.price_usd) - SUM(o.cogs_usd) AS gross_profit,
    RANK() OVER (
        ORDER BY SUM(o.price_usd) - SUM(o.cogs_usd) DESC
    ) AS profit_rank,
    COUNT(DISTINCT o.order_id)
        / COUNT(DISTINCT ws.website_session_id) AS conversion_rate,
    RANK() OVER (
        ORDER BY
            COUNT(DISTINCT o.order_id)
            / COUNT(DISTINCT ws.website_session_id) DESC
    ) AS conversion_rank
FROM Silver.website_sessions ws
LEFT JOIN Silver.orders o
    ON ws.website_session_id = o.website_session_id
GROUP BY ws.utm_campaign;


-- ============================================================
-- 3. MARKETING PERFORMANCE BY CONTENT
-- ============================================================
-- Grain: one row per UTM content.
-- ============================================================

CREATE OR REPLACE VIEW Gold.marketing_content_performance AS
SELECT
    ws.utm_content,
    COUNT(DISTINCT ws.user_id) AS users,
    RANK() OVER (
        ORDER BY COUNT(DISTINCT ws.user_id) DESC
    ) AS users_rank,
    COUNT(DISTINCT o.order_id) AS orders,
    RANK() OVER (
        ORDER BY COUNT(DISTINCT o.order_id) DESC
    ) AS orders_rank,
    SUM(o.price_usd) AS revenue,
    SUM(o.cogs_usd) AS cogs,
    SUM(o.price_usd) - SUM(o.cogs_usd) AS gross_profit,
    RANK() OVER (
        ORDER BY SUM(o.price_usd) - SUM(o.cogs_usd) DESC
    ) AS profit_rank,
    COUNT(DISTINCT o.order_id)
        / COUNT(DISTINCT ws.website_session_id) AS conversion_rate,
    RANK() OVER (
        ORDER BY
            COUNT(DISTINCT o.order_id)
            / COUNT(DISTINCT ws.website_session_id) DESC
    ) AS conversion_rank
FROM Silver.website_sessions ws
LEFT JOIN Silver.orders o
    ON ws.website_session_id = o.website_session_id
GROUP BY ws.utm_content;


-- ============================================================
-- 4. MARKETING PERFORMANCE BY DEVICE
-- ============================================================
-- Grain: one row per device type.
-- ============================================================

CREATE OR REPLACE VIEW Gold.marketing_device_performance AS
SELECT
    ws.device_type,
    COUNT(DISTINCT ws.user_id) AS users,
    RANK() OVER (
        ORDER BY COUNT(DISTINCT ws.user_id) DESC
    ) AS users_rank,
    COUNT(DISTINCT o.order_id) AS orders,
    RANK() OVER (
        ORDER BY COUNT(DISTINCT o.order_id) DESC
    ) AS orders_rank,
    SUM(o.price_usd) AS revenue,
    SUM(o.cogs_usd) AS cogs,
    SUM(o.price_usd) - SUM(o.cogs_usd) AS gross_profit,
    RANK() OVER (
        ORDER BY SUM(o.price_usd) - SUM(o.cogs_usd) DESC
    ) AS profit_rank,
    COUNT(DISTINCT o.order_id)
        / COUNT(DISTINCT ws.website_session_id) AS conversion_rate,
    RANK() OVER (
        ORDER BY
            COUNT(DISTINCT o.order_id)
            / COUNT(DISTINCT ws.website_session_id) DESC
    ) AS conversion_rank
FROM Silver.website_sessions ws
LEFT JOIN Silver.orders o
    ON ws.website_session_id = o.website_session_id
GROUP BY ws.device_type;


-- ============================================================
-- 5. MARKETING PERFORMANCE OVER TIME
-- ============================================================
-- Tracks UTM-source performance by year.
--
-- Metrics:
--   Website Sessions
--   Users
--   Orders
--   Revenue
--   Gross Profit
--   Conversion Rate
--
-- Grain: one row per year + UTM source.
--
-- This view supports analysis of whether source performance changes
-- over time rather than only comparing sources across the full
-- dataset.
-- ============================================================

CREATE OR REPLACE VIEW Gold.marketing_source_yearly_performance AS
SELECT
    YEAR(ws.created_at) AS year,
    ws.utm_source,
    COUNT(DISTINCT ws.website_session_id) AS website_sessions,
    COUNT(DISTINCT ws.user_id) AS users,
    COUNT(DISTINCT o.order_id) AS orders,
    SUM(o.price_usd) AS revenue,
    SUM(o.price_usd) - SUM(o.cogs_usd) AS gross_profit,
    COUNT(DISTINCT o.order_id)
        / COUNT(DISTINCT ws.website_session_id) AS conversion_rate
FROM Silver.website_sessions ws
LEFT JOIN Silver.orders o
    ON ws.website_session_id = o.website_session_id
GROUP BY
    YEAR(ws.created_at),
    ws.utm_source;


-- ============================================================
-- END OF MARKETING ANALYSIS
-- ============================================================