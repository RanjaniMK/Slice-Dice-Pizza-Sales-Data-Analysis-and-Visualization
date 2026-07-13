USE pizza_sales

-- INITIAL CHECK: For the data present in the file.
SELECT *
FROM temp_raw_data

-- Checking the total number of rows present.
SELECT COUNT(*)
FROM temp_raw_data


-- TABLE STRUCTURE CHANGE : Adding a new column for testing.
ALTER TABLE temp_raw_data
ADD COLUMN test_date_conversion DATE;


-- Adding and saving formatted date values to the new column from order_date column.
SET SQL_SAFE_UPDATES = 0;
UPDATE temp_raw_data
SET test_date_conversion = str_to_date(order_date, '%d-%m-%Y');
SET SQL_SAFE_UPDATES = 1;

-- TEST RUN : Verifying test_date_conversion column creation
-- NULL AUDIT RUN : Verifying that the new column created has no NULL values.
SELECT order_date, test_date_conversion
FROM temp_raw_data
LIMIT 10;    


-- FOLLOWED BY:  Now including the new added column and it's values into the order_date column in the main file.
-- Code can be found in the main.sql file
