USE pizza_sales

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
