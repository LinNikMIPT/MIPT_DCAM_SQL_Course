--������� ������ 1
USE UNIVERSITY
GO
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
BEGIN TRAN;

select * from Scientific_officer
where scientific_degree like '������ %'

UPDATE Scientific_officer
SET citation_index = (citation_index + 1)
WHERE scientific_degree like '������ %';

waitfor delay '00:00:10';

ROLLBACK;

select * from Scientific_officer
where scientific_degree like '������ %'
