select * from pizza_sales;

-- 1. Total Revenue

SELECT sum(total_price) AS Total_Revenue FROM pizza_sales;



-- 2. Average Order Value

SELECT SUM(total_price) / COUNT(distinct order_id) AS Avg_Order_Value from pizza_sales;


-- 3. Total Pizzas Sold

select SUM(quantity) as Total_Pizza_Sold from pizza_sales;


-- 4. Total Orders

select count(distinct order_id) as Total_Orders from pizza_sales;


-- 5. Average Pizzas Per Order

-- DECIMAL(10,2) - means, we will get 10 digits after the DECIMAL, 
-- and we need only the start 2 digits from that


select CAST(CAST(SUM(quantity) AS DECIMAL(10,2)) / 
CAST(COUNT(distinct order_id) AS DECIMAL (10,2)) AS DECIMAL (10,2)) AS Avg_Pizza_Per_Order from pizza_sales;



-- 6. Daily Trend for Total Orders

select * from pizza_sales;

SELECT DATENAME(DW, order_date) as Order_day,
COUNT(DISTINCT order_id) as Total_orders
from pizza_sales
GROUP BY DATENAME(DW, order_date);


-- 7. Hourly Trend for Orders

select * from pizza_sales;

SELECT DATEPART(HOUR, order_time) as Order_hours,
COUNT(DISTINCT order_id) as Total_orders
FROM pizza_sales
GROUP BY DATEPART(HOUR, order_time)
ORDER BY DATEPART(HOUR, order_time) ASC;


-- 8. Percentage (%) of Sales by Pizza Category


SELECT * FROM pizza_sales;

SELECT pizza_category, 
CAST(sum(total_price) AS DECIMAL (10,2))AS Total_Sales, 
CAST (sum(total_price) * 100 / 
(SELECT sum(total_price) from pizza_sales) AS DECIMAL (10,2))as PCT_Total_Sales
FROM pizza_sales
GROUP BY pizza_category;



-- 9. Percentage (%) of Sales by Pizza Size

SELECT pizza_size, CAST(sum(total_price) AS DECIMAL(10,2))AS Total_Sales, 
CAST(sum(total_price) * 100 / 
(SELECT sum(total_price) from pizza_sales WHERE DATEPART(QUARTER, order_date) = 1) AS DECIMAL(10,2)) as PCT_Total_Sales
FROM pizza_sales
WHERE DATEPART(QUARTER, order_date) = 1
GROUP BY pizza_size
ORDER BY PCT_Total_Sales DESC;



-- 10. Total Pizzas Sold by Pizza Category

select * from pizza_sales;

SELECT pizza_category, sum(quantity) AS Total_qty_sold 
FROM pizza_sales
GROUP BY pizza_category
ORDER BY Total_qty_sold DESC;



-- 11. Top 5 Best Sellers by Total Pizzas Sold

select DISTINCT pizza_name from pizza_sales;

SELECT TOP 5 pizza_name, 
sum(quantity) AS Total_pizza_sold 
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_pizza_sold DESC;



-- 12. Bottom 5 Best Sellers by Total Pizzas Sold

select DISTINCT pizza_name from pizza_sales;

SELECT TOP 5 pizza_name, 
sum(quantity) AS Total_pizza_sold 
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_pizza_sold ASC;




