CREATE DATABASE CaritasDB;
GO

USE CaritasDB;
GO

-- Tabla Usuarios
CREATE TABLE Usuarios (
    idUsuario INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
	nombreUsuario VARCHAR(20) NOT NULL,
	password VARCHAR(max) NOT NULL,
	salt VARCHAR(max) NOT NULL,
    permisoUsuario INT,
    nombre VARCHAR(15),
    apellidoPaterno VARCHAR(15),
    apellidoMaterno VARCHAR(15),
    zona VARCHAR(30)
);

-- Tabla Donantes
CREATE TABLE Donantes (
    folioDonante INT PRIMARY KEY NOT NULL,
    nombre VARCHAR(15),
    apellidoPaterno VARCHAR(15),
    apellidoMaterno VARCHAR(15),
    fechaNacimiento DATE,
	detalles VARCHAR(100)
);

-- Tabla Donativos
CREATE TABLE Donativos (
    idDonativo INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
	folioDonante INT NOT NULL,
	monto INT,
    cobrado INT,
    fechaConfirmacion DATE,
    fechaReprogramacion DATE,
    fechaCobro DATE,
	FOREIGN KEY (folioDonante) REFERENCES Donantes(folioDonante)
);

-- Tabla Recibos
CREATE TABLE Recibos (
    folioRecibo INT PRIMARY KEY NOT NULL,
    idDonativo INT NOT NULL,
	idUsuario INT NOT NULL,
	estatus INT,
    comentarios VARCHAR(100),
    FOREIGN KEY (idDonativo) REFERENCES Donativos(idDonativo),
	FOREIGN KEY (idUsuario) REFERENCES Usuarios(idUsuario),
);

-- Tabla Direcciones
CREATE TABLE Direcciones (
    idDireccion INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
    folioDonante INT NOT NULL,
    estado VARCHAR(20),
    municipio VARCHAR(20),
    calle VARCHAR(20),
    numero INT,
    referencias VARCHAR(50),
    FOREIGN KEY (folioDonante) REFERENCES Donantes(folioDonante)
);

-- Tabla Contactos
CREATE TABLE Contactos (
    idContacto INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
    folioDonante INT NOT NULL,
    email VARCHAR(30),
    telefonoPrincipal INT,
    telefonoSecundario INT,
    telefonoCelular INT,
    FOREIGN KEY (folioDonante) REFERENCES Donantes(folioDonante)
);

GO

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

GO

-- Usuarios
INSERT INTO Usuarios (nombreUsuario, password, salt, permisoUsuario, nombre, apellidoPaterno, apellidoMaterno, zona)
    VALUES ('alex', '70eb343a455abb8f48b713f49fcf68320b91a615aac44afbc10984b71c3e5710', 'z9876', 1, 'Alejandro', 'Fuentes', 'Martínez', 'Monterrey'); -- password: a1234
INSERT INTO Usuarios (nombreUsuario, password, salt, permisoUsuario, nombre, apellidoPaterno, apellidoMaterno, zona)
    VALUES ('jose', '70eb343a455abb8f48b713f49fcf68320b91a615aac44afbc10984b71c3e5710', 'z9876', 1, 'José', 'Plascencia', 'Cruz', 'Monterrey'); -- password: a1234
INSERT INTO Usuarios (nombreUsuario, password, salt, permisoUsuario, nombre, apellidoPaterno, apellidoMaterno, zona)
    VALUES ('angel', '70eb343a455abb8f48b713f49fcf68320b91a615aac44afbc10984b71c3e5710', 'z9876', 1, 'Ángel', 'García', 'Rangel', 'Monterrey'); -- password: a1234
INSERT INTO Usuarios (nombreUsuario, password, salt, permisoUsuario, nombre, apellidoPaterno, apellidoMaterno, zona)
    VALUES ('nallely', '70eb343a455abb8f48b713f49fcf68320b91a615aac44afbc10984b71c3e5710', 'z9876', 1, 'Nallely', 'Serna', 'Rivera', 'Monterrey'); -- password: a1234
INSERT INTO Usuarios (nombreUsuario, password, salt, permisoUsuario, nombre, apellidoPaterno, apellidoMaterno, zona)
    VALUES ('alejandro', '70eb343a455abb8f48b713f49fcf68320b91a615aac44afbc10984b71c3e5710', 'z9876', 1, 'Alejandro', 'Salazar', 'Anza', 'Monterrey'); -- password: a1234
