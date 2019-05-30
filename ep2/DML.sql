INSERT INTO users 
    (us_email, us_password) 
VALUES 
    ('russo@gmail.com', 'capivara'),
    ('lg@gmail.com', 'google'),
    ('vh@gmail.com', 'grafinhos'),
    ('damara@gmail.com', 'senha'),
    ('carlinhos@usp.br', 'maratona'),
    ('jef@usp.br', 'db'),
    ('finger@usp.br', 'admin'),
    ('germanohn@gmail.com', 'marcel'),
    ('marcel@usp.br', 'geometria'),
    ('cris@usp.br', 'geocomp'),
    ('a@gmail.com', 'capivara'),
    ('b@gmail.com', 'google'),
    ('c@gmail.com', 'grafinhos'),
    ('d@gmail.com', 'senha'),
    ('e@usp.br', 'maratona'),
    ('f@usp.br', 'db'),
    ('g@usp.br', 'admin'),
    ('h@gmail.com', 'marcel'),
    ('i@usp.br', 'geometria'),
    ('j@usp.br', 'geocomp'),
    ('k@gmail.com', 'capivara'),
    ('l@gmail.com', 'google'),
    ('m@gmail.com', 'grafinhos'),
    ('n@gmail.com', 'senha'),
    ('o@usp.br', 'maratona'),
    ('p@usp.br', 'db'),
    ('q@usp.br', 'admin'),
    ('r@gmail.com', 'marcel'),
    ('s@usp.br', 'geometria'),
    ('t@usp.br', 'geocomp'),
    ('u@usp.br', 'geocomp');

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
    ('95811319071', '9298110', 'banana'),
    ('95811319072', '9298111', 'banana'),
    ('95811319073', '9298112', 'banana'),
    ('95811319074', '9298113', 'banana'),
    ('95811319075', '9298114', 'banana'),
    ('95811319076', '9298115', 'banana'),
    ('95811319077', '9298116', 'banana'),
    ('95811319078', '9298117', 'banana'),
    ('95811319079', '9298118', 'banana'),
    ('95811319070', '9298119', 'banana');

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
    (codigo, nome) 
VALUES
    ('MAC0123', 'Introdução a introduções'),
    ('MAC0124', 'Introdução ao MAC'),
    ('MAC0125', 'Introdução a computação'),
    ('MAC0126', 'Introdução a matemática'),
    ('MAC0127', 'Introdução a faculdade'),
    ('MAC0128', 'Introdução a programação'),
    ('MAC0129', 'Introdução a algoritmos'),
    ('MAC0120', 'Introdução a estruturas de dados'),
    ('MAC0121', 'Introdução a autômatos'),
    ('MAC0122', 'Introdução a universidade');

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
    ('T01', 'Sistemas de Software', 'Lorem ipsum dolor, sit amet consectetur adipisicing elit. In, quibusdam. Optio voluptates at, voluptatibus sed perspiciatis fuga est laudantium nostrum possimus corporis repudiandae veritatis, eveniet accusamus incidunt reiciendis doloremque necessitatibus!', '45'),
    ('T02', 'Ciências de Dados', 'Lorem ipsum dolor, sit amet consectetur adipisicing elit. In, quibusdam. Optio voluptates at, voluptatibus sed perspiciatis fuga est laudantium nostrum possimus corporis repudiandae veritatis, eveniet accusamus incidunt reiciendis doloremque necessitatibus!', '46'),
    ('T03', 'Inteligência Artificial', 'Lorem ipsum dolor, sit amet consectetur adipisicing elit. In, quibusdam. Optio voluptates at, voluptatibus sed perspiciatis fuga est laudantium nostrum possimus corporis repudiandae veritatis, eveniet accusamus incidunt reiciendis doloremque necessitatibus!', '47'),
    ('T04', 'Teoria da Computação', 'Lorem ipsum dolor, sit amet consectetur adipisicing elit. In, quibusdam. Optio voluptates at, voluptatibus sed perspiciatis fuga est laudantium nostrum possimus corporis repudiandae veritatis, eveniet accusamus incidunt reiciendis doloremque necessitatibus!', '48'),
    ('T05', 'Automatização', 'Lorem ipsum dolor, sit amet consectetur adipisicing elit. In, quibusdam. Optio voluptates at, voluptatibus sed perspiciatis fuga est laudantium nostrum possimus corporis repudiandae veritatis, eveniet accusamus incidunt reiciendis doloremque necessitatibus!', '49'),
    ('T06', 'Telecomunicações', 'Lorem ipsum dolor, sit amet consectetur adipisicing elit. In, quibusdam. Optio voluptates at, voluptatibus sed perspiciatis fuga est laudantium nostrum possimus corporis repudiandae veritatis, eveniet accusamus incidunt reiciendis doloremque necessitatibus!', '40'),
    ('T07', 'Literatura', 'Lorem ipsum dolor, sit amet consectetur adipisicing elit. In, quibusdam. Optio voluptates at, voluptatibus sed perspiciatis fuga est laudantium nostrum possimus corporis repudiandae veritatis, eveniet accusamus incidunt reiciendis doloremque necessitatibus!', '41'),
    ('T08', 'Ciência Política', 'Lorem ipsum dolor, sit amet consectetur adipisicing elit. In, quibusdam. Optio voluptates at, voluptatibus sed perspiciatis fuga est laudantium nostrum possimus corporis repudiandae veritatis, eveniet accusamus incidunt reiciendis doloremque necessitatibus!', '42'),
    ('T09', 'História Mundial', 'Lorem ipsum dolor, sit amet consectetur adipisicing elit. In, quibusdam. Optio voluptates at, voluptatibus sed perspiciatis fuga est laudantium nostrum possimus corporis repudiandae veritatis, eveniet accusamus incidunt reiciendis doloremque necessitatibus!', '43'),
    ('T10', 'Sistemas de Banco de Dados', 'Lorem ipsum dolor, sit amet consectetur adipisicing elit. In, quibusdam. Optio voluptates at, voluptatibus sed perspiciatis fuga est laudantium nostrum possimus corporis repudiandae veritatis, eveniet accusamus incidunt reiciendis doloremque necessitatibus!', '44');

