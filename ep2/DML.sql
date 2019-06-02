INSERT INTO users 
    (us_email, us_password) 
VALUES 
    ('russo@gmail.com', crypt('capivara', gen_salt('bf'))),
    ('lg@gmail.com', crypt('google', gen_salt('bf'))),
    ('vh@gmail.com', crypt('grafinhos', gen_salt('bf'))),
    ('damara@gmail.com', crypt('senha', gen_salt('bf'))),
    ('carlinhos@usp.br', crypt('maratona', gen_salt('bf'))),
    ('jef@usp.br', crypt('db', gen_salt('bf'))),
    ('finger@usp.br', crypt('admin', gen_salt('bf'))),
    ('germanohn@gmail.com', crypt('marcel', gen_salt('bf'))),
    ('marcel@usp.br', crypt('geometria', gen_salt('bf'))),
    ('cris@usp.br', crypt('geocomp', gen_salt('bf'))),
    ('a@gmail.com', crypt('capivara', gen_salt('bf'))),
    ('b@gmail.com', crypt('google', gen_salt('bf'))),
    ('c@gmail.com', crypt('grafinhos', gen_salt('bf'))),
    ('d@gmail.com', crypt('senha', gen_salt('bf'))),
    ('e@usp.br', crypt('maratona', gen_salt('bf'))),
    ('f@usp.br', crypt('db', gen_salt('bf'))),
    ('g@usp.br', crypt('admin', gen_salt('bf'))),
    ('h@gmail.com', crypt('marcel', gen_salt('bf'))),
    ('i@usp.br', crypt('geometria', gen_salt('bf'))),
    ('j@usp.br', crypt('geocomp', gen_salt('bf'))),
    ('k@gmail.com', crypt('capivara', gen_salt('bf'))),
    ('l@gmail.com', crypt('google', gen_salt('bf'))),
    ('m@gmail.com', crypt('grafinhos', gen_salt('bf'))),
    ('n@gmail.com', crypt('senha', gen_salt('bf'))),
    ('o@usp.br', crypt('maratona', gen_salt('bf'))),
    ('p@usp.br', crypt('db', gen_salt('bf'))),
    ('q@usp.br', crypt('admin', gen_salt('bf'))),
    ('r@gmail.com', crypt('marcel', gen_salt('bf'))),
    ('s@usp.br', crypt('geometria', gen_salt('bf'))),
    ('t@usp.br', crypt('geocomp', gen_salt('bf'))),
    ('u@usp.br', crypt('geocomp', gen_salt('bf')));

INSERT INTO Pessoa 
    (CPF, nome, sexo, data_nascimento, us_id) 
