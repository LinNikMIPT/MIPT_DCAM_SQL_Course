-- Вариант №29

-- 1) Выбрать среднюю зарплату + комиссионные всех работников. like - для 4ой лабы
select cast(avg(salary + isnull(commission,0)) as money)  as avg_sal from EMPLOYEE

-- 2) Выбрать название продукта, который в 1989 г. продавался с наибольшими скидками.
select PRODUCT.description from PRODUCT
	INNER JOIN PRICE 
		on PRODUCT.product_id = PRICE.product_id
	inner join ITEM
		on ITEM.product_id = PRODUCT.product_id
	inner join SALES_ORDER
		on SALES_ORDER.order_id = ITEM.order_id
	cross join 
		(
			select max(PRICE.list_price - ITEM.actual_price) as max_discount
			from price, item
			where item.product_id = price.product_id
		) as t1
		
	where SALES_ORDER.order_date >= '1989-01-01'
		and SALES_ORDER.order_date < '1990-01-01'
		and (price.list_price - item.actual_price) = max_discount
	GROUP BY PRODUCT.description

-- 3) Выбрать менеджера, в отделе которого суммарная стоимость продаж за 1990 г. максимальна.
select manager_id
from	
	(
	select manager_id, department_id, sum(total) as total_sum
	from EMPLOYEE
		inner join customer 
			on EMPLOYEE.employee_id = CUSTOMER.salesperson_id
		inner join SALES_ORDER 
			on SALES_ORDER.customer_id = CUSTOMER.customer_id
	where SALES_ORDER.order_date >= '1990-01-01'
		and SALES_ORDER.order_date < '1991-01-01'
	group by department_id, manager_id
	) as t11
where total_sum = (
	select max(total_sum) from 
		(select manager_id, department_id, sum(total) as total_sum 
		from EMPLOYEE
			inner join customer 
				on EMPLOYEE.employee_id = CUSTOMER.salesperson_id
			inner join SALES_ORDER 
				on SALES_ORDER.customer_id = CUSTOMER.customer_id
		where SALES_ORDER.order_date >= '1990-01-01'
			and SALES_ORDER.order_date < '1991-01-01'
		group by department_id, manager_id) 
		as t12) 

-- 4) Выбрать список продуктов, цены на которые в 1988г. менялись не менее 2 раз.
select isnull(description,'таких нет') as description
from
(
	select description, count(description) as num_of_price_changes
	from product
		inner join price
			on price.product_id = PRODUCT.product_id
	where end_date < '1989-01-01'
		and end_date >= '1988-01-01'
	group by description
	having count(description) >=2
) as t228

-- это НАГЛЯДНО показывает, что таких товаров нет:
select description, start_date, end_date, count(description) as num_of_price_changes
from product
	inner join price
		on price.product_id = PRODUCT.product_id
group by description, start_date, end_date
order by description

-- здесь показано, у каких товаров меняется цена более двух раз за 1989-1990 гг:
select description
from
(
	select description, count(description) as num_of_price_changes
	from product
		inner join price
			on price.product_id = PRODUCT.product_id
	where end_date < '1991-01-01'
		and end_date >= '1989-01-01'
	group by description
	having count(description) >=2
) as t22