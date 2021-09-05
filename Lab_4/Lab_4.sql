-- ������ ������� � ������� �������� 89154539855 ���������� ����� �� 3%:
INSERT INTO shm.Discond_Card VALUES(11, 3, '2019-10-16', NULL)
UPDATE shm.Client SET Card_id = 11 WHERE Phone_number = '89154539855'


-- ������� ���������, �� ��� ����� �������� ������ �������� ����, � �� ��������� ������ �������� ���� �������� ������� ������� ������
DELETE w
	FROM shm.Employee w
	INNER JOIN shm.Job e
	  ON e.Job_id = w.Job_id 
	WHERE e.Description = '��������'
UPDATE shm.Employee SET Job_id = 10, Salary = 100000 WHERE First_name = '������' and Last_name = '��������'
UPDATE shm.Employee SET Job_id = 1, Salary = 80000 WHERE First_name = '�������' and Last_name = '������'


-- ������� ����������� �������
DELETE from shm.Client WHERE Name = '�������' and Phone_number = '89857826434'


-- ������� � ������� � ��������� 89858437077 ���������� ����� 
UPDATE t1 SET Percentage = NULL, Valid_to = '2019-10-23' from 
	shm.Discond_Card as t1
	inner join shm.Client as t2
		on t1.Card_id = t2.Card_id
	where t2.Phone_number = '89858437077'
UPDATE shm.Client SET Card_id = NULL WHERE Phone_number = '89858437077'


-- ���������, ���������� �� ����� �2 
select t1.Employee_id, t1.First_name, t1.Last_name
from shm.Employee as t1
inner join shm.warehouse as t2
on t1.Employee_id = t2.Employee_id
where t2.Warehouse_id = 2


-- ��������� ��� � �������� ���������� ������� �� ����� ������� 
select t1.date as Day, sum(t1.Sum) as total 
from shm.Order_Table as t1 
	where t1.date >= '2017-01-01' and t1.date < '2019-01-10' 
	group by t1.date 
	order by total desc


-- ������� �� ����������� ������ 
select t1.Salary, t1.Employee_id 
from shm.Employee as t1 
	inner join shm.Warehouse as t2 
	on t1.Employee_id = t2.Employee_id  
	order by salary 


-- ������� ������� ������ ���������� ����
select shm.Discond_Card.Percentage, count(shm.Discond_Card.Card_id) as Num
from shm.Discond_Card
	group by Percentage
	order by Percentage


-- �������� ���� �� 2019-10-22
UPDATE shm.Menu SET Dish_id = 2 WHERE Date = '2019-10-22' and Dish_id = 3
UPDATE shm.Menu SET Dish_id = 4 WHERE Date = '2019-10-22' and Dish_id = 5
DELETE from shm.Menu WHERE Date = '2019-10-22' and Dish_id = 9


------------------------------------------------------------


select * from shm.Discond_Card
select * from shm.Client
select * from shm.Employee
select * from shm.Menu where Date = '2019-10-22'