---------------------------------- Funciones y Stored Procedures de Usuarios ----------------------------------
-- Crear usuario
INSERT INTO Usuarios (nombreUsuario, password, salt, permisoUsuario, nombre, apellidoPaterno, apellidoMaterno, zona)
    VALUES ('alex', '70eb343a455abb8f48b713f49fcf68320b91a615aac44afbc10984b71c3e5710', 'z9876', 1, 'Alejandro', 'Fuentes', 'Martínez', 'Monterrey'); -- Cambiar valores aqui

-- Obtener usuarios
SELECT nombreUsuario, nombre, apellidoPaterno, apellidoMaterno, zona FROM usuarios;

-- Obtener salt
SELECT salt FROM usuarios WHERE nombreUsuario = 'alex'; -- Cambiar valores aqui

-- Verificar credenciales
SELECT idUsuario FROM usuarios WHERE nombreUsuario = 'admin' AND password = '70eb343a455abb8f48b713f49fcf68320b91a615aac44afbc10984b71c3e5710' AND permisoUsuario = 2; -- Cambiar valores aqui


---------------------------------- Funciones y Stored Procedures de Donantes ----------------------------------
-- Crear donante (Estará guardado en la DB, no es necesario agregarlo a la API)
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

-- Así llamas el SP de CrearDonante desde la API (este sí lo agregas a la API)
EXEC CrearDonante
	@folioDonante = 1234, -- Cambiar valores aqui
    @nombre = 'Alejandro', -- Cambiar valores aqui
    @apellidoPaterno = 'Fuentes', -- Cambiar valores aqui
    @apellidoMaterno = 'Martinez', -- Cambiar valores aqui
    @fechaNacimiento = '2003-09-26', -- Cambiar valores aqui
	@detalles = 'nada', -- Cambiar valores aqui
    @estado = 'Nuevo León', -- Cambiar valores aqui
    @municipio = 'San Pedro', -- Cambiar valores aqui
    @calle = 'Garza Sada', -- Cambiar valores aqui
    @numero = 123, -- Cambiar valores aqui
    @referencias = 'El Tec', -- Cambiar valores aqui
    @email = 'eso@tilin.com', -- Cambiar valores aqui
    @telefonoPrincipal = 12345678, -- Cambiar valores aqui
    @telefonoSecundario = 12345678, -- Cambiar valores aqui
    @telefonoCelular = 12345678; -- Cambiar valores aqui


---------------------------------- Funciones y Stored Procedures de Donativos y Recibos ----------------------------------
-- Crear donativo
INSERT INTO Donativos (folioDonante, monto, cobrado, fechaConfirmacion, fechaReprogramacion, fechaCobro)
    VALUES (1234, 100, 0, '2023-10-19', '2023-10-20', '2023-10-21'); -- Cambiar valores aqui

-- Crear recibo
DECLARE @idUsuario INT;
SELECT @idUsuario = idUsuario FROM Usuarios WHERE nombreUsuario = 'nuevoNombreUsuario'; -- Cambiar valores aqui
INSERT INTO Recibos (folioRecibo, idDonativo, idUsuario, estatus)
	VALUES (1234, 1, @idUsuario, 1); -- Cambiar valores aqui (con excepcion del 1 de estatus)

-- Obtener recibos de un usuario
SELECT folioRecibo, monto, nombre, cobrado, comentarios, apellidoPaterno, apellidoMaterno, detalles, municipio, calle, numero, referencias, telefonoPrincipal, telefonoSecundario, telefonoCelular
	FROM Recibos
	INNER JOIN Donativos ON Recibos.idDonativo = Donativos.idDonativo
	INNER JOIN Donantes ON Donativos.folioDonante = Donantes.folioDonante
	INNER JOIN Direcciones ON Donantes.folioDonante = Direcciones.folioDonante
	INNER JOIN Contactos ON Donantes.folioDonante = Contactos.folioDonante
	WHERE idUsuario = 1 AND estatus = 1; -- Cambiar valores aqui (no cambiar el estatus)

-- Marcar recibo como cobrado
UPDATE Donativos
SET
	cobrado = 1,
	fechaCobro = CAST(GETDATE() AS DATE)
FROM Donativos INNER JOIN Recibos ON Donativos.idDonativo = Recibos.idDonativo
WHERE folioRecibo = 1234; -- Cambiar valores aqui

-- Agregar comentarios a un recibo cuando no se cobra
UPDATE Recibos
Set
	comentarios = 'hola, no se cobro' -- Cambiar valores aqui
FROM Recibos
WHERE folioRecibo = 1234; -- Cambiar valores aqui

-- Intercambiar recibo (perspectiva del administrador)
DECLARE @idUsuarioAnterior INT;
DECLARE @idUsuarioNuevo INT;
SELECT @idUsuarioAnterior = idUsuario FROM Usuarios WHERE nombreUsuario = 'alejandro'; -- Cambiar valores aqui
SELECT @idUsuarioNuevo = idUsuario FROM Usuarios WHERE nombreUsuario = 'jose'; -- Cambiar valores aqui
UPDATE Recibos
SET
	idUsuario = @idUsuarioNuevo
WHERE idUsuario = @idUsuarioAnterior AND folioRecibo = 12381; -- Cambiar valores aqui (folioRecibo)

-- Obtener usuarios (HU8)
SELECT idUsuario, nombre, apellidoPaterno, apellidoMaterno, zona
	FROM usuarios
	WHERE permisoUsuario = 1;

-- Obtener recibos de un usuario (HU9)
SELECT folioRecibo, monto, nombre, cobrado, comentarios, fechaCobro, apellidoPaterno, apellidoMaterno, detalles, municipio, calle, numero, referencias, telefonoPrincipal, telefonoSecundario, telefonoCelular
	FROM Recibos
	INNER JOIN Donativos ON Recibos.idDonativo = Donativos.idDonativo
	INNER JOIN Donantes ON Donativos.folioDonante = Donantes.folioDonante
	INNER JOIN Direcciones ON Donantes.folioDonante = Direcciones.folioDonante
	INNER JOIN Contactos ON Donantes.folioDonante = Contactos.folioDonante
	WHERE idUsuario = 1 AND estatus = 1; -- Cambiar valores aqui (no cambiar el estatus)

-- Obtener recibos cobrados y no cobrados (HU10 - C2)
SELECT cobrado, COUNT(*) AS cantidad
	FROM Donativos
	WHERE fechaConfirmacion = CAST(GETDATE() AS DATE)
	GROUP BY cobrado;

-- Obtener recibos cobrados por zona (HU10 - C3)
SELECT municipio, COUNT(*) AS cantidad
	FROM Donativos
	INNER JOIN Donantes ON Donativos.folioDonante = Donantes.folioDonante
	INNER JOIN Direcciones ON Donantes.folioDonante = Direcciones.folioDonante
	WHERE fechaCobro = CAST(GETDATE() AS DATE) AND cobrado = 1
	GROUP BY municipio;

-- Obtener dinero recolectado en los últimos 5 días (HU10 - C4)
SELECT fechaCobro, SUM(monto) AS sumatoriaMontos
FROM Donativos
WHERE fechaCobro >= DATEADD(DAY, -5, GETDATE()) -- Obtener los donativos de los últimos 5 días
GROUP BY fechaCobro
ORDER BY fechaCobro ASC;