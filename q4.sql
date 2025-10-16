--  Impact on Economy: Analyze the money movement by e-commerce by looking
-- at order prices, freight and others.
-- 1. Get the % increase in the cost of orders from year 2017 to 2018
-- (include months between Jan to Aug only).
select * from order_items;
select * from orders;
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
select * from order_items;
select * from customers;
-- Calculate the Total & Average value of order price for each state
select c.customer_state, sum(oi.price) as total_value,avg(oi.price) as total_avg from order_items oi join orders o on oi.order_id = o.order_id
join customers c on o.customer_id = c.customer_id group by c.customer_state;

-- Calculate the Total & Average value of order freight for each state.
select c.customer_state, sum(oi.freight_value) as total_value,avg(oi.freight_value) as total_avg from order_items oi join orders o on oi.order_id = o.order_id
join customers c on o.customer_id = c.customer_id group by c.customer_state;