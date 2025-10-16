--  Can we see some kind of monthly seasonality in terms of the no. of orders being placed?
select extract(month from order_purchase_timestamp) as Month ,count(*) as No_of_orders
 from orders group by extract(month from order_purchase_timestamp) 
 order by extract(month from order_purchase_timestamp) ;

-- During what time of the day, do the Brazilian customers mostly place
-- their orders? (Dawn, Morning, Afternoon or Night)
-- ■ 0-6 hrs : Dawn
-- ■ 7-12 hrs : Mornings
-- ■ 13-18 hrs : Afternoon
-- ■ 19-23 hrs : Night
 select extract(hour from order_purchase_timestamp) as hrs ,count(order_id) as no_of_orders,
case when extract(hour from order_purchase_timestamp) between 0 and 6 then 'Dawn'
when extract(hour from order_purchase_timestamp) between 7 and 12 then 'Mornings'
when extract(hour from order_purchase_timestamp) between 13 and 18 then 'Afternoon'
when extract(hour from order_purchase_timestamp) between 19 and 23 then 'Night' end as time_of_the_day 
 from orders group by hrs,time_of_the_day order by count(order_id) desc;