INSERT INTO Usuarios (nombreUsuario, password, salt, permisoUsuario, nombre, apellidoPaterno, apellidoMaterno, zona)
    VALUES ('admin', '70eb343a455abb8f48b713f49fcf68320b91a615aac44afbc10984b71c3e5710', 'z9876', 2, 'primerNombre', 'apellidoMaterno', 'apellidoMaterno', 'Monterrey'); -- password: a1234

-- Donantes
EXEC CrearDonante
	@folioDonante = 5678,
    @nombre = 'Juan',
    @apellidoPaterno = 'Pérez',
    @apellidoMaterno = 'Fernández',
    @fechaNacimiento = '1987-06-21',
	@detalles = 'Ninguno',
    @estado = 'Nuevo León',
    @municipio = 'Apodaca',
    @calle = 'Villas de Apodaca',
    @numero = 437,
    @referencias = 'En frente de la tortillería',
    @email = 'juanpf@gmail.com',
    @telefonoPrincipal = 814501332,
    @telefonoSecundario = 819003671,
    @telefonoCelular = 814932177;
EXEC CrearDonante
	@folioDonante = 9898,
    @nombre = 'Alejandra',
    @apellidoPaterno = 'Villareal',
    @apellidoMaterno = 'Flores',
    @fechaNacimiento = '1981-10-5',
	@detalles = 'Entregar después de la 1 pm',
    @estado = 'Nuevo León',
    @municipio = 'Escobedo',
    @calle = 'Robles',
    @numero = 221,
    @referencias = 'Casa de tres pisos',
    @email = 'alevf@gmail.com',
    @telefonoPrincipal = 810573945,
    @telefonoSecundario = 811583537,
    @telefonoCelular = 814893204;
EXEC CrearDonante
	@folioDonante = 9345,
    @nombre = 'Francisco Emiliano',
    @apellidoPaterno = 'Lopez',
    @apellidoMaterno = 'Rojas',
    @fechaNacimiento = '1990-2-11',
	@detalles = 'Entregar antes de las 10 am',
    @estado = 'Nuevo León',
    @municipio = 'San Nicolás',
    @calle = 'Río Grande',
    @numero = 356,
    @referencias = 'Casa amarilla con un perro labrador',
    @email = 'franem@gmail.com',
    @telefonoPrincipal = 819341098,
    @telefonoSecundario = 810098134,
    @telefonoCelular = 818915473;
EXEC CrearDonante
	@folioDonante = 1562,
    @nombre = 'Laura Estafania',
    @apellidoPaterno = 'Treviño',
    @apellidoMaterno = 'González',
    @fechaNacimiento = '1992-4-1',
	@detalles = 'Tocar el timbre 3 veces',
    @estado = 'Nuevo León',
    @municipio = 'Escobedo',
    @calle = 'Los encinos',
    @numero = 912,
    @referencias = 'Casa roja con jardín grande',
    @email = 'lautre@gmail.com',
    @telefonoPrincipal = 815863424,
    @telefonoSecundario = 810842015,
    @telefonoCelular = 819070351;
EXEC CrearDonante
	@folioDonante = 9911,
    @nombre = 'Ernesto',
    @apellidoPaterno = 'Cárdenas',
    @apellidoMaterno = 'Montero',
    @fechaNacimiento = '1979-12-5',
	@detalles = 'Qudarse a platicar unos minutos',
    @estado = 'Nuevo León',
    @municipio = 'Santa Catarina',
    @calle = 'Emiliano Zapata',
    @numero = 103,
    @referencias = 'Casa azul con un naranjo en frente',
    @email = 'ernestocardenas@gmail.com',
    @telefonoPrincipal = 818830145,
    @telefonoSecundario = 813201254,
    @telefonoCelular = 819656012;

-- Donativos por cobrar en el día actual
INSERT INTO Donativos (folioDonante, monto, cobrado, fechaConfirmacion, fechaReprogramacion, fechaCobro)
    VALUES (5678, 1000, 0, CAST(GETDATE() AS DATE), null, null);
