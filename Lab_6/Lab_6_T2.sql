use Stolovaya

-- 1) ���������� ��������� T2
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
BEGIN TRANSACTION 
	update shm.Product set Description = '��������' where Product_id = 2;
	select * from shm.Product;
COMMIT

select * from shm.Product;

-- 2) ������� ������ T2
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
BEGIN TRANSACTION 
	select * from shm.Product;
COMMIT


-- 3) ��������������� ������ T2
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
BEGIN TRANSACTION 
	update shm.Product set Category_id = 2 where Product_id = 2;
COMMIT

update shm.Product set Category_id = 1 where Product_id = 2;
select * from shm.Product;


-- 4) ������
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
BEGIN TRANSACTION 
	insert into shm.Product VALUES(22, '��������', 1);
COMMIT

select * from shm.Product