VALUES
    ('95811319061', 'Gabriel Russo', 'M', '2017-03-14', (SELECT us_id FROM users WHERE us_email = 'russo@gmail.com')),
    ('95811319062', 'Luis Gustavo Bitencourt', 'M', '2017-03-15', (SELECT us_id FROM users WHERE us_email = 'lg@gmail.com')),
    ('95811319063', 'Victor Hugo Miranda', 'M', '2017-03-16', (SELECT us_id FROM users WHERE us_email = 'vh@gmail.com')),
    ('95811319064', 'Victor Aliende da Matta', 'M', '2017-03-17', (SELECT us_id FROM users WHERE us_email = 'damara@gmail.com')),
    ('95811319065', 'Carlos Eduardo Ferreira', 'M', '2017-03-18', (SELECT us_id FROM users WHERE us_email = 'carlinhos@usp.br')),
    ('95811319066', 'João Eduardo Ferreira', 'M', '2017-03-19', (SELECT us_id FROM users WHERE us_email = 'jef@usp.br')),
    ('95811319067', 'Marcelo Finger', 'M', '2017-03-20', (SELECT us_id FROM users WHERE us_email = 'finger@usp.br')),
    ('95811319068', 'Germano Neunfeld', 'M', '2017-03-14', (SELECT us_id FROM users WHERE us_email = 'germanohn@gmail.com')),
    ('95811319069', 'Marcel Kenji', 'M', '2017-03-15', (SELECT us_id FROM users WHERE us_email = 'marcel@usp.br')),
    ('95811319060', 'Cristina Fernandes', 'M', '2017-03-16', (SELECT us_id FROM users WHERE us_email = 'cris@usp.br')),
    ('95811319071', 'a', 'M', '2017-03-14', (SELECT us_id FROM users WHERE us_email = 'a@gmail.com')),
    ('95811319072', 'b', 'M', '2017-03-15', (SELECT us_id FROM users WHERE us_email = 'b@gmail.com')),
    ('95811319073', 'c', 'M', '2017-03-16', (SELECT us_id FROM users WHERE us_email = 'c@gmail.com')),
    ('95811319074', 'd', 'M', '2017-03-17', (SELECT us_id FROM users WHERE us_email = 'd@gmail.com')),
    ('95811319075', 'e', 'M', '2017-03-18', (SELECT us_id FROM users WHERE us_email = 'e@usp.br')),
    ('95811319076', 'f', 'M', '2017-03-19', (SELECT us_id FROM users WHERE us_email = 'f@usp.br')),
    ('95811319077', 'g', 'M', '2017-03-20', (SELECT us_id FROM users WHERE us_email = 'g@usp.br')),
    ('95811319078', 'h', 'M', '2017-03-14', (SELECT us_id FROM users WHERE us_email = 'h@gmail.com')),
    ('95811319079', 'i', 'M', '2017-03-15', (SELECT us_id FROM users WHERE us_email = 'i@usp.br')),
    ('95811319070', 'j', 'M', '2017-03-16', (SELECT us_id FROM users WHERE us_email = 'j@usp.br')),
    ('95811319081', 'k', 'M', '2017-03-14', (SELECT us_id FROM users WHERE us_email = 'k@gmail.com')),
    ('95811319082', 'l', 'M', '2017-03-15', (SELECT us_id FROM users WHERE us_email = 'l@gmail.com')),
    ('95811319083', 'm', 'M', '2017-03-16', (SELECT us_id FROM users WHERE us_email = 'm@gmail.com')),
    ('95811319084', 'n', 'M', '2017-03-17', (SELECT us_id FROM users WHERE us_email = 'n@gmail.com')),
    ('95811319085', 'o', 'M', '2017-03-18', (SELECT us_id FROM users WHERE us_email = 'o@usp.br')),
    ('95811319086', 'p', 'M', '2017-03-19', (SELECT us_id FROM users WHERE us_email = 'p@usp.br')),
    ('95811319087', 'q', 'M', '2017-03-20', (SELECT us_id FROM users WHERE us_email = 'q@usp.br')),
    ('95811319088', 'r', 'M', '2017-03-14', (SELECT us_id FROM users WHERE us_email = 'r@gmail.com')),
    ('95811319089', 's', 'M', '2017-03-15', (SELECT us_id FROM users WHERE us_email = 's@usp.br')),
    ('95811319080', 't', 'M', '2017-03-16', (SELECT us_id FROM users WHERE us_email = 't@usp.br')),
    ('95811319090', 'u', 'M', '2017-03-16', (SELECT us_id FROM users WHERE us_email = 'u@usp.br'));

INSERT INTO Professor 
    (pe_CPF, NUSP, instituto, departamento) 
VALUES
    ('95811319061', '9298100', 'IME', 'Ciência da Computação'),
    ('95811319062', '9298101', 'IME', 'Ciência da Computação'),
    ('95811319063', '9298102', 'IME', 'Ciência da Computação'),
    ('95811319064', '9298103', 'IME', 'Ciência da Computação'),
    ('95811319065', '9298104', 'IME', 'Ciência da Computação'),
    ('95811319066', '9298105', 'IME', 'Ciência da Computação'),
    ('95811319067', '9298106', 'IME', 'Ciência da Computação'),
    ('95811319068', '9298107', 'IME', 'Ciência da Computação'),
    ('95811319069', '9298108', 'IME', 'Ciência da Computação'),
    ('95811319060', '9298109', 'IME', 'Ciência da Computação');

INSERT INTO Administrador 
    (pe_CPF, NUSP, cargo) 
VALUES
    ('95811319071', '9298110', 'assistente administrativo'),
    ('95811319072', '9298111', 'auxiliar administrativo'),
    ('95811319073', '9298112', 'secretario'),
    ('95811319074', '9298113', 'subsecretario'),
    ('95811319075', '9298114', 'secretario'),
    ('95811319076', '9298115', 'secretario'),
    ('95811319077', '9298116', 'auxiliar administrativo'),
    ('95811319078', '9298117', 'auxiliar administrativo'),
    ('95811319079', '9298118', 'assistente administrativo'),
    ('95811319070', '9298119', 'secretario');

