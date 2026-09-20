create database superstore_project;
use superstore_project;
show databases;
SHOW VARIABLES LIKE 'local_infile';
SET GLOBAL local_infile = ON;
select * from superstore_project;
select count(*)  as total_rows
from orders_mysql;
select Min("Row ID") as min_row_id ,
       Max("Row ID") as max_row_id,
       count(distinct 'Row ID') as unique_row_id 
       from orders_mysql;
       
select count(distinct "Row ID") as unique_row_id from orders_mysql;
describe orders_mysql;
show columns from orders_mysql;

SELECT 
    MIN(`Row ID`) AS min_row_id,
    MAX(`Row ID`) AS max_row_id,
    COUNT(DISTINCT `Row ID`) AS unique_row_ids
FROM orders_mysql;

WITH RECURSIVE row_numbers AS (
    SELECT 1 AS row_id
    UNION ALL
    SELECT row_id + 1
    FROM row_numbers
    WHERE row_id < 9994
)
SELECT r.row_id
FROM row_numbers r
LEFT JOIN orders_mysql o
    ON r.row_id = o.`Row ID`
WHERE o.`Row ID` IS NULL;

SELECT COUNT(*) AS missing_rows
FROM (
    SELECT 1 AS row_id
    UNION ALL SELECT 2
    UNION ALL SELECT 3
    UNION ALL SELECT 4
    UNION ALL SELECT 5
) x;

select count(*) as  total_rows from orders_mysql;

select sum(sales) as total_sales,
       sum(profit) as total_profit,
       sum(quantity) as total_quantity ,
       count(distinct `order id`) as total_orders
from orders_mysql;

select sum(sales ) as total_sales,
	   sum(profit) as total_profit,
       round((sum(profit)/ sum(sales)) * 100,2) as profit_margin_percent
       from orders_mysql;

select 
category,
	   round(sum(sales), 2) as total_sales,
	   round(sum(profit),2) as total_profit,
       round((sum(profit)/sum(sales)) * 100,2) as profit_margin_percent
       from orders_mysql 
       group by category
       order by total_profit desc;
       
       SELECT
    `Sub-Category`,
    ROUND(SUM(Sales), 2) AS total_sales,
    ROUND(SUM(Profit), 2) AS total_profit,
    ROUND((SUM(Profit) / SUM(Sales)) * 100, 2) AS profit_margin_percent
FROM orders_mysql
GROUP BY `Sub-Category`
ORDER BY total_profit ASC;


SELECT
    Discount,
    ROUND(SUM(Sales), 2) AS total_sales,
    ROUND(SUM(Profit), 2) AS total_profit,
    ROUND((SUM(Profit) / SUM(Sales)) * 100, 2) AS profit_margin_percent
FROM orders_mysql
GROUP BY Discount
ORDER BY Discount;

select `sub-category`,
	 round(avg(discount)*100,2) AS avg_discount_percent,
     round(sum(sales),2) as total_sales,
     round(sum(profit),2) as total_profit
from orders_mysql
where `sub-category`= 'tables'
group by `sub-category`;

SELECT
    region ,
    round(sum(sales), 2) AS total_sales,
    ROUND(SUM(profit), 2) AS total_profit,
    ROUND((SUM(Profit) / sum(sales)) *100, 2) AS profit_margin_percent
from orders_mysql
GROUP BY region
order by total_profit desc;

SELECT
    Region,
    Category,
    ROUND(SUM(Sales), 2) AS total_sales,
    ROUND(SUM(Profit), 2) AS total_profit,
    ROUND((SUM(Profit) / SUM(Sales)) * 100, 2) AS profit_margin_percent
FROM orders_mysql
GROUP BY Region, Category
ORDER BY Region, total_profit;

SELECT
    YEAR(STR_TO_DATE(`Order Date`, '%m/%d/%Y')) AS order_year,
    ROUND(SUM(Sales), 2) AS total_sales,
    ROUND(SUM(Profit), 2) AS total_profit,
    ROUND((SUM(Profit) / SUM(Sales)) * 100, 2) AS profit_margin_percent
FROM orders_mysql
GROUP BY order_year
ORDER BY order_year;

SELECT
    `Order Date`,
    `Ship Date`
FROM orders_mysql
LIMIT 10;

SELECT
    YEAR(STR_TO_DATE(`Order Date`, '%d-%m-%Y')) AS order_year,
    ROUND(SUM(Sales), 2) AS total_sales,
    ROUND(SUM(Profit), 2) AS total_profit,
    ROUND((SUM(Profit) / SUM(Sales)) * 100, 2) AS profit_margin_percent
FROM orders_mysql
GROUP BY order_year
ORDER BY order_year;

SELECT
    `Product Name`,
    ROUND(SUM(Sales), 2) AS total_sales,
    ROUND(SUM(Profit), 2) AS total_profit
FROM orders_mysql
GROUP BY `Product Name`
ORDER BY total_profit DESC
LIMIT 10;


SELECT
    `Customer ID`,
    `Customer Name`,
    ROUND(SUM(Sales), 2) AS total_sales,
    ROUND(SUM(Profit), 2) AS total_profit
