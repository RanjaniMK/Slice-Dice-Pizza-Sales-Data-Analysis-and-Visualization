USE pizza_sales

SELECT *
FROM sales

-- PERCENTAGE OF SALES BY PIZZA CATEGORY

SELECT pizza_category, SUM(total_price) as Total_Sales, (SUM(total_price)/(SELECT SUM(total_price) FROM sales) * 100) as Percentage_Sales
FROM sales
GROUP BY pizza_category;


-- TOP 5 BEST SELLERS BY REVENUE

SELECT pizza_name_id, SUM(total_price) as Total_Revenue
FROM sales
GROUP BY pizza_name_id
ORDER BY Total_Revenue DESC
LIMIT 5

