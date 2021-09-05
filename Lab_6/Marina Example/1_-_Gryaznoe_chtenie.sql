--Грязное чтение 1
USE UNIVERSITY
GO
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
BEGIN TRAN;

select * from Scientific_officer
where scientific_degree like 'доктор %'

UPDATE Scientific_officer
SET citation_index = (citation_index + 1)
WHERE scientific_degree like 'доктор %';

waitfor delay '00:00:10';

ROLLBACK;

select * from Scientific_officer
where scientific_degree like 'доктор %'