INSERT INTO Modulo
    (codigo, nome, descricao, tr_codigo)
VALUES
    ('M01', 'Desenvolvimento de Software', 'Lorem ipsum dolor, sit amet consectetur adipisicing elit. In, quibusdam. Optio voluptates at, voluptatibus sed perspiciatis fuga est laudantium nostrum possimus corporis repudiandae veritatis, eveniet accusamus incidunt reiciendis doloremque necessitatibus!', 'T01'),
    ('M02', 'Sistemas Paralelos e Distribuídos', 'Lorem ipsum dolor, sit amet consectetur adipisicing elit. In, quibusdam. Optio voluptates at, voluptatibus sed perspiciatis fuga est laudantium nostrum possimus corporis repudiandae veritatis, eveniet accusamus incidunt reiciendis doloremque necessitatibus!', 'T01'),
    ('M03', 'Inteligência Artificial', 'Lorem ipsum dolor, sit amet consectetur adipisicing elit. In, quibusdam. Optio voluptates at, voluptatibus sed perspiciatis fuga est laudantium nostrum possimus corporis repudiandae veritatis, eveniet accusamus incidunt reiciendis doloremque necessitatibus!', 'T03'),
    ('M04', 'Introdução à IA', 'Lorem ipsum dolor, sit amet consectetur adipisicing elit. In, quibusdam. Optio voluptates at, voluptatibus sed perspiciatis fuga est laudantium nostrum possimus corporis repudiandae veritatis, eveniet accusamus incidunt reiciendis doloremque necessitatibus!', 'T03'),
    ('M05', 'Algoritmos I', 'Lorem ipsum dolor, sit amet consectetur adipisicing elit. In, quibusdam. Optio voluptates at, voluptatibus sed perspiciatis fuga est laudantium nostrum possimus corporis repudiandae veritatis, eveniet accusamus incidunt reiciendis doloremque necessitatibus!', 'T04'),
    ('M06', 'Otimização I', 'Lorem ipsum dolor, sit amet consectetur adipisicing elit. In, quibusdam. Optio voluptates at, voluptatibus sed perspiciatis fuga est laudantium nostrum possimus corporis repudiandae veritatis, eveniet accusamus incidunt reiciendis doloremque necessitatibus!', 'T04'),
    ('M07', 'Matemática Discreta II', 'Lorem ipsum dolor, sit amet consectetur adipisicing elit. In, quibusdam. Optio voluptates at, voluptatibus sed perspiciatis fuga est laudantium nostrum possimus corporis repudiandae veritatis, eveniet accusamus incidunt reiciendis doloremque necessitatibus!', 'T04'),
    ('M08', 'Bancos de Dados', 'Lorem ipsum dolor, sit amet consectetur adipisicing elit. In, quibusdam. Optio voluptates at, voluptatibus sed perspiciatis fuga est laudantium nostrum possimus corporis repudiandae veritatis, eveniet accusamus incidunt reiciendis doloremque necessitatibus!', 'T10'),
    ('M09', 'Segunda Guerra Mundial', 'Lorem ipsum dolor, sit amet consectetur adipisicing elit. In, quibusdam. Optio voluptates at, voluptatibus sed perspiciatis fuga est laudantium nostrum possimus corporis repudiandae veritatis, eveniet accusamus incidunt reiciendis doloremque necessitatibus!', 'T09'),
    ('M10', 'Machado de Assis', 'Lorem ipsum dolor, sit amet consectetur adipisicing elit. In, quibusdam. Optio voluptates at, voluptatibus sed perspiciatis fuga est laudantium nostrum possimus corporis repudiandae veritatis, eveniet accusamus incidunt reiciendis doloremque necessitatibus!', 'T07');

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
    ('root', 'Lorem ipsum dolor, sit amet consectetur adipisicing elit. In, quibusdam. Optio voluptates at, voluptatibus sed perspiciatis fuga est laudantium nostrum possimus corporis repudiandae veritatis, eveniet accusamus incidunt reiciendis doloremque necessitatibus!'),
    ('main', 'Lorem ipsum dolor, sit amet consectetur adipisicing elit. In, quibusdam. Optio voluptates at, voluptatibus sed perspiciatis fuga est laudantium nostrum possimus corporis repudiandae veritatis, eveniet accusamus incidunt reiciendis doloremque necessitatibus!'),
    ('admin', 'Lorem ipsum dolor, sit amet consectetur adipisicing elit. In, quibusdam. Optio voluptates at, voluptatibus sed perspiciatis fuga est laudantium nostrum possimus corporis repudiandae veritatis, eveniet accusamus incidunt reiciendis doloremque necessitatibus!'),
    ('basic', 'Lorem ipsum dolor, sit amet consectetur adipisicing elit. In, quibusdam. Optio voluptates at, voluptatibus sed perspiciatis fuga est laudantium nostrum possimus corporis repudiandae veritatis, eveniet accusamus incidunt reiciendis doloremque necessitatibus!'),
    ('limited', 'Lorem ipsum dolor, sit amet consectetur adipisicing elit. In, quibusdam. Optio voluptates at, voluptatibus sed perspiciatis fuga est laudantium nostrum possimus corporis repudiandae veritatis, eveniet accusamus incidunt reiciendis doloremque necessitatibus!');

