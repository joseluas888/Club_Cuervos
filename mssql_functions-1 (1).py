import pyodbc

# Define MSSQL database connection details
conn_str = (
    "DRIVER={ODBC Driver 18 for SQL Server};"
    "SERVER=100.80.80.3;" # Change to Team IP address assigned
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

        cursor.execute("SELECT UserID, username, email FROM users")
        users = [{'ID': row[0], 'User': row[1], 'email': row[2]} for row in cursor.fetchall()]

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
        query = "SELECT * FROM Users WHERE nombreUsuario = ? AND password = ?"
        
        # Execute the query with the provided nombreUsuario and hashed_password
        cursor.execute(query, (nombreUsuario, hashed_password))

        # Fetch one row
        row = cursor.fetchone()

        # Close the cursor and connection
        cursor.close()
        conn.close()

        # If a row is returned, then the nombreUsuario and password are correct
        if row:
            return row[0]
        else:
            return False
    except Exception as e:
        print(e)
        return False


# get recibos
def get_recibos(nombreUsuario):
    try:
        conn = get_db_connection()
        cursor = conn.cursor()

        cursor.execute("SELECT UserID, nombreUsuario FROM users WHERE nombreUsuarios = ?",(nombreUsuario))
        users = [{'ID': row[0], 'nombreUsuario': row[1]} for row in cursor.fetchall()]

        cursor.close()
        conn.close()

        return users
    except Exception as e:
        print(e)
        return