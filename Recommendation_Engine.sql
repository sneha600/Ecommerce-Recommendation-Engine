CREATE DATABASE Recommendation_Engine;
USE Recommendation_Engine;
SELECT top 1 * from products_data
SELECT top 1 * from orders_data
SELECT top 1 * from user_data

--Based On Category
with Required_data 
as
(
SELECT A.*,B.category from orders_data as A
Inner join
products_data as B
on A.product_id=B.product_id) 


select C.customer_id,D.product_id from Required_data as C
inner join
products_data as D
on C.category=D.category
where C.product_id!=D.product_id


--Based on price
select A.customer_id,B.product_id from orders_data as A
inner join
products_data as B
on A.amount_paid>=B.price
where A.product_id!=B.product_id


--based on price segment
with segment_data as(
select *,
case 
when price<=40 then 'low'
when price<=90 then 'medium'
when price<=150 then 'high'
else 'premium'
end as prod_price_seg
from products_data as A ),

segment2_data as (
select *,
case 
when amount_paid<=40 then 'low'
when amount_paid<=90 then 'medium'
when amount_paid<=150 then 'high'
else 'premium'
end as prod_price_seg
from orders_data as A)
select B.customer_id,A.product_id from segment_data as A
inner join
segment2_data as B
on A.prod_price_seg=B.prod_price_seg
where A.product_id!=B.product_id