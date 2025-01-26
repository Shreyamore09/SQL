CREATE  DATABASE sql_project2;

CREATE TABLE retail_sales(
transactions_id	INT PRIMARY KEY,
sale_date DATE,
sale_time TIME,
customer_id	INT,
gender VARCHAR(15),
age INT,
category VARCHAR(15),
quantiy INT,
price_per_unit FLOAT,
cogs FLOAT,
total_sale FLOAT
);

SELECT * FROM retail_sales;

SELECT * FROM retail_sales
LIMIT 10;

SELECT COUNT(*) FROM retail_sales

--data cleaning
SELECT * FROM retail_sales
WHERE transactions_id IS NULL

SELECT * FROM retail_sales
WHERE sale_date IS NULL

SELECT * FROM retail_sales
WHERE sale_time IS NULL

SELECT * FROM retail_sales
WHERE transactions_id IS NULL
OR
sale_time IS NULL
OR
sale_time IS NULL
OR
customer_id IS NULL
OR
gender IS NULL
OR 
age IS NULL
OR 
category IS NULL
OR
quantiy IS NULL
OR
price_per_unit IS NULL
OR 
cogs IS NULL
OR
total_sale IS NULL


DELETE FROM retail_sales
WHERE 
transactions_id IS NULL
OR
sale_time IS NULL
OR
sale_time IS NULL
OR
customer_id IS NULL
OR
gender IS NULL
OR 
age IS NULL
OR 
category IS NULL
OR
quantiy IS NULL
OR
price_per_unit IS NULL
OR 
cogs IS NULL
OR
total_sale IS NULL;

--Data Exploration

--How many sales we have?
SELECT COUNT(*) toatl_sales FROM retail_sales

--How many cutsmoer we have?
SELECT COUNT(DISTINCT customer_id) as toatl_sales FROM retail_sales

SELECT COUNT(DISTINCT category) as toatl_sales FROM retail_sales

SELECT DISTINCT category FROM retail_sales


--Data analysis n Business key problems

--WASQ to retrive all columns for sales made on'2022-11-05'
SELECT * FROM retail_sales
WHERE sale_date='2022-11-05'

--WASQ to retrieve all transaction where the category is 'clothing' and the quantity sold is more than 4 in the month of nov-2022
SELECT *FROM retail_sales
WHERE category='Clothing'
AND TO_CHAR(sale_date,'yyyy-mm')='2022-11'
AND  quantiy>=4

--WASQ  to calculate the total sales(total_sale)f or each category
SELECT category ,
SUM(total_sale) as net_sale,
Count (*) as total_orders
FROM retail_sales
GROUP BY 1

--WASQ to find the Average age of customers who purchased items from the 'Beauty' category
SELECT ROUND(AVG(age), 2) as avg_age
Fwhere the toalROM retail_sales
WHERE category ='Beauty'

--WASQ  to find all transaction where the total_sale is greater than 1000
SELECT * FROM retail_sales
WHERE total_sale>1000

--Write a sql to find the total number of transaction (transactio_id)made by each gender in each category
SELECT category, gender,
COUNT(*)as total_trans
FROM retail_sales
GROUP BY category, gender
ORDER BY 1

--WASQ to calculate the avg sale for each month. find out best selling month in each year
SELECT EXTRACT(year FROM sale_date) as year,
       EXTRACT(MONTH FROM sale_date) as month,
AVG(total_sale) as avg_sale
FROM retail_sales
GROUP BY 1,2 
ORDER BY 1, 2

SELECT EXTRACT(year FROM sale_date) as year,
       EXTRACT(MONTH FROM sale_date) as month,
AVG(total_sale) as avg_sale
FROM retail_sales
GROUP BY 1,2 
ORDER BY 1,3 DESC--HIGHEST

SELECT EXTRACT(year FROM sale_date) as year,
       EXTRACT(MONTH FROM sale_date) as month,
AVG(total_sale) as avg_sale,
RANK() OVER (PARTITION BY EXTRACT (YEAR FROM sale_date) ORDER BY AVG (total_sale)DESC)
FROM retail_sales
GROUP BY 1,2 


SELECT * FROM(
SELECT EXTRACT(year FROM sale_date) as year,
       EXTRACT(MONTH FROM sale_date) as month,
AVG(total_sale) as avg_sale,
RANK() OVER (PARTITION BY EXTRACT (YEAR FROM sale_date) ORDER BY AVG (total_sale)DESC)
FROM retail_sales
GROUP BY 1,2  )
as t1
WHERE rank=1

SELECT year, 
month
avg_sale  
FROM(
SELECT EXTRACT(year FROM sale_date) as year,
       EXTRACT(month FROM sale_date) as month,
AVG(total_sale) as avg_sale,
RANK() OVER (PARTITION BY EXTRACT (YEAR FROM sale_date) ORDER BY AVG (total_sale)DESC)
FROM retail_sales
GROUP BY 1,2)
as t1
WHERE rank=1

--WASQ to find the top 5 customer based on the highest tottal sales

SELECT customer_id,
SUM(total_sale) as total_sales
FROM retail_sales
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5

--WASQ find no. of unique customer who purchased items from each category
SELECT category,
COUNT (DISTINCT customer_id) as cnt_unique_cs
FROM retail_sales
GROUP BY category


--WASQ to create each shift and no. of orders (morning <=12,Afternoon Between 12 & 17 , Evening>17)

SELECT *, 
CASE
WHEN EXTRACT (HOUR FROM sale_time)<12 THEN 'Morning'
WHEN EXTRACT (HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
ELSE 'Evening'
END as shift
FROM retail_sales

WITH hourly_sale
As(
SELECT *, 
CASE
WHEN EXTRACT (HOUR FROM sale_time)<12 THEN 'Morning'
WHEN EXTRACT (HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
ELSE 'Evening'
END as shift
FROM retail_sales)
SELECT shift,
COUNT(*) as total_orders 
FROM hourly_sale
GROUP BY shift

SELECT EXTRACT (HOUR FROM CURRENT_TIME)

