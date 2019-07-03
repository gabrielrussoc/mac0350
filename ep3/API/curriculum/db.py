from db.Postgres import Postgres

db = Postgres(database='curriculum', user='postgres', host='postgres')

def insere_curriculo(codigo, ad_NUSP, nome, instituto, descricao):
    """Cadastra um novo currículo.
    
    Arguments:
        codigo {string} -- Código do currículo
        ad_NUSP {int} -- NUSP do admin
        nome {string} -- Nome do currículo
        instituto {string} -- Instituto
        descricao {string} -- Descrição
    """
    with db.cursor() as cursor:
        cursor.callproc('insere_curriculo', [codigo, ad_NUSP, nome, instituto, descricao])

def insere_disciplina(codigo, nome, departamento, descricao, creditos):
    """Cadastra uma nova disciplina.
    
    Arguments:
        codigo {string} -- Código da disciplina
        nome {string} -- Nome da disciplina
        departamento {string} -- Departamento da disciplina
        descricao {string} -- Descrição
        creditos {int} -- Número de créditos
    """
    with db.cursor() as cursor:
        cursor.callproc('insere_disciplina', [codigo, nome, departamento, descricao, creditos])

def insere_trilha(codigo, nome, descricao, cu_codigo):
    """Insere uma nova trilha
    
    Arguments:
        codigo {string} -- Código da trilha
        nome {string} -- Nome da trilha
        descricao {string} -- Descrição da trilha
        cu_codigo {string} -- Código do currículo da trilha
    """
    with db.cursor() as cursor:
        cursor.callproc('insere_trilha', [codigo, nome, descricao, cu_codigo])

def insere_modulo(codigo, nome, descricao, tr_codigo):
    """Cadastra um novo módulo.
    
    Arguments:
        codigo {string} -- Código do módulo
        nome {string} -- Nome do módulo
        descricao {string} -- Descrição do módulo
        tr_codigo {string} -- Código da trilha do módulo
    """
    with db.cursor() as cursor:
        cursor.callproc('insere_modulo', [codigo, nome, descricao, tr_codigo])

def insere_disciplina_no_modulo(di_codigo, mo_codigo, obrigatoria):
    """Insere uma disciplina no módulo
    
    Arguments:
        di_codigo {string} -- Código da disciplina
        mo_codigo {string} -- Código do módulo
        obrigatoria {boolean} -- True se disciplina é obrigatória no módulo
    """
    with db.cursor() as cursor:
        cursor.callproc('insere_disciplina_no_modulo', [di_codigo, mo_codigo, obrigatoria])

def deleta_rel_dis_mod(di_codigo, mo_codigo):
    """Remove a disciplina do módulo
    
    Arguments:
        di_codigo {string} -- Código da disciplina
        mo_codigo {string} -- Código do módulo
    """
    with db.cursor() as cursor:
        cursor.callproc('deleta_rel_dis_mod', [di_codigo, mo_codigo])

def deleta_disciplina(di_codigo):
    """Remove a disciplina
    
    Arguments:
        di_codigo {string} -- Código da disciplina
    """
    with db.cursor() as cursor:
        cursor.callproc('deleta_disciplina', [di_codigo])

def deleta_curriculo(cu_codigo):
    """Remove o currículo
    
    Arguments:
        cu_codigo {string} -- Código do currículo
    """
    with db.cursor() as cursor:
        cursor.callproc('deleta_curriculo', [cu_codigo])

def deleta_trilha(tr_codigo):
    """Remove a trilha
    
    Arguments:
        tr_codigo {string} -- Código da trilha
    """
    with db.cursor() as cursor:
        cursor.callproc('deleta_trilha', [tr_codigo])

def deleta_modulo(mo_codigo):
    """Remove o módulo
    
    Arguments:
        mo_codigo {string} -- Código do módulo
    """
    with db.cursor() as cursor:
        cursor.callproc('deleta_modulo', [mo_codigo])