INSERT INTO Curriculo 
    (codigo, ad_NUSP, nome, instituto) 
VALUES
    ('45', '9298110', 'BCC - 45', 'IME'),
    ('46', '9298111', 'BCC - 46', 'IME'),
    ('47', '9298112', 'BCC - 47', 'IME'),
    ('48', '9298113', 'BCC - 48', 'IME'),
    ('49', '9298114', 'BCC - 49', 'IME'),
    ('40', '9298115', 'BCC - 40', 'IME'),
    ('41', '9298116', 'BCC - 41', 'IME'),
    ('42', '9298117', 'BCC - 42', 'IME'),
    ('43', '9298118', 'BCC - 43', 'IME'),
    ('44', '9298119', 'BCC - 44', 'IME');

INSERT INTO Aluno 
    (pe_CPF, NUSP, cu_codigo) 
VALUES
    ('95811319081', '9298120', '45'),
    ('95811319082', '9298121', '46'),
    ('95811319083', '9298122', '47'),
    ('95811319084', '9298123', '48'),
    ('95811319085', '9298124', '49'),
    ('95811319086', '9298125', '40'),
    ('95811319087', '9298126', '41'),
    ('95811319088', '9298127', '42'),
    ('95811319089', '9298128', '43'),
    ('95811319080', '9298129', '44');

INSERT INTO Disciplina 
    (codigo, nome, departamento, descricao, creditos)
VALUES
    ('MAC0123', 'Introdução a introduções', 'DCC', '', 4),
    ('MAC0124', 'Introdução ao MAC', 'DCC', '', 4),
    ('MAC0125', 'Introdução a computação', 'DCC', '', 4),
    ('MAC0126', 'Introdução a matemática', 'DCC', '', 4),
    ('MAC0127', 'Introdução a faculdade', 'DCC', '', 4),
    ('MAC0128', 'Introdução a programação', 'DCC', '', 4),
    ('MAC0129', 'Introdução a algoritmos', 'DCC', '', 4),
    ('MAC0120', 'Introdução a estruturas de dados', 'DCC', '', 4),
    ('MAC0121', 'Introdução a autômatos', 'DCC', '', 4),
    ('MAC0122', 'Introdução a universidade', 'DCC', '', 4);

INSERT INTO Ministra 
    (pr_NUSP, di_codigo) 
VALUES
    ('9298100', 'MAC0123'),
    ('9298100', 'MAC0124'),
    ('9298102', 'MAC0125'),
    ('9298103', 'MAC0126'),
    ('9298104', 'MAC0127'),
    ('9298105', 'MAC0128'),
    ('9298106', 'MAC0129'),
    ('9298107', 'MAC0120'),
    ('9298108', 'MAC0121'),
    ('9298109', 'MAC0122');

INSERT INTO Planeja 
    (al_NUSP, di_codigo) 
VALUES
    ('9298120', 'MAC0123'),
    ('9298121', 'MAC0124'),
    ('9298122', 'MAC0125'),
    ('9298123', 'MAC0126'),
    ('9298124', 'MAC0127'),
    ('9298125', 'MAC0128'),
    ('9298126', 'MAC0129'),
    ('9298127', 'MAC0120'),
    ('9298128', 'MAC0121'),
    ('9298129', 'MAC0122');

INSERT INTO Oferecimento 
    (pr_NUSP, di_codigo, semestre) 
VALUES
    ('9298100', 'MAC0123', '2018/1'),
    ('9298100', 'MAC0124', '2018/2'),
    ('9298102', 'MAC0125', '2018/1'),
    ('9298103', 'MAC0126', '2018/1'),
    ('9298104', 'MAC0127', '2018/1'),
    ('9298105', 'MAC0128', '2018/1'),
    ('9298106', 'MAC0129', '2018/1'),
    ('9298107', 'MAC0120', '2018/1'),
    ('9298108', 'MAC0121', '2018/1'),
    ('9298109', 'MAC0122', '2018/1');

INSERT INTO Cursa
    (al_NUSP, of_id, nota)
