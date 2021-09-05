use Stolovaya

-- уровень_изоляции может принимать значения: READ UNCOMMITTED / READ COMMITTED / REPEATABLE READ / SERIALIZABLE

-- 0) Пример транзакции 
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
BEGIN TRANSACTION 
	select * from shm.Client;
	select Product_id, Description from shm.Product
		where Category_id = 2;
COMMIT


-- 1) Потерянные изменения T1 (вторая транзакция затирается)
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
BEGIN TRANSACTION 
	select * from shm.Product;
	waitfor delay '00:00:07';
	update shm.Product set Description = 'Петух' where Product_id = 2
COMMIT

select * from shm.Product

update shm.Product set Description = 'Курица' where Product_id = 2


-- 2) Грязное чтение T1 (вторая транзакция читает измененную таблицу (из-за 1ой транзакции), которая потом откатится)
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
BEGIN TRANSACTION 
	update shm.Product set Description = 'Что-то' where Product_id = 2;
	waitfor delay '00:00:07';
	if 1 > 0 
		rollback;
	else
		COMMIT;

select * from shm.Product


-- 3) Неповторяющееся чтение T1 (сначала выводит исходную таблицу, потом выводит сумму из измененной таблицы (из-за 2ой транзакции))
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
BEGIN TRANSACTION 
	select * from shm.Product;
	waitfor delay '00:00:07';
	select sum(Category_id) from shm.Product where Product_id = 1 or Product_id = 2;
COMMIT

select * from shm.Product


-- 4) Фантом (1ая транзакция выводит данные, потом вторая добавляет, и первая их меняет)
SET TRANSACTION ISOLATION LEVEL REPEATABLE READ
BEGIN TRANSACTION 
	select * from shm.Product;
	waitfor delay '00:00:07';
	update shm.Product set Description = 'Что-то' where Category_id = 1;
COMMIT

update shm.Product set Category_id = 1 where Category_id = 0;
select * from shm.Product