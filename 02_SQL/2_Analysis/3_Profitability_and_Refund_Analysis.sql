-- =================================
-- PROFITABILITY & REFUNDS ANALYSIS
-- =================================

WITH monthly_orders AS (
	SELECT 
		MONTH(created_at) AS month_num, 
		MONTHNAME(created_at) AS month_name, 
		YEAR(created_at) AS 'year', 
		SUM(price_usd) AS revenue,
		SUM(cogs_usd) AS cogs,
		SUM(price_usd) - SUM(o.cogs_usd) AS gross_profit
	FROM Silver.orders o
    GROUP BY month_num, month_name, YEAR(created_at)
),
monthly_items AS (
	SELECT
		MONTH(created_at) AS month_num, 
		MONTHNAME(created_at) AS month_name, 
		YEAR(created_at) AS 'year',
		COUNT(*) AS total_items
	FROM Silver.order_items
    GROUP BY month_num, month_name, YEAR(created_at)
),
monthly_refunds AS (
	SELECT
		MONTH(created_at) AS month_num, 
		MONTHNAME(created_at) AS month_name, 
		YEAR(created_at) AS 'year',
		COUNT(*) AS refund_items,
		SUM(refund_amount_usd) AS refund_amount
	FROM Silver.order_item_refunds
    GROUP BY month_num, month_name, YEAR(created_at)
)
SELECT
	mo.month_num,
    mo.month_name,
    mo.year,
    mo.revenue,
    mo.cogs,
    mo.gross_profit,
    mi.total_items,
    mr.refund_items,
    mr.refund_amount
FROM monthly_orders mo
LEFT JOIN monthly_items mi
ON mo.year = mi.year
AND mo.month_num = mi.month_num
LEFT JOIN monthly_refunds mr
ON mo.year = mr.year
AND mo.month_num = mr.month_num
ORDER BY year, month_num;


WITH product_refunds AS (
	SELECT 
		p.product_id AS product_id,
		p.product_name AS product_name,
		COUNT(oir.order_item_refund_id) AS refunds
	FROM Silver.order_item_refunds oir
	LEFT JOIN Silver.order_items oi
	on oir.order_item_id = oi.order_item_id
	LEFT JOIN Silver.products p
	ON oi.product_id = p.product_id
	GROUP BY p.product_id, p.product_name
),
product_sales AS (
	SELECT 
		p.product_id AS product_id,
		p.product_name AS product_name,
		COUNT(oi.order_item_id) AS sales
	FROM Silver.order_items oi
	LEFT JOIN Silver.products p
	ON oi.product_id = p.product_id
	GROUP BY p.product_id, p.product_name
)
SELECT
	pr.product_id,
    pr.product_name,
    pr.refunds,
    ps.sales,
    pr.refunds / ps.sales AS refund_ratio
FROM product_refunds pr
LEFT JOIN product_sales ps
ON pr.product_id = ps.product_id;


WITH product_refunds AS (
	SELECT 
		MONTH(oir.created_at) AS month_num, 
		MONTHNAME(oir.created_at) AS month_name, 
		YEAR(oir.created_at) AS 'year',
		p.product_id AS product_id,
		p.product_name AS product_name,
		COUNT(oir.order_item_refund_id) AS refunds
	FROM Silver.order_item_refunds oir
	LEFT JOIN Silver.order_items oi
	on oir.order_item_id = oi.order_item_id
	LEFT JOIN Silver.products p
	ON oi.product_id = p.product_id
	GROUP BY month_num, month_name, YEAR(created_at), p.product_id, p.product_name
),
product_sales AS (
	SELECT 
		MONTH(oi.created_at) AS month_num, 
		MONTHNAME(oi.created_at) AS month_name, 
		YEAR(oi.created_at) AS 'year',
		p.product_id AS product_id,
		p.product_name AS product_name,
		COUNT(oi.order_item_id) AS sales
	FROM Silver.order_items oi
	LEFT JOIN Silver.products p
	ON oi.product_id = p.product_id
	GROUP BY month_num, month_name, YEAR(created_at), p.product_id, p.product_name
)
SELECT
	ps.month_num,
    ps.month_name,
    ps.year,
	pr.product_id,
    pr.product_name,
    pr.refunds,
    ps.sales,
    pr.refunds / ps.sales AS refund_ratio
FROM product_refunds pr
LEFT JOIN product_sales ps
ON pr.year = ps.year
AND pr.month_num = ps.month_num
AND pr.product_id = ps.product_id
ORDER BY year, month_num;