VALUES
    ('9298120', (SELECT ID FROM Oferecimento WHERE di_codigo = 'MAC0123' AND semestre = '2018/1'), 7),
    ('9298121', (SELECT ID FROM Oferecimento WHERE di_codigo = 'MAC0124' AND semestre = '2018/2'), 5),
    ('9298122', (SELECT ID FROM Oferecimento WHERE di_codigo = 'MAC0123' AND semestre = '2018/1'), 2),
    ('9298123', (SELECT ID FROM Oferecimento WHERE di_codigo = 'MAC0122' AND semestre = '2018/1'), 9),
    ('9298124', (SELECT ID FROM Oferecimento WHERE di_codigo = 'MAC0123' AND semestre = '2018/1'), 5),
    ('9298125', (SELECT ID FROM Oferecimento WHERE di_codigo = 'MAC0123' AND semestre = '2018/1'), 1),
    ('9298126', (SELECT ID FROM Oferecimento WHERE di_codigo = 'MAC0123' AND semestre = '2018/1'), 10),
    ('9298127', (SELECT ID FROM Oferecimento WHERE di_codigo = 'MAC0123' AND semestre = '2018/1'), 9),
    ('9298128', (SELECT ID FROM Oferecimento WHERE di_codigo = 'MAC0123' AND semestre = '2018/1'), 8),
    ('9298129', (SELECT ID FROM Oferecimento WHERE di_codigo = 'MAC0126' AND semestre = '2018/1'), 7);

INSERT INTO Trilha
    (codigo, nome, descricao, cu_codigo)
VALUES
    ('T01', 'Sistemas de Software', 'bla', '45'),
    ('T02', 'Ciências de Dados', 'ble', '46'),
    ('T03', 'Inteligência Artificial', 'bli', '47'),
    ('T04', 'Teoria da Computação', 'blo', '48'),
    ('T05', 'Automatização', 'blu', '49'),
    ('T06', 'Telecomunicações', 'bla', '40'),
    ('T07', 'Literatura', 'ble', '41'),
    ('T08', 'Ciência Política', 'bli', '42'),
    ('T09', 'História Mundial', 'blo', '43'),
    ('T10', 'Sistemas de Banco de Dados', 'blu', '44');

INSERT INTO Modulo
    (codigo, nome, descricao, tr_codigo)
VALUES
    ('M01', 'Desenvolvimento de Software', 'Lorem ipsum', 'T01'),
    ('M02', 'Sistemas Paralelos e Distribuídos', 'Lorem dolor', 'T01'),
    ('M03', 'Inteligência Artificial', 'Lorem dolor', 'T03'),
    ('M04', 'Introdução à IA', 'Lorem ipsum', 'T03'),
    ('M05', 'Algoritmos I', 'Lorem dolor', 'T04'),
    ('M06', 'Otimização I', 'Lorem ipsum', 'T04'),
    ('M07', 'Matemática Discreta II', 'Lorem dolor', 'T04'),
    ('M08', 'Bancos de Dados', 'Lorem ipsum', 'T10'),
    ('M09', 'Segunda Guerra Mundial', 'Lorem ipsum', 'T09'),
    ('M10', 'Machado de Assis', 'Lorem dolor', 'T07');

INSERT INTO rel_dis_mod 
    (di_codigo, mo_codigo, obrigatoria)
VALUES
    ('MAC0123', 'M01', false),
    ('MAC0124', 'M02', true),
    ('MAC0125', 'M03', false),
    ('MAC0126', 'M04', true),
    ('MAC0127', 'M05', false),
    ('MAC0128', 'M06', true),
    ('MAC0129', 'M07', false),
    ('MAC0120', 'M08', true),
    ('MAC0121', 'M09', false),
    ('MAC0122', 'M10', true);

INSERT INTO Perfil
    (nome, descricao)
VALUES
    ('visitante', 'Usuario cadastrado'),
    ('aluno', 'Aluno'),
    ('administrador', 'Administrador'),
    ('professor', 'Professor');

INSERT INTO Servico
    (nome, descricao)
