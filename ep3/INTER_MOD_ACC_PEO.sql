-------------------------------
--         DDL
-------------------------------

DROP DATABASE IF EXISTS access_people;
CREATE DATABASE access_people;
\c access_people;

CREATE EXTENSION IF NOT EXISTS pgcrypto;
CREATE EXTENSION IF NOT EXISTS citext;

DROP DOMAIN IF EXISTS email CASCADE;
CREATE DOMAIN email AS citext
  CHECK ( value ~ '^[a-zA-Z0-9.!#$%&''*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$' );

CREATE EXTENSION postgres_fdw;

CREATE SERVER access_server
FOREIGN DATA WRAPPER postgres_fdw
OPTIONS (host 'localhost', port '5432', dbname 'access');

CREATE USER MAPPING FOR postgres
SERVER access_server
OPTIONS (user 'postgres');

CREATE SERVER people_server
FOREIGN DATA WRAPPER postgres_fdw
OPTIONS (host 'localhost', port '5432', dbname 'people');

CREATE USER MAPPING FOR postgres
SERVER people_server
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

CREATE FOREIGN TABLE users_us_id_foreign_seq (
    a INTEGER
)
SERVER access_server
OPTIONS (table_name 'users_us_id_seq_view');

CREATE FUNCTION users_us_id_foreign_seq_nextval() 
RETURNS INTEGER 
AS 'SELECT a FROM users_us_id_foreign_seq;' 
LANGUAGE SQL;

CREATE FOREIGN TABLE users (
  us_id       INTEGER DEFAULT users_us_id_foreign_seq_nextval(),
  us_email    email,
  us_password TEXT NOT NULL
)
SERVER access_server
OPTIONS (table_name 'users');

CREATE FOREIGN TABLE Perfil (
  id INTEGER,
  nome varchar(64) not NULL,
  descricao text
)
SERVER access_server
OPTIONS (table_name 'perfil');

CREATE FOREIGN TABLE us_pf (
  us_id INTEGER,
  pf_id INTEGER
)
SERVER access_server
OPTIONS (table_name 'us_pf');

-------------------------------
--         FUNCTIONS
-------------------------------

/*
Cadastra um novo usuário.
  @param us_email: email do usuário
  @param us_pass: senha do usuário
  @param pe_CPF: CPF do usuário
  @param pe_nome: nome do usuário
  @param pe_sexo: sexo do usuário (caractere M ou F)
  @param pe_data_nascimento: data de nascimento
*/
CREATE OR REPLACE FUNCTION cadastro(
  us_email email, 
  us_pass TEXT,
  pe_CPF varchar(11),
  pe_nome varchar(255),
  pe_sexo varchar(1),
  pe_data_nascimento date)
RETURNS INTEGER AS $$
DECLARE new_id INTEGER;
BEGIN
  INSERT INTO users (us_email, us_password) 
  VALUES (us_email, crypt(us_pass, gen_salt('bf')))
  RETURNING us_id INTO new_id;

  INSERT INTO Pessoa (CPF, nome, sexo, data_nascimento, us_id)
  VALUES (pe_CPF, pe_nome, pe_sexo, pe_data_nascimento, new_id);

  INSERT INTO us_pf (us_id, pf_id)
  VALUES (new_id, (SELECT id FROM Perfil WHERE nome='visitante'));

  RETURN new_id;
END; $$  
LANGUAGE plpgsql;

CREATE TYPE Pessoa_completa AS (CPF varchar(11), nome varchar(255), al_NUSP varchar(9), pr_NUSP varchar(9), ad_NUSP varchar(9));

CREATE OR REPLACE FUNCTION lista_usuario(
  id INTEGER
)
RETURNS Pessoa_completa AS $$
DECLARE ans Pessoa_completa;
BEGIN
  SELECT Pessoa.CPF, Pessoa.nome, Aluno.NUSP, Professor.NUSP, Administrador.NUSP INTO ans
  FROM Pessoa
  LEFT OUTER JOIN Aluno on Aluno.pe_CPF = Pessoa.CPF
  LEFT OUTER JOIN Professor on Professor.pe_CPF = Pessoa.CPF
  LEFT OUTER JOIN Administrador on Administrador.pe_CPF = Pessoa.CPF
  WHERE Pessoa.us_id = id;

  RETURN ans;
END; $$  
LANGUAGE plpgsql;

-------------------------------
--         DML
-------------------------------

-- We can't call this here because it runs before the servers are up and ready to connect
-- SELECT cadastro('a@z.com', '1234', '10000000701', 'InterMod', 'M', '2019-01-01');

