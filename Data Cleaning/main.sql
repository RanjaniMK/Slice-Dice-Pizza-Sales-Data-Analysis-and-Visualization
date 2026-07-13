USE pizza_sales

-- NUMBER OF RECORDS
SELECT COUNT(*)
FROM sales

-- DATA CLEANING & ANALYSIS


-- 1.The pizza_sales database was created first using the SQL command.
-- 2.Then the sales table  and it's schema was created with the attributes and datatypes.


/* To successfully import order_date column into the MySQL Workbench, the order_date column
is temporarily changed to VARCHAR datatype. */
ALTER TABLE sales
MODIFY COLUMN `order_date` VARCHAR(10);

/* Below output is a table full of values, so data import was successful. */
select * from sales;

/* Now changing the datatype of order_date column to DATE follows the below SQL command execution. */


/* Update without a WHERE clause, hence use the below SQL statement 
SET SQL_SAFE_UPDATES = 0;


UPDATE sales
SET order_date=str_to_date(order_date, '%d/%m/%Y');


/*Update without a WHERE clause, hence use the below SQL statement post UPDATE execution 
SET SQL_SAFE_UPDATES = 1; 
*/

-- Finding broken rows
SELECT order_date
FROM sales
WHERE STR_TO_DATE(order_date, '%Y-%m-%d') IS NULL 
AND  order_date IS NOT NULL;

-- Fixing data
SET SQL_SAFE_UPDATES = 0;

UPDATE sales
SET order_date = NULL
WHERE order_date = '' OR order_date = ' ' OR  TRIM(order_date) ='';


-- Checking if the order_date format is correct

/*SELECT order_date
FROM sales
*/


/* Further formatting cannot be carried out in the same order_date column as MySQL Workbench is creating an error.
 Hence creating a new column for order_date*/
 
 ALTER TABLE sales 
 ADD COLUMN new_date DATE;
 
 
 /* Populating the new column using the exact format */
 
 SET SQL_SAFE_UPDATES = 0;
 
 UPDATE sales
 SET new_date = STR_TO_DATE(order_date, '%d-%m-%Y')
 WHERE order_date like '%-%-%';
 
 
 -- Getting rid of the old order_date varchar() column
 ALTER TABLE sales
 DROP COLUMN order_date;
 
 
 -- Renaming the new date column to order_date now
 ALTER TABLE sales
 CHANGE COLUMN new_date order_date DATE;
 
 SET SQL_SAFE_UPDATES = 1;
 
 -- Verifying your data to make sure everything looks as expected
 
 
 
 SELECT order_date
 FROM sales
 LIMIT 10;

-- The output has NULL values for order_date column. Hence including the below code solution.
 SET SQL_SAFE_UPDATES = 0;
UPDATE sales as original 
JOIN temp_raw_data as temp
on original.pizza_id = temp.pizza_id
SET original.order_date = temp.test_date_conversion;
 SET SQL_SAFE_UPDATES = 1;
 
 
 -- CLEANING UP : Deleting the temporary table.
 DROP TABLE temp_raw_data;
 
 
 -- Verifying the order_date column and it's values.
SELECT order_date
FROM sales

-- unit_price and total_price are in double datatype. Changing them to decimal(10,2)
ALTER TABLE sales
MODIFY COLUMN unit_price DECIMAL(10,2);

ALTER TABLE sales
MODIFY COLUMN total_price DECIMAL(10,2);




SELECT *
FROM sales


-- Data Cleaning for the columns : unit_price, total_price, quantity

/* Ensuring there are no $ symbols*/

SET SQL_SAFE_UPDATES = 0; /* Turning off safe updates */

-- Cleaning queries below
UPDATE sales
SET unit_price = REPLACE(unit_price, '$', '');

UPDATE sales
SET total_price = REPLACE(total_price, '$', '');

ALTER TABLE sales
MODIFY COLUMN quantity INT;


ALTER TABLE sales
MODIFY COLUMN unit_price DECIMAL(10,2);

ALTER TABLE sales
MODIFY COLUMN total_price DECIMAL(10,2);



SET SQL_SAFE_UPDATES = 1;

-- Ensuring that quantity * unit_price = total_price because sometimes data extraction corrupts these numbers.



SELECT *
FROM sales
WHERE ABS(total_price-(quantity * unit_price)) > 0.01;

-- OUTPUT : The result has NULL values for all the columns, which means the math adds-up and there are no discrepancies.



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





/* The values in pizza_name_id column have their respective names ending with _m and _l. Any spaces in the naming like hawaiian m, will suggest that the hawaiian m is a 
different pizza type. To ensure the correctness, we use the below SQL query to standardize pizza_name_id column. */

SET SQL_SAFE_UPDATES = 0; /* Turning off safe updates */

UPDATE sales
SET pizza_name_id= TRIM(LOWER(pizza_name_id));

SET SQL_SAFE_UPDATES = 1; /* Turning on safe updates */



SELECT *
FROM sales

-- Data Cleaning for comma separated values column : pizza_ingredients

-- CHECKING THE COLUMN VALUES
SELECT pizza_ingredients
FROM sales

-- CLEAN HIDDEN SPACING 
/* SQL code for uniform spacing */

SET SQL_SAFE_UPDATES = 0;

UPDATE sales
SET pizza_ingredients = REPLACE(pizza_ingredients, ', ', ', ');


SET SQL_SAFE_UPDATES = 1;


-- FINAL CHECK : THE "NULL" AUDIT

SELECT
	SUM(CASE WHEN pizza_id IS NULL THEN 1
        ELSE 0
        END) as missing_pizza_ids,
        
	SUM(CASE WHEN order_id IS NULL THEN 1
		ELSE 0
        END) as missing_order_ids,
	
    SUM( CASE WHEN quantity IS NULL THEN 0
		ELSE 0
        END) as missing_quantities,
        
	SUM( CASE WHEN total_price IS NULL THEN 1
		ELSE 0
        END) as missing_prices

FROM sales;

 /* OUTPUT: The data looks clean as none of the audited columns have NULL values. 
 If NULL values were present then it means that the  pizza_sales data is dirty and it will skew your business analysis. */



SELECT *
FROM sales



/* We have categorical fields like pizza_size, pizza_category and pizza_name in the dataset. It is important to standardize the values of these columns in order to come up
with accurate analysis. */

-- Standardize Sizes. Sometimes text imports mess up with casing and spaces. Check how your categorical data looks like.

SELECT DISTINCT pizza_size
FROM sales

-- The OUTPUT looks good. There are only M, L and S pizza sizes.



-- STANDARDIZING CATEGORIES. Ensuring pizza_category column values are uniformly capitalized.

SET SQL_SAFE_UPDATES = 0;

UPDATE sales
SET pizza_category = TRIM(CONCAT(UPPER(SUBSTRING(pizza_category, 1,1)),LOWER(SUBSTRING(pizza_category,2))));

SET SQL_SAFE_UPDATES = 1;

-- Displaying modified results for the column pizza_category after applying the string functions above.
SELECT pizza_category
FROM sales

-- FINAL CSV FILE OUTPUT TO BE EXPORTED

SELECT *
FROM sales

SELECT COUNT(*)
FROM sales