VALUES
    ('insere_curriculo', 'Cadastro de curriculo na base de dados'),
    ('insere_disciplina', 'Cadastro de disciplina na base de dados'),
    ('insere_trilha', 'Cadastro de trilha na base de dados'),
    ('insere_modulo', 'Cadastro de modulo na base de dados'),
    ('insere_ministra', 'Cadastro de professores que ministram uma disciplina'),
    ('insere_planeja', 'Cadastro de alunos que planejam cursar uma disciplina'),
    ('insere_oferecimento', 'Cadastro de professores que oferecem uma disciplina'),
    ('insere_cursa', 'Cadastro de alunos que cursam uma disciplina'),
    ('insere_disciplina_no_modulo', 'Cadastro de disciplina num modulo'),
    ('lista_disciplinas_cursadas', 'Listagem das disciplinas cursadas por um aluno'),
    ('lista_disciplinas_planejadas', 'Listagem das disciplinas planejadas por um aluno'),
    ('creditos_cursados', 'Contagem de creditos cursados por um aluno'),
    ('creditos_planejados', 'Contagem de creditos planejados por um aluno'),
    ('lista_disciplinas_ministradas', 'Listagem das disciplinas ministradas por um professor'),
    ('lista_disciplinas_oferecidas', 'Listagem das disciplinas oferecidas por um professor'),
    ('lista_alunos_do_oferecimento', 'Listagem dos alunos matriculados num oferecimento'),
    ('atualiza_curriculo','Atualizacao de um curriculo'),
    ('atualiza_disciplina','Atualizacao de uma disciplina'),
    ('atualiza_nota','Atualizacao de uma nota'),
    ('atualiza_trilha','Atualizacao de uma trilha'),
    ('atualiza_modulo','Atualizacao de um modulo'),
    ('atualiza_obrigatoria','Atualizacao da obrigatoriedade de uma disciplina'),
    ('atualiza_senha','Atualizacao da senha de um usuario'),
    ('deleta_relacao_ministra', 'Remove um ministramento de professor'),
    ('deleta_relacao_planeja', 'Remove um planejamento de aluno'),
    ('deleta_oferecimento', 'Remove um oferecimento de professor'),
    ('deleta_relacao_cursa', 'Remove a matricula de um aluno num oferecimento'),
    ('deleta_relacao_disciplina_modulo', 'Remove uma disciplina de um modulo'),
    ('deleta_disciplina', 'Remove uma disciplina'),
    ('deleta_curriculo', 'Remove um curriculo'),
    ('deleta_trilha', 'Remove uma trilha'),
    ('deleta_modulo', 'Remove um modulo');

INSERT INTO us_pf
    (us_id, pf_id)
VALUES
    ((SELECT us_id FROM users WHERE us_email = 'russo@gmail.com'), (SELECT id FROM Perfil WHERE nome = 'visitante')),
    ((SELECT us_id FROM users WHERE us_email = 'lg@gmail.com'), (SELECT id FROM Perfil WHERE nome = 'visitante')),
    ((SELECT us_id FROM users WHERE us_email = 'vh@gmail.com'), (SELECT id FROM Perfil WHERE nome = 'aluno')),
    ((SELECT us_id FROM users WHERE us_email = 'damara@gmail.com'), (SELECT id FROM Perfil WHERE nome = 'administrador')),
    ((SELECT us_id FROM users WHERE us_email = 'carlinhos@usp.br'), (SELECT id FROM Perfil WHERE nome = 'visitante')),
    ((SELECT us_id FROM users WHERE us_email = 'jef@usp.br'), (SELECT id FROM Perfil WHERE nome = 'professor')),
    ((SELECT us_id FROM users WHERE us_email = 'finger@usp.br'), (SELECT id FROM Perfil WHERE nome = 'professor')),
    ((SELECT us_id FROM users WHERE us_email = 'germanohn@gmail.com'), (SELECT id FROM Perfil WHERE nome = 'visitante')),
    ((SELECT us_id FROM users WHERE us_email = 'marcel@usp.br'), (SELECT id FROM Perfil WHERE nome = 'professor')),
    ((SELECT us_id FROM users WHERE us_email = 'cris@usp.br'), (SELECT id FROM Perfil WHERE nome = 'professor'));

INSERT INTO pf_se
    (pf_id, se_id)