INSERT INTO Servico
    (nome, descricao)
VALUES
    ('add_user', 'Lorem ipsum dolor, sit amet consectetur adipisicing elit. In, quibusdam. Optio voluptates at, voluptatibus sed perspiciatis fuga est laudantium nostrum possimus corporis repudiandae veritatis, eveniet accusamus incidunt reiciendis doloremque necessitatibus!'),
    ('add_discipline', 'Lorem ipsum dolor, sit amet consectetur adipisicing elit. In, quibusdam. Optio voluptates at, voluptatibus sed perspiciatis fuga est laudantium nostrum possimus corporis repudiandae veritatis, eveniet accusamus incidunt reiciendis doloremque necessitatibus!'),
    ('edit_user', 'Lorem ipsum dolor, sit amet consectetur adipisicing elit. In, quibusdam. Optio voluptates at, voluptatibus sed perspiciatis fuga est laudantium nostrum possimus corporis repudiandae veritatis, eveniet accusamus incidunt reiciendis doloremque necessitatibus!'),
    ('edit_discipline', 'Lorem ipsum dolor, sit amet consectetur adipisicing elit. In, quibusdam. Optio voluptates at, voluptatibus sed perspiciatis fuga est laudantium nostrum possimus corporis repudiandae veritatis, eveniet accusamus incidunt reiciendis doloremque necessitatibus!'),
    ('check_track_status', 'Lorem ipsum dolor, sit amet consectetur adipisicing elit. In, quibusdam. Optio voluptates at, voluptatibus sed perspiciatis fuga est laudantium nostrum possimus corporis repudiandae veritatis, eveniet accusamus incidunt reiciendis doloremque necessitatibus!'),
    ('add_student', 'Lorem ipsum dolor, sit amet consectetur adipisicing elit. In, quibusdam. Optio voluptates at, voluptatibus sed perspiciatis fuga est laudantium nostrum possimus corporis repudiandae veritatis, eveniet accusamus incidunt reiciendis doloremque necessitatibus!'),
    ('add_module', 'Lorem ipsum dolor, sit amet consectetur adipisicing elit. In, quibusdam. Optio voluptates at, voluptatibus sed perspiciatis fuga est laudantium nostrum possimus corporis repudiandae veritatis, eveniet accusamus incidunt reiciendis doloremque necessitatibus!'),
    ('remove_discipline', 'Lorem ipsum dolor, sit amet consectetur adipisicing elit. In, quibusdam. Optio voluptates at, voluptatibus sed perspiciatis fuga est laudantium nostrum possimus corporis repudiandae veritatis, eveniet accusamus incidunt reiciendis doloremque necessitatibus!'),
    ('edit_module', 'Lorem ipsum dolor, sit amet consectetur adipisicing elit. In, quibusdam. Optio voluptates at, voluptatibus sed perspiciatis fuga est laudantium nostrum possimus corporis repudiandae veritatis, eveniet accusamus incidunt reiciendis doloremque necessitatibus!'),
    ('add_planned offering', 'Lorem ipsum dolor, sit amet consectetur adipisicing elit. In, quibusdam. Optio voluptates at, voluptatibus sed perspiciatis fuga est laudantium nostrum possimus corporis repudiandae veritatis, eveniet accusamus incidunt reiciendis doloremque necessitatibus!');

