-------------------------------
--         DDL
-------------------------------

DROP DATABASE IF EXISTS people_curriculum;
CREATE DATABASE people_curriculum;
\c people_curriculum;

CREATE EXTENSION postgres_fdw;

CREATE SERVER people_server
FOREIGN DATA WRAPPER postgres_fdw
OPTIONS (host 'localhost', port '5432', dbname 'people');

CREATE USER MAPPING FOR postgres
SERVER people_server
OPTIONS (user 'postgres');

CREATE SERVER curriculum_server
FOREIGN DATA WRAPPER postgres_fdw
OPTIONS (host 'localhost', port '5432', dbname 'curriculum');

CREATE USER MAPPING FOR postgres
SERVER curriculum_server
OPTIONS (user 'postgres');

CREATE FOREIGN TABLE Pessoa (
  CPF varchar(11) not NULL,
  nome varchar(255) not NULL,
  sexo varchar(1),
  data_nascimento date,
  us_id INTEGER
)
SERVER people_server
OPTIONS (table_name 'pessoa');

CREATE FOREIGN TABLE Professor (
  pe_CPF varchar(11) not NULL,
  NUSP varchar(9) not NULL,
  instituto varchar(128) not NULL
)
SERVER people_server
OPTIONS (table_name 'professor');

CREATE FOREIGN TABLE Administrador (
  pe_CPF varchar(11) not NULL,
  NUSP varchar(9) not NULL,
  cargo varchar(64)
)
SERVER people_server
OPTIONS (table_name 'administrador');

CREATE FOREIGN TABLE Aluno (
  pe_CPF varchar(11) not NULL,
  NUSP varchar(9) not NULL,
  cu_codigo varchar(64) not NULL
)
SERVER people_server
OPTIONS (table_name 'aluno');

CREATE FOREIGN TABLE Disciplina (
  codigo varchar(7) not NULL,
  nome varchar(128) not NULL,
  departamento varchar(128),
  descricao text,
  creditos integer
)
SERVER curriculum_server
OPTIONS (table_name 'disciplina');

CREATE TABLE Ministra (
  pr_NUSP varchar(9) not NULL,
  di_codigo varchar(7) not NULL,
  CONSTRAINT pk_ministra PRIMARY KEY (pr_NUSP, di_codigo)
);

CREATE TABLE Planeja (
  al_NUSP varchar(9) not NULL,
  di_codigo varchar(7) not NULL,
  CONSTRAINT pk_planeja PRIMARY KEY (al_NUSP, di_codigo)
);

CREATE TABLE Oferecimento (
  ID SERIAL,
  pr_NUSP varchar(9) not NULL,
  di_codigo varchar(7) not NULL,
  semestre varchar(6) not NULL,
  CONSTRAINT pk_oferecimento PRIMARY KEY (ID),
  CONSTRAINT check_semestre CHECK (char_length(semestre) = 6 AND semestre ~ '^[1-9][0-9]{3}\/[1-2]$')
);

CREATE TABLE Cursa (
  al_NUSP varchar(9) not NULL,
  of_id SERIAL,
  nota integer,
  CONSTRAINT pk_cursa PRIMARY KEY (al_NUSP, of_id),
  CONSTRAINT check_nota CHECK (nota >= 0)
);

-------------------------------
--         FUNCTIONS
-------------------------------


/*
Cadastra um novo relacionamento ministra.
  @param pr_NUSP: número USP do professor que ministra a disciplina
  @param di_codigo: código da disciplina
*/
CREATE OR REPLACE FUNCTION insere_ministra(
  pr_NUSP varchar(9),
  di_codigo varchar(7)
)
RETURNS void AS $$
BEGIN
  INSERT INTO Ministra (pr_NUSP, di_codigo)
  VALUES (pr_NUSP, di_codigo);
END; $$
LANGUAGE plpgsql;

/*
Cadastra um novo relacionamento planeja.
  @param al_NUSP: número USP do aluno que planeja cursar a disciplina
  @param di_codigo: código da disciplina
*/
CREATE OR REPLACE FUNCTION insere_planeja(
  al_NUSP varchar(9),
  di_codigo varchar(7)
)
RETURNS void AS $$
BEGIN
  INSERT INTO Planeja (al_NUSP, di_codigo)
  VALUES (al_NUSP, di_codigo);
