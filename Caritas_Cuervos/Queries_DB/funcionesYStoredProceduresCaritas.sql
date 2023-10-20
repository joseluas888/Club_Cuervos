---------------------------------- Funciones y Stored Procedures de Usuarios ----------------------------------
-- Crear usuario
INSERT INTO Usuarios (nombreUsuario, password, salt, permisoUsuario, nombre, apellidoPaterno, apellidoMaterno, zona)
    VALUES ('alex', '70eb343a455abb8f48b713f49fcf68320b91a615aac44afbc10984b71c3e5710', 'z9876', 1, 'Alejandro', 'Fuentes', 'Martínez', 'Monterrey'); -- Cambiar valores aqui

-- Obtener usuarios
SELECT nombreUsuario, nombre, apellidoPaterno, apellidoMaterno, zona FROM usuarios;

-- Obtener salt
SELECT salt FROM usuarios WHERE nombreUsuario = 'alex'; -- Cambiar valores aqui

-- Verificar credenciales
SELECT idUsuario FROM usuarios WHERE nombreUsuario = 'alex' AND password = '70eb343a455abb8f48b713f49fcf68320b91a615aac44afbc10984b71c3e5710'; -- Cambiar valores aqui

-- Obtener permiso del usuario
SELECT permisoUsuario FROM usuarios WHERE idUsuario = 1; -- Cambiar valores aqui

-- Modificar informacion del usuario
UPDATE Usuarios
SET
	nombreUsuario = 'nuevoNombreUsuario', -- Cambiar valores aqui
    password = 'nuevoPassword', -- Cambiar valores aqui
    salt = 'nuevaSalt', -- Cambiar valores aqui
    nombre = 'nuevoNombre', -- Cambiar valores aqui
    apellidoPaterno = 'nuevoApellidoP', -- Cambiar valores aqui
    apellidoMaterno = 'nuevoApellidoM', -- Cambiar valores aqui
    zona = 'San Pedro' -- Cambiar valores aqui
WHERE idUsuario = 1; -- Cambiar valores aqui


---------------------------------- Funciones y Stored Procedures de Donantes ----------------------------------
-- Crear donante (Estará guardado en la DB, no es necesario agregarlo a la API)
CREATE PROCEDURE CrearDonante
	@folio INT,
    @nombre VARCHAR(15),
    @apellidoPaterno VARCHAR(15),
    @apellidoMaterno VARCHAR(15),
    @fechaNacimiento DATE,
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
    INSERT INTO Donantes (folio, nombre, apellidoPaterno, apellidoMaterno, fechaNacimiento)
    VALUES (@folio, @nombre, @apellidoPaterno, @apellidoMaterno, @fechaNacimiento);

    DECLARE @idDonante INT = SCOPE_IDENTITY();

    INSERT INTO Direcciones (idDonante, estado, municipio, calle, numero, referencias)
    VALUES (@idDonante, @estado, @municipio, @calle, @numero, @referencias);

    INSERT INTO Contactos (idDonante, email, telefonoPrincipal, telefonoSecundario, telefonoCelular)
    VALUES (@idDonante, @email, @telefonoPrincipal, @telefonoSecundario, @telefonoCelular);
END;

-- Así llamas el SP de CrearDonante desde la API (este sí lo agregas a la API)
EXEC CrearDonante
	@folio = 1234, -- Cambiar valores aqui
    @nombre = 'Alejandro', -- Cambiar valores aqui
    @apellidoPaterno = 'Fuentes', -- Cambiar valores aqui
    @apellidoMaterno = 'Martinez', -- Cambiar valores aqui
    @fechaNacimiento = '2003-09-26', -- Cambiar valores aqui
    @estado = 'Nuevo León', -- Cambiar valores aqui
    @municipio = 'San Pedro', -- Cambiar valores aqui
    @calle = 'Garza Sada', -- Cambiar valores aqui
    @numero = 123, -- Cambiar valores aqui
    @referencias = 'El Tec', -- Cambiar valores aqui
    @email = 'eso@tilin.com', -- Cambiar valores aqui
    @telefonoPrincipal = 12345678, -- Cambiar valores aqui
    @telefonoSecundario = 12345678, -- Cambiar valores aqui
    @telefonoCelular = 12345678; -- Cambiar valores aqui

-- Modificar datos del donante
UPDATE Donantes
SET
    nombre = 'nuevoNombre', -- Cambiar valores aqui
    apellidoPaterno = 'nuevoApellidoP', -- Cambiar valores aqui
    apellidoMaterno = 'nuevoApellidoM', -- Cambiar valores aqui
    fechaNacimiento = '1999-01-01' -- Cambiar valores aqui
