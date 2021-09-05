use Stolovaya

-- 1) Потерянные изменения T2
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
BEGIN TRANSACTION 
	update shm.Product set Description = 'Цыпленок' where Product_id = 2;
	select * from shm.Product;
COMMIT

select * from shm.Product;

-- 2) Грязное чтение T2
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
BEGIN TRANSACTION 
	select * from shm.Product;
COMMIT


-- 3) Неповторяющееся чтение T2
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
BEGIN TRANSACTION 
	update shm.Product set Category_id = 2 where Product_id = 2;
COMMIT

update shm.Product set Category_id = 1 where Product_id = 2;
select * from shm.Product;


-- 4) Фантом
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
BEGIN TRANSACTION 
	insert into shm.Product VALUES(22, 'Баранина', 1);
COMMIT

select * from shm.Product