USE University_1
GO
--Запрещает добавлять пары каждой конкретной группе, если так у нее получится более 6 пар в день.
IF OBJECT_ID('Restriction_0', 'TR') IS NOT NULL
 DROP TRIGGER Restriction_0
 GO

CREATE TRIGGER Restriction_0
		ON Schedule
instead of insert
AS
begin

	declare @all_the_classes table (
									[discipline_id] [int] NOT NULL,
									[scientific_officer_id] [int] NOT NULL,
									[time_start] [time](4) NOT NULL,
									[group_id] [int] NOT NULL,
									[week_day] [nchar](3) NOT NULL,
									[year] [int] NOT NULL,
									[time_end] [time](4) NOT NULL,
									[auditorium] [nchar](7) NOT NULL,
									[semester] [nchar](3) NOT NULL 
								)

	insert into @all_the_classes 
		select * from Schedule
	insert into @all_the_classes 
		select * from inserted

   

	if not exists 
			(
			select group_id from @all_the_classes
				group by group_id,week_day, [year], semester
					having count(*) > 6
			)
		begin
			insert into Schedule select * from inserted
			select 'The norm is not exceeded' as verdict
		end	
	else
		
		begin
		
		with not_allowed as 
			(
				select group_id from @all_the_classes
				group by group_id,week_day, [year], semester 
					having count(*) > 6
			)
		insert into Schedule 
		select * from inserted
		where group_id not in (select * from not_allowed)
		
		 select  'Some inserts are rejected as the daily norm for particular groups is exceeded' as verdict
		end
end

go
	
--Проверка
begin transaction	
select * from Schedule
where group_id = 3 and week_day = 'THU'
select * from Schedule
where group_id = 4 and week_day = 'THU'
insert into Schedule values 
				(12, 88, '13:55:00', 4, 'THU', 2015, '15:20:00', 404, 1),
				(12, 89, '13:55:00', 4, 'THU', 2015, '15:20:00', 404, 1),
				(12, 90, '13:55:00', 4, 'THU', 2015, '15:20:00', 404, 1),
				(12, 91, '13:55:00', 4, 'THU', 2015, '15:20:00', 404, 1),
				(12, 92, '13:55:00', 4, 'THU', 2015, '15:20:00', 404, 1),
				(12, 79, '13:55:00', 3, 'THU', 2015, '15:20:00', 404, 1),
				(12, 80, '13:55:00', 3, 'THU', 2015, '15:20:00', 404, 1),
				(12, 85, '13:55:00', 3, 'THU', 2015, '15:20:00', 404, 1),
				(12, 81, '13:55:00', 3, 'THU', 2015, '15:20:00', 404, 1),
				(12, 82, '13:55:00', 3, 'THU', 2015, '15:20:00', 404, 1),
				(12, 83, '13:55:00', 3, 'THU', 2015, '15:20:00', 404, 1),
				(12, 84, '13:55:00', 3, 'THU', 2015, '15:20:00', 404, 1)

				
				
select * from Schedule
where group_id = 3 and week_day = 'THU'
select * from Schedule
where group_id = 4 and week_day = 'THU'
ROLLBACK



select group_id,week_day, [year], semester from Schedule
group by group_id,week_day, [year], semester 
					



WITH cte AS
(
   SELECT *,
         ROW_NUMBER() OVER (PARTITION BY group_id,week_day, [year], semester  ORDER BY time_start) AS rn FROM Schedule
)
SELECT * FROM cte
WHERE rn <= 6