# Data Analysis using SQL
## Impact on Economy: Analyze the money movement by e-commerce by looking
## at order prices, freight and others.
### 1. Get the % increase in the cost of orders from year 2017 to 2018
### (include months between Jan to Aug only).
``` sql
with cte as(
select extract(year from order_purchase_timestamp) as year_,
sum(p.payment_value) as total_payment 
from orders o join payments p on o.order_id = p.order_id  where extract(month from order_purchase_timestamp) between 1 and 8 
group by year_ order by year_),
	  cte2 as(
select * ,lag(total_payment) over(order by year_) as prev_year_payment from cte 
)
select *,(total_payment-prev_year_payment)/total_payment * 100 as percent_changed 
from cte2 where prev_year_payment is not null;
```
## Analysis based on sales, freight and delivery time.
 ### 2)Find the no. of days taken to deliver each order from the order’s
### purchase date as delivery time.
### Also, calculate the difference (in days) between the estimated & actual
### delivery date of an order.
### Do this in a single query.
``` sql
 select order_id,customer_id,
 datediff(date(order_delivered_customer_date),date (order_purchase_timestamp)) as delivery_time,
datediff(date(order_delivered_customer_date),date(order_estimated_delivery_date))as expected_delivery_time 
from orders;
```


### 3)Find out the top 5 states where the order delivery is really fast as
### compared to the estimated date of delivery
``` sql
with cte as (
 select c.customer_state,
 datediff(date(o.order_delivered_customer_date),date (o.order_purchase_timestamp)) as delivery_time,
datediff(date(o.order_delivered_customer_date),date(o.order_estimated_delivery_date))as expected_delivery_time
from orders o join customers c on o.customer_id = c.customer_id
)
select customer_state,sum((delivery_time-expected_delivery_time)) as no_of_days_saved from cte group by c.customer_state order by no_of_days_saved desc limit 5 ;
```

### 4)Find the month on month no. of orders placed using different payment
types.
``` sql
select p.payment_type as payment_type, extract(year from o.order_purchase_timestamp) as year_ ,
extract(month from o.order_purchase_timestamp) as month_ ,
count(distinct o.order_id) as no_of_orders
from  payments p  join orders o on p.order_id = o.order_id  group by payment_type,year_,month_ ;
```
### 5)  During what time of the day, do the Brazilian customers mostly place
### their orders? (Dawn, Morning, Afternoon or Night)
###  ■ 0-6 hrs : Dawn
###  ■ 7-12 hrs : Mornings
###  ■ 13-18 hrs : Afternoon
###  ■ 19-23 hrs : Night
``` sql
 select extract(hour from order_purchase_timestamp) as hrs ,count(order_id) as no_of_orders,
case when extract(hour from order_purchase_timestamp) between 0 and 6 then 'Dawn'
when extract(hour from order_purchase_timestamp) between 7 and 12 then 'Mornings'
when extract(hour from order_purchase_timestamp) between 13 and 18 then 'Afternoon'
when extract(hour from order_purchase_timestamp) between 19 and 23 then 'Night' end as time_of_the_day 
 from orders group by hrs,time_of_the_day order by count(order_id) desc;
```
