---
Create table retail_sales(
      transactions_id int primary key,
	  sale_date date, -- It should be in YYYY-MM--DD
	  sale_time time,  -- It should be in hh:mm:ss
	  customer_id int,
	  gender varchar(10),
	  age int,
	  category varchar(15),
	  quantiy int,
	  price_per_unit float,
	  cogs float,
	  total_sale int

);

Select count(*) from retail_sales;
Select * from retail_sales;

-- Data Cleaning

-- Deleting those rows from the table where value is null

Delete from retail_sales
where transactions_id is null
or
sale_date is null
or
sale_time is null
or customer_id is null
or gender is null
or age is null
or category is null 
or
quantiy is null
or price_per_unit is null
or cogs is null
or total_sale is null;


-- Data anaysis and business problems

-- -> Write a sql query to retrieve all columns for sales made on 2022-11-05.

Select * from retail_sales
where sale_date = '2022-11-05';

-- -> Write a sql query to retrive all traxs where category = clothing & qty>10 in month of Nov 2022.

Select transactions_id from retail_sales
where category='Clothing' 
and sale_date between '2022-11-01' and '2022-11-30'
and quantiy>=4;

-- -> Write a sql to calculate the total sales for each category.

Select category, sum(total_sale) from retail_sales
group by category;

-- -> Write a sql query to find the average age of customers who purchased items from the beauty category.

Select category, Round(avg(age),2) from retail_sales
where category = 'Beauty'
group by category;

-- -> Write a sql query to find all transactions where total sale is greater than 1000.

Select transactions_id from retail_sales
where total_sale > 1000;

-- -> Write a sql query to find the total number of transactions made by each gender to each category.

Select count(transactions_id), gender, category  from retail_sales
group by gender, category;

-- -> Write a sql query to calculate the average sale for each month. Also, find out best selling month in each year.
Select * from (Select month, year, rank()over(partition by year order by avg_sale desc ) as ranke from(
Select Round(avg(total_sale),2) as avg_sale, Extract('Month'from sale_date) as month, Extract('Year'from sale_date) as year from retail_sales
group by month,year
)as t1 ) as t2 where ranke =1;

-- order by avg_sale desc limit 2; agar rank na use karo to isse bhi nikal sakte ho.

-- -> Write a sql query to find the top 5 customers based on the highest total sales.

Select customer_id, sum(total_sale) as total_sales from retail_sales
group by customer_id
order by total_sales desc limit 5;

-- -> Write a sql query to find the no. of unique customers who purchased items from each category.

Select count(distinct customer_id) as unique_customers, category from retail_sales
group by category;

-- -> Write a sql query to create each shift and number of orders.

Select count(transactions_id),
Case 
when extract(hour from sale_time) < 12 then 'Morning'
when extract(hour from sale_time) between 12 and 17 then 'Afternoon'
else 'Evening'
end as shift
from retail_sales
group by shift;

-- END OF THE PROJECT --
