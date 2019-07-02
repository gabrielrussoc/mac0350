from flask import Blueprint, request, jsonify
from http import HTTPStatus
from . import db

blueprint = Blueprint('access', __name__)

@blueprint.route('/authorize', methods=['GET'])
def authorize():
    """Verifica se um usuário tem acesso a um serviço.
    
    Arguments:
        user_id {int} -- ID do usuário
        service {string} -- Nome do serviço
    
    Returns:
        bool -- se o usuário está autorizado
    """
    user_id = request.args['user_id']
    service = request.args['service']
    return jsonify(db.authorize(user_id, service))

@blueprint.route('/password', methods=['PUT'])
def update_password():
    """Atualiza a senha de um usuário.
    
    Arguments:
        user_id {int} -- ID do usuário
        password {string} -- Nova senha
    """
    params = request.get_json()
    user_id = params['user_id']
    password = params['password']
    db.update_password(user_id, password)
    return ('', HTTPStatus.NO_CONTENT)

@blueprint.route('/login', methods=['POST'])
def login():
    """Faz login no sistema.
    
    Arguments:
        email {string} -- Email do usuário
        password {string} -- Senha do usuário
    
    Returns:
        bool -- se as credenciais estão corretas
    """
    params = request.get_json()
    email = params['email']
    password = params['password']
    return jsonify(db.login(email, password))