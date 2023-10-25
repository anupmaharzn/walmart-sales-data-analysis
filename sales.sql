SELECT * FROM sales;

-----------------------feature engineering--------------------------------
--creating new column time_of_day based on sale_time
SELECT sale_time,
  (CASE
     WHEN sale_time BETWEEN '00:00:00' AND '12:00:00' THEN 'Morning'
     WHEN sale_time BETWEEN '12:01:00' AND '16:00:00' THEN 'Afternoon'
     ELSE 'Evening'
   END) as time_of_day
FROM sales;
--adding new column time_of_day
ALTER TABLE sales
ADD time_of_day VARCHAR(20);

--updating sales table 
UPDATE sales
SET time_of_day = (  
     CASE
     WHEN sale_time BETWEEN '00:00:00' AND '12:00:00' THEN 'Morning'
     WHEN sale_time BETWEEN '12:01:00' AND '16:00:00' THEN 'Afternoon'
     ELSE 'Evening'
   END
 );

--creating new column day_name based on sale_date

SELECT sale_date, To_Char(sale_date,'Day' )AS day_name FROM sales;

ALTER TABLE sales ADD day_name VARCHAR(20); 

SELECT * FROM sales;

UPDATE sales SET day_name = (
 To_Char(sale_date,'Day' )
);

--creating new column month_name based on sale_date

SELECT sale_date, To_Char(sale_date,'Month') AS month_name FROM sales;

ALTER TABLE sales ADD month_name VARCHAR(20);

UPDATE sales SET month_name = (
    To_Char(sale_date,'Month')
);

SELECT * FROM sales;
------------------------------------------------------------------------

----Business Question to Answer ----

 --generic---


 --How many unique cities does the data have?

 SELECT DISTINCT city FROM sales;


 --In which city is each branch?

SELECT DISTINCT city, branch FROM sales;

 ---product---

--How many unique product lines does the data have?

SELECT Count (DISTINCT product_line) FROM sales;


--What is the most common payment method?
 SELECT payment,Count(payment) AS count FROM sales GROUP BY payment ORDER BY Count desc;


--What is the most selling product line?

SELECT product_line,Count(product_line)AS product_count FROM sales GROUP BY product_line ORDER BY product_count DESC FETCH first 1 ROW ONLY   ;
                                                                         
--What is the total revenue by month?

SELECT month_name AS MONTH,Sum(total) AS total_revenue FROM sales GROUP BY month_name ORDER BY  total_revenue DESC   ;


--What month had the largest COGS?

SELECT month_name,Sum (cogs) AS cogs FROM sales GROUP BY month_name ORDER BY cogs DESC  ;


--What product line had the largest revenue?

SELECT product_line,Sum(total) AS total_revenue FROM sales GROUP BY product_line ORDER BY total_revenue DESC FETCH first 1 ROW ONLY  ;

--What is the city with the largest revenue?

SELECT city,branch,Sum(total) AS total_revenue FROM sales GROUP BY city,branch ORDER BY total_revenue DESC ;

--What product line had the largest VAT?

SELECT product_line,Avg(vat) AS avg_tax
FROM sales
GROUP BY product_line
ORDER BY avg_tax DESC ;


--Fetch each product line and add a column to those product line showing "Good", "Bad".Good if its greater than average sales
WITH product_cte AS 
(
SELECT product_line,Avg(total) AS each_avg,(SELECT avg(total) FROM sales) AS avg_sal
FROM sales GROUP BY product_line 
)
SELECT
 product_line,
 each_avg,
 avg_sal,
  (CASE WHEN each_avg > avg_sal THEN 'good'
     ELSE 'bad'
END) AS  mark 
FROM product_cte;

 --Which branch sold more products than average product sold?
SELECT branch,
       COUNT(quantity) AS qty_cnt,
       sum(quantity) AS total_product_sold ,
       Avg(quantity) AS avg_product_sold
FROM sales
GROUP BY branch
HAVING avg(quantity) > (SELECT AVG(quantity) FROM sales);


--What is the most common product line by gender?

