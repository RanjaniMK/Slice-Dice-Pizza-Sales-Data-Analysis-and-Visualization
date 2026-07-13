USE pizza_sales

SELECT *
FROM sales

-- TOTAL REVENUE

SELECT SUM(total_price) as Total_Revenue
FROM sales


-- AVERAGE ORDER VALUE

SELECT SUM(total_price)/COUNT(DISTINCT order_id) as Average_Order_Value
FROM sales


-- Total Pizzas sold

SELECT SUM(quantity) as Total_Pizzas_Sold
FROM sales;