INSERT INTO Donativos (folioDonante, monto, cobrado, fechaConfirmacion, fechaReprogramacion, fechaCobro)
    VALUES (9898, 200, 0, CAST(GETDATE() AS DATE), null, null);
INSERT INTO Donativos (folioDonante, monto, cobrado, fechaConfirmacion, fechaReprogramacion, fechaCobro)
    VALUES (9345, 1300, 0, CAST(GETDATE() AS DATE), null, null);
INSERT INTO Donativos (folioDonante, monto, cobrado, fechaConfirmacion, fechaReprogramacion, fechaCobro)
    VALUES (1562, 1050, 0, CAST(GETDATE() AS DATE), null, null);
INSERT INTO Donativos (folioDonante, monto, cobrado, fechaConfirmacion, fechaReprogramacion, fechaCobro)
    VALUES (9911, 1900, 0, CAST(GETDATE() AS DATE), null, null);
INSERT INTO Donativos (folioDonante, monto, cobrado, fechaConfirmacion, fechaReprogramacion, fechaCobro)
    VALUES (5678, 100, 0, CAST(GETDATE() AS DATE), null, null);
INSERT INTO Donativos (folioDonante, monto, cobrado, fechaConfirmacion, fechaReprogramacion, fechaCobro)
    VALUES (9898, 230, 0, CAST(GETDATE() AS DATE), null, null);
INSERT INTO Donativos (folioDonante, monto, cobrado, fechaConfirmacion, fechaReprogramacion, fechaCobro)
    VALUES (9345, 1550, 0, CAST(GETDATE() AS DATE), null, null);
INSERT INTO Donativos (folioDonante, monto, cobrado, fechaConfirmacion, fechaReprogramacion, fechaCobro)
    VALUES (1562, 1750, 0, CAST(GETDATE() AS DATE), null, null);
INSERT INTO Donativos (folioDonante, monto, cobrado, fechaConfirmacion, fechaReprogramacion, fechaCobro)
    VALUES (9911, 900, 0, CAST(GETDATE() AS DATE), null, null);
INSERT INTO Donativos (folioDonante, monto, cobrado, fechaConfirmacion, fechaReprogramacion, fechaCobro)
    VALUES (5678, 500, 0, CAST(GETDATE() AS DATE), null, null);
INSERT INTO Donativos (folioDonante, monto, cobrado, fechaConfirmacion, fechaReprogramacion, fechaCobro)
    VALUES (9898, 800, 0, CAST(GETDATE() AS DATE), null, null);
INSERT INTO Donativos (folioDonante, monto, cobrado, fechaConfirmacion, fechaReprogramacion, fechaCobro)
    VALUES (9345, 300, 0, CAST(GETDATE() AS DATE), null, null);
INSERT INTO Donativos (folioDonante, monto, cobrado, fechaConfirmacion, fechaReprogramacion, fechaCobro)
    VALUES (1562, 4050, 0, CAST(GETDATE() AS DATE), null, null);
INSERT INTO Donativos (folioDonante, monto, cobrado, fechaConfirmacion, fechaReprogramacion, fechaCobro)
    VALUES (9911, 3200, 0, CAST(GETDATE() AS DATE), null, null);
INSERT INTO Donativos (folioDonante, monto, cobrado, fechaConfirmacion, fechaReprogramacion, fechaCobro)
    VALUES (5678, 1800, 0, CAST(GETDATE() AS DATE), null, null);
INSERT INTO Donativos (folioDonante, monto, cobrado, fechaConfirmacion, fechaReprogramacion, fechaCobro)
    VALUES (9898, 2010, 0, CAST(GETDATE() AS DATE), null, null);
INSERT INTO Donativos (folioDonante, monto, cobrado, fechaConfirmacion, fechaReprogramacion, fechaCobro)
    VALUES (9345, 145, 0, CAST(GETDATE() AS DATE), null, null);
INSERT INTO Donativos (folioDonante, monto, cobrado, fechaConfirmacion, fechaReprogramacion, fechaCobro)
    VALUES (1562, 270, 0, CAST(GETDATE() AS DATE), null, null);
INSERT INTO Donativos (folioDonante, monto, cobrado, fechaConfirmacion, fechaReprogramacion, fechaCobro)
    VALUES (9911, 400, 0, CAST(GETDATE() AS DATE), null, null);

