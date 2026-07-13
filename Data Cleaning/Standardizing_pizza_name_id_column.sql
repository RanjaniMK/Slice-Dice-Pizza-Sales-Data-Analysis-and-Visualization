USE pizza_sales



/* The values in pizza_name_id column have their respective names ending with _m and _l. Any spaces in the naming like hawaiian m, will suggest that the hawaiian m is a 
different pizza type. To ensure the correctness, we use the below SQL query to standardize pizza_name_id column. */

SET SQL_SAFE_UPDATES = 0; /* Turning off safe updates */

UPDATE sales
SET pizza_name_id= TRIM(LOWER(pizza_name_id));

SET SQL_SAFE_UPDATES = 1; /* Turning on safe updates */
