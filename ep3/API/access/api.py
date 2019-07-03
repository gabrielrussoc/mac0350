from flask import Blueprint, request, jsonify
from http import HTTPStatus
from . import db, services
from jwt_wrapper.auth import service, create_token, get_user_id

blueprint = Blueprint('access', __name__)

@blueprint.route('/password', methods=['PUT'])
@service(services.ATUALIZA_SENHA)
def update_password():
    """Atualiza a senha de um usuário logado.
    
    Arguments:
        password {string} -- Nova senha
    """
    params = request.get_json()
    user_id = get_user_id()
    password = params['password']
    db.update_password(user_id, password)
    return jsonify({ 'msg': 'Password updated' })

@blueprint.route('/login', methods=['POST'])
def login():
    """Faz login no sistema.
    
    Arguments:
        email {string} -- Email do usuário
        password {string} -- Senha do usuário
    
    Returns:
        string -- token de acesso JWT
    """
    params = request.get_json()
    email = params['email']
    password = params['password']
    if db.check_password(email, password):
        user_id = db.id(email)
        return jsonify({ 'jwt': create_token(user_id) })
    return jsonify({ 'msg': 'Wrong credentials' }), HTTPStatus.UNAUTHORIZED