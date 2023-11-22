-- Crear usuario
INSERT INTO Usuarios (nombreUsuario, password, salt, permisoUsuario, nombre, apellidoPaterno, apellidoMaterno, zona)
    VALUES ('alex', '70eb343a455abb8f48b713f49fcf68320b91a615aac44afbc10984b71c3e5710', 'z9876', 1, 'Alejandro', 'Fuentes', 'Martínez', 'Monterrey'); -- Cambiar valores aqui

-- Obtener usuarios
SELECT nombreUsuario, nombre, apellidoPaterno, apellidoMaterno, zona FROM usuarios;

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

-- Intercambiar recibo (perspectiva del administrador)
DECLARE @idUsuarioAnterior INT;
DECLARE @idUsuarioNuevo INT;
SELECT @idUsuarioAnterior = idUsuario FROM Usuarios WHERE nombreUsuario = 'alejandro'; -- Cambiar valores aqui
SELECT @idUsuarioNuevo = idUsuario FROM Usuarios WHERE nombreUsuario = 'jose'; -- Cambiar valores aqui
UPDATE Recibos
SET
	idUsuario = @idUsuarioNuevo
WHERE idUsuario = @idUsuarioAnterior AND folioRecibo = 12381; -- Cambiar valores aqui (folioRecibo)



----------------------------------------- Llamadas a las funciones y stored procedures -----------------------------------------

-- Así llamas el SP de CrearDonante
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

-- Así llamas a la función ObtenerSalt (HU1)
SELECT * FROM ObtenerSalt('alex'); -- Cambiar el parámetro por el nombreUsuario

-- Así llamas a la función VerificarCredencialesUsuario (HU1)
SELECT * FROM VerificarCredencialesUsuario('alex', '70eb343a455abb8f48b713f49fcf68320b91a615aac44afbc10984b71c3e5710');

-- Así llamas la función ObtenerRecibosUsuario (HU2 Y HU9)
SELECT * FROM ObtenerRecibosUsuario(1); -- Cambiar el parámetro por el idUsuario

-- Así llamas a la función CobrarRecibo (HU3)
EXEC CobrarRecibo
	@folioRecibo = 1001; -- Cambiar el parámetro por el folioRecibo

-- Así llamas a la función ComentarRecibo (HU3)
EXEC ComentarRecibo
	@folioRecibo = 1001, -- Cambiar el parámetro por el folioRecibo
	@comentarios = 'No se cobro'; -- Cambiar el parámetro por los comentarios

-- Así llamas a la función ObtenerRecolectores (HU8)
SELECT * FROM ObtenerRecolectores();

-- Así llamas a la función ObtenerRecibosCobradosNoCobrados (HU10 - C2)
SELECT * FROM ObtenerRecibosCobradosNoCobrados();

-- Así llamas a la función ObtenerRecibosCobradosPorZona (HU10 - C3)
SELECT * FROM ObtenerRecibosCobradosPorZona();

-- Así llamas a la función ObtenerIngresosUltimos5Dias (HU10 - C4)
SELECT * FROM ObtenerIngresosUltimos5Dias() ORDER BY fechaCobro ASC;
-- La cláusula ORDER BY debe ir fuera de la llamada de la función porque, por sintaxis de SQL Server, no es posible usarla dentro de una función