SELECT product_line ,gender,Count(gender) AS total_cnt 
FROM sales 
GROUP BY product_line,gender  
ORDER  BY total_cnt DESC ;

--What is the average rating of each product line?

SELECT product_line,Trunc(Avg(rating),2) AS avg_rating FROM sales GROUP BY product_line ORDER BY avg_rating DESC ;

-----------sales----------------


--Number of sales made in each time of the day per weekday
   SELECT time_of_day,Count(*) AS total_sales
     FROM sales
     WHERE day_name = 'Monday'
     GROUP BY time_of_day
     ORDER BY total_sales DESC ;

--Which of the customer types brings the most revenue?

SELECT customer_type,Sum(total) AS total_revenue FROM sales GROUP BY customer_type ORDER BY total_revenue DESC FETCH first 1 ROW only;

--Which city has the largest tax percent/ VAT (Value Added Tax)?

 SELECT city,vat FROM sales WHERE vat = (SELECT Max(vat) FROM sales);

 SELECT city,Avg(vat) AS vat FROM sales GROUP BY city ORDER BY vat DESC ;

--Which customer type pays the most in VAT?
SELECT customer_type ,Avg(vat) AS vat
FROM sales
GROUP BY customer_type ORDER BY vat DESC FETCH first 1 ROW ONLY;


-----------sales----------------
--Number of sales made in each time of the day per weekday
   SELECT time_of_day,Count(*) AS total_sales
     FROM sales
     WHERE day_name = 'Monday'
     GROUP BY time_of_day
     ORDER BY total_sales DESC ;

--Which of the customer types brings the most revenue?

SELECT customer_type,Sum(total) AS total_revenue FROM sales GROUP BY customer_type ORDER BY total_revenue DESC FETCH first 1 ROW only;

--Which city has the largest tax percent/ VAT (Value Added Tax)?

 SELECT city,vat FROM sales WHERE vat = (SELECT Max(vat) FROM sales);

 SELECT city,Avg(vat) AS vat FROM sales GROUP BY city ORDER BY vat DESC ;

--Which customer type pays the most in VAT?
SELECT customer_type ,Avg(vat) AS vat
FROM sales
GROUP BY customer_type ORDER BY vat DESC FETCH first 1 ROW ONLY;


--------customer----------

--How many unique customer types does the data have?

SELECT DISTINCT customer_type FROM sales;


 --How many unique payment methods does the data have?

 SELECT DISTINCT payment AS payment_method FROM sales;


--What is the most common customer type?

 SELECT customer_type,Count(customer_type)AS customer_count FROM sales GROUP BY customer_type ORDER BY customer_count DESC ;

--Which customer type buys the most?

SELECT customer_type,Count(total)AS buy_count FROM sales GROUP BY customer_type;

-- What is the gender of most of the customers?

SELECT customer_type,gender,Count(gender) AS count FROM sales GROUP BY customer_type,gender ORDER BY customer_type;

SELECT gender , Count(gender) AS gender_count FROM sales GROUP BY gender ORDER BY gender_count;

--What is the gender distribution per branch?

SELECT branch,gender,Count(gender) AS gender_count FROM sales GROUP BY branch,gender ORDER BY branch ;

--or one branch at a time
SELECT gender ,Count(gender) AS gender_count FROM sales WHERE branch='A' GROUP BY gender ORDER BY gender_count DESC;


--Which time of the day do customers give most ratings?

SELECT time_of_day,Count(rating) AS rating FROM sales GROUP BY time_of_day ORDER BY rating desc;

--Which time of the day do customers give most ratings per branch?

SELECT time_of_day,Count(rating) AS rating FROM sales WHERE branch='A' GROUP BY time_of_day ORDER BY rating desc;

--Which day fo the week has the best avg ratings?

SELECT day_name,Avg(rating) AS avg_rating FROM sales GROUP BY day_name ORDER BY avg_rating DESC ;

--Which day of the week has the best average ratings per branch?
SELECT day_name,Avg(rating) AS avg_rating FROM sales WHERE branch='C' GROUP BY day_name ORDER BY avg_rating DESC ;