END; $$
LANGUAGE plpgsql;

/*
Cadastra um novo oferecimento.
  @param pr_NUSP: número USP do professor que ministra a disciplina
  @param di_codigo: código da disciplina
  @param semestre: descrição do semestre (YYYY/{1|2})
*/
CREATE OR REPLACE FUNCTION insere_oferecimento(
  pr_NUSP varchar(9),
  di_codigo varchar(7),
  semestre varchar(6)
)
RETURNS void AS $$
BEGIN
  INSERT INTO Oferecimento (pr_NUSP, di_codigo, semestre)
  VALUES (pr_NUSP, di_codigo, semestre);
END; $$
LANGUAGE plpgsql;

/*
Cadastra um novo relacionamento cursa.
  @param al_NUSP: número USP aluno que cursa a disciplina
  @param of_id: id do oferecimento
*/
CREATE OR REPLACE FUNCTION insere_cursa(
  al_NUSP varchar(9),
  of_id INTEGER
)
RETURNS void AS $$
BEGIN
  INSERT INTO Cursa (al_NUSP, of_id)
  VALUES (al_NUSP, of_id);
END; $$
LANGUAGE plpgsql;

/*
Remove um relacionamento ministra.
  @param pr_NUSP: número USP do professor que ministra a disciplina
  @param di_codigo: código da disciplina
*/
CREATE OR REPLACE FUNCTION deleta_ministra(
  professor_NUSP varchar(9), 
  disciplina_codigo varchar(7)
)
RETURNS void AS $$
BEGIN
  DELETE FROM Ministra
      WHERE pr_NUSP = professor_NUSP
          AND di_codigo = disciplina_codigo;
  
END; $$
LANGUAGE plpgsql;

/*
Remove um relacionamento planeja.
  @param al_NUSP: número USP do aluno que planeja cursar a disciplina
  @param di_codigo: código da disciplina
*/
CREATE OR REPLACE FUNCTION deleta_planeja(
  aluno_NUSP varchar(9),
  disciplina_codigo varchar(7)
)
RETURNS void AS $$
BEGIN
  DELETE FROM Planeja
      WHERE al_NUSP = aluno_NUSP
          AND di_codigo = disciplina_codigo;

END; $$
LANGUAGE plpgsql;

/*
Remove um oferecimento.
  @param oferimento_id: id do oferecimento
*/
CREATE OR REPLACE FUNCTION deleta_oferecimento(
  oferimento_id INTEGER
)
RETURNS void AS $$
BEGIN
  DELETE FROM Oferecimento
      WHERE ID = oferimento_id;

END; $$
LANGUAGE plpgsql;

/*
Remove um relacionamento cursa.
  @param al_NUSP: número USP aluno que cursa a disciplina
  @param of_id: id do oferecimento
*/
CREATE OR REPLACE FUNCTION deleta_cursa(
  aluno_NUSP varchar(9),
  oferecimento_id INTEGER
)
RETURNS void AS $$
BEGIN
  DELETE FROM Cursa
      WHERE al_NUSP = aluno_NUSP
          AND of_id = oferecimento_id;

END; $$
LANGUAGE plpgsql;

/*
Retorna lista de disciplinas cursadas por um aluno
  @param al_NUSP: número USP do aluno

  @return set: lista de disciplinas
*/
CREATE OR REPLACE FUNCTION lista_disciplinas_cursadas(
  al_NUSP varchar(9)
)
RETURNS SETOF Disciplina AS $$
BEGIN
  RETURN QUERY
  SELECT DISTINCT Disciplina.*
  FROM Cursa 
  JOIN Oferecimento ON Cursa.of_id = Oferecimento.ID
  JOIN Disciplina ON Oferecimento.di_codigo = Disciplina.codigo
  WHERE Cursa.al_NUSP = lista_disciplinas_cursadas.al_NUSP;
END; $$  
LANGUAGE plpgsql;

/*
Retorna lista de disciplinas planejadas por um aluno
  @param al_NUSP: número USP do aluno

  @return set: lista de disciplinas
*/
CREATE OR REPLACE FUNCTION lista_disciplinas_planejadas(
  al_NUSP varchar(9)
)
RETURNS SETOF Disciplina AS $$
BEGIN
  RETURN QUERY
  SELECT DISTINCT Disciplina.*
  FROM Planeja 
  JOIN Disciplina ON Planeja.di_codigo = Disciplina.codigo
  WHERE Planeja.al_NUSP = lista_disciplinas_planejadas.al_NUSP;