-- Donativos cobrados en el día actual
INSERT INTO Donativos (folioDonante, monto, cobrado, fechaConfirmacion, fechaReprogramacion, fechaCobro)
    VALUES (5678, 600, 1, CAST(GETDATE() AS DATE), null, CAST(GETDATE() AS DATE));
INSERT INTO Donativos (folioDonante, monto, cobrado, fechaConfirmacion, fechaReprogramacion, fechaCobro)
    VALUES (9898, 300, 1, CAST(GETDATE() AS DATE), null, CAST(GETDATE() AS DATE));
INSERT INTO Donativos (folioDonante, monto, cobrado, fechaConfirmacion, fechaReprogramacion, fechaCobro)
    VALUES (9345, 1000, 1, CAST(GETDATE() AS DATE), null, CAST(GETDATE() AS DATE));
INSERT INTO Donativos (folioDonante, monto, cobrado, fechaConfirmacion, fechaReprogramacion, fechaCobro)
    VALUES (1562, 150, 1, CAST(GETDATE() AS DATE), null, CAST(GETDATE() AS DATE));
INSERT INTO Donativos (folioDonante, monto, cobrado, fechaConfirmacion, fechaReprogramacion, fechaCobro)
    VALUES (9911, 230, 1, CAST(GETDATE() AS DATE), null, CAST(GETDATE() AS DATE));
INSERT INTO Donativos (folioDonante, monto, cobrado, fechaConfirmacion, fechaReprogramacion, fechaCobro)
    VALUES (5678, 410, 1, CAST(GETDATE() AS DATE), null, CAST(GETDATE() AS DATE));
INSERT INTO Donativos (folioDonante, monto, cobrado, fechaConfirmacion, fechaReprogramacion, fechaCobro)
    VALUES (5678, 550, 1, CAST(GETDATE() AS DATE), null, CAST(GETDATE() AS DATE));
INSERT INTO Donativos (folioDonante, monto, cobrado, fechaConfirmacion, fechaReprogramacion, fechaCobro)
    VALUES (9345, 700, 1, CAST(GETDATE() AS DATE), null, CAST(GETDATE() AS DATE));
INSERT INTO Donativos (folioDonante, monto, cobrado, fechaConfirmacion, fechaReprogramacion, fechaCobro)
    VALUES (1562, 1500, 1, CAST(GETDATE() AS DATE), null, CAST(GETDATE() AS DATE));
INSERT INTO Donativos (folioDonante, monto, cobrado, fechaConfirmacion, fechaReprogramacion, fechaCobro)
    VALUES (9911, 2300, 1, CAST(GETDATE() AS DATE), null, CAST(GETDATE() AS DATE));

-- Donativos cobrados en días anteriores
INSERT INTO Donativos (folioDonante, monto, cobrado, fechaConfirmacion, fechaReprogramacion, fechaCobro)
    VALUES (5678, 1000, 1, CAST(DATEADD(DAY, -1, GETDATE()) AS DATE), null, CAST(DATEADD(DAY, -1, GETDATE()) AS DATE));
INSERT INTO Donativos (folioDonante, monto, cobrado, fechaConfirmacion, fechaReprogramacion, fechaCobro)
    VALUES (9898, 2000, 1, CAST(DATEADD(DAY, -1, GETDATE()) AS DATE), null, CAST(DATEADD(DAY, -1, GETDATE()) AS DATE));
INSERT INTO Donativos (folioDonante, monto, cobrado, fechaConfirmacion, fechaReprogramacion, fechaCobro)
    VALUES (9345, 1300, 1, CAST(DATEADD(DAY, -1, GETDATE()) AS DATE), null, CAST(DATEADD(DAY, -1, GETDATE()) AS DATE));
INSERT INTO Donativos (folioDonante, monto, cobrado, fechaConfirmacion, fechaReprogramacion, fechaCobro)
    VALUES (1562, 1500, 1, CAST(DATEADD(DAY, -1, GETDATE()) AS DATE), null, CAST(DATEADD(DAY, -1, GETDATE()) AS DATE));
INSERT INTO Donativos (folioDonante, monto, cobrado, fechaConfirmacion, fechaReprogramacion, fechaCobro)
    VALUES (9911, 1880, 1, CAST(DATEADD(DAY, -1, GETDATE()) AS DATE), null, CAST(DATEADD(DAY, -1, GETDATE()) AS DATE));
