-- 1) Триггер меняет значения в таблицу Salary после изменения в таблице Employee
DROP TRIGGER shm.My_Trigger

UPDATE shm.Employee SET Salary = 100000 where Employee_id = 2
UPDATE shm.Salary SET Sum_Salary = 100000 where Job_id = 10

go
CREATE TRIGGER shm.My_Trigger
on shm.Employee after update as
begin
	declare @row int, @now int
	set @row = (select max(Job_id) from shm.Employee)
	set @now = 1
	
	while @now <= @row
	begin
		update shm.Salary
		set Sum_Salary = (select sum(t.Salary) from shm.Employee as t
							where t.Job_id = @now
							group by t.Job_id) where Job_id = @now
		set @now = @now + 1
	end
end

select * from shm.Employee
select * from shm.Salary

UPDATE shm.Employee SET Salary = 110000 where Employee_id = 2




DROP TRIGGER shm.My_Trigger_1

go
CREATE TRIGGER shm.My_Trigger_1
on shm.Employee after update as
begin
	update shm.Salary 
	set Sum_Salary = 
end