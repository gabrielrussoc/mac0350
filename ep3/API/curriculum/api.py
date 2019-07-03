from flask import Blueprint, request, jsonify
from http import HTTPStatus
from . import db

blueprint = Blueprint('curriculum', __name__)

@blueprint.route('/')
def home():
    return "IT WORKS"

@blueprint.route('/insere', methods=['POST'])
def insere_curriculo():
    params = request.get_json()
    codigo = params['codigo']
    ad_NUSP = params['ad_NUSP']
    nome = params['nome']
    instituto = params['instituto']
    descricao = params['descricao']
    db.insere_curriculo(codigo, ad_NUSP, nome, instituto, descricao)
    return ('', HTTPStatus.NO_CONTENT)

@blueprint.route('/deleta', methods=['POST'])
def deleta_curriculo():
    params = request.get_json()
    codigo = params['codigo']
    db.deleta_curriculo(codigo)
    return ('', HTTPStatus.NO_CONTENT)

@blueprint.route('/insere/disciplina', methods=['POST'])
def insere_disciplina():
    params = request.get_json()
    codigo = params['codigo']
    nome = params['nome']
    departamento = params['departamento']
    descricao = params['descricao']
    creditos = params['creditos']
    db.deleta_disciplina(codigo, nome, departamento, descricao, creditos)
    return ('', HTTPStatus.NO_CONTENT)

@blueprint.route('/deleta/disciplina', methods=['POST'])
def deleta_disciplina():
    params = request.get_json()
    codigo = params['codigo']
    db.deleta_disciplina(codigo)
    return ('', HTTPStatus.NO_CONTENT)

@blueprint.route('/insere/trilha', methods=['POST'])
def insere_trilha():
    params = request.get_json()
    codigo = params['codigo']
    nome = params['nome']
    descricao = params['descricao']
    cu_codigo = params['cu_codigo']
    db.insere_trilha(codigo, nome, descricao, cu_codigo)
    return ('', HTTPStatus.NO_CONTENT)

@blueprint.route('/deleta/trilha', methods=['POST'])
def deleta_trilha():
    params = request.get_json()
    codigo = params['codigo']
    db.deleta_trilha(codigo)
    return ('', HTTPStatus.NO_CONTENT)

@blueprint.route('/insere/modulo', methods=['POST'])
def insere_modulo():
    params = request.get_json()
    codigo = params['codigo']
    nome = params['nome']
    descricao = params['descricao']
    tr_codigo = params['tr_codigo']
    db.insere_modulo(codigo, nome, descricao, tr_codigo)
    return ('', HTTPStatus.NO_CONTENT)

@blueprint.route('/deleta/modulo', methods=['POST'])
def deleta_modulo():
    params = request.get_json()
    codigo = params['codigo']
    db.deleta_modulo(codigo)
    return ('', HTTPStatus.NO_CONTENT)

@blueprint.route('/insere/disciplina/modulo', methods=['POST'])
def insere_disciplina_modulo():
    params = request.get_json()
    di_codigo = params['di_codigo']
    mo_codigo = params['mo_codigo']
    obrigatoria = params['obrigatoria']
    db.insere_disciplina_no_modulo(di_codigo, mo_codigo, obrigatoria)
    return ('', HTTPStatus.NO_CONTENT)

@blueprint.route('/deleta/disciplina/modulo', methods=['POST'])
def deleta_disciplina_modulo():
    params = request.get_json()
    di_codigo = params['di_codigo']
    mo_codigo = params['mo_codigo']
    db.deleta_rel_dis_mod(di_codigo, mo_codigo)
    return ('', HTTPStatus.NO_CONTENT)