INSERT INTO Donativos (folioDonante, monto, cobrado, fechaConfirmacion, fechaReprogramacion, fechaCobro)
    VALUES (5678, 2000, 1, CAST(DATEADD(DAY, -2, GETDATE()) AS DATE), null, CAST(DATEADD(DAY, -2, GETDATE()) AS DATE));
INSERT INTO Donativos (folioDonante, monto, cobrado, fechaConfirmacion, fechaReprogramacion, fechaCobro)
    VALUES (9898, 1700, 1, CAST(DATEADD(DAY, -2, GETDATE()) AS DATE), null, CAST(DATEADD(DAY, -2, GETDATE()) AS DATE));
INSERT INTO Donativos (folioDonante, monto, cobrado, fechaConfirmacion, fechaReprogramacion, fechaCobro)
    VALUES (9345, 900, 1, CAST(DATEADD(DAY, -2, GETDATE()) AS DATE), null, CAST(DATEADD(DAY, -2, GETDATE()) AS DATE));
INSERT INTO Donativos (folioDonante, monto, cobrado, fechaConfirmacion, fechaReprogramacion, fechaCobro)
    VALUES (1562, 1200, 1, CAST(DATEADD(DAY, -2, GETDATE()) AS DATE), null, CAST(DATEADD(DAY, -2, GETDATE()) AS DATE));
INSERT INTO Donativos (folioDonante, monto, cobrado, fechaConfirmacion, fechaReprogramacion, fechaCobro)
    VALUES (9911, 1650, 1, CAST(DATEADD(DAY, -2, GETDATE()) AS DATE), null, CAST(DATEADD(DAY, -2, GETDATE()) AS DATE));
INSERT INTO Donativos (folioDonante, monto, cobrado, fechaConfirmacion, fechaReprogramacion, fechaCobro)
    VALUES (5678, 1000, 1, CAST(DATEADD(DAY, -3, GETDATE()) AS DATE), null, CAST(DATEADD(DAY, -3, GETDATE()) AS DATE));
INSERT INTO Donativos (folioDonante, monto, cobrado, fechaConfirmacion, fechaReprogramacion, fechaCobro)
    VALUES (9898, 2000, 1, CAST(DATEADD(DAY, -3, GETDATE()) AS DATE), null, CAST(DATEADD(DAY, -3, GETDATE()) AS DATE));
INSERT INTO Donativos (folioDonante, monto, cobrado, fechaConfirmacion, fechaReprogramacion, fechaCobro)
    VALUES (9345, 1300, 1, CAST(DATEADD(DAY, -3, GETDATE()) AS DATE), null, CAST(DATEADD(DAY, -3, GETDATE()) AS DATE));
INSERT INTO Donativos (folioDonante, monto, cobrado, fechaConfirmacion, fechaReprogramacion, fechaCobro)
    VALUES (1562, 1500, 1, CAST(DATEADD(DAY, -3, GETDATE()) AS DATE), null, CAST(DATEADD(DAY, -3, GETDATE()) AS DATE));
INSERT INTO Donativos (folioDonante, monto, cobrado, fechaConfirmacion, fechaReprogramacion, fechaCobro)
    VALUES (9911, 1880, 1, CAST(DATEADD(DAY, -3, GETDATE()) AS DATE), null, CAST(DATEADD(DAY, -3, GETDATE()) AS DATE));
INSERT INTO Donativos (folioDonante, monto, cobrado, fechaConfirmacion, fechaReprogramacion, fechaCobro)
    VALUES (5678, 3200, 1, CAST(DATEADD(DAY, -4, GETDATE()) AS DATE), null, CAST(DATEADD(DAY, -4, GETDATE()) AS DATE));
INSERT INTO Donativos (folioDonante, monto, cobrado, fechaConfirmacion, fechaReprogramacion, fechaCobro)
    VALUES (9898, 800, 1, CAST(DATEADD(DAY, -4, GETDATE()) AS DATE), null, CAST(DATEADD(DAY, -4, GETDATE()) AS DATE));
INSERT INTO Donativos (folioDonante, monto, cobrado, fechaConfirmacion, fechaReprogramacion, fechaCobro)
    VALUES (9345, 1100, 1, CAST(DATEADD(DAY, -4, GETDATE()) AS DATE), null, CAST(DATEADD(DAY, -4, GETDATE()) AS DATE));
