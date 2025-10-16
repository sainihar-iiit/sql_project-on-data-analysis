-- Analysis based on the payments:
-- 1. Find the month on month no. of orders placed using different payment
-- types.
select * from payments;
select p.payment_type as payment_type, extract(year from o.order_purchase_timestamp) as year_ ,
extract(month from o.order_purchase_timestamp) as month_ ,
count(distinct o.order_id) as no_of_orders
from  payments p  join orders o on p.order_id = o.order_id  group by payment_type,year_,month_ ;

-- 2.  Find the no. of orders placed on the basis of the payment installments
-- that have been paid.
select payment_installments,count(distinct order_id) as no_of_orders from payments
group by payment_installments ;