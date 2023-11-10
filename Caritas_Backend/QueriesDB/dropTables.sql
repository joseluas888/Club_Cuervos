EXEC sp_msforeachtable 'ALTER TABLE ? NOCHECK CONSTRAINT ALL';
EXEC sp_msforeachtable 'DROP TABLE ?';
DROP PROCEDURE CrearDonante;