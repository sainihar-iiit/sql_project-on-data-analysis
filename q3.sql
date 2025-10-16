-- Evolution of E-commerce orders in the Brazil region:
-- 1. Get the month on month no. of orders placed in each state.
 select extract(year from o.order_purchase_timestamp) as year_, extract(month from o.order_purchase_timestamp) as month_,
c.customer_state as state ,count(o.order_id) as no_of_orders from orders o join customers c on o.customer_id = c.customer_id
 group by year_,month_,state order by year_,month_,state;

-- 2. How are the customers distributed across all the states?
 select customer_state , count(customer_id) from customers group by customer_state;
