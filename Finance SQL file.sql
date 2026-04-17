CREATE DATABASE finance;
USE finance;

-- Total Orders-- 
SELECT COUNT(*) AS Total_Orders
FROM orders;
 
 
 -- Total Revenue , Cost ,Profit--
 SELECT 
        COUNT(*) as Total_Orders,
        SUM(Revenue) as Total_Revenue,
		SUM(Cost)  as Total_Cost,
        SUM(Profit) as Total_Profit,
        SUM(Shipping_Cost) as Total_Shipping_cost,
        SUM(Revenue) / COUNT(*) as Avg_order_value,
        (SUM(Profit) / SUM(Revenue)) * 100 as Profit_Margin
        FROM orders;



-- Average Order Value -- 

SELECT SUM(Revenue) / COUNT(*) AS Avg_order_value 
FROM orders ;
	
    
-- TIME ANALYSIS 

SELECT Month , SUM(Revenue) as Revenue
FROM orders
GROUP BY month
ORDER BY Month;


SELECT 
       YEAR ,
       MONTH,
       SUM(Revenue) as Revenue,
       SUM(Profit) as Profit
FROM Orders
GROUP BY Year , Month 
ORDER BY Year , Month ;


-- Quarterly Profit-- 

SELECT Quarter , SUM(Profit) as Profit
FROM orders
GROUP BY Quarter ;




-- Yearly Performance --

SELECT Year ,
SUM(Revenue) as Revenue,
SUM(Profit) as Profit
FROM orders
GROUP BY Year ;  


-- REGION WISE REVENUE & PROFIT

SELECT Region ,
               SUM(Revenue) as Revenue,
			   SUM(Profit) as Profit
FROM orders
GROUP BY Region
ORDER BY Revenue DESC ;



 -- TOP COUNTRY BY PROFIT
 
 SELECT Country ,
		SUM(Profit) as Profit
FROM orders
GROUP BY Country 
ORDER BY Profit DESC
LIMIT 10 ;


-- CATEGORY WISE PERFORMANCE

SELECT Category ,
        SUM(Revenue) as Revenue,
		SUM(Profit) as Profit,
        (SUM(Profit) / SUM(Revenue)) * 100 as Profit_Margin 
FROM orders
GROUP BY Category ;



-- SUB - Category Profit

SELECT Sub_Category,
       SUM(Profit) as Profit
FROM orders
GROUP BY Sub_Category
ORDER BY Profit DESC 
LIMIT 10 ;


 -- TOP 10 PRODUCT BY REVENUE
 
 SELECT ProductName,
		SUM(Revenue) as Revenue,
        SUM(Profit) as Profit
FROM orders
GROUP BY ProductName
ORDER BY Revenue DESC
LIMIT 10 ;



--  Loss Making Products-- 
SELECT ProductName,
       SUM(Profit) as Profit,
       SUM(Cost) as Cost,
       SUM(Profit) as Profit
FROM orders
GROUP BY ProductName
HAVING Profit < 0 
ORDER BY Profit ;


-- Loss by Category
 
SELECT Category ,
       SUM(Profit) as Profit
FROM orders
GROUP BY Category 
HAVING Profit < 0 ;


-- Discount vs Profit

SELECT Discount ,
       AVG(Profit) as Avg_Profit,
       AVG(Revenue) as Avg_Revenue
FROM orders
GROUP BY Discount 
ORDER BY Discount ;



-- High Discount Orders

SELECT * FROM orders
WHERE Discount > 0.30 ;


--  Shipping cost vs profit

SELECT Shipping_Method,
	   AVG(Shipping_Days) as Avg_Delivery_Days,
       SUM(Profit) as Profit
FROM orders
GROUP BY Shipping_Method ;



--  Delivery Efficiency --

SELECT Shipping_Method,
       AVG(Shipping_Days) as Avg_Delivery_Days
FROM orders
GROUP BY Shipping_Method ;




-- CUSTOMER SEGMENT Performance

SELECT Segment ,
       SUM(Revenue) as Revenue,
       SUM(Profit) as Profit
FROM orders
GROUP BY Segment ;




-- Gender Wise Profit

SELECT Gender ,
       SUM(Profit) as Profit
FROM orders
GROUP BY Gender ;

-- Order Status Distribution

SELECT Order_Status,
       COUNT(Revenue) as Total_Orders
FROM orders
GROUP BY Order_Status ;



-- REVENUE LOSS DUE TO RETURNS  
SELECT Order_Status,
	   SUM(Revenue) as Revenue
FROM orders
WHERE Order_Status IN ("Returned", "Cancelled")
GROUP BY Order_Status ;
 

-- TOP 3 PRODUCTS PER CATEGORY  
SELECT * 
FROM (
	SELECT Category ,
		   ProductName,
           SUM(Profit) as Profit,
           RANK() OVER (PARTITION BY Category ORDER BY SUM(Profit) DESC ) AS Rankk
           FROM orders
           GROUP BY Category , ProductName
           ) t
           WHERE Rankk <= 3 ;
           


-- RUNNING TOTAL REVENUE

SELECT OrderDate,
       SUM(Revenue)  OVER (ORDER BY OrderDate) as Running_Revenue
FROM orders ;


-- Profit Margin

SELECT Category ,
	   (SUM(Profit) / SUM(Revenue)) * 100 as Profit_Margin
FROM orders
GROUP BY Category ;
           
           


--
 SELECT Shipping_Method,
		AVG(Shipping_Cost) as avg_shiping_cost,
        AVG(Shipping_Days) as Avg_Days,
        SUM(Profit) as Profit
FROM orders
GROUP BY Shipping_Method ;

           
 
