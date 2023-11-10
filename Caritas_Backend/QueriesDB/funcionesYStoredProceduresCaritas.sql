---------------------------------- Funciones y Stored Procedures de Usuarios ----------------------------------
-- Crear usuario
INSERT INTO Usuarios (nombreUsuario, password, salt, permisoUsuario, nombre, apellidoPaterno, apellidoMaterno, zona)
    VALUES ('alex', '70eb343a455abb8f48b713f49fcf68320b91a615aac44afbc10984b71c3e5710', 'z9876', 2, 'Alejandro', 'Fuentes', 'Martínez', 'Monterrey'); -- Cambiar valores aqui

-- Obtener usuarios
SELECT nombreUsuario, nombre, apellidoPaterno, apellidoMaterno, zona FROM usuarios;

-- Obtener salt
SELECT salt FROM usuarios WHERE nombreUsuario = 'alex'; -- Cambiar valores aqui

-- Verificar credenciales
SELECT idUsuario FROM usuarios WHERE nombreUsuario = 'admin' AND password = '70eb343a455abb8f48b713f49fcf68320b91a615aac44afbc10984b71c3e5710' AND permisoUsuario = 2; -- Cambiar valores aqui

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
WHERE folioDonante = 1234; -- Cambiar valores aqui

-- Modificar direcciones del donante
UPDATE Direcciones
SET
	estado = 'nuevoEstado', -- Cambiar valores aqui
	municipio = 'nuevoMunicipio', -- Cambiar valores aqui
	calle = 'nuevaCalle', -- Cambiar valores aqui
	numero = 321, -- Cambiar valores aqui
	referencias = 'nuevaReferencia' -- Cambiar valores aqui
	FROM Direcciones INNER JOIN Donantes ON Direcciones.folioDonante = Donantes.folioDonante
WHERE folioDonante = 1234; -- Cambiar valores aqui

-- Modificar contactos del donante
UPDATE Contactos
SET
	email = 'nuevo@correo.com', -- Cambiar valores aqui
	telefonoPrincipal = 12345678, -- Cambiar valores aqui
    telefonoSecundario = 12345678, -- Cambiar valores aqui
    telefonoCelular = 12345678 -- Cambiar valores aqui
	FROM Contactos INNER JOIN Donantes ON Contactos.folioDonante = Donantes.folioDonante
WHERE folioDonante = 1234; -- Cambiar valores aqui

-- Obtener informacion de un donante
SELECT 
	nombre, apellidoPaterno, apellidoMaterno, fechaNacimiento, estado, municipio, calle, numero, referencias, email, telefonoPrincipal, telefonoSecundario, telefonoCelular
	FROM Donantes
	INNER JOIN Direcciones ON Donantes.folioDonante = Direcciones.folioDonante
	INNER JOIN Contactos ON Donantes.folioDonante = Contactos.folioDonante
WHERE folioDonante = 1234; -- Cambiar valores aqui


---------------------------------- Funciones y Stored Procedures de Donativos y Recibos ----------------------------------
-- Crear donativo
INSERT INTO Donativos (folioDonante, monto, cobrado, fechaConfirmacion, fechaReprogramacion, fechaCobro)
    VALUES (1234, 100, 0, '2023-10-19', '2023-10-20', '2023-10-21'); -- Cambiar valores aqui

-- Obtener donativos
SELECT * FROM Donativos;

-- Crear recibo
DECLARE @idUsuario INT;
SELECT @idUsuario = idUsuario FROM Usuarios WHERE nombreUsuario = 'nuevoNombreUsuario'; -- Cambiar valores aqui
INSERT INTO Recibos (folioRecibo, idDonativo, idUsuario, estatus)
	VALUES (1234, 1, @idUsuario, 1); -- Cambiar valores aqui (con excepcion del 1 de estatus)

-- Obtener recibos de un usuario
SELECT folioRecibo, monto, nombre, apellidoPaterno, apellidoMaterno, detalles, municipio, calle, numero, referencias, telefonoPrincipal, telefonoSecundario, telefonoCelular
	FROM Recibos
	INNER JOIN Donativos ON Recibos.idDonativo = Donativos.idDonativo
	INNER JOIN Donantes ON Donativos.folioDonante = Donantes.folioDonante
	INNER JOIN Direcciones ON Donantes.folioDonante = Direcciones.folioDonante
	INNER JOIN Contactos ON Donantes.folioDonante = Contactos.folioDonante
	WHERE idUsuario = 1 AND estatus = 1; -- Cambiar valores aqui (no cambiar el estatus)

