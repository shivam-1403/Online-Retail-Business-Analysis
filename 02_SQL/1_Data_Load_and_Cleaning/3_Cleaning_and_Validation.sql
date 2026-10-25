-- =====================================================================================
-- DATA CLEANING AND VALIDATION
-- =====================================================================================


-- Row Counts between Bronze ans Silver Tables
SELECT "orders" AS table_name,
	(SELECT COUNT(*) FROM Bronze.orders) AS bronze_rows,
    (SELECT COUNT(*) FROM Silver.orders) AS silver_rows
UNION ALL
SELECT "order_items",
	(SELECT COUNT(*) FROM Bronze.order_items),
    (SELECT COUNT(*) FROM Silver.order_items)
UNION ALL
SELECT "order_item_refunds",
	(SELECT COUNT(*) FROM Bronze.order_item_refunds),
    (SELECT COUNT(*) FROM Silver.order_item_refunds)
UNION ALL
SELECT "products",
	(SELECT COUNT(*) FROM Bronze.products),
    (SELECT COUNT(*) FROM Silver.products)
UNION ALL
SELECT "website_pageviews",
	(SELECT COUNT(*) FROM Bronze.website_pageviews),
    (SELECT COUNT(*) FROM Silver.website_pageviews)
UNION ALL
SELECT "website_sessions",
	(SELECT COUNT(*) FROM Bronze.website_sessions),
    (SELECT COUNT(*) FROM Silver.website_sessions);
    
    
-- Duplicacy Check
SELECT "orders" AS table_name,
	(SELECT COUNT(DISTINCT order_id) FROM Silver.orders) AS distinct_rows,
    (SELECT COUNT(order_id) FROM Silver.orders) AS total_rows
UNION ALL
SELECT "order_items",
	(SELECT COUNT(DISTINCT order_item_id) FROM Silver.order_items),
    (SELECT COUNT(order_item_id) FROM Silver.order_items)
UNION ALL
SELECT "order_item_refunds",
	(SELECT COUNT(DISTINCT order_item_refund_id) FROM Silver.order_item_refunds),
    (SELECT COUNT(order_item_refund_id) FROM Silver.order_item_refunds)
UNION ALL
SELECT "products",
	(SELECT COUNT(DISTINCT product_id) FROM Silver.products),
    (SELECT COUNT(product_id) FROM Silver.products)
UNION ALL
SELECT "website_pageviews",
	(SELECT COUNT(DISTINCT website_pageview_id) FROM Silver.website_pageviews),
    (SELECT COUNT(website_pageview_id) FROM Silver.website_pageviews)
UNION ALL
SELECT "website_sessions",
	(SELECT COUNT(DISTINCT website_session_id) FROM Silver.website_sessions),
    (SELECT COUNT(website_session_id) FROM Silver.website_sessions);
    
    
-- Nulls Validation
SELECT * FROM Silver.orders
WHERE order_id IS NULL
	OR created_at IS NULL
    OR website_session_id IS NULL
    OR user_id IS NULL
    OR primary_product_id IS NULL
    OR items_purchased IS NULL
    OR price_usd IS NULL
    OR cogs_usd IS NULL;
    
SELECT * FROM Silver.order_items
WHERE order_item_id IS NULL
	OR created_at IS NULL
    OR order_id IS NULL
    OR product_id IS NULL
    OR is_primary_item IS NULL
    OR price_usd IS NULL
    OR cogs_usd IS NULL;
    
SELECT * FROM Silver.order_item_refunds
WHERE order_item_refund_id IS NULL
	OR created_at IS NULL
    OR order_item_id IS NULL
    OR order_id IS NULL
    OR refund_amount_usd IS NULL;
    
SELECT * FROM Silver.products
WHERE product_id IS NULL
	OR created_at IS NULL
    OR product_name IS NULL OR TRIM(product_name) = "" OR TRIM(product_name) = "NULL";
    
SELECT * FROM Silver.website_pageviews
WHERE website_pageview_id IS NULL
	OR created_at IS NULL
    OR website_session_id IS NULL
    OR pageview_url IS NULL OR TRIM(pageview_url) = "" OR TRIM(pageview_url) = "NULL";
    
