select *
from walmartdatasales w;

alter table walmartdatasales
rename column `Invoice ID` to invoice_id,
rename column Branch to branch,
rename column City to city,
rename column `Customer type` to customer_type,
rename column Gender to gender,
rename column `Product line` to product_line,
rename column `Unit price` to unit_price,
rename column Quantity to quantity,
rename column `Tax 5%` to VAT,
rename column Total to total,
rename column Date to date,
rename column Time to time,
rename column Payment to payment_method,
rename column `gross margin percentage` to gross_margin_percentage,
rename column `gross income` to gross_income,
rename column Rating to rating;

select 
	time,
	(case
		when `time` between "00:00:00" and "12:00:00" then "Morning"
		when `time` between "12:01:00" and "16:00:00" then "Afternoon"
		else "Evening"
	end
	) as time_of_date
from walmartdatasales w;

alter table walmartdatasales add column time_of_day varchar(20);

update walmartdatasales
set time_of_day = (case
		when `time` between "00:00:00" and "12:00:00" then "Morning"
		when `time` between "12:01:00" and "16:00:00" then "Afternoon"
		else "Evening"
	end
);

select time_of_day
from walmartdatasales w;

select
	date,
	time,
	dayname(date) as day_name
from walmartdatasales w;

alter table walmartdatasales add column day_name varchar(10);

update walmartdatasales
set day_name = dayname(date);

select day_name
from walmartdatasales w;

select
	date,
	monthname(date) as month_name
from walmartdatasales w;

alter table walmartdatasales add column month_name varchar(10);

update walmartdatasales
set month_name = monthname(date);

select month_name
from walmartdatasales w;

-- How many unique cities does the data have?
select count(distinct city)
from walmartdatasales w;

-- In which city is each branch?
select distinct branch,city 
from walmartdatasales w;

-- How many unique product lines does the data have?
select count(distinct product_line)
from walmartdatasales w;

-- What is the most common payment method?
select payment_method, count(payment_method) as payment_method_count 
from walmartdatasales w
group by payment_method
order by payment_method_count desc;

-- What is the most selling product line?
select product_line , count(product_line) as most_selling_product 
from walmartdatasales w
group by product_line 
order by most_selling_product desc;

-- What is the total revenue by month?
select month_name as month, round(sum(total),2) as total_revenue
from walmartdatasales w
group by month_name
order by total_revenue desc;

-- What month had the largest cogs (Cost of Good Sold)?
select month_name as month, sum(cogs) as cogs 
from walmartdatasales w
group by month_name
order by cogs desc;

-- What product line had the largest revenue?
select product_line, round(sum(total),2) as total_revenue 
from walmartdatasales w
group by product_line
order by total_revenue desc;

-- What is the city with the largest revenue?
select branch, city, round(sum(total),2) as total_revenue 
from walmartdatasales w
group by city, branch 
order by total_revenue desc;

-- What product line had the largest VAT?
select product_line, round(avg(VAT),2) as avg_tax
from walmartdatasales w
group by product_line
order by avg_tax desc;

-- Fetch each product line and add a column to those product line showing "Good", "Bad". Good if its greater than average sales

-- Which branch sold more products than average product sold?
select branch, sum(quantity) as quantity
from walmartdatasales w
group by branch
having sum(quantity) > (select avg(quantity) from walmartdatasales w2);

-- What is the most common product line by gender?
select gender, product_line, count(gender) as count_total_gender 
from walmartdatasales w 
group by gender, product_line
order by count_total_gender desc;

-- What is the average rating of each product line?
select round(avg(rating),1) as avg_rating, product_line  
from walmartdatasales w 
group  by product_line
order by avg_rating desc;

-- Number of sales made in each time of the day per weekday
select time_of_day, count(*) as total_sales 
from walmartdatasales w
-- where day_name ="Friday"
group by time_of_day
order by total_sales desc;

-- Which of the customer types brings the most revenue?
select customer_type, round(sum(total),2)  as total_revenue 
from walmartdatasales w 
group by customer_type
order by total_revenue desc;

-- Which city has the largest tax percent/VAT(Value Added Tax)?
select city, round(avg(VAT),2)  as VAT
from walmartdatasales w 
group by city 
order by VAT desc;

-- Which customer type pays the most in VAT?
select customer_type, round(avg(VAT),2) as VAT 
from walmartdatasales w
group by customer_type
order by VAT desc;

-- How many unique customer types does the data have?
select distinct customer_type 
from walmartdatasales w;

-- How many unique payment methods does the data have?
select distinct payment_method 
from walmartdatasales w;

-- Which customer type buys the most?
select customer_type, count(*) as customer_count 
from walmartdatasales w 
group by customer_type
order by customer_count desc;

-- What is the gender of most of the customers?
select gender, count(*) as gender_count 
from walmartdatasales w
group by gender
order by gender_count desc;

-- What is the gender distribution per branch?
select gender, count(*) as gender_count 
from walmartdatasales w
where branch = "C"
group by gender
order by gender_count desc;

-- Which time of the day do customers give most ratings?
select time_of_day, round(avg(rating),2)  as average_rating
from walmartdatasales w 
group by time_of_day
order by average_rating desc;

-- Which time of the day do customers give most ratings per branch?
select time_of_day, round(avg(rating),2) as average_rating
from walmartdatasales w 
where branch = "B"
group by time_of_day
order by average_rating desc;

-- Which day of the week has the best average ratings?
select day_name, round(avg(rating),2) as average_rating
from walmartdatasales w 
group by day_name
order by average_rating desc;

-- Which day of the week has the best average ratings per branch?
select day_name , round(avg(rating),2) as average_rating
from walmartdatasales w 
where branch = "A"
group by day_name 
order by average_rating desc;







