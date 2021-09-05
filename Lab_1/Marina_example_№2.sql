--1) ¬ыбрать цены на сегодн€шний день всех продуктов, в названии которых есть слова 'WIFF SOFTBALL'.

select list_price,description from PRICE
			join PRODUCT on price.product_id = product.product_id
where description like '%WIFF SOFTBALL%' and end_date is null

--2) ¬ыбрать названи€ и города отделов в которых есть аналитики, и их количество (должность - 'ANALYST')
select name,regional_group,count(last_name) as quantity from EMPLOYEE
	join JOB on EMPLOYEE.job_id = JOB.job_id
	join DEPARTMENT on employee.department_id = DEPARTMENT.department_id
	right join LOCATION on DEPARTMENT.location_id = LOCATION.location_id
	
where JOB.[function] = 'ANALYST' 
group by name,regional_group
 
--3) ¬ыбрать названи€ и города тех отделов, в которых есть сотрудники, не €вл€ющиес€ продавцами (должность - не 'SALESPERSON'), но получающие комиссионные
select concat(name,' ', regional_group) as name_of_department_and_city from EMPLOYEE
							join JOB on EMPLOYEE.job_id = JOB.job_id
							join DEPARTMENT on employee.department_id = DEPARTMENT.department_id
							join LOCATION on DEPARTMENT.location_id = LOCATION.location_id
where job.[function] != 'SALESPERSON' and EMPLOYEE.commission is not null and EMPLOYEE.commission > 0

select commission from EMPLOYEE

--4) ¬ыбрать минимальную сумму продаж, котора€ приходитс€ на одного сотрудника, работающего в городе 'NEW YORK'.
with summ as 
	(select sum(SALES_ORDER.Total) as one_employee_sum from SALES_ORDER
		join CUSTOMER on SALES_ORDER.customer_id = CUSTOMER.customer_id
		join EMPLOYEE on CUSTOMER.salesperson_id = EMPLOYEE.employee_id
		join DEPARTMENT on EMPLOYEE.department_id = DEPARTMENT.department_id
		join LOCATION on DEPARTMENT.location_id = LOCATION.location_id
	where regional_group = 'NEW YORK'
	group by employee_id)
select one_employee_sum from summ
where one_employee_sum = (select min(one_employee_sum) from summ)
--HAVING LOCATION.regional_group = 'NEW YORK'





select price.start_date, price.end_date, product.description, price.list_price from price
join PRODUCT on product.product_id = price.product_id
where start_date like '%1989%'

select EMPLOYEE.employee_id, job.[function] from EMPLOYEE, JOB
where employee.employee_id like '%1%'
