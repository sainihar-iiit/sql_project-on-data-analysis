-- Analysis based on sales, freight and delivery time.
-- 1. Find the no. of days taken to deliver each order from the order’s
-- purchase date as delivery time.
-- Also, calculate the difference (in days) between the estimated & actual
-- delivery date of an order.
-- Do this in a single query.
select * from orders;
 select order_id,customer_id,
 datediff(date(order_delivered_customer_date),date (order_purchase_timestamp)) as delivery_time,
datediff(date(order_delivered_customer_date),date(order_estimated_delivery_date))as expected_delivery_time 
from orders limit 10; 

-- Find out the top 4 states with the highest & lowest average freight
-- value.
select c.customer_state 
from order_items oi join orders o on oi.order_id = o.order_id
join customers c on o.customer_id = c.customer_id order by oi.freight_value desc limit 4 ;

select c.customer_state 
from order_items oi join orders o on oi.order_id = o.order_id
join customers c on o.customer_id = c.customer_id order by oi.freight_value limit 4;

-- Find out the top 5 states with the highest & lowest average delivery
-- time
select c.customer_state, avg(datediff(date(order_delivered_customer_date),date (order_purchase_timestamp))) as avg_delivery_time
from orders o join customers c on o.customer_id = c.customer_id group by c.customer_state 
order by avg_delivery_time desc limit 5;

select c.customer_state, avg(datediff(date(order_delivered_customer_date),date (order_purchase_timestamp))) as avg_delivery_time
from orders o join customers c on o.customer_id = c.customer_id group by c.customer_state 
order by avg_delivery_time limit 5;

--  Find out the top 5 states where the order delivery is really fast as
-- compared to the estimated date of delivery
with cte as (
 select c.customer_state,
 datediff(date(o.order_delivered_customer_date),date (o.order_purchase_timestamp)) as delivery_time,
datediff(date(o.order_delivered_customer_date),date(o.order_estimated_delivery_date))as expected_delivery_time
from orders o join customers c on o.customer_id = c.customer_id
)
select customer_state,sum((delivery_time-expected_delivery_time)) as no_of_days_saved from cte group by c.customer_state order by no_of_days_saved desc limit 5 ;

with cte as (
 select c.customer_state,
 datediff(date(o.order_delivered_customer_date),date (o.order_purchase_timestamp)) as delivery_time,
datediff(date(o.order_delivered_customer_date),date(o.order_estimated_delivery_date))as expected_delivery_time
from orders o join customers c on o.customer_id = c.customer_id
)
select customer_state,sum((delivery_time-expected_delivery_time)) as no_of_days_saved from cte group by c.customer_state order by no_of_days_saved limit 5 ;



