-- =====================================================================================
-- DATABASE CREATION AND DATA LOADING IN BRONZE
-- =====================================================================================


CREATE DATABASE Bronze;
CREATE DATABASE Silver;
CREATE DATABASE Gold;

SELECT COUNT(*) FROM Bronze.website_sessions;		-- 472871 
SELECT COUNT(*) FROM Bronze.website_pageviews;		-- 1188124
SELECT COUNT(*) FROM Bronze.orders;					-- 32313
SELECT COUNT(*) FROM Bronze.order_items;			-- 40025
SELECT COUNT(*) FROM Bronze.order_item_refunds;		-- 1731
SELECT COUNT(*) FROM Bronze.products;				-- 4