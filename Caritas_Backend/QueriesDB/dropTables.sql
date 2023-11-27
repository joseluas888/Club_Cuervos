DROP PROCEDURE CrearDonante;
DROP FUNCTION ObtenerRecibosUsuario;
DROP FUNCTION ObtenerSalt;
DROP FUNCTION VerificarCredencialesUsuario;
DROP PROCEDURE CobrarRecibo;
DROP PROCEDURE ComentarRecibo;
DROP FUNCTION VerificarCredencialesAdministrador;
DROP FUNCTION ObtenerRecolectores;
DROP FUNCTION ObtenerRecibosCobradosNoCobrados;
DROP FUNCTION ObtenerRecibosCobradosPorZona;
DROP FUNCTION ObtenerImportes;

EXEC sp_msforeachtable 'ALTER TABLE ? NOCHECK CONSTRAINT ALL';
EXEC sp_msforeachtable 'DROP TABLE ?';