USE pizza_sales

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

