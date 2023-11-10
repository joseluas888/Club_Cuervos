import pyodbc

# Define MSSQL database connection details
conn_str = (
    "DRIVER={ODBC Driver 18 for SQL Server};"
    "SERVER=100.80.80.7;" # Change to Team IP address assigned
    "DATABASE=usuarios;" # Change to right DB 
    "UID=SA;"
    "PWD=Shakira123.;"
    "TrustServerCertificate=yes"  # Disable certificate validation
)

# Function to establish a database connection
def get_db_connection():
    try:
        conn = pyodbc.connect(conn_str)
        return conn
    except Exception as e:
        return None

# Create a user in the database
def create_user(userid, username, email,passwd):
    try:
        conn = get_db_connection()
        cursor = conn.cursor()

        cursor.execute(" INSERT INTO users (UserID, username, email, PasswordHash) VALUES (?, ?, ?, HASHBYTES('SHA2_256',?))", (userid, username, email, passwd))
        conn.commit()

        cursor.close()
        conn.close()

        return True
    except Exception as e:
        return False

# Retrieve all users from the database
def get_users():
    try:
        conn = get_db_connection()
        cursor = conn.cursor()

        cursor.execute("SELECT * FROM Usuarios")
        users = [{'idUsuario': row[0], 'nombreUsuario': row[1], 'password': row[2]} for row in cursor.fetchall()]

        cursor.close()
        conn.close()

        return users
    except Exception as e:
        return []

# Update a user in the database
def update_user(userID, username, email, passwd):
    try:
        conn = get_db_connection()
        cursor = conn.cursor()

        cursor.execute("UPDATE users SET username = ?, email = ?, PasswordHash = HASHBYTES('SHA2_256',?) WHERE UserID = ?", (username, email, passwd, userID))
        conn.commit()

        cursor.close()
        conn.close()

        return True
    except Exception as e:
        return False
    


# Delete a user from the database
def delete_user(userID):
    try:
        conn = get_db_connection()
        cursor = conn.cursor()

        cursor.execute("DELETE FROM users WHERE UserID = ?", (userID,))
        conn.commit()

        cursor.close()
        conn.close()

        return True
    except Exception as e:
        return False

###

# Retrieve salt from the database
def get_salt(nombreUsuario):
    try:
        conn = get_db_connection()
        cursor = conn.cursor()

        cursor.execute("SELECT salt from Usuarios WHERE nombreUsuario = ?", (nombreUsuario))
        salt = cursor.fetchone()[0]

        cursor.close()
        conn.close()

        return salt
    except Exception as e:
        return []
    
# Verify Credentials
def verify_user(nombreUsuario, hashed_password):
    try:
        # Create a new connection to the database
        conn = get_db_connection()
        cursor = conn.cursor()

        # Write the query
        query = "SELECT * FROM Usuarios WHERE nombreUsuario = ? AND password = ? AND permisoUsuario = 1"

        # Execute the query with the provided matricula and hashed_password
        cursor.execute(query, (nombreUsuario, hashed_password))

        # Fetch one row
        row = cursor.fetchone()

        # Close the cursor and connection
        cursor.close()
        conn.close()

        # If a row is returned, then the matricula and password are correct
        if row:
            return row[0]
        else:
            return False
    except Exception as e:
        print(e)
        return False

def get_receipts(user_id):
    try:
        conn = get_db_connection()
        cursor = conn.cursor()

        query = """
        SELECT folioRecibo, monto, nombre, apellidoPaterno, apellidoMaterno, detalles, municipio, calle, numero, referencias, telefonoPrincipal, telefonoSecundario, telefonoCelular
        FROM Recibos
        INNER JOIN Donativos ON Recibos.idDonativo = Donativos.idDonativo
        INNER JOIN Donantes ON Donativos.folioDonante = Donantes.folioDonante
        INNER JOIN Direcciones ON Donantes.folioDonante = Direcciones.folioDonante
        INNER JOIN Contactos ON Donantes.folioDonante = Contactos.folioDonante
        WHERE idUsuario = ? AND estatus = 1;
        """
        cursor.execute(query, (user_id,))

        receipts = [{'folioRecibo': row[0], 'monto': row[1], 'nombre': row[2], 'apellidoPaterno': row[3], 'apellidoMaterno': row[4], 'detalles': row[5], 'municipio': row[6], 'calle': row[7], 'numero': row[8], 'referencias': row[9], 'telefonoPrincipal': row[10], 'telefonoSecundario': row[11], 'telefonoCelular': row[12]} for row in cursor.fetchall()]

        cursor.close()
        conn.close()

        return receipts
    except Exception as e:
        print(e)
        return []


def mark_receipt_as_paid(receipt_id):
    try:
        conn = get_db_connection()
        cursor = conn.cursor()

        query = """
        UPDATE Donativos
        SET cobrado = 1
        FROM Donativos INNER JOIN Recibos ON Donativos.idDonativo = Recibos.idDonativo
        WHERE folioRecibo = ?;
        """
        cursor.execute(query, (receipt_id,))

        # Commit the transaction
        conn.commit()

        # Close the cursor and connection
        cursor.close()
        conn.close()

        return True
    except Exception as e:
        print(e)
        return False

def add_comment_to_receipt(receipt_id, comment):
    try:
        conn = get_db_connection()
        cursor = conn.cursor()

        query = """
        UPDATE Recibos
        SET comentarios = ?
        WHERE folioRecibo = ?;
        """
        cursor.execute(query, (comment, receipt_id))

        # Commit the transaction
        conn.commit()

        # Close the cursor and connection
        cursor.close()
        conn.close()

        return True
    except Exception as e:
        print(e)
        return False

# Verify Admin Credentials
def verify_user_admin(nombreUsuario, hashed_password):
    try:
        # Create a new connection to the database
        conn = get_db_connection()
        cursor = conn.cursor()

        # Write the query
        query = "SELECT * FROM Usuarios WHERE nombreUsuario = ? AND password = ? AND permisoUsuario = 2"

        # Execute the query with the provided matricula and hashed_password
        cursor.execute(query, (nombreUsuario, hashed_password))

        # Fetch one row
        row = cursor.fetchone()

        # Close the cursor and connection
        cursor.close()
        conn.close()

        # If a row is returned, then the matricula and password are correct
        if row:
            return row[0]
        else:
            return False
    except Exception as e:
        print(e)
        return False
