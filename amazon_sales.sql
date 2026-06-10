-- Average discount rate
SELECT category, ROUND(AVG(CAST(discount_percentage AS FLOAT)), 2) AS average_discount_rate
FROM amazon_sales
GROUP BY category
ORDER BY average_discount_rate DESC;

-- Top 10 best rated products
SELECT product_name, rating, rating_count
FROM amazon_sales
WHERE rating != '|'
ORDER BY CAST(rating AS FLOAT) DESC, CAST(rating_count AS FLOAT) DESC
LIMIT 10;

-- Real price vs discounted price (category)
SELECT category, ROUND(AVG(CAST(actual_price AS FLOAT)),2) AS actual_price, ROUND(AVG(CAST(discounted_price AS FLOAT)),2) AS discounted_price
FROM amazon_sales
GROUP BY category
ORDER BY actual_price DESC;

-- Top 10 Products with Most number of Reviews
SELECT DISTINCT product_id, product_name, CAST(rating_count AS FLOAT) AS rating_count
FROM amazon_sales
ORDER BY rating_count DESC
LIMIT 10;

-- Discount rate vs ratings relationship
SELECT ROUND(AVG(CAST(rating AS FLOAT)),2) AS average_ratings, 
CASE WHEN CAST(discount_percentage AS FLOAT) < 25 THEN "LOW"
WHEN CAST(discount_percentage AS FLOAT) < 50 THEN "MEDIUM"
WHEN CAST(discount_percentage AS FLOAT) < 75 THEN "HIGH"
ELSE "VERY HIGH"
END AS discount_group, COUNT(*) AS count
FROM amazon_sales
GROUP BY discount_group;