INSERT INTO Donativos (folioDonante, monto, cobrado, fechaConfirmacion, fechaReprogramacion, fechaCobro)
    VALUES (1562, 400, 1, CAST(DATEADD(DAY, -4, GETDATE()) AS DATE), null, CAST(DATEADD(DAY, -4, GETDATE()) AS DATE));
INSERT INTO Donativos (folioDonante, monto, cobrado, fechaConfirmacion, fechaReprogramacion, fechaCobro)
    VALUES (9911, 1920, 1, CAST(DATEADD(DAY, -4, GETDATE()) AS DATE), null, CAST(DATEADD(DAY, -4, GETDATE()) AS DATE));

-- Asignar recibos a los recolectores
DECLARE @idUsuario INT;
SELECT @idUsuario = idUsuario FROM Usuarios WHERE nombreUsuario = 'alex';
INSERT INTO Recibos (folioRecibo, idDonativo, idUsuario, estatus)
	VALUES (1001, 1, @idUsuario, 1);
SELECT @idUsuario = idUsuario FROM Usuarios WHERE nombreUsuario = 'jose';
INSERT INTO Recibos (folioRecibo, idDonativo, idUsuario, estatus)
	VALUES (1002, 2, @idUsuario, 1);
SELECT @idUsuario = idUsuario FROM Usuarios WHERE nombreUsuario = 'nallely';
INSERT INTO Recibos (folioRecibo, idDonativo, idUsuario, estatus)
	VALUES (1003, 3, @idUsuario, 1);
	SELECT @idUsuario = idUsuario FROM Usuarios WHERE nombreUsuario = 'angel';
INSERT INTO Recibos (folioRecibo, idDonativo, idUsuario, estatus)
	VALUES (1004, 4, @idUsuario, 1);
SELECT @idUsuario = idUsuario FROM Usuarios WHERE nombreUsuario = 'alejandro';
INSERT INTO Recibos (folioRecibo, idDonativo, idUsuario, estatus)
	VALUES (1005, 5, @idUsuario, 1);
SELECT @idUsuario = idUsuario FROM Usuarios WHERE nombreUsuario = 'alex';
INSERT INTO Recibos (folioRecibo, idDonativo, idUsuario, estatus)
	VALUES (1006, 6, @idUsuario, 1);
SELECT @idUsuario = idUsuario FROM Usuarios WHERE nombreUsuario = 'jose';
INSERT INTO Recibos (folioRecibo, idDonativo, idUsuario, estatus)
	VALUES (1007, 7, @idUsuario, 1);
SELECT @idUsuario = idUsuario FROM Usuarios WHERE nombreUsuario = 'nallely';
INSERT INTO Recibos (folioRecibo, idDonativo, idUsuario, estatus)
	VALUES (1008, 8, @idUsuario, 1);
	SELECT @idUsuario = idUsuario FROM Usuarios WHERE nombreUsuario = 'angel';
INSERT INTO Recibos (folioRecibo, idDonativo, idUsuario, estatus)
	VALUES (1009, 9, @idUsuario, 1);
SELECT @idUsuario = idUsuario FROM Usuarios WHERE nombreUsuario = 'alejandro';
INSERT INTO Recibos (folioRecibo, idDonativo, idUsuario, estatus)
	VALUES (1010, 10, @idUsuario, 1);
SELECT @idUsuario = idUsuario FROM Usuarios WHERE nombreUsuario = 'alex';
INSERT INTO Recibos (folioRecibo, idDonativo, idUsuario, estatus)
	VALUES (1011, 11, @idUsuario, 1);
SELECT @idUsuario = idUsuario FROM Usuarios WHERE nombreUsuario = 'jose';
INSERT INTO Recibos (folioRecibo, idDonativo, idUsuario, estatus)
	VALUES (1012, 12, @idUsuario, 1);
SELECT @idUsuario = idUsuario FROM Usuarios WHERE nombreUsuario = 'nallely';
INSERT INTO Recibos (folioRecibo, idDonativo, idUsuario, estatus)
	VALUES (1013, 13, @idUsuario, 1);
	SELECT @idUsuario = idUsuario FROM Usuarios WHERE nombreUsuario = 'angel';
