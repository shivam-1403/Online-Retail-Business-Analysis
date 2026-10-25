-- ==============================
-- PRODUCT PERFORMANCE ANALYSIS
-- ==============================

-- Which products sell the most?
SELECT
	oi.product_id,
    p.product_name,
    SUM(oi.price_usd) AS sale,
    COUNT(oi.product_id) AS orders,
    RANK() OVER (ORDER BY COUNT(oi.product_id) DESC) AS order_rank
FROM Silver.order_items oi
LEFT JOIN Silver.products p
ON oi.product_id = p.product_id
GROUP BY oi.product_id, p.product_name;

-- Is demand increasing?
SELECT
	YEAR(oi.created_at) AS `year`,
	oi.product_id,
    p.product_name,
    SUM(oi.price_usd) AS sale,
    COUNT(oi.product_id) AS orders,
    RANK() OVER (PARTITION BY YEAR(oi.created_at) ORDER BY SUM(oi.price_usd) DESC) AS sales_rank,
    RANK() OVER (PARTITION BY YEAR(oi.created_at) ORDER BY COUNT(oi.product_id) DESC) AS order_rank
FROM Silver.order_items oi
LEFT JOIN Silver.products p
ON oi.product_id = p.product_id
GROUP BY `year`, oi.product_id, p.product_name;

-- Has the selling price and COGS of each product changed over time?
SELECT
	YEAR(oi.created_at) AS `year`,
    oi.product_id,
    p.product_name,
    oi.price_usd,
    MIN(oi.price_usd) OVER (PARTITION BY oi.product_id, YEAR(oi.created_at) ORDER BY YEAR(oi.created_at)) AS min_price_usd,
    oi.cogs_usd,
    MIN(oi.cogs_usd) OVER (PARTITION BY oi.product_id, YEAR(oi.created_at) ORDER BY YEAR(oi.created_at)) AS min_cogs_usd
FROM Silver.order_items oi
LEFT JOIN Silver.products p
ON oi.product_id = p.product_id
GROUP BY `year`, oi.product_id, p.product_name, oi.price_usd, oi.cogs_usd;

-- product profitability
SELECT
	YEAR(oi.created_at) AS `year`,
    oi.product_id,
    p.product_name,
    SUM(oi.price_usd) AS total_price,
    SUM(oi.cogs_usd) AS total_cogs,
	SUM(oi.price_usd) - SUM(oi.cogs_usd) AS profit
FROM Silver.order_items oi
LEFT JOIN Silver.products p
ON oi.product_id = p.product_id
GROUP BY `year`, oi.product_id, p.product_name;