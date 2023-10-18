-- Tabla Usuarios
CREATE TABLE Usuarios (
    idUsuario INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
	matricula VARCHAR(10) NOT NULL,
	password INT NOT NULL,
	salt INT NOT NULL,
    permisoUsuario INT,
    nombre VARCHAR(15),
    apellidoPaterno VARCHAR(15),
    apellidoMaterno VARCHAR(15),
    zona VARCHAR(30)
);

-- Tabla Donantes
CREATE TABLE Donantes (
    idDonante INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
    nombre VARCHAR(15),
    apellidoPaterno VARCHAR(15),
    apellidoMaterno VARCHAR(15),
    fechaNacimiento DATE
);

-- Tabla Donativos
CREATE TABLE Donativos (
    idDonativo INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
	idDonante INT NOT NULL,
    folio INT,
	monto INT,
    estatus BINARY,
    comentarios VARCHAR(100),
    fechaConfirmacion DATE,
    fechaReprogramacion DATE,
    fechaCobro DATE,
	FOREIGN KEY (idDonante) REFERENCES Donantes(idDonante)
);

-- Tabla Recibos
CREATE TABLE Recibos (
    idRecibo INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
    idDonativo INT NOT NULL,
    folio INT,
    estatus BINARY,
    comentarios VARCHAR(100),
    FOREIGN KEY (idDonativo) REFERENCES Donativos(idDonativo)
);

-- Tabla RecolectorRecibo
CREATE TABLE RecolectorRecibo (
    idRecolectorRecibo INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
    idUsuario INT NOT NULL,
    idRecibo INT NOT NULL,
    estatus BINARY,
    FOREIGN KEY (idUsuario) REFERENCES Usuarios(idUsuario),
    FOREIGN KEY (idRecibo) REFERENCES Recibos(idRecibo)
);

-- Tabla Direcciones
CREATE TABLE Direcciones (
    idDireccion INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
    idDonante INT NOT NULL,
    estado VARCHAR(20),
    municipio VARCHAR(20),
    calle VARCHAR(20),
    numero VARCHAR(20),
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