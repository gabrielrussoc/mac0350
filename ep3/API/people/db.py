from db.Postgres import Postgres

db = Postgres(database='people')

def insert_student(cpf, nusp, curriculum):
    with db.cursor() as cursor:
        cursor.callproc('insere_aluno', [cpf, nusp, curriculum])

def insert_professor(cpf, nusp, institution):
    with db.cursor() as cursor:
        cursor.callproc('insere_professor', [cpf, nusp, institution])

def insert_administrator(cpf, nusp, title):
    with db.cursor() as cursor:
        cursor.callproc('insere_administrador', [cpf, nusp, title])