INSERT INTO us_pf
    (us_id, pf_id)
VALUES
    ((SELECT us_id FROM users WHERE us_email = 'russo@gmail.com'), (SELECT id FROM Perfil WHERE nome = 'root')),
    ((SELECT us_id FROM users WHERE us_email = 'lg@gmail.com'), (SELECT id FROM Perfil WHERE nome = 'root')),
    ((SELECT us_id FROM users WHERE us_email = 'vh@gmail.com'), (SELECT id FROM Perfil WHERE nome = 'main')),
    ((SELECT us_id FROM users WHERE us_email = 'damara@gmail.com'), (SELECT id FROM Perfil WHERE nome = 'admin')),
    ((SELECT us_id FROM users WHERE us_email = 'carlinhos@usp.br'), (SELECT id FROM Perfil WHERE nome = 'root')),
    ((SELECT us_id FROM users WHERE us_email = 'jef@usp.br'), (SELECT id FROM Perfil WHERE nome = 'basic')),
    ((SELECT us_id FROM users WHERE us_email = 'finger@usp.br'), (SELECT id FROM Perfil WHERE nome = 'limited')),
    ((SELECT us_id FROM users WHERE us_email = 'germanohn@gmail.com'), (SELECT id FROM Perfil WHERE nome = 'root')),
    ((SELECT us_id FROM users WHERE us_email = 'marcel@usp.br'), (SELECT id FROM Perfil WHERE nome = 'limited')),
    ((SELECT us_id FROM users WHERE us_email = 'cris@usp.br'), (SELECT id FROM Perfil WHERE nome = 'basic'));

INSERT INTO pf_se
    (pf_id, se_id)
VALUES
    ((SELECT id FROM Perfil WHERE nome = 'root'), ((SELECT id FROM Servico WHERE nome = 'add_user'))),
    ((SELECT id FROM Perfil WHERE nome = 'main'), ((SELECT id FROM Servico WHERE nome = 'add_discipline'))),
    ((SELECT id FROM Perfil WHERE nome = 'admin'), ((SELECT id FROM Servico WHERE nome = 'edit_user'))),
    ((SELECT id FROM Perfil WHERE nome = 'basic'), ((SELECT id FROM Servico WHERE nome = 'edit_discipline'))),
    ((SELECT id FROM Perfil WHERE nome = 'limited'), ((SELECT id FROM Servico WHERE nome = 'check_track_status'))),
    ((SELECT id FROM Perfil WHERE nome = 'root'), ((SELECT id FROM Servico WHERE nome = 'add_student'))),
    ((SELECT id FROM Perfil WHERE nome = 'main'), ((SELECT id FROM Servico WHERE nome = 'add_module'))),
    ((SELECT id FROM Perfil WHERE nome = 'admin'), ((SELECT id FROM Servico WHERE nome = 'remove_discipline'))),
    ((SELECT id FROM Perfil WHERE nome = 'basic'), ((SELECT id FROM Servico WHERE nome = 'edit_module'))),
    ((SELECT id FROM Perfil WHERE nome = 'limited'), ((SELECT id FROM Servico WHERE nome = 'add_planned offering')));