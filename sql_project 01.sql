
--- creating database

CREATE DATABASE sql_project01;

--- creating a table

CREATE TABLE retail_sales(
transactions_id INT PRIMARY KEY,
	sale_date DATE ,
    sale_time TIME ,
    customer_id INT,
	gender	VARCHAR(10) NOT NULL,
    age	INT,
    category VARCHAR(50),
	quantiy INT,
	price_per_unit INT,
	cogs FLOAT,
    total_sale FLOAT
); 
use sql_project01;

SELECT * FROM retail_sales;

-- seeing the number of data we have

SELECT  COUNT(*)
FROM retail_sales;

-- number of customers
SELECT COUNT(customer_id)
FROM retail_sales;

--- number of males and females

SELECT COUNT(gender), 'Males' AS number_of_genders
FROM retail_sales
WHERE gender = 'male'
		UNION
SELECT COUNT(gender), 'Females'
FROM retail_sales
WHERE gender = 'female';
	
    --- aggregate of age by gender    
 SELECT gender,COUNT(gender),
 AVG(age),
 MAX(age),
 MIN(age),
 COUNT(age)
 FROM
retail_sales
 ORDER BY gender;
;
--- DATA ANALYSIS
---- number of sales made on 2022-11-05

SELECT *
 FROM retail_sales
WHERE sale_date = '2022-11-05'
;


SELECT * FROM
retail_sales;

--- sql query to retrieve all transactions where category is' Clothing' and the quantity sold is >= 4 in the month of Nov-11

SELECT * 
FROM retail_sales
WHERE category = 'Clothing'
AND 
sale_date LIKE'%2022-11%'
AND 
quantiy >= 4;

--- query to calculate the total sale(total_sale) for each category

SELECT category, SUM(total_sale)
FROM retail_sales
GROUP BY category
;

--- query to find the avg age of customers who purchased items from the 'Beauty' category

SELECT AVG(age)
FROM retail_sales
WHERE category = 'Beauty'
;

--- query to show total sales more than 1000

SELECT *
FROM retail_sales
WHERE total_sale > 1000;

--- query to how the total transactions made for each category by genders

SELECT gender, 
category, 
COUNT(transactions_id) AS total_number_of_tansactions_id
FROM retail_sales
GROUP BY gender,category
ORDER BY category
;
USE sql_project01;


--- query for calculating the avg sale for each month and finding the nest month in each year



SELECT 
MONTH(sale_date) AS months,
SUM(total_sale) AS total_sale_of_month,
ROUND(AVG(total_sale), 2) AS avg_month_sale,
YEAR(sale_date) AS year
FROM
retail_sales
GROUP BY months, year
ORDER BY avg_month_sale DESC, months
;

-- OR

SELECT 
MONTH(sale_date) AS months,
SUM(total_sale) AS total_sale_of_month,
ROUND(AVG(total_sale), 2) AS avg_month_sale,
YEAR(sale_date) AS year,
RANK () OVER(PARTITION BY YEAR(sale_date) ORDER BY AVG(total_sale) DESC)
FROM
retail_sales
GROUP BY months, year;



SELECT *
FROM retail_sales;



SELECT 
customer_id,
SUM(total_sale) AS total_makes
FROM retail_sales
GROUP BY customer_id
ORDER BY total_makes DESC
LIMIT 5;


SELECT 
COUNT(DISTINCT customer_id),
category
FROM retail_sales
GROUP BY category;



SELECT * FROM
retail_sales;

WITH CTE_shift_sales AS
(

SELECT sale_time, transactions_id,
CASE
	WHEN  HOUR(sale_time) <= 12 THEN 'Morning'
    WHEN HOUR(sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
    WHEN HOUR(sale_time) > 17 THEN 'Evening'
    END AS shift
    FROM retail_sales
    )
    SELECT COUNT(transactions_id) AS count_total,
    shift
    from CTE_shift_sales
    GROUP BY shift
    ;