WHERE folio = 1234; -- Cambiar valores aqui

-- Modificar direcciones del donante
UPDATE Direcciones
SET
	estado = 'nuevoEstado', -- Cambiar valores aqui
	municipio = 'nuevoMunicipio', -- Cambiar valores aqui
	calle = 'nuevaCalle', -- Cambiar valores aqui
	numero = 321, -- Cambiar valores aqui
	referencias = 'nuevaReferencia' -- Cambiar valores aqui
	FROM Direcciones INNER JOIN Donantes ON Direcciones.idDonante = Donantes.idDonante
WHERE folio = 1234; -- Cambiar valores aqui

-- Modificar contactos del donante
UPDATE Contactos
SET
	email = 'nuevo@correo.com', -- Cambiar valores aqui
	telefonoPrincipal = 12345678, -- Cambiar valores aqui
    telefonoSecundario = 12345678, -- Cambiar valores aqui
    telefonoCelular = 12345678 -- Cambiar valores aqui
	FROM Contactos INNER JOIN Donantes ON Contactos.idDonante = Donantes.idDonante
WHERE folio = 1234; -- Cambiar valores aqui

-- Obtener informacion de un donante
SELECT 
	nombre, apellidoPaterno, apellidoMaterno, fechaNacimiento, estado, municipio, calle, numero, referencias, email, telefonoPrincipal, telefonoSecundario, telefonoCelular
	FROM Donantes
	INNER JOIN Direcciones ON Donantes.idDonante = Direcciones.idDonante
	INNER JOIN Contactos ON Donantes.idDonante = Contactos.idDonante
WHERE folio = 1234; -- Cambiar valores aqui


---------------------------------- Funciones y Stored Procedures de Donativos y Recibos ----------------------------------
-- Crear donativo
DECLARE @idDonante INT;
SELECT @idDonante = idDonante FROM Donantes WHERE folio = 1234; -- Cambiar valores aqui
INSERT INTO Donativos (idDonante, monto, estatus, fechaConfirmacion, fechaReprogramacion, fechaCobro)
    VALUES (@idDonante, 100, 1, '2023-10-19', '2023-10-20', '2023-10-21'); -- Cambiar valores aqui

-- Obtener donativos
SELECT folio, idDonativo, monto, estatus, fechaConfirmacion, fechaReprogramacion, fechaCobro
	FROM Donativos INNER JOIN Donantes ON Donativos.idDonante = Donantes.idDonante

-- Crear recibo
DECLARE @idUsuario INT;
SELECT @idUsuario = idUsuario FROM Usuarios WHERE nombreUsuario = 'nuevoNombreUsuario'; -- Cambiar valores aqui
INSERT INTO Recibos (idDonativo, idUsuario, folio)
	VALUES (1, @idUsuario, 7896); -- Cambiar valores aqui

-- Obtener todos los recibos
SELECT idRecibo, folio, monto, estatus, comentarios, fechaConfirmacion, fechaReprogramacion, fechaCobro
	FROM Recibos INNER JOIN Donativos ON Recibos.idDonativo = Donativos.idDonativo;

-- Obtener recibos de un usuario
SELECT idRecibo, folio, monto, estatus, comentarios, fechaConfirmacion, fechaReprogramacion, fechaCobro
	FROM Recibos INNER JOIN Donativos ON Recibos.idDonativo = Donativos.idDonativo
	WHERE idUsuario = 1; -- Cambiar valores aqui

-- Obtener detalles del donante a partir de un recibo
SELECT 
	nombre, apellidoPaterno, apellidoMaterno, fechaNacimiento, estado, municipio, calle, numero, referencias, email, telefonoPrincipal, telefonoSecundario, telefonoCelular
	FROM Donantes
	INNER JOIN Direcciones ON Donantes.idDonante = Direcciones.idDonante
	INNER JOIN Contactos ON Donantes.idDonante = Contactos.idDonante
	INNER JOIN Donativos ON Donantes.idDonante = Donativos.idDonante
	INNER JOIN Recibos ON Donativos.idDonativo = Recibos.idDonativo
WHERE idRecibo = 1; -- Cambiar valores aqui

-- Intercambiar recibo
DECLARE @idUsuarioNuevo INT;
SELECT @idUsuarioNuevo = idUsuario FROM Usuarios WHERE nombreUsuario = 'nuevoNombreUsuario'; -- Cambiar valores aqui
UPDATE Recibos
SET
	idUsuario = @idUsuarioNuevo
WHERE idUsuario = 2; -- Cambiar valores aqui