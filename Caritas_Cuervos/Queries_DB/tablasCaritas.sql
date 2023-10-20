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
    idDonante INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
	folio INT,
    nombre VARCHAR(15),
    apellidoPaterno VARCHAR(15),
    apellidoMaterno VARCHAR(15),
    fechaNacimiento DATE
);

-- Tabla Donativos
CREATE TABLE Donativos (
    idDonativo INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
	idDonante INT NOT NULL,
	monto INT,
    estatus BINARY,
    fechaConfirmacion DATE,
    fechaReprogramacion DATE,
    fechaCobro DATE,
	FOREIGN KEY (idDonante) REFERENCES Donantes(idDonante)
);

-- Tabla Recibos
CREATE TABLE Recibos (
    idRecibo INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
    idDonativo INT NOT NULL,
	idUsuario INT NOT NULL,
    folio INT,
    comentarios VARCHAR(100),
    FOREIGN KEY (idDonativo) REFERENCES Donativos(idDonativo),
	FOREIGN KEY (idUsuario) REFERENCES Usuarios(idUsuario),
);

-- Tabla Direcciones
CREATE TABLE Direcciones (
    idDireccion INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
    idDonante INT NOT NULL,
    estado VARCHAR(20),
    municipio VARCHAR(20),
    calle VARCHAR(20),
    numero INT,
    referencias VARCHAR(50),
    FOREIGN KEY (idDonante) REFERENCES Donantes(idDonante)
);

-- Tabla Contactos
CREATE TABLE Contactos (
    idContacto INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
    idDonante INT NOT NULL,
    email VARCHAR(30),
    telefonoPrincipal INT,
    telefonoSecundario INT,
    telefonoCelular INT,
    FOREIGN KEY (idDonante) REFERENCES Donantes(idDonante)
);