FROM orders_mysql
GROUP BY `Customer ID`, `Customer Name`
ORDER BY total_sales DESC
LIMIT 10;

SELECT
    r.Returned,
    COUNT(DISTINCT r.`Order ID`) AS returned_orders,
    ROUND(SUM(o.Sales), 2) AS total_sales,
    ROUND(SUM(o.Profit), 2) AS total_profit
FROM orders_mysql o
JOIN returns r
    ON o.`Order ID` = r.`Order ID`
GROUP BY r.Returned;



SHOW TABLES;



USE superstore_project;

SHOW TABLES;

SELECT 'Orders' AS table_name, COUNT(*) AS rows_count
FROM orders_mysql

UNION ALL

SELECT 'returns', COUNT(*)
FROM returns

UNION ALL

SELECT 'People', COUNT(*)
FROM people;


SELECT
    r.returns,
    COUNT(DISTINCT r.`Order ID`) AS returned_orders,
    ROUND(SUM(o.Sales), 2) AS total_sales,
    ROUND(SUM(o.Profit), 2) AS total_profit
FROM orders_mysql o
JOIN returns r
    ON o.`Order ID` = r.`Order ID`
GROUP BY r.Returned;
DESCRIBE returns;

SELECT
    r.`Returned`,
    COUNT(DISTINCT r.`Order ID`) AS returned_orders,
    ROUND(SUM(o.Sales), 2) AS total_sales,
    ROUND(SUM(o.Profit), 2) AS total_profit
FROM orders_mysql o
JOIN returns r
    ON o.`Order ID` = r.`Order ID`
GROUP BY r.`Returned`;
DESCRIBE returns;
SELECT
    r.`Returned`,
    COUNT(DISTINCT r.`Order ID`) AS returned_orders,
    ROUND(SUM(o.Sales), 2) AS total_sales,
    ROUND(SUM(o.Profit), 2) AS total_profit
FROM orders_mysql o
JOIN returns r
    ON o.`Order ID` = r.`Order ID`
GROUP BY r.`Returned`;

SELECT *
FROM returns
LIMIT 5;
SELECT
  returns,
    COUNT(DISTINCT `Order ID`) AS returned_orders
FROM returns
GROUP BY returns;
SHOW CREATE TABLE returns;
ALTER TABLE returns
CHANGE COLUMN `﻿Returned` `Returned` TEXT;
DESCRIBE returns;
SELECT
    r.`Returned`,
    COUNT(DISTINCT r.`Order ID`) AS returned_orders,
    ROUND(SUM(o.Sales), 2) AS total_sales,
    ROUND(SUM(o.Profit), 2) AS total_profit
FROM orders_mysql o
JOIN returns r
    ON o.`Order ID` = r.`Order ID`
GROUP BY r.`Returned`;

SELECT
    `Product Name`,
    ROUND(SUM(Sales), 2) AS total_sales,
    ROUND(SUM(Profit), 2) AS total_profit
FROM orders_mysql
GROUP BY `Product Name`
ORDER BY total_profit DESC
LIMIT 10;

SELECT
    `Product Name`,
    ROUND(SUM(Sales), 2) AS total_sales,
    ROUND(SUM(Profit), 2) AS total_profit
FROM orders_mysql
GROUP BY `Product Name`
ORDER BY total_profit ASC
LIMIT 10;

SELECT
    `Customer ID`,
    `Customer Name`,
    ROUND(SUM(Sales), 2) AS total_sales,
    ROUND(SUM(Profit), 2) AS total_profit
FROM orders_mysql
GROUP BY `Customer ID`, `Customer Name`
ORDER BY total_sales DESC
LIMIT 10;
SELECT
    DATE_FORMAT(
        STR_TO_DATE(`Order Date`, '%d-%m-%Y'),
        '%Y-%m'
    ) AS order_month,
    ROUND(SUM(Sales), 2) AS total_sales,
    ROUND(SUM(Profit), 2) AS total_profit
FROM orders_mysql
GROUP BY order_month
ORDER BY order_month;

USE superstore_project;

SHOW TABLES;

SELECT COUNT(*) AS total_rows
FROM orders_mysql;
SELECT *
FROM orders_mysql
LIMIT 5;
SELECT COUNT(*) AS total_rows
FROM orders_mysql;
SELECT
    ROUND(SUM(Sales), 2) AS total_sales,
    ROUND(SUM(Profit), 2) AS total_profit,
    SUM(Quantity) AS total_quantity,
    COUNT(DISTINCT `Order ID`) AS total_orders,
    ROUND((SUM(Profit) / SUM(Sales)) * 100, 2) AS profit_margin
FROM orders_mysql;
SELECT
    Category,
    ROUND(SUM(Sales), 2) AS total_sales,
    ROUND(SUM(Profit), 2) AS total_profit,
    ROUND((SUM(Profit) / SUM(Sales)) * 100, 2) AS profit_margin
FROM orders_mysql
GROUP BY Category
ORDER BY total_profit DESC;









