-- Crear usuario
INSERT INTO Usuarios (nombreUsuario, password, salt, permisoUsuario, nombre, apellidoPaterno, apellidoMaterno, zona)
    VALUES ('alex', '70eb343a455abb8f48b713f49fcf68320b91a615aac44afbc10984b71c3e5710', 'z9876', 1, 'Alejandro', 'Fuentes', 'Martínez', 'Monterrey'); -- password: a1234
INSERT INTO Usuarios (nombreUsuario, password, salt, permisoUsuario, nombre, apellidoPaterno, apellidoMaterno, zona)
    VALUES ('jose', '70eb343a455abb8f48b713f49fcf68320b91a615aac44afbc10984b71c3e5710', 'z9876', 1, 'primerNombre', 'apellidoMaterno', 'apellidoMaterno', 'Monterrey'); -- password: a1234
INSERT INTO Usuarios (nombreUsuario, password, salt, permisoUsuario, nombre, apellidoPaterno, apellidoMaterno, zona)
    VALUES ('angel', '70eb343a455abb8f48b713f49fcf68320b91a615aac44afbc10984b71c3e5710', 'z9876', 1, 'primerNombre', 'apellidoMaterno', 'apellidoMaterno', 'Monterrey'); -- password: a1234
INSERT INTO Usuarios (nombreUsuario, password, salt, permisoUsuario, nombre, apellidoPaterno, apellidoMaterno, zona)
    VALUES ('nallely', '70eb343a455abb8f48b713f49fcf68320b91a615aac44afbc10984b71c3e5710', 'z9876', 1, 'primerNombre', 'apellidoMaterno', 'apellidoMaterno', 'Monterrey'); -- password: a1234
INSERT INTO Usuarios (nombreUsuario, password, salt, permisoUsuario, nombre, apellidoPaterno, apellidoMaterno, zona)
    VALUES ('alejandro', '70eb343a455abb8f48b713f49fcf68320b91a615aac44afbc10984b71c3e5710', 'z9876', 1, 'primerNombre', 'apellidoMaterno', 'apellidoMaterno', 'Monterrey'); -- password: a1234


EXEC CrearDonante
	@folioDonante = 1234,
    @nombre = 'Alejandro',
    @apellidoPaterno = 'Fuentes',
    @apellidoMaterno = 'Martinez',
    @fechaNacimiento = '2003-09-26',
    @estado = 'Nuevo León',
    @municipio = 'San Pedro',
    @calle = 'Garza Sada',
    @numero = 123,
    @referencias = 'El Tec',
    @email = 'eso@tilin.com',
    @telefonoPrincipal = 12345678,
    @telefonoSecundario = 12345678,
    @telefonoCelular = 12345678;
EXEC CrearDonante
	@folioDonante = 1235,
    @nombre = 'José',
    @apellidoPaterno = 'Plascencia',
    @apellidoMaterno = 'Cruz',
    @fechaNacimiento = '1999-01-01',
    @estado = 'Nuevo León',
    @municipio = 'San Pedro',
    @calle = 'Garza Sada',
    @numero = 123,
    @referencias = 'El Tec',
    @email = 'eso@tilin.com',
    @telefonoPrincipal = 12345678,
    @telefonoSecundario = 12345678,
    @telefonoCelular = 12345678;
EXEC CrearDonante
	@folioDonante = 1236,
    @nombre = 'Nallely',
    @apellidoPaterno = 'Serna',
    @apellidoMaterno = 'Rivera',
    @fechaNacimiento = '1999-01-01',
    @estado = 'Nuevo León',
    @municipio = 'San Pedro',
    @calle = 'Garza Sada',
    @numero = 123,
    @referencias = 'El Tec',
    @email = 'eso@tilin.com',
    @telefonoPrincipal = 12345678,
    @telefonoSecundario = 12345678,
    @telefonoCelular = 12345678;
EXEC CrearDonante
	@folioDonante = 1237,
    @nombre = 'Ángel',
    @apellidoPaterno = 'García',
    @apellidoMaterno = 'Rangel',
    @fechaNacimiento = '1999-01-01',
    @estado = 'Nuevo León',
    @municipio = 'San Pedro',
    @calle = 'Garza Sada',
    @numero = 123,
    @referencias = 'El Tec',
    @email = 'eso@tilin.com',
    @telefonoPrincipal = 12345678,
    @telefonoSecundario = 12345678,
    @telefonoCelular = 12345678;
