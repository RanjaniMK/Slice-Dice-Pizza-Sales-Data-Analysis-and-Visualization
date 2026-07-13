USE pizza_sales

SELECT *
FROM sales

-- TREND ANALYSIS

-- 1. Daily Trend for Total Orders

SELECT DAYNAME(order_date) as Order_Day, COUNT(DISTINCT order_id) as Total_Orders
FROM sales
GROUP BY Order_Day
ORDER BY Total_Orders DESC;


-- 2. Hourly Trend for Total Orders

SELECT HOUR(order_time) as Order_Hour, COUNT(DISTINCT order_id) as Total_Orders
FROM sales
GROUP BY Order_Hour
ORDER BY Order_Hour
