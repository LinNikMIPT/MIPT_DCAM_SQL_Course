USE University
GO
--��������/�������� ����� user � login 
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

--��������, ����� �������� ����� ��������� user TEST3
EXECUTE AS USER = 'TEST3';

SELECT * FROM Laboratory; -- �� ����� ������ �� �������

SELECT citation_index  FROM Scientific_officer; 

SELECT * FROM Scientific_officer
UPDATE Scientific_officer
	SET citation_index = citation_index + 1
	WHERE scientific_officer_id = 2; --�� ����� ���������

INSERT INTO Laboratory VALUES ('������ ���������', '���������', 12); --�� ����� ���������
DELETE FROM Laboratory
	WHERE Laboratory.lab_name = '������ ���������' --�� ����� �������

REVERT

--��������� ������ ������������ ����� SELECT, INSERT, UPDATE � ������ ������ �� ���� �������

GRANT INSERT, SELECT, UPDATE, DELETE ON Scientific_officer TO TEST3;
GRANT INSERT, SELECT, UPDATE, DELETE ON Laboratory TO TEST3;
EXECUTE AS USER = 'TEST3';
SELECT * FROM Scientific_officer
UPDATE Scientific_officer
	SET citation_index = citation_index + 1
	WHERE scientific_officer_id = 2; --����� ���������

INSERT INTO Laboratory VALUES ('������ ���������', '���������', 12); --����� ���������
SELECT * FROM Laboratory

UPDATE Laboratory
SET lab_name = REPLACE(REPLACE(STUFF(lab_name, 1, 1, '�. �'),'��','��'), '��', '��')--����� ��������
where  lab_name like '%������ ���������%';

SELECT * FROM Laboratory
	DELETE FROM Laboratory
	WHERE Laboratory.lab_name = '�. ������ ���������' --����� �������
REVERT;

--��� ����� ������� ������ ������������ �������� ����� SELECT � UPDATE ������ ��������� ��������.
GRANT SELECT, UPDATE ON Common_officer (officer_id, officer_lastname, officer_name, officer_patronymic) TO TEST3;

EXECUTE AS USER = 'TEST3';

SELECT * FROM Common_officer --�� �� ����� ������

SELECT officer_id, officer_lastname, officer_name, officer_patronymic from Common_officer; --"��������" ������� �����

UPDATE Common_officer
 	SET date_of_birth = DATEADD(day, 1, date_of_birth) 
	WHERE (officer_id = 2) --��� ������� � ������� scientific_degree, ������� �� ����� ��������

select * from Common_officer
where officer_id = 2
REVERT;

--��� ����� ������� ������ ������������ �������� ������ ����� SELECT.

GRANT SELECT ON Educational_Department TO TEST3;
GRANT SELECT ON Discipline TO TEST3;

EXECUTE AS USER = 'TEST3';

SELECT * FROM Role_in_the_lab -- �� ����� ������ ������� 
SELECT * FROM Discipline -- ����� ������ �������
SELECT * FROM Educational_department -- ����� ������ �������
UPDATE Educational_department 
	SET department_name = '�. ������ ���������'
	WHERE department_name = '�. ���������'--��� ���� �� ����������
REVERT;

--�������� ������ ������������ ����� ������� (SELECT) � ���� ��������������, ���������� � ������������ ������ �5.

GRANT SELECT ON [PUBLICATION_DATA] TO TEST3;
GRANT SELECT ON [Common_officer1] TO TEST3;
EXECUTE AS USER = 'TEST3';

SELECT * FROM [PUBLICATION_DATA];
SELECT * FROM [Common_officer1];
REVERT;

--�������� ����������� ���� ������ ���� ������
--��������������� �������� � ���������: �������� �����, ������������� ����, �. �. ������ ������� ����, ���� �� ����������� �����; 
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
--��� ����� ������: DROP ROLE IF EXISTS TEST3ROLE
EXEC sp_addrole 'TEST3ROLE';
--�������� �� ����� ������� (UPDATE �� ��������� �������) � �������������, ���������� � ������������ ������ �5.
GRANT SELECT ON ED_DEP_DIS_OFFICER (am_of_off_in_dep, discipline_name, department_name) TO TEST3ROLE;
GRANT UPDATE ON ED_DEP_DIS_OFFICER (am_of_off_in_dep, discipline_name, department_name) TO TEST3ROLE;

EXEC sp_addrolemember @rolename = 'TEST3ROLE', @membername = 'TEST3';

SELECT * FROM [ED_DEP_DIS_OFFICER]

EXECUTE AS USER = 'TEST3';

SELECT * FROM [ED_DEP_DIS_OFFICER]

UPDATE [ED_DEP_DIS_OFFICER]
SET discipline_name = STUFF(discipline_name, 1, 1, '�����. �')
WHERE discipline_name like '���. ������%'
REVERT;

SELECT * FROM [ED_DEP_DIS_OFFICER]

REVOKE UPDATE ON ED_DEP_DIS_OFFICER (am_of_off_in_dep, discipline_name, department_name) TO TEST3ROLE;
REVOKE SELECT ON ED_DEP_DIS_OFFICER (am_of_off_in_dep, discipline_name, department_name) TO TEST3ROLE;
--��� ����� revoke
--����������� � avtorization


