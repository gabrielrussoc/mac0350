-------------------------------
--         DDL
-------------------------------

DROP DATABASE IF EXISTS access;
CREATE DATABASE access;
\c access;

CREATE EXTENSION IF NOT EXISTS pgcrypto;
CREATE EXTENSION IF NOT EXISTS citext;

DROP DOMAIN IF EXISTS email CASCADE;
CREATE DOMAIN email AS citext
  CHECK ( value ~ '^[a-zA-Z0-9.!#$%&''*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$' );

CREATE TABLE users (
  us_id       SERIAL,
  us_email    email,
  us_password TEXT NOT NULL,
  CONSTRAINT pk_user PRIMARY KEY (us_id),
  CONSTRAINT sk_user UNIQUE (us_email)
);

CREATE TABLE Perfil (
  id SERIAL,
  nome varchar(64) not NULL,
  descricao text,
  CONSTRAINT pk_perfil PRIMARY KEY (id),
  CONSTRAINT sk_perfil UNIQUE (nome)
);

CREATE TABLE Servico (
  id SERIAL,
  nome varchar(64) not NULL,
  descricao text,
  CONSTRAINT pk_servico PRIMARY KEY (id)
);

CREATE TABLE us_pf (
  us_id INTEGER,
  pf_id INTEGER,
  CONSTRAINT pk_us_pf PRIMARY KEY (us_id, pf_id),
  CONSTRAINT fk_usuario FOREIGN KEY (us_id)
    REFERENCES users(us_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT fk_perfil FOREIGN KEY (pf_id)
    REFERENCES Perfil(id)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

CREATE TABLE pf_se (
  pf_id INTEGER,
  se_id INTEGER,
  CONSTRAINT pk_pf_se PRIMARY KEY (pf_id, se_id),
  CONSTRAINT fk_perfil FOREIGN KEY (pf_id)
    REFERENCES Perfil(id)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT fk_servico FOREIGN KEY (se_id)
    REFERENCES Servico(id)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

-------------------------------
--         FUNCTIONS
-------------------------------

/*
Checa se a senha do usuário esta correta
  @param user_email: email do usuário
  @param user_pass: senha do usuário

  @return booleano: true se a senha está correta
*/
CREATE OR REPLACE FUNCTION check_password(user_email email, user_pass TEXT)
RETURNS BOOLEAN AS $$
DECLARE
valid_login BOOLEAN;
BEGIN
  -- This select returns either 1 row if valid or 0 rows if invalid
  -- Just setting the case password match to a boolean
  SELECT COUNT(*) = 1 INTO valid_login
  FROM public.users
  WHERE us_email = $1 AND us_password = public.crypt($2, us_password);

  RETURN valid_login;
END; $$  
LANGUAGE plpgsql;

/*
Checa se o usuário pode executar um serviço
  @param us_id: id do usuário
  @param se_nome: nome do serviço

  @return booleano: true se autorizado
*/
CREATE OR REPLACE FUNCTION autoriza(
  us_id INTEGER,
  se_nome varchar(64)
)
RETURNS BOOLEAN AS $$
BEGIN
  RETURN EXISTS (
      SELECT * FROM us_pf
      INNER JOIN pf_se ON us_pf.pf_id = pf_se.pf_id
      INNER JOIN Servico ON pf_se.se_id = Servico.id
      WHERE us_pf.us_id = autoriza.us_id AND Servico.nome = autoriza.se_nome 
  ) AS allowed;
END; $$  
LANGUAGE plpgsql;

/*
Atualiza a senha de um usuário.
  @param us_id: id do usuário
  @param us_password: senha
*/
CREATE OR REPLACE FUNCTION atualiza_password(
  us_id       integer,
  us_password TEXT
)
RETURNS void AS $$
#variable_conflict use_column
BEGIN
  UPDATE users
  SET us_password = crypt(atualiza_password.us_password, gen_salt('bf'))
  WHERE us_id = atualiza_password.us_id;
END; $$
LANGUAGE plpgsql;

-------------------------------
--         DML
-------------------------------

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
    ('cris@usp.br', crypt('geocomp', gen_salt('bf')));


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
    ('deleta_relacao_ministra', 'Remove uma ministracao  de professor'),
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
    ((SELECT id FROM Perfil WHERE nome = 'administrador'), (SELECT id FROM Servico WHERE nome = 'deleta_modulo'))