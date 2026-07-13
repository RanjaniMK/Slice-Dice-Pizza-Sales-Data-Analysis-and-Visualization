USE pizza_sales

SELECT *
FROM sales;

-- We aleady fixed the order_date column in the Data_Cleaning file
-- Now we need to ensure that order_time is recognized as a true time data type so that it can be used for further analysis.

ALTER TABLE sales
MODIFY COLUMN order_time TIME;


DESCRIBE sales


/* Checking for anomalies : For example, ensure there are no bizarre ordering hours like 4:00 AM as the Pizzeria opens only at 11:00 AM in the morning. */

SELECT DISTINCT HOUR(order_time)
FROM sales
ORDER BY 1

-- OUTPUT: There were no anomalies detected as all orders have been placed between 11 AM to 10 PM, during the Pizzeria's working hours.
