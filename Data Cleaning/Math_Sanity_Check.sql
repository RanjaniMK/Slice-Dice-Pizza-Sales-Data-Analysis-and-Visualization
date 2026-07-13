-- Ensuring that quantity * unit_price = total_price because sometimes data extraction corrupts these numbers.

USE pizza_sales

SELECT *
FROM sales
WHERE ABS(total_price-(quantity * unit_price)) > 0.01;

-- OUTPUT : The result has NULL values for all the columns, which means the math adds-up and there are no discrepancies.