INSERT INTO Recibos (folioRecibo, idDonativo, idUsuario, estatus)
	VALUES (1014, 14, @idUsuario, 1);
SELECT @idUsuario = idUsuario FROM Usuarios WHERE nombreUsuario = 'alejandro';
INSERT INTO Recibos (folioRecibo, idDonativo, idUsuario, estatus)
	VALUES (1015, 15, @idUsuario, 1);
SELECT @idUsuario = idUsuario FROM Usuarios WHERE nombreUsuario = 'alex';
INSERT INTO Recibos (folioRecibo, idDonativo, idUsuario, estatus)
	VALUES (1016, 16, @idUsuario, 1);
SELECT @idUsuario = idUsuario FROM Usuarios WHERE nombreUsuario = 'jose';
INSERT INTO Recibos (folioRecibo, idDonativo, idUsuario, estatus)
	VALUES (1017, 17, @idUsuario, 1);
SELECT @idUsuario = idUsuario FROM Usuarios WHERE nombreUsuario = 'nallely';
INSERT INTO Recibos (folioRecibo, idDonativo, idUsuario, estatus)
	VALUES (1018, 18, @idUsuario, 1);
	SELECT @idUsuario = idUsuario FROM Usuarios WHERE nombreUsuario = 'angel';
INSERT INTO Recibos (folioRecibo, idDonativo, idUsuario, estatus)
	VALUES (1019, 19, @idUsuario, 1);
SELECT @idUsuario = idUsuario FROM Usuarios WHERE nombreUsuario = 'alejandro';
INSERT INTO Recibos (folioRecibo, idDonativo, idUsuario, estatus)
	VALUES (1020, 20, @idUsuario, 1);
SELECT @idUsuario = idUsuario FROM Usuarios WHERE nombreUsuario = 'alex';
INSERT INTO Recibos (folioRecibo, idDonativo, idUsuario, estatus)
	VALUES (1021, 21, @idUsuario, 1);
SELECT @idUsuario = idUsuario FROM Usuarios WHERE nombreUsuario = 'jose';
INSERT INTO Recibos (folioRecibo, idDonativo, idUsuario, estatus)
	VALUES (1022, 22, @idUsuario, 1);
SELECT @idUsuario = idUsuario FROM Usuarios WHERE nombreUsuario = 'nallely';
INSERT INTO Recibos (folioRecibo, idDonativo, idUsuario, estatus)
	VALUES (1023, 23, @idUsuario, 1);
	SELECT @idUsuario = idUsuario FROM Usuarios WHERE nombreUsuario = 'angel';
INSERT INTO Recibos (folioRecibo, idDonativo, idUsuario, estatus)
	VALUES (1024, 24, @idUsuario, 1);
SELECT @idUsuario = idUsuario FROM Usuarios WHERE nombreUsuario = 'alejandro';
INSERT INTO Recibos (folioRecibo, idDonativo, idUsuario, estatus)
	VALUES (1025, 25, @idUsuario, 1);
SELECT @idUsuario = idUsuario FROM Usuarios WHERE nombreUsuario = 'alex';
INSERT INTO Recibos (folioRecibo, idDonativo, idUsuario, estatus)
	VALUES (1026, 26, @idUsuario, 1);
SELECT @idUsuario = idUsuario FROM Usuarios WHERE nombreUsuario = 'jose';
INSERT INTO Recibos (folioRecibo, idDonativo, idUsuario, estatus)
	VALUES (1027, 27, @idUsuario, 1);
SELECT @idUsuario = idUsuario FROM Usuarios WHERE nombreUsuario = 'nallely';
INSERT INTO Recibos (folioRecibo, idDonativo, idUsuario, estatus)
	VALUES (1028, 28, @idUsuario, 1);
	SELECT @idUsuario = idUsuario FROM Usuarios WHERE nombreUsuario = 'angel';
INSERT INTO Recibos (folioRecibo, idDonativo, idUsuario, estatus)
	VALUES (1029, 29, @idUsuario, 1);
SELECT @idUsuario = idUsuario FROM Usuarios WHERE nombreUsuario = 'alejandro';
INSERT INTO Recibos (folioRecibo, idDonativo, idUsuario, estatus)
	VALUES (1030, 30, @idUsuario, 1);