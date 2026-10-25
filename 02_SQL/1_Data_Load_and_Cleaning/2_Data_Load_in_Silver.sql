-- =====================================================================================
-- DATA LOADING IN SILVER FROM BRONZE
-- =====================================================================================


-- ======================================================================
-- Orders
-- ======================================================================
CREATE TABLE Silver.orders AS
SELECT
	CAST(order_id AS UNSIGNED) AS order_id,
    CAST(created_at AS DATETIME) AS created_at,
    CAST(website_session_id AS UNSIGNED) AS website_session_id,
    CAST(user_id AS UNSIGNED) AS user_id,
    CAST(primary_product_id AS UNSIGNED) AS primary_product_id,
    CAST(items_purchased AS UNSIGNED) AS items_purchased,
    CAST(price_usd AS DECIMAL(10, 2)) AS price_usd,
    CAST(cogs_usd AS DECIMAL(10, 2)) AS cogs_usd
FROM Bronze.orders;

-- ======================================================================
-- Order Items
-- ======================================================================
CREATE TABLE Silver.order_items AS
SELECT
	CAST(order_item_id AS UNSIGNED) AS order_item_id,
    CAST(created_at AS DATETIME) AS created_at,
    CAST(order_id AS UNSIGNED) AS order_id,
    CAST(product_id AS UNSIGNED) AS product_id,
    CAST(is_primary_item AS UNSIGNED) AS is_primary_item,
    CAST(price_usd AS DECIMAL(10, 2)) AS price_usd,
    CAST(cogs_usd AS DECIMAL(10, 2)) AS cogs_usd
FROM Bronze.order_items;

-- ======================================================================
-- Order Item Refunds
-- ======================================================================
CREATE TABLE Silver.order_item_refunds AS
SELECT
	CAST(order_item_refund_id AS UNSIGNED) AS order_item_refund_id,
    CAST(created_at AS DATETIME) AS created_at,
    CAST(order_item_id AS UNSIGNED) AS order_item_id,
    CAST(order_id AS UNSIGNED) AS order_id,
    CAST(refund_amount_usd AS DECIMAL(10, 2)) AS refund_amount_usd
FROM Bronze.order_item_refunds;

-- ======================================================================
-- Products
-- ======================================================================
CREATE TABLE Silver.products AS
SELECT
	CAST(product_id AS UNSIGNED) AS product_id,
    CAST(created_at AS DATETIME) AS created_at,
    product_name AS product_name
FROM Bronze.products;

-- ======================================================================
-- Website Pageviews
-- ======================================================================
CREATE TABLE Silver.website_pageviews AS
SELECT
	CAST(website_pageview_id AS UNSIGNED) AS website_pageview_id,
    CAST(created_at AS DATETIME) AS created_at,
    CAST(website_session_id AS UNSIGNED) AS website_session_id,
    pageview_url AS pageview_url
FROM Bronze.website_pageviews;

-- ======================================================================
-- Website Sessions
-- ======================================================================
CREATE TABLE Silver.website_sessions AS
SELECT
	CAST(website_session_id AS UNSIGNED) AS website_session_id,
    CAST(created_at AS DATETIME) AS created_at,
    CAST(user_id AS UNSIGNED) AS user_id,
    CAST(is_repeat_session AS UNSIGNED) AS is_repeat_session,
    utm_source AS utm_source,
    utm_campaign AS utm_campaign,
    utm_content AS utm_content,
    device_type AS device_type,
    http_referer AS http_referer
FROM Bronze.website_sessions;