VALUES
    ((SELECT id FROM Perfil WHERE nome = 'visitante'), (SELECT id FROM Servico WHERE nome = 'atualiza_senha')),
    ((SELECT id FROM Perfil WHERE nome = 'administrador'), (SELECT id FROM Servico WHERE nome = 'insere_curriculo')),
    ((SELECT id FROM Perfil WHERE nome = 'administrador'), (SELECT id FROM Servico WHERE nome = 'insere_disciplina')),
    ((SELECT id FROM Perfil WHERE nome = 'administrador'), (SELECT id FROM Servico WHERE nome = 'insere_trilha')),
    ((SELECT id FROM Perfil WHERE nome = 'administrador'), (SELECT id FROM Servico WHERE nome = 'insere_modulo')),
    ((SELECT id FROM Perfil WHERE nome = 'administrador'), (SELECT id FROM Servico WHERE nome = 'insere_ministra')),
    ((SELECT id FROM Perfil WHERE nome = 'administrador'), (SELECT id FROM Servico WHERE nome = 'atualiza_curriculo')),
    ((SELECT id FROM Perfil WHERE nome = 'administrador'), (SELECT id FROM Servico WHERE nome = 'atualiza_disciplina')),
    ((SELECT id FROM Perfil WHERE nome = 'administrador'), (SELECT id FROM Servico WHERE nome = 'atualiza_trilha')),
    ((SELECT id FROM Perfil WHERE nome = 'administrador'), (SELECT id FROM Servico WHERE nome = 'atualiza_modulo')),
    ((SELECT id FROM Perfil WHERE nome = 'administrador'), (SELECT id FROM Servico WHERE nome = 'atualiza_obrigatoria')),
    ((SELECT id FROM Perfil WHERE nome = 'aluno'), (SELECT id FROM Servico WHERE nome = 'insere_planeja')),
    ((SELECT id FROM Perfil WHERE nome = 'professor'), (SELECT id FROM Servico WHERE nome = 'insere_oferecimento')),
    ((SELECT id FROM Perfil WHERE nome = 'aluno'), (SELECT id FROM Servico WHERE nome = 'insere_cursa')),
    ((SELECT id FROM Perfil WHERE nome = 'administrador'), (SELECT id FROM Servico WHERE nome = 'insere_disciplina_no_modulo')),
    ((SELECT id FROM Perfil WHERE nome = 'aluno'), (SELECT id FROM Servico WHERE nome = 'lista_disciplinas_cursadas')),
    ((SELECT id FROM Perfil WHERE nome = 'aluno'), (SELECT id FROM Servico WHERE nome = 'lista_disciplinas_planejadas')),
    ((SELECT id FROM Perfil WHERE nome = 'aluno'), (SELECT id FROM Servico WHERE nome = 'creditos_cursados')),
    ((SELECT id FROM Perfil WHERE nome = 'aluno'), (SELECT id FROM Servico WHERE nome = 'creditos_planejados')),
    ((SELECT id FROM Perfil WHERE nome = 'professor'), (SELECT id FROM Servico WHERE nome = 'lista_disciplinas_ministradas')),
    ((SELECT id FROM Perfil WHERE nome = 'professor'), (SELECT id FROM Servico WHERE nome = 'lista_disciplinas_oferecidas')),
    ((SELECT id FROM Perfil WHERE nome = 'professor'), (SELECT id FROM Servico WHERE nome = 'lista_alunos_do_oferecimento')),
    ((SELECT id FROM Perfil WHERE nome = 'professor'), (SELECT id FROM Servico WHERE nome = 'atualiza_nota')),
    ((SELECT id FROM Perfil WHERE nome = 'administrador'), (SELECT id FROM Servico WHERE nome = 'deleta_relacao_ministra')),
    ((SELECT id FROM Perfil WHERE nome = 'aluno'), (SELECT id FROM Servico WHERE nome = 'deleta_relacao_planeja')),
    ((SELECT id FROM Perfil WHERE nome = 'administrador'), (SELECT id FROM Servico WHERE nome = 'deleta_oferecimento')),
    ((SELECT id FROM Perfil WHERE nome = 'aluno'), (SELECT id FROM Servico WHERE nome = 'deleta_relacao_cursa')),
    ((SELECT id FROM Perfil WHERE nome = 'administrador'), (SELECT id FROM Servico WHERE nome = 'deleta_relacao_disciplina_modulo')),
    ((SELECT id FROM Perfil WHERE nome = 'administrador'), (SELECT id FROM Servico WHERE nome = 'deleta_disciplina')),
    ((SELECT id FROM Perfil WHERE nome = 'administrador'), (SELECT id FROM Servico WHERE nome = 'deleta_curriculo')),
    ((SELECT id FROM Perfil WHERE nome = 'administrador'), (SELECT id FROM Servico WHERE nome = 'deleta_trilha')),
    ((SELECT id FROM Perfil WHERE nome = 'administrador'), (SELECT id FROM Servico WHERE nome = 'deleta_modulo'));
