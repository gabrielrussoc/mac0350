from db.Postgres import Postgres

db = Postgres(database='access_people')

def cadastro(email, password, cpf, nome, sexo, data_nascimento):
    """Cadastra um usuario
    
    Arguments:
        email {string} -- Email
        password {string} -- Senha
        cpf {string} -- CPF somente numeros
        nome {string} -- Nome
        sexo {string} -- Sexo (caractere 'M' ou 'F')
        data_nascimento {string} -- Data de nascimento 'yyyy-MM-dd'
    
    Returns:
        int -- ID do usuário
    """
    with db.cursor() as cursor:
        cursor.callproc('cadastro', [email, password, cpf, nome, sexo, data_nascimento])
        return cursor.fetchone()[0]

def get_user(id):
    with db.cursor() as cursor:
        cursor.callproc('lista_usuario', [int(id)])
        return cursor.fetchone()