-- Obtener recibos no cobrados de un usuario (cobrado 0, estatus 1)
SELECT folioRecibo, monto, nombre, apellidoPaterno, apellidoMaterno, municipio, calle, numero
	FROM Recibos
	INNER JOIN Donativos ON Recibos.idDonativo = Donativos.idDonativo
	INNER JOIN Donantes ON Donativos.folioDonante = Donantes.folioDonante
	INNER JOIN Direcciones ON Donantes.folioDonante = Direcciones.folioDonante
	WHERE idUsuario = 1 AND cobrado = 0 AND estatus = 1; -- Cambiar valores aqui

-- Obtener recibos cobrados de un usuario (cobrado 1, estatus 1)
SELECT folioRecibo, monto, nombre, apellidoPaterno, apellidoMaterno, municipio, calle, numero
	FROM Recibos
	INNER JOIN Donativos ON Recibos.idDonativo = Donativos.idDonativo
	INNER JOIN Donantes ON Donativos.folioDonante = Donantes.folioDonante
	INNER JOIN Direcciones ON Donantes.folioDonante = Direcciones.folioDonante
	WHERE idUsuario = 1 AND cobrado = 1 AND estatus = 1; -- Cambiar valores aqui

-- Obtener detalles del donante a partir de un recibo
SELECT 
	nombre, apellidoPaterno, apellidoMaterno, estado, municipio, calle, numero, referencias, telefonoPrincipal, telefonoSecundario, telefonoCelular
	FROM Donantes
	INNER JOIN Direcciones ON Donantes.folioDonante = Direcciones.folioDonante
	INNER JOIN Contactos ON Donantes.folioDonante = Contactos.folioDonante
	INNER JOIN Donativos ON Donantes.folioDonante = Donativos.folioDonante
	INNER JOIN Recibos ON Donativos.idDonativo = Recibos.idDonativo
WHERE folioRecibo = 1234; -- Cambiar valores aqui

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

-- Intercambiar recibo (perspectiva del cobrador)
DECLARE @idUsuarioNuevo INT;
SELECT @idUsuarioNuevo = idUsuario FROM Usuarios WHERE nombreUsuario = 'nombreNuevoUsuario'; -- Cambiar valores aqui
UPDATE Recibos
SET
	idUsuario = @idUsuarioNuevo
WHERE idUsuario = 2 AND folioRecibo = 12381; -- Cambiar valores aqui (cobrador original y folioRecibo)

-- Intercambiar recibo (perspectiva del administrador)
DECLARE @idUsuarioAnterior INT;
DECLARE @idUsuarioNuevo INT;
SELECT @idUsuarioAnterior = idUsuario FROM Usuarios WHERE nombreUsuario = 'alejandro'; -- Cambiar valores aqui
SELECT @idUsuarioNuevo = idUsuario FROM Usuarios WHERE nombreUsuario = 'jose'; -- Cambiar valores aqui
UPDATE Recibos
SET
	idUsuario = @idUsuarioNuevo
WHERE idUsuario = @idUsuarioAnterior AND folioRecibo = 12381; -- Cambiar valores aqui (folioRecibo)

-- Cambiar el estatus de un recibo a inactivo (perspectiva del administrador)
UPDATE Recibos
Set
	estatus = 0
FROM Recibos
WHERE folioRecibo = 1234; -- Cambiar valores aqui

-- Cambiar el estatus de un recibo a activo (perspectiva del administrador)
UPDATE Recibos
Set
	estatus = 1
FROM Recibos
WHERE folioRecibo = 1234; -- Cambiar valores aqui

-- Obtener todos los recibos para la pantalla de administrador "Resúmen del día"
SELECT folioRecibo, monto, fechaCobro, comentarios, nombre, apellidoPaterno, apellidoMaterno, municipio, calle, numero
	FROM Recibos
	INNER JOIN Donativos ON Recibos.idDonativo = Donativos.idDonativo
	INNER JOIN Donantes ON Donativos.folioDonante = Donantes.folioDonante
	INNER JOIN Direcciones ON Donantes.folioDonante = Direcciones.folioDonante
	INNER JOIN Contactos ON Donantes.folioDonante = Contactos.folioDonante
	WHERE fechaConfirmacion = CAST(GETDATE() AS DATE); -- No es necesario cambiar este campo