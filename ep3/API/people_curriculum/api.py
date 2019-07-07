from flask import Blueprint, request, jsonify
from http import HTTPStatus
from access import services
from jwt_wrapper.auth import service, jwt_required, get_user_id
from . import db
from access_people import db as access_db

blueprint = Blueprint('people_curriculum', __name__)

@blueprint.route('/disciplinas/ministradas', methods=['POST'])
@service(services.INSERE_MINISTRA)
def insere_ministra():
    prof = access_db.get_user(get_user_id())["pr_nusp"]
    di_codigo = request.get_json()["codigo"]
    db.insere_ministra(prof, di_codigo)
    return jsonify({ 'msg': 'Inserido' })

@blueprint.route('/disciplinas/planejadas', methods=['POST'])
@service(services.INSERE_PLANEJA)
def insere_planeja():
    al = access_db.get_user(get_user_id())["al_nusp"]
    di_codigo = request.get_json()["codigo"]
    db.insere_planeja(al, di_codigo)
    return jsonify({ 'msg': 'Inserido' })

@blueprint.route('/disciplinas/oferecidas', methods=['POST'])
@service(services.INSERE_OFERECIMENTO)
def insere_oferecimento():
    prof = access_db.get_user(get_user_id())["pr_nusp"]
    req = request.get_json()
    di_codigo = req["codigo"]
    semestre = req["semestre"]
    db.insere_oferecimento(prof, di_codigo, semestre)
    return jsonify({ 'msg': 'Inserido' })

@blueprint.route('/disciplinas/cursadas', methods=['POST'])
@service(services.INSERE_CURSA)
def insere_cursa():
    al = access_db.get_user(get_user_id())["al_nusp"]
    of_id = request.get_json()["oferecimento"]
    db.insere_cursa(al, of_id)
    return jsonify({ 'msg': 'Inserido' })

@blueprint.route('/disciplinas/ministradas', methods=['DELETE'])
@service(services.DELETA_RELACAO_MINISTRA)
def deleta_ministra():
    prof = access_db.get_user(get_user_id())["pr_nusp"]
    di_codigo = request.get_json()["codigo"]
    db.deleta_ministra(prof, di_codigo)
    return jsonify({ 'msg': 'Removido' })

@blueprint.route('/disciplinas/planejadas', methods=['DELETE'])
@service(services.DELETA_RELACAO_PLANEJA)
def deleta_planeja():
    al = access_db.get_user(get_user_id())["al_nusp"]
    di_codigo = request.get_json()["codigo"]
    db.deleta_planeja(al, di_codigo)
    return jsonify({ 'msg': 'Removido' })

@blueprint.route('/disciplinas/oferecidas', methods=['DELETE'])
@service(services.DELETA_OFERECIMENTO)
def deleta_oferecimento():
    of_id = request.get_json()["oferecimento"]
    db.deleta_oferecimento(of_id)
    return jsonify({ 'msg': 'Removido' })

@blueprint.route('/disciplinas/cursadas', methods=['DELETE'])
@service(services.DELETA_RELACAO_CURSA)
def deleta_cursa():
    al = access_db.get_user(get_user_id())["al_nusp"]
    of_id = request.get_json()["oferecimento"]
    db.deleta_cursa(al, of_id)
    return jsonify({ 'msg': 'Removido' })

@blueprint.route('/disciplinas/cursadas', methods=['GET'])
@service(services.LISTA_DISCIPLINAS_CURSADAS)
def lista_disciplinas_cursadas():
    user = access_db.get_user(get_user_id())
    if user["al_nusp"] != None:
        return jsonify(db.lista_disciplinas_cursadas(user["al_nusp"])), HTTPStatus.OK
    else:
        return '', HTTPStatus.NO_CONTENT

@blueprint.route('/disciplinas/cursadas/creditos', methods=['GET'])
@service(services.LISTA_DISCIPLINAS_CURSADAS)
def lista_creditos_cursados():
    user = access_db.get_user(get_user_id())
    if user["al_nusp"] != None:
        return jsonify(db.lista_creditos_cursados(user["al_nusp"])), HTTPStatus.OK
    else:
        return '', HTTPStatus.NO_CONTENT

@blueprint.route('/disciplinas/planejadas', methods=['GET'])
@service(services.LISTA_DISCIPLINAS_PLANEJADAS)
def lista_disciplinas_planejadas():
    user = access_db.get_user(get_user_id())
    if user["al_nusp"] != None:
        return jsonify(db.lista_disciplinas_planejadas(user["al_nusp"])), HTTPStatus.OK
    else:
        return '', HTTPStatus.NO_CONTENT

@blueprint.route('/disciplinas/planejadas/creditos', methods=['GET'])
@service(services.LISTA_DISCIPLINAS_PLANEJADAS)
def lista_creditos_planejados():
    user = access_db.get_user(get_user_id())
    if user["al_nusp"] != None:
        return jsonify(db.lista_creditos_planejados(user["al_nusp"])), HTTPStatus.OK
    else:
        return '', HTTPStatus.NO_CONTENT


@blueprint.route('/disciplinas/ministradas', methods=['GET'])
@service(services.LISTA_DISCIPLINAS_MINISTRADAS)
def lista_disciplinas_ministradas():
    user = access_db.get_user(get_user_id())
    if user["pr_nusp"] != None:
        return jsonify(db.lista_disciplinas_ministradas(user["pr_nusp"])), HTTPStatus.OK
    else:
        return '', HTTPStatus.NO_CONTENT

@blueprint.route('/disciplinas/oferecidas', methods=['GET'])
@service(services.LISTA_DISCIPLINAS_OFERECIDAS)
def lista_disciplinas_oferecidas():
    user = access_db.get_user(get_user_id())
    if user["pr_nusp"] != None:
        return jsonify(db.lista_disciplinas_oferecidas(user["pr_nusp"])), HTTPStatus.OK
    else:
        return '', HTTPStatus.NO_CONTENT

@blueprint.route('/oferecimentos/<id>/alunos', methods=['GET'])
def lista_alunos_do_oferecimento(id):
    return jsonify(db.lista_alunos_do_oferecimento(id)), HTTPStatus.OK

@blueprint.route('/oferecimentos/<id>/notas', methods=['PUT'])
@service(services.ATUALIZA_NOTA)
def atualiza_nota(of_id):
    params = request.get_json()
    aluno = params['al_NUSP']
    nota = params['nota']
    db.atualiza_nota(aluno, of_id, nota)
    return jsonify({ 'msg': 'Grade updated' })