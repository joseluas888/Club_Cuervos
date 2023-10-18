---------------------------------- Funciones y Stored Procedures de Login ----------------------------------
-- Crear usuario
CREATE PROCEDURE CrearUsuario 
    @matricula VARCHAR(10),
    @password INT,
    @salt INT,
    @permisoUsuario INT,
    @nombre VARCHAR(15),
    @apellidoPaterno VARCHAR(15),
    @apellidoMaterno VARCHAR(15),
    @zona VARCHAR(30)
AS
BEGIN
    INSERT INTO Usuarios (matricula, password, salt, permisoUsuario, nombre, apellidoPaterno, apellidoMaterno, zona)
    VALUES (@matricula, @password, @salt, @permisoUsuario, @nombre, @apellidoPaterno, @apellidoMaterno, @zona);
END;

-- Obtener salt
CREATE FUNCTION ObtenerSalt
(
    @matricula VARCHAR(10)
)
RETURNS INT
AS
BEGIN
    DECLARE @salt INT;
    SELECT @salt = salt FROM Usuarios WHERE matricula = @matricula;
    RETURN @salt;
END;

-- Verificar credenciales
CREATE FUNCTION VerificarCredenciales
(
    @matricula VARCHAR(10),
    @password INT
)
RETURNS BIT
AS
BEGIN
    DECLARE @credencialesCorrectas BIT;
    SET @credencialesCorrectas = (
        SELECT CASE 
            WHEN COUNT(*) > 0 THEN 1
            ELSE 0
        END
        FROM Usuarios
        WHERE matricula = @matricula AND password = @password
    );
    RETURN @credencialesCorrectas;
END;

-- Obtener id
CREATE FUNCTION ObtenerIdUsuario
(
    @matricula VARCHAR(10)
)
RETURNS INT
AS
BEGIN
    DECLARE @idUsuario INT;
    SET @idUsuario = (
        SELECT idUsuario 
        FROM Usuarios 
        WHERE matricula = @matricula
    );
    RETURN @idUsuario;
END;

-- Obtener toda la informacion del usuario
CREATE FUNCTION ObtenerColumnasUsuario
(
    @idUsuario INT
)
RETURNS TABLE
AS
RETURN (
    SELECT *
    FROM Usuarios
    WHERE idUsuario = @idUsuario
);

-- Modificar informacion del usuario
CREATE PROCEDURE ModificarUsuario 
    @idUsuario INT,
    @password INT,
    @salt INT,
    @nombre VARCHAR(15),
    @apellidoPaterno VARCHAR(15),
    @apellidoMaterno VARCHAR(15),
    @zona VARCHAR(30)
AS
BEGIN
    UPDATE Usuarios
    SET
        password = @password,
        salt = @salt,
        nombre = @nombre,
        apellidoPaterno = @apellidoPaterno,
        apellidoMaterno = @apellidoMaterno,
        zona = @zona
    WHERE idUsuario = @idUsuario;
END;