EXEC CrearDonante
	@folioDonante = 1238,
    @nombre = 'Alejandro',
    @apellidoPaterno = 'Salazar',
    @apellidoMaterno = 'Anza',
    @fechaNacimiento = '1999-01-01',
    @estado = 'Nuevo León',
    @municipio = 'San Pedro',
    @calle = 'Garza Sada',
    @numero = 123,
    @referencias = 'El Tec',
    @email = 'eso@tilin.com',
    @telefonoPrincipal = 12345678,
    @telefonoSecundario = 12345678,
    @telefonoCelular = 12345678;


INSERT INTO Donativos (folioDonante, monto, cobrado, fechaConfirmacion, fechaReprogramacion, fechaCobro)
    VALUES (1234, 1000, 0, '2023-10-19', '2023-10-20', '2023-10-21');
INSERT INTO Donativos (folioDonante, monto, cobrado, fechaConfirmacion, fechaReprogramacion, fechaCobro)
    VALUES (1235, 1100, 0, '2023-10-19', '2023-10-20', '2023-10-21');
INSERT INTO Donativos (folioDonante, monto, cobrado, fechaConfirmacion, fechaReprogramacion, fechaCobro)
    VALUES (1236, 1200, 0, '2023-10-19', '2023-10-20', '2023-10-21');
INSERT INTO Donativos (folioDonante, monto, cobrado, fechaConfirmacion, fechaReprogramacion, fechaCobro)
    VALUES (1237, 1300, 0, '2023-10-19', '2023-10-20', '2023-10-21');
INSERT INTO Donativos (folioDonante, monto, cobrado, fechaConfirmacion, fechaReprogramacion, fechaCobro)
    VALUES (1238, 1400, 0, '2023-10-19', '2023-10-20', '2023-10-21');
INSERT INTO Donativos (folioDonante, monto, cobrado, fechaConfirmacion, fechaReprogramacion, fechaCobro)
    VALUES (1234, 100, 0, '2023-10-19', '2023-10-20', '2023-10-21');
INSERT INTO Donativos (folioDonante, monto, cobrado, fechaConfirmacion, fechaReprogramacion, fechaCobro)
    VALUES (1235, 110, 0, '2023-10-19', '2023-10-20', '2023-10-21');
INSERT INTO Donativos (folioDonante, monto, cobrado, fechaConfirmacion, fechaReprogramacion, fechaCobro)
    VALUES (1236, 120, 0, '2023-10-19', '2023-10-20', '2023-10-21');
INSERT INTO Donativos (folioDonante, monto, cobrado, fechaConfirmacion, fechaReprogramacion, fechaCobro)
    VALUES (1237, 130, 0, '2023-10-19', '2023-10-20', '2023-10-21');
INSERT INTO Donativos (folioDonante, monto, cobrado, fechaConfirmacion, fechaReprogramacion, fechaCobro)
    VALUES (1238, 140, 0, '2023-10-19', '2023-10-20', '2023-10-21');
INSERT INTO Donativos (folioDonante, monto, cobrado, fechaConfirmacion, fechaReprogramacion, fechaCobro)
    VALUES (1234, 10000, 0, '2023-10-19', '2023-10-20', '2023-10-21');
INSERT INTO Donativos (folioDonante, monto, cobrado, fechaConfirmacion, fechaReprogramacion, fechaCobro)
    VALUES (1235, 11000, 0, '2023-10-19', '2023-10-20', '2023-10-21');
INSERT INTO Donativos (folioDonante, monto, cobrado, fechaConfirmacion, fechaReprogramacion, fechaCobro)
    VALUES (1236, 12000, 0, '2023-10-19', '2023-10-20', '2023-10-21');
INSERT INTO Donativos (folioDonante, monto, cobrado, fechaConfirmacion, fechaReprogramacion, fechaCobro)
    VALUES (1237, 13000, 0, '2023-10-19', '2023-10-20', '2023-10-21');
