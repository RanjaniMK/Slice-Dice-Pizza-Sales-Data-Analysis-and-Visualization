USE pizza_sales

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

