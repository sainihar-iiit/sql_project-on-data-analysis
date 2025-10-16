
-- 1)Get the time range between in which orders placed
select min(order_purchase_timestamp) as initial_order, max(order_purchase_timestamp) as lastorder from orders;

-- 2)Count the cities and states of person who ordered during the period 2017-08 and 2017-10
 select customers.customer_state, customers.customer_city ,count(*) as no_of_persons
 from orders join customers on orders.customer_id = customers.customer_id 
 where extract(year from orders.order_purchase_timestamp) = 2017 
 and extract(month from orders.order_purchase_timestamp)between 8 and 10 
 group by customers.customer_state,customers.customer_city order by no_of_persons desc limit 10;
 
--  3)Is there a growing trend in the no. of orders placed over the past years?
 select extract(year from order_purchase_timestamp) as year ,count(*) as no_of_orders 
from orders group by  extract(year from order_purchase_timestamp) order by year;