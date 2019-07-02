from db.Postgres import Postgres

db = Postgres(database='access')

def authorize(user_id, service):
    """Verifica se um usuário tem acesso a um serviço.
    
    Arguments:
        user_id {int} -- ID do usuário
        service {string} -- Nome do serviço
    
    Returns:
        bool -- se o usuário está autorizado
    """
    with db.cursor() as cursor:
        cursor.callproc('autoriza', [user_id, service])
        return cursor.fetchone()[0]

def update_password(user_id, password):
    """Atualiza a senha de um usuário.
    
    Arguments:
        user_id {int} -- ID do usuário
        password {string} -- Nova senha
    """
    with db.cursor() as cursor:
        cursor.callproc('atualiza_password', [user_id, password])

def login(email, password):
    """Faz login no sistema.
    
    Arguments:
        email {string} -- Email do usuário
        password {string} -- Senha do usuário
    
    Returns:
        bool -- se as credenciais estão corretas
    """
    with db.cursor() as cursor:
        cursor.callproc('check_password', [email, password])
        return cursor.fetchone()[0]

