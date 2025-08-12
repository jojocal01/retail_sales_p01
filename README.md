Retail Sales Analysis SQL Project Project Title: Retail Sales Analysis Level: Beginner Database: sql_project01

This project is designed to demonstrate SQL skills and techniques typically used by data analysts to explore, clean, and analyze retail sales data. The project involves setting up a retail sales database, performing exploratory data analysis (EDA), and answering specific business questions through SQL queries. This project is ideal for those who are starting their journey in data analysis and want to build a solid foundation in SQL.

Objectives Set up a retail sales database: Create and populate a retail sales database with the provided sales data. Data Cleaning: Identify and remove any records with missing or null values. Exploratory Data Analysis (EDA): Perform basic exploratory data analysis to understand the dataset. Business Analysis: Use SQL to answer specific business questions and derive insights from the sales data. Project Structure

Database Setup Database Creation: The project starts by creating a database named p1_retail_db. Table Creation: A table named retail_sales is created to store the sales data. The table structure includes columns for transaction ID, sale date, sale time, customer ID, gender, age, product category, quantity sold, price per unit, cost of goods sold (COGS), and total sale amount. CREATE DATABASE sql_project01;
--- creating a table '''sql

CREATE TABLE retail_sales( transactions_id INT PRIMARY KEY, sale_date DATE , sale_time TIME , customer_id INT, gender VARCHAR(10) NOT NULL, age INT, category VARCHAR(50), quantiy INT, price_per_unit INT, cogs FLOAT, total_sale FLOAT );

'''sql 2. Data Exploration & Cleaning -- seeing the number of data we have '''sql SELECT COUNT(*) FROM retail_sales;

-- number of customers SELECT COUNT(customer_id) FROM retail_sales; '''

--- number of males and females '''sql

SELECT COUNT(gender), 'Males' AS number_of_genders FROM retail_sales WHERE gender = 'male' UNION SELECT COUNT(gender), 'Females' FROM retail_sales WHERE gender = 'female'; '''

--- aggregate of age by gender
'''sql
SELECT gender,COUNT(gender), AVG(age), MAX(age), MIN(age), COUNT(age) FROM retail_sales ORDER BY gender; ; '''

The following SQL queries were developed to answer specific business questions:

--- DATA ANALYSIS ---- number of sales made on 2022-11-05 '''sql

SELECT * FROM retail_sales WHERE sale_date = '2022-11-05' ; '''

SELECT * FROM retail_sales;

--- sql query to retrieve all transactions where category is' Clothing' and the quantity sold is >= 4 in the month of Nov-11 '''sql SELECT * FROM retail_sales WHERE category = 'Clothing' AND sale_date LIKE'%2022-11%' AND quantiy >= 4; ''' --- query to calculate the total sale(total_sale) for each category '''sql SELECT category, SUM(total_sale) FROM retail_sales GROUP BY category ; '''

--- query to find the avg age of customers who purchased items from the 'Beauty' category '''sql

SELECT AVG(age) FROM retail_sales WHERE category = 'Beauty' ; ''' --- query to show total sales more than 1000 '''sql SELECT * FROM retail_sales WHERE total_sale > 1000; '''

--- query to how the total transactions made for each category by genders '''sql

SELECT gender, category, COUNT(transactions_id) AS total_number_of_tansactions_id FROM retail_sales GROUP BY gender,category ORDER BY category ; '''

--- query for calculating the avg sale for each month and finding the best month in each year

'''sql

SELECT MONTH(sale_date) AS months, SUM(total_sale) AS total_sale_of_month, ROUND(AVG(total_sale), 2) AS avg_month_sale, YEAR(sale_date) AS year FROM retail_sales GROUP BY months, year ORDER BY avg_month_sale DESC, months ;

''' -- OR

'''sql

SELECT MONTH(sale_date) AS months, SUM(total_sale) AS total_sale_of_month, ROUND(AVG(total_sale), 2) AS avg_month_sale, YEAR(sale_date) AS year, RANK () OVER(PARTITION BY YEAR(sale_date) ORDER BY AVG(total_sale) DESC) FROM retail_sales GROUP BY months, year;

''' **Write a SQL query to find the top 5 customers based on the highest total sales **: '''sql

SELECT customer_id, SUM(total_sale) AS total_makes FROM retail_sales GROUP BY customer_id ORDER BY total_makes DESC LIMIT 5; '''

Write a SQL query to find the number of unique customers who purchased items from each category.: '''sql SELECT COUNT(DISTINCT customer_id), category FROM retail_sales GROUP BY category; '''

Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17): '''sql

WITH CTE_shift_sales AS (

SELECT sale_time, transactions_id, CASE WHEN HOUR(sale_time) <= 12 THEN 'Morning' WHEN HOUR(sale_time) BETWEEN 12 AND 17 THEN 'Afternoon' WHEN HOUR(sale_time) > 17 THEN 'Evening' END AS shift FROM retail_sales ) SELECT COUNT(transactions_id) AS count_total, shift from CTE_shift_sales GROUP BY shift ;

'''

Findings Customer Demographics: The dataset includes customers from various age groups, with sales distributed across different categories such as Clothing and Beauty. High-Value Transactions: Several transactions had a total sale amount greater than 1000, indicating premium purchases. Sales Trends: Monthly analysis shows variations in sales, helping identify peak seasons. Customer Insights: The analysis identifies the top-spending customers and the most popular product categories. Reports Sales Summary: A detailed report summarizing total sales, customer demographics, and category performance. Trend Analysis: Insights into sales trends across different months and shifts. Customer Insights: Reports on top customers and unique customer counts per category. Conclusion This project serves as a comprehensive introduction to SQL for data analysts, covering database setup, data cleaning, exploratory data analysis, and business-driven SQL queries. The findings from this project can help drive business decisions by understanding sales patterns, customer behavior, and product performance.
