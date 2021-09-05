-- https://life-prog.ru/2_43520_ispolzovanie-virtualnih-tablits.html

-- 1) ������� ����������� �������, ������� �������� ������ ������� Product
CREATE VIEW Product_Copy AS
	SELECT * FROM shm.Product

select * from Product_Copy


-- 2) ������� ����������� �������, � ������� ����� ��������� ��� � ������� ��������
CREATE VIEW virtual_table (column1, column2) AS
	SELECT Name, Phone_number
	FROM shm.Client

select * from virtual_table


-- 3) ����� ��� ������� � ������� 88005553535
select column1 from virtual_table
	where column2 = '88005553535'


-- 4) ������� �������� ���� �������� � ������� �������
select column2 from virtual_table
	where column1 = '�������'


-- 5) ������� ����������� ������� � �� ����������� ������
CREATE VIEW Stock_Salary AS
select distinct t1.First_name, t1.Salary, t1.Employee_id 
from shm.Employee as t1 
	inner join shm.Warehouse as t2 
	on t1.Employee_id = t2.Employee_id

select * from Stock_Salary


-- 6) ������� ��� ���������� ������, � ������� �� >= 50 000
select First_name from Stock_Salary
	where Salary >= 50000


-- 7) ������� ����������� ������� Stock_Salary
drop view Stock_Salary 


-- 8) �������� ����� �������� � ����������� ������� virtual_table � 89778275567 �� 89778275566
UPDATE virtual_table SET column2 = '89778275566'
	where column2 = '89778275567'

select * from virtual_table


-- 9) ������� ����������� ������� � ������, �������� � ��������� ��������� �����������
CREATE VIEW Employee_Job AS
select t1.First_name, t1.Last_name, t2.Description
from shm.Employee as t1 
	inner join shm.Job as t2 
	on t1.Job_id = t2.Job_id

select * from Employee_Job


-- 10) ������� ��� � ������� ���� ��������
select First_name, Last_name from Employee_Job
	where Description = '������'


-- 11) 
--���������, ���������� ���� ���� ���������, ������� ���������� ������� � ����, ������� ��������� �����.
go
CREATE VIEW table_1 (Description, Sum_Cost, Num_Dish) AS
	SELECT t2.Description, sum(t4.Cost), count(t2.Description)
	FROM shm.Category as t1
		inner join shm.Product as t2
			on t1.Category_id = t2.Category_id
		inner join shm.Dish_Contains as t3
			on t2.Product_id = t3.Product_id
		inner join shm.Dish as t4
			on t3.Dish_id = t4.Dish_id
		inner join shm.Warehouse as t5
			on t5.Warehouse_id = t1.Warehouse_id
		inner join shm.Employee as t6
			on t6.Employee_id = t5.Employee_id
		full join shm.Order_Table as t7
			on t7.Employee_id = t6.Employee_id   
	where t1.Category_id = 1
	group by t2.Description
	with check option
go
select * from table_1

drop view table_1