END; $$  
LANGUAGE plpgsql;

/*
Retorna número de créditos cursados por um aluno
  @param al_NUSP: número USP do aluno

  @return inteiro
*/
CREATE OR REPLACE FUNCTION lista_creditos_cursados(
  al_NUSP varchar(9)
)
RETURNS INTEGER AS $$
DECLARE
  total INTEGER;
BEGIN
  SELECT SUM(creditos) into total
  FROM lista_disciplinas_cursadas(al_NUSP);

  RETURN total;
END; $$  
LANGUAGE plpgsql;

/*
Retorna número de créditos planejados por um aluno
  @param al_NUSP: número USP do aluno

  @return inteiro
*/
CREATE OR REPLACE FUNCTION lista_creditos_planejados(
  al_NUSP varchar(9)
)
RETURNS INTEGER AS $$
DECLARE
  total INTEGER;
BEGIN
  SELECT SUM(creditos) into total
  FROM lista_disciplinas_planejadas(al_NUSP);

  RETURN total;
END; $$  
LANGUAGE plpgsql;

/*
Retorna lista de alunos matriculados em um oferecimento
  @param of_id: id do oferecimento

  @return set: lista de alunos
*/
CREATE OR REPLACE FUNCTION lista_alunos_do_oferecimento(
  of_id INTEGER
)
RETURNS SETOF Aluno AS $$
BEGIN
  RETURN QUERY
  SELECT DISTINCT Aluno.*
  FROM Oferecimento
  JOIN Cursa ON Oferecimento.ID = Cursa.of_id
  JOIN Aluno ON Cursa.al_NUSP = Aluno.NUSP
  WHERE Oferecimento.id = lista_alunos_do_oferecimento.of_id;
END; $$  
LANGUAGE plpgsql;

/*
Retorna lista de disciplinas ministradas por um professor
  @param pr_NUSP: número USP do professor

  @return set: lista de disciplinas
*/
CREATE OR REPLACE FUNCTION lista_disciplinas_ministradas(
  pr_NUSP varchar(9)
)
RETURNS SETOF Disciplina AS $$
BEGIN
  RETURN QUERY
  SELECT DISTINCT Disciplina.*
  FROM Ministra
  JOIN Disciplina ON Ministra.di_codigo = Disciplina.codigo
  WHERE Ministra.pr_NUSP = lista_disciplinas_ministradas.pr_NUSP;
END; $$  
LANGUAGE plpgsql;

/*
Retorna lista de disciplinas oferecidas por um professor
  @param pr_NUSP: número USP do professor

  @return set: lista de disciplinas
*/
CREATE OR REPLACE FUNCTION lista_disciplinas_oferecidas(
  pr_NUSP varchar(9)
)
RETURNS SETOF Disciplina AS $$
BEGIN
  RETURN QUERY
  SELECT DISTINCT Disciplina.*
  FROM Oferecimento
  JOIN Disciplina ON Oferecimento.di_codigo = Disciplina.codigo
  WHERE Oferecimento.pr_NUSP = lista_disciplinas_oferecidas.pr_NUSP;
END; $$  
LANGUAGE plpgsql;

/*
Atualiza a nota de um aluno.
  @param al_NUSP: número USP do aluno
  @param of_id: id do oferecimento cursado
  @param nota: inteiro 0-10
*/
CREATE OR REPLACE FUNCTION atualiza_nota(
  al_NUSP varchar(9),
  of_id integer,
  nota integer
)
RETURNS void AS $$
#variable_conflict use_column
BEGIN
  UPDATE Cursa
  SET nota = atualiza_nota.nota
  WHERE (al_NUSP = atualiza_nota.al_NUSP AND of_id = atualiza_nota.of_id);
END; $$
LANGUAGE plpgsql;

-------------------------------
--         DML
-------------------------------

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
    ('9298120', 1, 7),
    ('9298121', 2, 5),
    ('9298122', 1, 2),
    ('9298123', 10, 9),
    ('9298124', 1, 5),
    ('9298125', 1, 1),
    ('9298126', 1, 10),
    ('9298127', 1, 9),
    ('9298128', 1, 8),
    ('9298129', 4, 7);