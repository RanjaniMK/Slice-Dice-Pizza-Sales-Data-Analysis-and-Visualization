USE pizza_sales;
-- 1.The pizza_sales database was created first using the SQL command.
-- 2.Then the sales table  and it's schema was created with the attributes and datatypes.


/* To successfully import order_date column into the MySQL Workbench, the order_date column
is temporarily changed to VARCHAR datatype. */
ALTER TABLE sales
MODIFY COLUMN `order_date` VARCHAR(50);

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
 DESCRIBE sales;
 
 SELECT order_date
 FROM sales
 LIMIT 10;

-- The output: order_date is in YYYY-MM--DD format. It is the expected, correct output.

-- unit_price and total_price are in double datatype. Changing them to decimal(10,2)
ALTER TABLE sales
MODIFY COLUMN unit_price DECIMAL(10,2);

ALTER TABLE sales
MODIFY COLUMN total_price DECIMAL(10,2);











