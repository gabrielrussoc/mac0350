from db.Postgres import Postgres

db = Postgres(database='people_curriculum')

def insere_ministra(pr_NUSP, di_codigo):
    with db.cursor() as cursor:
        cursor.callproc('insere_ministra', [pr_NUSP, di_codigo])

def insere_planeja(al_NUSP, di_codigo):
    with db.cursor() as cursor:
        cursor.callproc('insere_planeja', [al_NUSP, di_codigo])

def insere_oferecimento(pr_NUSP, di_codigo, semestre):
    with db.cursor() as cursor:
        cursor.callproc('insere_oferecimento', [pr_NUSP, di_codigo, semestre])

def insere_cursa(al_NUSP, of_id):
    with db.cursor() as cursor:
        cursor.callproc('insere_cursa', [al_NUSP, of_id])

def deleta_ministra(pr_NUSP, di_codigo):
    with db.cursor() as cursor:
        cursor.callproc('deleta_ministra', [pr_NUSP, di_codigo])

def deleta_planeja(al_NUSP, di_codigo):
    with db.cursor() as cursor:
        cursor.callproc('deleta_planeja', [al_NUSP, di_codigo])

def deleta_oferecimento(of_id):
    with db.cursor() as cursor:
        cursor.callproc('deleta_oferecimento', [of_id])

def deleta_cursa(al_NUSP, of_id):
    with db.cursor() as cursor:
        cursor.callproc('deleta_cursa', [al_NUSP, of_id])

def lista_disciplinas_cursadas(nusp):
    with db.cursor() as cursor:
        cursor.callproc('lista_disciplinas_cursadas', [nusp])
        columns = [c.name for c in cursor.description]
        return [dict(zip(columns, disciplina)) for disciplina in cursor.fetchall()]

def lista_creditos_cursados(nusp):
    with db.cursor() as cursor:
        cursor.callproc('lista_creditos_cursados', [nusp])
        return cursor.fetchone()

def lista_disciplinas_planejadas(nusp):
    with db.cursor() as cursor:
        cursor.callproc('lista_disciplinas_planejadas', [nusp])
        columns = [c.name for c in cursor.description]
        return [dict(zip(columns, disciplina)) for disciplina in cursor.fetchall()]

def lista_creditos_planejados(nusp):
    with db.cursor() as cursor:
        cursor.callproc('lista_creditos_planejados', [nusp])
        return cursor.fetchone()

def lista_disciplinas_ministradas(nusp):
    with db.cursor() as cursor:
        cursor.callproc('lista_disciplinas_ministradas', [nusp])
        columns = [c.name for c in cursor.description]
        return [dict(zip(columns, disciplina)) for disciplina in cursor.fetchall()]

def lista_disciplinas_oferecidas(nusp):
    with db.cursor() as cursor:
        cursor.callproc('lista_disciplinas_oferecidas', [nusp])
        columns = [c.name for c in cursor.description]
        return [dict(zip(columns, disciplina)) for disciplina in cursor.fetchall()]        

def lista_alunos_do_oferecimento(of_id):
    with db.cursor() as cursor:
        cursor.callproc('lista_alunos_do_oferecimento', [of_id])
        columns = [c.name for c in cursor.description]
        return [dict(zip(columns, aluno)) for aluno in cursor.fetchall()]

def atualiza_nota(al_NUSP, of_id, nota):
    with db.cursor() as cursor:
        cursor.callproc('atualiza_nota', [al_NUSP, of_id, nota])