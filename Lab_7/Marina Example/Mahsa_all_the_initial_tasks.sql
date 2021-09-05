USE University
GO
--создание/удаление новых user и login 
IF EXISTS 
    (SELECT name FROM sys.database_principals WHERE name = 'TEST3') 
BEGIN
    DROP USER TEST3
END

IF EXISTS 
    (SELECT name FROM sys.server_principals WHERE name = 'TEST3') 
BEGIN
    DROP LOGIN TEST3
END

CREATE LOGIN TEST3 WITH PASSWORD = '314159'
CREATE USER TEST3 FOR LOGIN TEST3

--проверим, какие действия может выполнять user TEST3
EXECUTE AS USER = 'TEST3';

SELECT * FROM Laboratory; -- не может читать из таблицы

SELECT citation_index  FROM Scientific_officer; 

SELECT * FROM Scientific_officer
UPDATE Scientific_officer
	SET citation_index = citation_index + 1
	WHERE scientific_officer_id = 2; --не может обновлять

INSERT INTO Laboratory VALUES ('Генная инженерия', 'биофизика', 12); --не может вставлять
DELETE FROM Laboratory
	WHERE Laboratory.lab_name = 'Генная инженерия' --не может удалять

REVERT

--Присвоить новому пользователю права SELECT, INSERT, UPDATE в полном объеме на одну таблицу

GRANT INSERT, SELECT, UPDATE, DELETE ON Scientific_officer TO TEST3;
GRANT INSERT, SELECT, UPDATE, DELETE ON Laboratory TO TEST3;
EXECUTE AS USER = 'TEST3';
SELECT * FROM Scientific_officer
UPDATE Scientific_officer
	SET citation_index = citation_index + 1
	WHERE scientific_officer_id = 2; --может обновлять

INSERT INTO Laboratory VALUES ('Генная инженерия', 'биофизика', 12); --может вставлять
SELECT * FROM Laboratory

UPDATE Laboratory
SET lab_name = REPLACE(REPLACE(STUFF(lab_name, 1, 1, 'л. Г'),'ая','ой'), 'ия', 'ии')--может изменять
where  lab_name like '%Генная инженерия%';

SELECT * FROM Laboratory
	DELETE FROM Laboratory
	WHERE Laboratory.lab_name = 'л. Генной инженерии' --может удалять
REVERT;

--Для одной таблицы новому пользователю присвоим права SELECT и UPDATE только избранных столбцов.
GRANT SELECT, UPDATE ON Common_officer (officer_id, officer_lastname, officer_name, officer_patronymic) TO TEST3;

EXECUTE AS USER = 'TEST3';

SELECT * FROM Common_officer --всё не может читать

SELECT officer_id, officer_lastname, officer_name, officer_patronymic from Common_officer; --"открытые" столбцы может

UPDATE Common_officer
 	SET date_of_birth = DATEADD(day, 1, date_of_birth) 
	WHERE (officer_id = 2) --нет доступа к столбцу scientific_degree, поэтому не может обновить

select * from Common_officer
where officer_id = 2
REVERT;

--Для одной таблицы новому пользователю присвоим только право SELECT.

GRANT SELECT ON Educational_Department TO TEST3;
GRANT SELECT ON Discipline TO TEST3;

EXECUTE AS USER = 'TEST3';

SELECT * FROM Role_in_the_lab -- не может делать выборки 
SELECT * FROM Discipline -- может делать выборки
SELECT * FROM Educational_department -- может делать выборки
UPDATE Educational_department 
	SET department_name = 'к. генной инженерии'
	WHERE department_name = 'к. биофизики'--нет прав на обновление
REVERT;

--Присвоим новому пользователю право доступа (SELECT) к двум представлениям, созданному в лабораторной работе №5.

GRANT SELECT ON [PUBLICATION_DATA] TO TEST3;
GRANT SELECT ON [Common_officer1] TO TEST3;
EXECUTE AS USER = 'TEST3';

SELECT * FROM [PUBLICATION_DATA];
SELECT * FROM [Common_officer1];
REVERT;

--Создадим стандартную роль уровня базы данных
--предварительное удаление с условиями: удаление схемы, принадлежащей роли, т. к. нельзя удалить роль, если ей принадлежит схема; 
IF (SELECT SCHEMA_ID('TEST3ROLE')) IS NOT NULL
BEGIN
DROP SCHEMA TEST3ROLE
END;
IF (select database_principal_id('TEST3ROLE')) is not null AND (SELECT IS_ROLEMEMBER ('TEST3ROLE', 'TEST3')) = 1
BEGIN
exec sp_droprolemember [test3role], [test3]
--REVOKE ROLE TEST3ROLE FROM TEST3
END;
IF database_principal_id('TEST3ROLE') is not null
BEGIN
DROP ROLE TEST3ROLE
END;
--или можно просто: DROP ROLE IF EXISTS TEST3ROLE
EXEC sp_addrole 'TEST3ROLE';
--Присвоим ей право доступа (UPDATE на некоторые столбцы) к представлению, созданному в лабораторной работе №5.
GRANT SELECT ON ED_DEP_DIS_OFFICER (am_of_off_in_dep, discipline_name, department_name) TO TEST3ROLE;
GRANT UPDATE ON ED_DEP_DIS_OFFICER (am_of_off_in_dep, discipline_name, department_name) TO TEST3ROLE;

EXEC sp_addrolemember @rolename = 'TEST3ROLE', @membername = 'TEST3';

SELECT * FROM [ED_DEP_DIS_OFFICER]

EXECUTE AS USER = 'TEST3';

SELECT * FROM [ED_DEP_DIS_OFFICER]

UPDATE [ED_DEP_DIS_OFFICER]
SET discipline_name = STUFF(discipline_name, 1, 1, 'семин. М')
WHERE discipline_name like 'Мат. анализ%'
REVERT;

SELECT * FROM [ED_DEP_DIS_OFFICER]

REVOKE UPDATE ON ED_DEP_DIS_OFFICER (am_of_off_in_dep, discipline_name, department_name) TO TEST3ROLE;
REVOKE SELECT ON ED_DEP_DIS_OFFICER (am_of_off_in_dep, discipline_name, department_name) TO TEST3ROLE;
--что такое revoke
--разобраться с avtorization


