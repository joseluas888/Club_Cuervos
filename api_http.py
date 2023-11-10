from flask import Flask, request, jsonify
import mssql_functions as mssql
import hashlib
import binascii

app = Flask(__name__)

# Shakira Rocks
@app.route('/hello', methods=['GET'])
def hello():
    message = "Shakira Rocks!"
    return jsonify(message), 200

# Create a user in the database
@app.route('/users', methods=['POST'])
def create_user():
    data = request.get_json()
    userid = data['UserID']
    username = data['username']
    email = data['email']
    passwd = data['password']

    if mssql.create_user(userid, username, email, passwd):
        return jsonify({'message': 'User created successfully'}), 201
    else:
        return jsonify({'error': 'Failed to create user'}), 500

# Retrieve all users from the database
@app.route('/users', methods=['GET'])
def get_users():
    users = mssql.get_users()
    return jsonify(users), 200

# Update a user in the database
@app.route('/users/<int:user_id>', methods=['PUT'])
def update_user(user_id):
    data = request.get_json()
    username = data['username']
    email = data['email']
    passwd = data['password']

    if mssql.update_user(user_id, username, email, passwd):
        return jsonify({'message': 'User updated successfully'}), 200
    else:
        return jsonify({'error': 'Failed to update user'}), 500
    

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

# UPDATE comments to a receipt number
@app.route('/comments/<int:receipt_id>', methods=['PUT'])
def comment(receipt_id):
    data = request.get_json()
    comment = data['comment']

    if mssql.update_comment(receipt_id, comment):
        return jsonify({'message': 'Comment updated successfully'}), 200
    else:
        return jsonify({'error': 'Failed to update comment'}), 500

# Delete a user from the database
@app.route('/users/<int:userId>', methods=['DELETE'])
def delete_user(userId):
    if mssql.delete_user(userId):
        return jsonify({'message': 'User deleted successfully'}), 200
    else:
        return jsonify({'error': 'Failed to delete user'}), 500

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

if __name__ == '__main__':
    app.run(debug=True, port=8084, host='0.0.0.0')

