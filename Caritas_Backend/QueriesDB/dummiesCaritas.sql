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