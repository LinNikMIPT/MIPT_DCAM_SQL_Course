use Stolovaya

-- �������_�������� ����� ��������� ��������: READ UNCOMMITTED / READ COMMITTED / REPEATABLE READ / SERIALIZABLE

-- 0) ������ ���������� 
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
BEGIN TRANSACTION 
	select * from shm.Client;
	select Product_id, Description from shm.Product
		where Category_id = 2;
COMMIT


-- 1) ���������� ��������� T1 (������ ���������� ����������)
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
BEGIN TRANSACTION 
	select * from shm.Product;
	waitfor delay '00:00:07';
	update shm.Product set Description = '�����' where Product_id = 2
COMMIT

select * from shm.Product

update shm.Product set Description = '������' where Product_id = 2


-- 2) ������� ������ T1 (������ ���������� ������ ���������� ������� (��-�� 1�� ����������), ������� ����� ���������)
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
BEGIN TRANSACTION 
	update shm.Product set Description = '���-��' where Product_id = 2;
	waitfor delay '00:00:07';
	if 1 > 0 
		rollback;
	else
		COMMIT;

select * from shm.Product


-- 3) ��������������� ������ T1 (������� ������� �������� �������, ����� ������� ����� �� ���������� ������� (��-�� 2�� ����������))
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
BEGIN TRANSACTION 
	select * from shm.Product;
	waitfor delay '00:00:07';
	select sum(Category_id) from shm.Product where Product_id = 1 or Product_id = 2;
COMMIT

select * from shm.Product


-- 4) ������ (1�� ���������� ������� ������, ����� ������ ���������, � ������ �� ������)
SET TRANSACTION ISOLATION LEVEL REPEATABLE READ
BEGIN TRANSACTION 
	select * from shm.Product;
	waitfor delay '00:00:07';
	update shm.Product set Description = '���-��' where Category_id = 1;
COMMIT

update shm.Product set Category_id = 1 where Category_id = 0;
select * from shm.Product