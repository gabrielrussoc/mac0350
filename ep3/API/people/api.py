from flask import Blueprint, request, jsonify
from http import HTTPStatus
from . import db

blueprint = Blueprint('people', __name__)

@blueprint.route('/aluno', methods=['POST'])
def insert_student():
    params = request.get_json()
    cpf = params['cpf']
    nusp = params['nusp']
    curriculum = params['curriculo']
    db.insert_student(cpf, nusp, curriculum)
    return ('', HTTPStatus.NO_CONTENT)

@blueprint.route('/professor', methods=['POST'])
def insert_professor():
    params = request.get_json()
    cpf = params['cpf']
    nusp = params['nusp']
    institution = params['instituto']
    db.insert_professor(cpf, nusp, institution)
    return ('', HTTPStatus.NO_CONTENT)

@blueprint.route('/administrador', methods=['POST'])
def insert_administrator():
    params = request.get_json()
    cpf = params['cpf']
    nusp = params['nusp']
    title = params['cargo']
    db.insert_administrator(cpf, nusp, title)
    return ('', HTTPStatus.NO_CONTENT)
