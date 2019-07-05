from flask import Blueprint, request, jsonify
from http import HTTPStatus
from . import db
from access import services
from jwt_wrapper.auth import service, create_token, get_user_id

blueprint = Blueprint('curriculum', __name__)

@blueprint.route('/<cu_codigo>', methods=['GET'])
def lista_trilhas(cu_codigo):
    return jsonify({ 'trilhas': db.lista_trilhas(cu_codigo) })

@blueprint.route('/<cu_codigo>/disciplinas', methods=['GET'])
def lista_disciplinas_do_curriculo(cu_codigo):
    return jsonify({ 'disciplinas': db.lista_disciplinas_do_curriculo(cu_codigo) })

@blueprint.route('/', methods=['POST'])
@service(services.INSERE_CURRICULO)
def insere_curriculo():
    params = request.get_json()
    codigo = params['codigo']
    ad_NUSP = params['ad_NUSP']
    nome = params['nome']
    instituto = params['instituto']
    descricao = params['descricao']
    db.insere_curriculo(codigo, ad_NUSP, nome, instituto, descricao)
    return jsonify({ 'msg': 'Curriculum created' })

@blueprint.route('/', methods=['PUT'])
@service(services.ATUALIZA_CURRICULO)
def atualiza_curriculo():
    params = request.get_json()
    codigo = params['codigo']
    ad_NUSP = params['ad_NUSP']
    nome = params['nome']
    instituto = params['instituto']
    descricao = params['descricao']
    db.atualiza_curriculo(codigo, ad_NUSP, nome, instituto, descricao)
    return jsonify({ 'msg': 'Curriculum updated' })

@blueprint.route('/', methods=['DELETE'])
@service(services.DELETA_CURRICULO)
def deleta_curriculo():
    params = request.get_json()
    codigo = params['codigo']
    db.deleta_curriculo(codigo)
    return jsonify({ 'msg': 'Curriculum deleted' })

@blueprint.route('/disciplina', methods=['POST'])
@service(services.INSERE_DISCIPLINA)
def insere_disciplina():
    params = request.get_json()
    codigo = params['codigo']
    nome = params['nome']
    departamento = params['departamento']
    descricao = params['descricao']
    creditos = params['creditos']
    db.insere_disciplina(codigo, nome, departamento, descricao, creditos)
    return jsonify({ 'msg': 'Course created' })

@blueprint.route('/disciplina', methods=['PUT'])
@service(services.ATUALIZA_DISCIPLINA)
def atualiza_disciplina():
    params = request.get_json()
    codigo = params['codigo']
    nome = params['nome']
    departamento = params['departamento']
    descricao = params['descricao']
    creditos = params['creditos']
    db.atualiza_disciplina(codigo, nome, departamento, descricao, creditos)
    return jsonify({ 'msg': 'Course updated' })

@blueprint.route('/disciplina', methods=['DELETE'])
@service(services.DELETA_DISCIPLINA)
def deleta_disciplina():
    params = request.get_json()
    codigo = params['codigo']
    db.deleta_disciplina(codigo)
    return jsonify({ 'msg': 'Course deleted' })

@blueprint.route('/trilha/<tr_codigo>', methods=['GET'])
def lista_modulos(tr_codigo):
    return jsonify({ 'modulos': db.lista_modulos(tr_codigo) })

@blueprint.route('/trilha', methods=['POST'])
@service(services.INSERE_TRILHA)
def insere_trilha():
    params = request.get_json()
    codigo = params['codigo']
    nome = params['nome']
    descricao = params['descricao']
    cu_codigo = params['cu_codigo']
    db.insere_trilha(codigo, nome, descricao, cu_codigo)
    return jsonify({ 'msg': 'Specialization created' })

@blueprint.route('/trilha', methods=['PUT'])
@service(services.ATUALIZA_TRILHA)
def atualiza_trilha():
    params = request.get_json()
    codigo = params['codigo']
    nome = params['nome']
    descricao = params['descricao']
    cu_codigo = params['cu_codigo']
    db.atualiza_trilha(codigo, nome, descricao, cu_codigo)
    return jsonify({ 'msg': 'Specialization updated' })

@blueprint.route('/trilha', methods=['DELETE'])
@service(services.DELETA_TRILHA)
def deleta_trilha():
    params = request.get_json()
    codigo = params['codigo']
    db.deleta_trilha(codigo)
    return jsonify({ 'msg': 'Specialization deleted' })

@blueprint.route('/modulo/<mo_codigo>', methods=['GET'])
def lista_disciplinas_do_modulo(mo_codigo):
    return jsonify({ 'disciplinas': db.lista_disciplinas_do_modulo(mo_codigo) })

@blueprint.route('/modulo', methods=['POST'])
@service(services.INSERE_MODULO)
def insere_modulo():
    params = request.get_json()
    codigo = params['codigo']
    nome = params['nome']
    descricao = params['descricao']
    tr_codigo = params['tr_codigo']
    db.insere_modulo(codigo, nome, descricao, tr_codigo)
    return jsonify({ 'msg': 'Module created' })

@blueprint.route('/modulo', methods=['PUT'])
@service(services.ATUALIZA_MODULO)
def atualiza_modulo():
    params = request.get_json()
    codigo = params['codigo']
    nome = params['nome']
    descricao = params['descricao']
    tr_codigo = params['tr_codigo']
    db.atualiza_modulo(codigo, nome, descricao, tr_codigo)
    return jsonify({ 'msg': 'Module updated' })

@blueprint.route('/modulo', methods=['DELETE'])
@service(services.DELETA_MODULO)
def deleta_modulo():
    params = request.get_json()
    codigo = params['codigo']
    db.deleta_modulo(codigo)
    return jsonify({ 'msg': 'Module delete' })

@blueprint.route('disciplina/modulo', methods=['POST'])
@service(services.INSERE_DISCIPLINA_NO_MODULO)
def insere_disciplina_modulo():
    params = request.get_json()
    di_codigo = params['di_codigo']
    mo_codigo = params['mo_codigo']
    obrigatoria = params['obrigatoria']
    db.insere_disciplina_no_modulo(di_codigo, mo_codigo, obrigatoria)
    return jsonify({ 'msg': 'Course inserted into module' })

@blueprint.route('disciplina/modulo', methods=['PUT'])
@service(services.ATUALIZA_OBRIGATORIA)
def atualiza_obrigatoria():
    params = request.get_json()
    di_codigo = params['di_codigo']
    mo_codigo = params['mo_codigo']
    obrigatoria = params['obrigatoria']
    db.atualiza_obrigatoria(di_codigo, mo_codigo, obrigatoria)
    return jsonify({ 'msg': 'Course updated into module' })

@blueprint.route('/disciplina/modulo', methods=['DELETE'])
@service(services.DELETA_RELACAO_DISCIPLINA_MODULO)
def deleta_disciplina_modulo():
    params = request.get_json()
    di_codigo = params['di_codigo']
    mo_codigo = params['mo_codigo']
    db.deleta_rel_dis_mod(di_codigo, mo_codigo)
    return jsonify({ 'msg': 'Course delete from module' })
