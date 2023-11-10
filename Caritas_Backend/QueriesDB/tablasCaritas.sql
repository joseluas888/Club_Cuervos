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
    cobrado BINARY,
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
	estatus BINARY,
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