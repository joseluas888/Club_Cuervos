from flask import Flask, request, jsonify
import mssql_functions as mssql
import hashlib
import binascii

app = Flask(__name__)


# Retrieve all users from the database
@app.route('/users', methods=['GET'])
def get_users():
    users = mssql.get_users()
    return jsonify(users), 200


# Verify User
@app.route('/login', methods=['POST'])
def login():
    data = request.get_json()
    nombreUsuario = data['nombreUsuario']
    password = data['password']

    # Get the salt value for the user
    salt = mssql.get_salt(nombreUsuario)

    # Hash the password with SHA256 and the salt
    dk = hashlib.pbkdf2_hmac('sha256', password.encode(), salt.encode(), 100000)
    hashed_password  = (binascii.hexlify(dk)).decode()

    # Print the matricula and hashed_password
    print("nombreUsuario: ", nombreUsuario)
    print("Contrasena hasheada: ", hashed_password)

    idUsuario = mssql.verify_user(nombreUsuario,hashed_password)

    # Verify the hashed password
    if idUsuario:
        return jsonify({'message': 'Login successful', 'idUsuario': idUsuario}), 200
    else:
        return jsonify({'error': 'Invalid matricula or password'}), 401

# Retrieve receipts
@app.route('/receipts/<int:user_id>', methods=['GET'])
def get_receipts(user_id):
    receipts = mssql.get_receipts(user_id)
    return jsonify(receipts), 200

# Update receipt status PAID
@app.route('/paid/<int:receipt_id>', methods=['PUT'])
def paid(receipt_id):
    if mssql.mark_receipt_as_paid(receipt_id):
        return jsonify({'message': 'Receipt status updated to PAID'}), 200
    else:
        return jsonify({'error': 'Failed to update receipt status'}), 500

# Update receipt status NOT PAID
@app.route('/not_paid/<int:receipt_id>', methods=['PUT'])
def not_paid(receipt_id):
    if mssql.update_receipt_status(receipt_id, 'NOT PAID'):
        return jsonify({'message': 'Receipt status updated to NOT PAID'}), 200
    else:
        return jsonify({'error': 'Failed to update receipt status'}), 500

# Add Comentario
@app.route('/comment/<int:receipt_id>', methods=['PUT'])
def add_comment(receipt_id):
    comment = request.json.get('comment', '')
    if mssql.add_comment_to_receipt(receipt_id, comment):
        return jsonify({'message': 'Comment added to receipt'}), 200
    else:
        return jsonify({'error': 'Failed to add comment'}), 500

# Verify Admin User
@app.route('/login_admin', methods=['POST'])
def login_admin():
    data = request.get_json()
    nombreUsuario = data['nombreUsuario']
    password = data['password']

    # Get the salt value for the user
    salt = mssql.get_salt(nombreUsuario)

    # Hash the password with SHA256 and the salt
    dk = hashlib.pbkdf2_hmac('sha256', password.encode(), salt.encode(), 100000)
    hashed_password  = (binascii.hexlify(dk)).decode()

    # Print the matricula and hashed_password
    print("nombreUsuario: ", nombreUsuario)
    print("Contrasena hasheada: ", hashed_password)

    idUsuario = mssql.verify_user_admin(nombreUsuario,hashed_password)

    # Verify the hashed password
    if idUsuario:
        return jsonify({'message': 'Login successful', 'idUsuario': idUsuario}), 200
    else:
        return jsonify({'error': 'Invalid matricula or password'}), 401
    
    # Existing endpoint: Get Collectors
@app.route('/collectors', methods=['GET'])
def get_collectors():
    collectors = mssql.get_collectors()
    return jsonify(collectors), 200

# Existing endpoint: Get paid and unpaid receipts
@app.route('/paid_unpaid_receipts', methods=['GET'])
def get_paid_unpaid_receipts():
    results = mssql.get_paid_unpaid_receipts()
    return jsonify(results), 200

# Existing endpoint: Get paid receipts by zone
@app.route('/paid_receipts_by_zone', methods=['GET'])
def get_paid_receipts_by_zone():
    results = mssql.get_paid_receipts_by_zone()
    return jsonify(results), 200

# Existing endpoint: Get income in the last 5 days
@app.route('/income_last_5_days', methods=['GET'])
def get_income_last_5_days():
    results = mssql.get_income_last_5_days()
    return jsonify(results), 200
    
API_CERT = '/root/api_https/SSL/equipo18.pem'
API_KEY = '/root/api_https/SSL/equipo18_key.pem'

if __name__ == '__main__':
    import ssl

    context = ssl.SSLContext(ssl.PROTOCOL_TLSv1_2)
    context.load_cert_chain(API_CERT, API_KEY)
    app.run(host='0.0.0.0', port=8082, ssl_context=context, debug=True)