SELECT * FROM Silver.website_sessions
WHERE website_session_id IS NULL
	OR created_at IS NULL
    OR user_id IS NULL
    OR is_repeat_session IS NULL
    OR utm_source IS NULL OR TRIM(utm_source) = "" OR TRIM(utm_source) = "NULL"
    OR utm_campaign IS NULL OR TRIM(utm_campaign) = "" OR TRIM(utm_campaign) = "NULL"
    OR utm_content IS NULL OR TRIM(utm_content) = "" OR TRIM(utm_content) = "NULL"
    OR device_type IS NULL OR TRIM(device_type) = "" OR TRIM(device_type) = "NULL"
    OR http_referer IS NULL OR TRIM(http_referer) = "" OR TRIM(http_referer) = "NULL";
    
SELECT COUNT(*) FROM Silver.website_sessions
WHERE website_session_id IS NULL
	OR created_at IS NULL
    OR user_id IS NULL
    OR is_repeat_session IS NULL
    OR utm_source IS NULL OR TRIM(utm_source) = "" OR TRIM(utm_source) = "NULL"
    OR utm_campaign IS NULL OR TRIM(utm_campaign) = "" OR TRIM(utm_campaign) = "NULL"
    OR utm_content IS NULL OR TRIM(utm_content) = "" OR TRIM(utm_content) = "NULL"
    OR device_type IS NULL OR TRIM(device_type) = "" OR TRIM(device_type) = "NULL"
    OR http_referer IS NULL OR TRIM(http_referer) = "" OR TRIM(http_referer) = "NULL";
    
    
-- Is the primary product id and product id same?
SELECT o.* FROM Silver.orders o
LEFT JOIN Silver.products p
ON o.primary_product_id = p.product_id
WHERE p.product_id IS NULL;

-- Is website session id correct in orders?
SELECT o.* FROM Silver.orders o
LEFT JOIN Silver.website_sessions ws
ON o.website_session_id = ws.website_session_id
WHERE ws.website_session_id IS NULL;

-- Is there any orders sold below COGS?
SELECT * FROM Silver.orders
WHERE price_usd < cogs_usd;

-- Is order date valid?
SELECT o.* FROM Silver.orders o
LEFT JOIN Silver.website_sessions ws
ON o.website_session_id = ws.website_session_id
WHERE o.created_at < ws.created_at;

-- Is order creation valid?
SELECT o.* FROM Silver.orders o
LEFT JOIN Silver.products p
ON o.primary_product_id = p.product_id
WHERE o.created_at < p.created_at;

-- Is item purchased valid?
SELECT * FROM Silver.orders
WHERE items_purchased <= 0;

-- Are all order ids valid in order items tables
SELECT oi.* FROM Silver.order_items oi
LEFT JOIN Silver.orders o
ON oi.order_id = o.order_id
WHERE o.order_id IS NULL;

-- Are all products valid in order items table
SELECT oi.* FROM Silver.order_items oi
LEFT JOIN Silver.products p
ON oi.product_id = p.product_id
WHERE p.product_id IS NULL;

-- Is there any order item sold below COGS?
SELECT * FROM Silver.order_items
WHERE price_usd < cogs_usd;

-- Are all order ids valid in order item refunds table
SELECT oir.* FROM Silver.order_item_refunds oir
LEFT JOIN Silver.orders o
ON oir.order_id = o.order_id
WHERE o.order_id IS NULL;

-- Are all order item ids valid in order item refunds table
SELECT oir.* FROM Silver.order_item_refunds oir
LEFT JOIN Silver.order_items oi
ON oir.order_item_id = oi.order_item_id
WHERE oi.order_item_id IS NULL;

-- Does refund order_id match the order_id of its order item?
SELECT oir.* FROM Silver.order_item_refunds oir
LEFT JOIN Silver.order_items oi
ON oir.order_item_id = oi.order_item_id
WHERE oir.order_id != oi.order_id;

-- Order Item Refund date validity
SELECT oir.* FROM Silver.order_item_refunds oir
LEFT JOIN Silver.order_items oi
ON oir.order_item_id = oi.order_item_id
WHERE oir.created_at < oi.created_at;

-- Is refund price correct
SELECT oir.* FROM Silver.order_item_refunds oir
LEFT JOIN Silver.order_items oi
ON oir.order_item_id = oi.order_item_id
WHERE oir.refund_amount_usd != oi.price_usd;

-- Does every page has valid session
SELECT COUNT(*) FROM Silver.website_pageviews wp
LEFT JOIN Silver.website_sessions ws
ON wp.website_session_id = ws.website_session_id
WHERE ws.website_session_id IS NULL;

-- Flags Check
SELECT DISTINCT is_primary_item
FROM Silver.order_items;

SELECT DISTINCT is_repeat_session
FROM Silver.website_sessions;

-- device types
SELECT DISTINCT device_type FROM Silver.website_sessions;