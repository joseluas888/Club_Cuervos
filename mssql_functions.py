import pyodbc

import os
# Obtener las variables de entorno
driver = os.getenv('DRIVER')
server = os.getenv('SERVER')
database = os.getenv('DATABASE')
uid = os.getenv('DBUSER')
pwd = os.getenv('PWD')
trust_certificate = os.getenv('TRUST_CERTIFICATE')

# Ahora puedes usar estas variables para construir tu cadena de conexión
conn_str = (
    f"DRIVER={{{driver}}};"
    f"SERVER={server};"
    f"DATABASE={database};"
    f"UID={uid};"
    f"PWD={pwd};"
    f"TrustServerCertificate={trust_certificate}"
)


# Function to establish a database connection
def get_db_connection():
    try:
        conn = pyodbc.connect(conn_str)
        return conn
    except Exception as e:
        return None

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


# Function to obtain the salt of a user (HU1)
def get_salt(nombreUsuario):
    try:
        conn = get_db_connection()
        cursor = conn.cursor()

        cursor.execute("SELECT * FROM ObtenerSalt(?)", (nombreUsuario,))
        salt = cursor.fetchone()[0]

        cursor.close()
        conn.close()

        return salt
    except Exception as e:
        print(e)
        return []
    
# Function to verify user credentials (HU1)
def verify_user(nombreUsuario, hashed_password):
    try:
        conn = get_db_connection()
        cursor = conn.cursor()

        cursor.execute("SELECT * FROM VerificarCredencialesUsuario(?, ?)", (nombreUsuario, hashed_password))
        user_id = cursor.fetchone()[0]

        cursor.close()
        conn.close()

        return user_id
    except Exception as e:
        print(e)
        return False

# Function to get user receipts (HU2 and HU9)
def get_receipts(user_id):
    try:
        conn = get_db_connection()
        cursor = conn.cursor()

        cursor.execute("SELECT * FROM ObtenerRecibosUsuario(?)", (user_id,))
        receipts = [{'folioRecibo': row[0], 'monto': row[1], 'cobrado': row[2], 'comentarios': row[3], 'nombre': row[4], 'apellidoPaterno': row[5], 'apellidoMaterno': row[6], 'detalles': row[7], 'municipio': row[8], 'calle': row[9], 'numero': row[10], 'referencias': row[11], 'telefonoPrincipal': row[12], 'telefonoSecundario': row[13], 'telefonoCelular': row[14]} for row in cursor.fetchall()]

        cursor.close()
        conn.close()

        return receipts
    except Exception as e:
        print(e)
        return []


# Function to mark a receipt as paid (HU3)
def mark_receipt_as_paid(receipt_id):
    try:
        conn = get_db_connection()
        cursor = conn.cursor()

        cursor.execute("EXEC CobrarRecibo @folioRecibo = ?", (receipt_id,))

        # Commit the transaction
        conn.commit()

        # Close the cursor and connection
        cursor.close()
        conn.close()

        return True
    except Exception as e:
        print(e)
        return False

# Function to add comments to a receipt when not paid (HU4)
def add_comment_to_receipt(receipt_id, comment):
    try:
        conn = get_db_connection()
        cursor = conn.cursor()

        cursor.execute("EXEC ComentarRecibo @folioRecibo = ?, @comentarios = ?", (receipt_id, comment))

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
        conn = get_db_connection()
        cursor = conn.cursor()

        cursor.execute("SELECT * FROM VerificarCredencialesAdministrador (?, ?)", (nombreUsuario, hashed_password))
        user_id = cursor.fetchone()[0]

        cursor.close()
        conn.close()

        return user_id
    except Exception as e:
        print(e)
        return False

# Function to get collectors (HU8)
def get_collectors():
    try:
        conn = get_db_connection()
        cursor = conn.cursor()

        cursor.execute("SELECT idUsuario, nombre, apellidoPaterno, apellidoMaterno, zona FROM ObtenerRecolectores()")
        collectors = [{'idUsuario': row[0], 'nombre': row[1], 'apellidoPaterno': row[2], 'apellidoMaterno': row[3], 'zona': row[4]} for row in cursor.fetchall()]

        cursor.close()
        conn.close()

        return collectors
    except Exception as e:
        print(e)
        return []
    
# Function to get paid and unpaid receipts (HU10 - C2)
def get_paid_unpaid_receipts():
    try:
        conn = get_db_connection()
        cursor = conn.cursor()

        cursor.execute("SELECT estadoCobro, cantidad FROM ObtenerRecibosCobradosNoCobrados()")
        results = [{'estadoCobro': row[0], 'cantidad': row[1]} for row in cursor.fetchall()]

        cursor.close()
        conn.close()

        return results
    except Exception as e:
        print(e)
        return []

# Function to get paid receipts by zone (HU10 - C3)
def get_paid_receipts_by_zone():
    try:
        conn = get_db_connection()
        cursor = conn.cursor()

        cursor.execute("SELECT municipio, cantidad FROM ObtenerRecibosCobradosPorZona()")
        results = [{'municipio': row[0], 'cantidad': row[1]} for row in cursor.fetchall()]

        cursor.close()
        conn.close()

        return results
    except Exception as e:
        print(e)
        return []
    
# Function to get money collected in the last 5 days (HU10 - C4)
def get_income_last_5_days():
    try:
        conn = get_db_connection()
        cursor = conn.cursor()

        cursor.execute("SELECT estadoCobro, sumatoriaMontos FROM ObtenerImportes()")
        results = [{'estadoCobro': row[0], 'sumatoriaMontos': row[1]} for row in cursor.fetchall()]

        cursor.close()
        conn.close()

        return results
    except Exception as e:
        print(e)
        return []