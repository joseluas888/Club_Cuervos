-- Obtener salt de un usuario (HU1)
CREATE FUNCTION ObtenerSalt(@nombreUsuario VARCHAR(20))
RETURNS TABLE
AS
RETURN (
	SELECT salt FROM usuarios WHERE nombreUsuario = @nombreUsuario);

GO

-- Verificar credenciales de un usuario (HU1)
CREATE FUNCTION VerificarCredencialesUsuario(@nombreUsuario VARCHAR(20), @password VARCHAR(MAX))
RETURNS TABLE
AS
RETURN (
	SELECT idUsuario FROM usuarios
	WHERE nombreUsuario = @nombreUsuario AND password = @password AND permisoUsuario = 1);

GO

-- Crear donante (No incluir en la API)
CREATE PROCEDURE CrearDonante
	@folioDonante INT,
    @nombre VARCHAR(15),
    @apellidoPaterno VARCHAR(15),
    @apellidoMaterno VARCHAR(15),
    @fechaNacimiento DATE,
	@detalles VARCHAR(100),
    @estado VARCHAR(20),
    @municipio VARCHAR(20),
    @calle VARCHAR(20),
    @numero INT,
    @referencias VARCHAR(50),
    @email VARCHAR(30),
    @telefonoPrincipal INT,
    @telefonoSecundario INT,
    @telefonoCelular INT
AS
BEGIN
    INSERT INTO Donantes (folioDonante, nombre, apellidoPaterno, apellidoMaterno, fechaNacimiento, detalles)
    VALUES (@folioDonante, @nombre, @apellidoPaterno, @apellidoMaterno, @fechaNacimiento, @detalles);

    INSERT INTO Direcciones (folioDonante, estado, municipio, calle, numero, referencias)
    VALUES (@folioDonante, @estado, @municipio, @calle, @numero, @referencias);

    INSERT INTO Contactos (folioDonante, email, telefonoPrincipal, telefonoSecundario, telefonoCelular)
    VALUES (@folioDonante, @email, @telefonoPrincipal, @telefonoSecundario, @telefonoCelular);
END;

GO

-- Obtener recibos de un usuario (HU2 y HU9)
CREATE FUNCTION ObtenerRecibosUsuario(@idUsuario INT)
RETURNS TABLE
AS
RETURN (
    SELECT folioRecibo, monto, cobrado, comentarios, nombre, apellidoPaterno, apellidoMaterno, detalles, municipio, calle, numero, referencias, telefonoPrincipal, telefonoSecundario, telefonoCelular
    FROM Recibos
    INNER JOIN Donativos ON Recibos.idDonativo = Donativos.idDonativo
    INNER JOIN Donantes ON Donativos.folioDonante = Donantes.folioDonante
    INNER JOIN Direcciones ON Donantes.folioDonante = Direcciones.folioDonante
    INNER JOIN Contactos ON Donantes.folioDonante = Contactos.folioDonante
    WHERE idUsuario = @idUsuario AND estatus = 1 );

GO

-- Marcar recibo como cobrado (HU3)
CREATE PROCEDURE CobrarRecibo
	@folioRecibo INT
AS
BEGIN
	UPDATE Donativos
	SET
		cobrado = 1,
		fechaCobro = CAST(GETDATE() AS DATE)
	FROM Donativos INNER JOIN Recibos ON Donativos.idDonativo = Recibos.idDonativo
	WHERE folioRecibo = @folioRecibo;
END;

GO

-- Agregar comentarios a un recibo cuando no se cobra (HU4)
CREATE PROCEDURE ComentarRecibo
	@folioRecibo INT,
	@comentarios VARCHAR(100)
AS
BEGIN
	UPDATE Recibos
	Set
		comentarios = @comentarios -- Cambiar valores aqui
	FROM Recibos
	WHERE folioRecibo = @folioRecibo; -- Cambiar valores aqui
END;

GO

-- Verificar credenciales de un administrador (HU7)
CREATE FUNCTION VerificarCredencialesAdministrador(@nombreUsuario VARCHAR(20), @password VARCHAR(MAX))
RETURNS TABLE
AS
RETURN (
	SELECT idUsuario FROM usuarios
	WHERE nombreUsuario = @nombreUsuario AND password = @password AND permisoUsuario = 2);

GO

-- Obtener recolectores (HU8)
CREATE FUNCTION ObtenerRecolectores()
RETURNS TABLE
AS
RETURN (
	SELECT idUsuario, nombre, apellidoPaterno, apellidoMaterno, zona
	FROM usuarios
	WHERE permisoUsuario = 1);

GO

-- Obtener recibos cobrados y no cobrados (HU10 - C2)
CREATE FUNCTION ObtenerRecibosCobradosNoCobrados()
RETURNS TABLE
AS
RETURN (
    SELECT
        CASE 
            WHEN cobrado = 0 THEN 'No cobrados'
            WHEN cobrado = 1 THEN 'Cobrados'
        END AS estadoCobro,
        COUNT(*) AS cantidad
    FROM Donativos
    WHERE fechaConfirmacion = CAST(GETDATE() AS DATE)
    GROUP BY cobrado
    UNION
    SELECT
        'Promesas' AS estadoCobro,
        SUM(COUNT(*)) OVER () AS cantidad
    FROM Donativos
    WHERE fechaConfirmacion = CAST(GETDATE() AS DATE)
);

GO

-- Obtener recibos cobrados por zona (HU10 - C3)
CREATE FUNCTION ObtenerRecibosCobradosPorZona()
RETURNS TABLE
AS
RETURN (
	SELECT municipio, COUNT(*) AS cantidad
	FROM Donativos
	INNER JOIN Donantes ON Donativos.folioDonante = Donantes.folioDonante
	INNER JOIN Direcciones ON Donantes.folioDonante = Direcciones.folioDonante
	WHERE fechaCobro = CAST(GETDATE() AS DATE) AND cobrado = 1
	GROUP BY municipio);

GO

-- Obtener dinero recolectado en los últimos 5 días (HU10 - C4)
CREATE FUNCTION ObtenerImportes()
RETURNS TABLE
AS
RETURN (
	SELECT
		CASE 
			WHEN cobrado = 0 THEN 'No cobrados'
			WHEN cobrado = 1 THEN 'Cobrados'
		END AS estadoCobro,
		SUM(monto) AS sumatoriaMontos
	FROM Donativos
    WHERE fechaConfirmacion = CAST(GETDATE() AS DATE)
    GROUP BY cobrado
    UNION
    SELECT
        'Promesas' AS estadoCobro,
        SUM(monto) OVER () AS sumatoriaMontos
    FROM Donativos
    WHERE fechaConfirmacion = CAST(GETDATE() AS DATE)
);