INSERT INTO Donativos (folioDonante, monto, cobrado, fechaConfirmacion, fechaReprogramacion, fechaCobro)
    VALUES (1238, 14000, 0, '2023-10-19', '2023-10-20', '2023-10-21');


DECLARE @idUsuario INT;
SELECT @idUsuario = idUsuario FROM Usuarios WHERE nombreUsuario = 'alex';
INSERT INTO Recibos (folioRecibo, idDonativo, idUsuario, estatus)
	VALUES (1234, 1, @idUsuario, 1);
SELECT @idUsuario = idUsuario FROM Usuarios WHERE nombreUsuario = 'jose';
INSERT INTO Recibos (folioRecibo, idDonativo, idUsuario, estatus)
	VALUES (1235, 2, @idUsuario, 1);
SELECT @idUsuario = idUsuario FROM Usuarios WHERE nombreUsuario = 'nallely';
INSERT INTO Recibos (folioRecibo, idDonativo, idUsuario, estatus)
	VALUES (1236, 3, @idUsuario, 1);
	SELECT @idUsuario = idUsuario FROM Usuarios WHERE nombreUsuario = 'angel';
INSERT INTO Recibos (folioRecibo, idDonativo, idUsuario, estatus)
	VALUES (1237, 4, @idUsuario, 1);
SELECT @idUsuario = idUsuario FROM Usuarios WHERE nombreUsuario = 'alejandro';
INSERT INTO Recibos (folioRecibo, idDonativo, idUsuario, estatus)
	VALUES (1238, 5, @idUsuario, 1);
SELECT @idUsuario = idUsuario FROM Usuarios WHERE nombreUsuario = 'alex';
INSERT INTO Recibos (folioRecibo, idDonativo, idUsuario, estatus)
	VALUES (12341, 6, @idUsuario, 1);
SELECT @idUsuario = idUsuario FROM Usuarios WHERE nombreUsuario = 'jose';
INSERT INTO Recibos (folioRecibo, idDonativo, idUsuario, estatus)
	VALUES (12351, 7, @idUsuario, 1);
SELECT @idUsuario = idUsuario FROM Usuarios WHERE nombreUsuario = 'nallely';
INSERT INTO Recibos (folioRecibo, idDonativo, idUsuario, estatus)
	VALUES (12361, 8, @idUsuario, 1);
SELECT @idUsuario = idUsuario FROM Usuarios WHERE nombreUsuario = 'angel';
INSERT INTO Recibos (folioRecibo, idDonativo, idUsuario, estatus)
	VALUES (12371, 9, @idUsuario, 1);
SELECT @idUsuario = idUsuario FROM Usuarios WHERE nombreUsuario = 'alejandro';
INSERT INTO Recibos (folioRecibo, idDonativo, idUsuario, estatus)
	VALUES (12381, 10, @idUsuario, 1);
SELECT @idUsuario = idUsuario FROM Usuarios WHERE nombreUsuario = 'alex';
INSERT INTO Recibos (folioRecibo, idDonativo, idUsuario, estatus)
	VALUES (12342, 11, @idUsuario, 1);
SELECT @idUsuario = idUsuario FROM Usuarios WHERE nombreUsuario = 'jose';
INSERT INTO Recibos (folioRecibo, idDonativo, idUsuario, estatus)
	VALUES (12352, 12, @idUsuario, 1);
SELECT @idUsuario = idUsuario FROM Usuarios WHERE nombreUsuario = 'nallely';
INSERT INTO Recibos (folioRecibo, idDonativo, idUsuario, estatus)
	VALUES (12362, 13, @idUsuario, 1);
SELECT @idUsuario = idUsuario FROM Usuarios WHERE nombreUsuario = 'angel';
INSERT INTO Recibos (folioRecibo, idDonativo, idUsuario, estatus)
	VALUES (12372, 14, @idUsuario, 1);
SELECT @idUsuario = idUsuario FROM Usuarios WHERE nombreUsuario = 'alejandro';
INSERT INTO Recibos (folioRecibo, idDonativo, idUsuario, estatus)
	VALUES (12382, 15, @idUsuario, 1);