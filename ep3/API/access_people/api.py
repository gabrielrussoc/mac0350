from flask import Blueprint, request, jsonify
from http import HTTPStatus
from access import services
from jwt_wrapper.auth import create_token
from . import db

blueprint = Blueprint('access_people', __name__)

@blueprint.route('/signup', methods=['POST'])
def signup():
    """Cadastra um usuario

    Arguments:
        email {string} -- Email
        password {string} -- Senha
        cpf {string} -- CPF somente numeros
        nome {string} -- Nome
        sexo {string} -- Sexo (caractere 'M' ou 'F')
        data_nascimento {string} -- Data de nascimento 'yyyy-MM-dd'
    """
    params = request.get_json()
    email = params['email']
    password = params['password']
    cpf = params['cpf']
    nome = params['nome']
    sexo = params['sexo']
    data_nascimento = params['data_nascimento']
    user_id = db.cadastro(email, password, cpf, nome, sexo, data_nascimento)
    return jsonify({ 'msg': 'User created', 'jwt': create_token(user_id) }), HTTPStatus.CREATED