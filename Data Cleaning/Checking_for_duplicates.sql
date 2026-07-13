USE pizza_sales

SELECT * 
FROM sales

-- pizza_id is the Primary Key and as it is a unique identifier to each row the we should ensure that there are no duplicates in the pizza_id column.
-- If the pizza_id column contains duplicates then your total pizza count will be artificially inflated.

-- CHECKING FOR DUPLICATES

SELECT pizza_id, COUNT(*)
FROM sales
GROUP BY pizza_id
HAVING COUNT(*) > 1;

-- OUTPUT : No rows with values were returned, which implies that there are no duplicate pizza_id column values. 