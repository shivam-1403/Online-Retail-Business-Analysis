-- ============================================================
-- GOLD LAYER: WEBSITE BEHAVIOR ANALYSIS
-- ============================================================
-- Purpose:
--   Final reusable Gold-layer views for the completed Website
--   Behavior analysis.
--
-- Source tables:
--   Silver.website_sessions
--   Silver.website_pageviews
--   Silver.orders
--
-- Views created:
--   1. Gold.monthly_website_behavior
--   2. Gold.page_performance
--   3. Gold.purchasing_session_pageviews
--   4. Gold.website_purchase_funnel
--   5. Gold.landing_page_performance
--
-- Grain:
--   monthly_website_behavior -> one row per year + month
--   page_performance         -> one row per page URL
--   purchasing_session_pageviews -> one row per page URL
--   website_purchase_funnel  -> one row for the complete funnel
--   landing_page_performance -> one row per landing page
-- ============================================================


-- ============================================================
-- 1. MONTHLY WEBSITE BEHAVIOR
-- ============================================================
-- Tracks overall website traffic and browsing depth over time.
--
-- Metrics:
--   Website Sessions
--   Website Pageviews
--   Average Pageviews per Session
--
-- Grain: one row per year + month.
-- ============================================================

CREATE OR REPLACE VIEW Gold.monthly_website_behavior AS
SELECT
    MONTH(created_at) AS month_num,
    MONTHNAME(created_at) AS month_name,
    YEAR(created_at) AS year,
    COUNT(DISTINCT website_session_id) AS website_sessions,
    COUNT(DISTINCT website_pageview_id) AS website_pageviews,
    COUNT(DISTINCT website_pageview_id)
        / COUNT(DISTINCT website_session_id) AS avg_pageviews_per_session
FROM Silver.website_pageviews
GROUP BY
    YEAR(created_at),
    MONTH(created_at),
    MONTHNAME(created_at);


-- ============================================================
-- 2. PAGE PERFORMANCE
-- ============================================================
-- Identifies the most-viewed website pages.
--
-- Metrics:
--   Pageviews
--   Page Rank
--
-- Grain: one row per page URL.
-- ============================================================

CREATE OR REPLACE VIEW Gold.page_performance AS
SELECT
    pageview_url,
    COUNT(website_pageview_id) AS views,
    RANK() OVER (
        ORDER BY COUNT(website_pageview_id) DESC
    ) AS page_rank
FROM Silver.website_pageviews
GROUP BY pageview_url;


-- ============================================================
-- 3. PURCHASING-SESSION PAGE PERFORMANCE
-- ============================================================
-- Identifies pages visited before an order within sessions that
-- eventually resulted in a purchase.
--
-- Metrics:
--   Purchasing Sessions
--
-- Grain: one row per page URL.
--
-- A pageview is included only when its timestamp occurs before
-- the corresponding order timestamp. This avoids treating the
-- purchase/thank-you page itself as a pre-purchase page.
-- ============================================================

CREATE OR REPLACE VIEW Gold.purchasing_session_pageviews AS
SELECT
    wp.pageview_url,
    COUNT(DISTINCT wp.website_session_id) AS purchasing_sessions
FROM Silver.website_pageviews wp
JOIN Silver.orders o
    ON wp.website_session_id = o.website_session_id
WHERE wp.created_at < o.created_at
GROUP BY wp.pageview_url;


-- ============================================================
-- 4. WEBSITE PURCHASE FUNNEL
-- ============================================================
-- Funnel:
--   All Website Sessions
--       -> Product Viewed
--       -> Cart
--       -> Shipping
--       -> Billing
--       -> Purchased
--
-- Each stage counts distinct website sessions reaching that stage.
--
-- Grain: one row for the complete funnel.
--
-- Product Viewed is defined using the four product-detail URLs
-- present in the completed analysis.
--
-- Cart, Shipping, and Billing represent sessions that reached
-- those pages. They are not claimed to be explicit click events.
-- Purchased is based on distinct website sessions in Silver.orders.
-- ============================================================

CREATE OR REPLACE VIEW Gold.website_purchase_funnel AS
WITH total_sessions AS (
    SELECT
        COUNT(DISTINCT website_session_id) AS sessions
    FROM Silver.website_sessions
),
product_views AS (
    SELECT
        COUNT(DISTINCT website_session_id) AS sessions
    FROM Silver.website_pageviews
    WHERE pageview_url IN (
        '/the-original-mr-fuzzy',
        '/the-forever-love-bear',
        '/the-birthday-sugar-panda',
        '/the-hudson-river-mini-bear'
    )
),
cart_sessions AS (
    SELECT
        COUNT(DISTINCT website_session_id) AS sessions
    FROM Silver.website_pageviews
    WHERE pageview_url = '/cart'
),
shipping_sessions AS (
    SELECT
        COUNT(DISTINCT website_session_id) AS sessions
    FROM Silver.website_pageviews
    WHERE pageview_url = '/shipping'
),
billing_sessions AS (
    SELECT
        COUNT(DISTINCT website_session_id) AS sessions
    FROM Silver.website_pageviews
    WHERE pageview_url IN ('/billing', '/billing-2')
),
purchased_sessions AS (
    SELECT
        COUNT(DISTINCT website_session_id) AS sessions
    FROM Silver.orders
)
SELECT
    ts.sessions AS total_sessions,
    pv.sessions AS product_view_sessions,
    cs.sessions AS cart_sessions,
    ss.sessions AS shipping_sessions,
    bs.sessions AS billing_sessions,
    ps.sessions AS purchased_sessions
FROM total_sessions ts
CROSS JOIN product_views pv
CROSS JOIN cart_sessions cs
CROSS JOIN shipping_sessions ss
CROSS JOIN billing_sessions bs
CROSS JOIN purchased_sessions ps;


-- ============================================================
-- 5. LANDING PAGE PERFORMANCE
-- ============================================================
-- Compares the performance of the five landing-page variants.
--
-- Metrics:
--   Sessions
--   Orders
--   Conversion Rate
--   Revenue
--   Gross Profit
--
-- Grain: one row per landing page.
--
-- DISTINCT is used in the lander_sessions CTE so that repeated
-- visits to the same lander within one session do not duplicate
-- the session before it is joined to orders.
-- ============================================================

CREATE OR REPLACE VIEW Gold.landing_page_performance AS
WITH lander_sessions AS (
    SELECT DISTINCT
        website_session_id,
        pageview_url AS lander
    FROM Silver.website_pageviews
    WHERE pageview_url IN (
        '/lander-1',
        '/lander-2',
        '/lander-3',
        '/lander-4',
        '/lander-5'
    )
)
SELECT
    ls.lander,
    COUNT(DISTINCT ls.website_session_id) AS sessions,
    COUNT(DISTINCT o.order_id) AS orders,
    COUNT(DISTINCT o.order_id)
        / COUNT(DISTINCT ls.website_session_id) AS conversion_rate,
    SUM(o.price_usd) AS revenue,
    SUM(o.price_usd) - SUM(o.cogs_usd) AS gross_profit
FROM lander_sessions ls
LEFT JOIN Silver.orders o
    ON ls.website_session_id = o.website_session_id
GROUP BY ls.lander;


-- ============================================================
-- END OF WEBSITE BEHAVIOR ANALYSIS
-- ============================================================