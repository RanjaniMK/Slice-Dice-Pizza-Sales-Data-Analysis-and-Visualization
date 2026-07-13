USE pizza_sales

-- 7-Day Rolling Average Forecast
-- This SQL Query calculates 7 day moving average to project the upcoming pizza demand based on immediate past trends.



SELECT order_date, pizza_id, quantity,
AVG(quantity) OVER (PARTITION BY pizza_id ORDER BY order_date ROWS BETWEEN 6 PRECEDING AND CURRENT ROW) as seven_day_demand_forecast
FROM sales
