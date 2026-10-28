
use [Project 1 superstore]
--Sales per Category with % of total.
select Category,ROUND(SUM(Sales), 2) AS Total_Sales, 
concat(ROUND(SUM(Sales) * 100.0 / SUM(SUM(Sales)) OVER (), 1),'%') AS Sales_Pct
from [Fact Superstore]
group by Category


--Per Region: total sales, number of orders, and average order value
select region ,round(sum(sales),2) , count(distinct order_id) as Numb_of_orders , 
round(sum(sales) / count(distinct order_id) ,2) Avg_order_value
from [Fact Superstore]
group by region
--Top 10 customers by sales, with their Segment.
select top 10 customer_id, customer_name, segment, round(sum(sales),2) as Total_sales
from [Fact Superstore]
group by customer_id, customer_name, segment
order by total_sales desc

--Per Ship Mode: average shipping days, and % of orders that took more than 5 days.
with cte as (select ship_mode,count(distinct order_id) as [Total Orders],
avg (datediff(day,Order_Date,Ship_Date)) as [avg ship duration],
count (distinct case when datediff(day,Order_Date,Ship_Date) > 5 then order_id end ) as late 
from [Fact Superstore]
group by ship_mode
)
select ship_mode ,[Total Orders],[avg ship duration], late ,
concat(late * 100 / [Total Orders], '%') as pct
from cte


--yearly growth
--Return Year, Total_Sales, Growth_Pct vs the previous year 2015 has no previous year, so its growth is NULL
with cte as(
select  year( order_Date) year, round(sum(sales),2)total_sales ,LAG(round(sum(sales),2)) 
over(order by year( order_Date))as previous_year
from [Fact Superstore]
group by  year( order_Date))

select year, total_sales ,previous_year,concat(
round ((total_sales -previous_year)*100.0 /previous_year,2),
'%') as Growth_Pct
from cte 



--top 3 Sub-Categories per Category
with cte as(
select Category,Sub_Category ,row_number()over(partition by category order by sum(sales)desc) as ranking , 
round(sum(sales),2) as total_sales 
from [Fact Superstore]
group by Category,Sub_Category
)
select * from cte
where ranking <=3



--monthly running total

select year(order_date) years,month(order_date) AS Month ,round( sum(sales),2)  Monthly_Sales,  
round(sum(sum(sales)) over(partition by year(order_date) order by month(order_date)),2) as Running_Total
from [Fact Superstore]
group by  year(order_date),month(order_date)
order by year(order_date),month(order_date)


--loyal customers
--customers who ordered in all 4 years Return how many there are, and their % of total sales
with cte as(
select customer_id 
from [Fact Superstore]
where customer_id in (select  Customer_ID
    from [Fact Superstore]
    group by Customer_ID
    having count(distinct year(Order_Date)) >= 4)
    )
select count(distinct Customer_ID) Total_count,
round(sum(sales),2) AS Total_sales,
concat
(round (sum(sales) * 100 / (select sum(sales) from [Fact Superstore]) ,2),'%') AS PCT_Total_sales
from [Fact Superstore]
where Customer_ID in(select Customer_ID from cte)


--comparisons
--States whose sales are above the average state sales.
select state ,sum(sales) AS state_sales
from [Fact Superstore]
group by state
having sum(sales) > (select avg(total_state) from (select sum(sales) as total_state
from [Fact Superstore] group by state) x )

--Customers who bought in 2017 but never in 2018 (NOT EXISTS).
select distinct s.customer_id ,s.customer_name
from [Fact Superstore] s
where year(order_date) ='2017' and not exists 
(select  1 from [Fact Superstore] c where year(order_date) ='2018' 
and s.customer_id = c.Customer_ID)

--Products sold in all 4 Regions.
select  product_name ,count(distinct region) as region_sold
from [Fact Superstore]
group by product_name
having count(distinct region) >= 4
