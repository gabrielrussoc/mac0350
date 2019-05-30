-- MODULO DE ACESSO

/*
Next lines checks if you have permission to create extensions
and:
  *create two extensions: pgcrypto for password and citext for email check
  *create a role dba and a schema admins
  *grant permissions to dba over admins
*/

CREATE EXTENSION IF NOT EXISTS pgcrypto;
CREATE EXTENSION IF NOT EXISTS citext;
-- For security create admin schema as well
CREATE ROLE dba
  WITH SUPERUSER CREATEDB CREATEROLE
  LOGIN ENCRYPTED PASSWORD 'dba1234'
  VALID UNTIL '2019-07-01';
CREATE SCHEMA IF NOT EXISTS admins;
GRANT admins TO dba;

/*
If you get something like:
ERROR:  permission denied to create extension "pgcrypto"
HINT:  Must be superuser to create this extension.
It means that the current user does not permissions to create extensions,
in that case, log out and use the postgres superuser our grant superuser
permission to yourself.
Usually you can log as postgres by doing:
$sudo su - postgres
$psql -d <NAME_OF_THE_DATABASE>
Example:
decio@laptop:~$ sudo su - postgres
postgres@laptop$ psql -d test
psql (9.5.16)
Type "help" for help.

test=# CREATE EXTENSION IF NOT EXISTS pgcrypto;
CREATE EXTENSION
test=# \q
*/

/*
After creating the extensions, lets create a domain for valid emails
Valid emails follows a specific Request for Comment defined in RFC5322
For more info, see: https://tools.ietf.org/html/rfc5322
*/
DROP DOMAIN IF EXISTS email CASCADE;
CREATE DOMAIN email AS citext
  CHECK ( value ~ '^[a-zA-Z0-9.!#$%&''*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$' );


/*
After creating the EXTENSIONs and the email DOMAIN, go back to your user
and execute.
*/
DROP TABLE IF EXISTS users;
CREATE TABLE users (
  us_id       SERIAL,
  us_email    email,
  us_password TEXT NOT NULL,
  CONSTRAINT pk_user PRIMARY KEY (us_id),
  CONSTRAINT sk_user UNIQUE (us_email)
);

/*
You should create a function and trigger to insert new user, but since I don't
want to spoil all the fun, I will just provide the insert operation syntax
*/

-- Remove comments from the next line to text the insertion of a tuple
--INSERT INTO users (us_email, us_password) VALUES ('decio@mail.com', crypt('deciopassword', gen_salt('bf')));

/*
INSERT 0 1
test=> select * from users;
 id |     email      |                           password                           
----+----------------+--------------------------------------------------------------
  1 | decio@mail.com | $2a$06$hrVWxlypvvjRY5xat9YNPeHy9H2aD8h5NFwvrvUc9aRZjSe7H9Ul.
(1 row)
*/

/*
Below I present a function for password check that returns true if password
match.
To avoid sharing salt between API and Database, I defined that our agreement
is that:
  *API and client must agree on some hashing method between them.
  *Between API server-side and Database the call is made using plain text
  *Database checks with their internal hash/salt and returns only true/false
  *API and client must agree on how to deal with that information
Due security issues, I am defining and executing it under a transaction.
This may be a little paranoid because the system is not yet deployed and we
will take the roles of DBAs, back-end and front-end developers ourselves, but
good practices never die, right? :-)
I am setting a security search path in admin schema to avoid malicious use
of the function. Fell free to adjust the schema to your needs or leave it
without SECURITY DEFINER Definition.
*/

-- BEGIN OF THE ENTIRE TRANSACTION
BEGIN;
-- Firstly we define the function
-- START OF THE FUNCTION PART!
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
END;
$$  LANGUAGE plpgsql
    SECURITY DEFINER
  -- Here we set the secure search_path, by providing a trusted
  -- schema (admin) before anything else like pg_temp
    SET search_path = admins, pg_temp;

-- END OF THE FUNCTION PART!

-- With function defined, we revoke permission to call from public
-- And allow call just from dba
REVOKE ALL ON FUNCTION check_password(user_email email, user_pass TEXT)
  FROM PUBLIC;
GRANT EXECUTE ON FUNCTION check_password(user_email email, user_pass TEXT)
  TO dba;
COMMIT;
-- END OF THE ENTIRE TRANSACTION

-- FIM MODULO DE ACESSO

CREATE TABLE Pessoa (
  CPF varchar(11) not NULL,
  nome varchar(255) not NULL,
  sexo varchar(1),
  data_nascimento date,
  us_id SERIAL,
  CONSTRAINT pk_pessoa PRIMARY KEY (CPF),
  CONSTRAINT fk_usuario FOREIGN KEY (us_id)
    REFERENCES users(us_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT sk_us_id UNIQUE (us_id),
  CONSTRAINT check_CPF  CHECK (char_length(CPF) = 11 AND CPF ~ '^[0-9]+$'),
  CONSTRAINT check_sexo CHECK (sexo='M' OR sexo='F' OR sexo='O')
);

CREATE TABLE Professor (
  pe_CPF varchar(11) not NULL,
  NUSP varchar(9) not NULL,
  instituto varchar(128) not NULL,
  departamento varchar(128),
  CONSTRAINT pk_nusp PRIMARY KEY (NUSP),
  CONSTRAINT fk_pessoa FOREIGN KEY (pe_CPF)
    REFERENCES Pessoa(CPF)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT check_NUSP CHECK (NUSP ~ '^[0-9]+$')
);

CREATE TABLE Administrador (
  pe_CPF varchar(11) not NULL,
  NUSP varchar(9) not NULL,
  cargo varchar(64),
  CONSTRAINT pk_adm PRIMARY KEY (NUSP),
  CONSTRAINT fk_pessoa FOREIGN KEY (pe_CPF)
    REFERENCES Pessoa(CPF)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT check_NUSP CHECK (NUSP ~ '^[0-9]+$')
);

CREATE TABLE Curriculo (
  codigo varchar(64) not NULL,
  ad_NUSP varchar(9) not NULL,
  nome varchar(255) not NULL,
  instituto varchar(128) not NULL,
  descricao text,
  CONSTRAINT pk_curriculo PRIMARY KEY (codigo),
  CONSTRAINT fk_adm FOREIGN KEY (ad_NUSP)
    REFERENCES Administrador(NUSP)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

CREATE TABLE Aluno (
  pe_CPF varchar(11) not NULL,
  NUSP varchar(9) not NULL,
  cu_codigo varchar(64) not NULL,
  CONSTRAINT pk_aluno PRIMARY KEY (NUSP),
  CONSTRAINT fk_pessoa FOREIGN KEY (pe_CPF)
    REFERENCES Pessoa(CPF)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT fk_curriculo FOREIGN KEY (cu_codigo)
    REFERENCES Curriculo(codigo)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT check_NUSP CHECK (NUSP ~ '^[0-9]+$')
);

CREATE TABLE Disciplina (
  codigo varchar(7) not NULL,
  nome varchar(128) not NULL,
  departamento varchar(128),
  descricao text,
  creditos integer,
  CONSTRAINT pk_disciplina PRIMARY KEY (codigo),
  CONSTRAINT check_codigo CHECK (char_length(codigo) = 7 AND codigo ~ '^[A-Z]{3}[0-9]{4}$'),
  CONSTRAINT check_creditos CHECK (creditos > 0)
);

CREATE TABLE Ministra (
  pr_NUSP varchar(9) not NULL,
  di_codigo varchar(7) not NULL,
  CONSTRAINT pk_ministra PRIMARY KEY (pr_NUSP, di_codigo),
  CONSTRAINT fk_professor FOREIGN KEY (pr_NUSP)
    REFERENCES Professor(NUSP)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT fk_disciplina FOREIGN KEY (di_codigo)
    REFERENCES Disciplina(codigo)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

CREATE TABLE Planeja (
  al_NUSP varchar(9) not NULL,
  di_codigo varchar(7) not NULL,
  CONSTRAINT pk_planeja PRIMARY KEY (al_NUSP, di_codigo),
  CONSTRAINT fk_aluno FOREIGN KEY (al_NUSP)
    REFERENCES Aluno(NUSP)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT fk_disciplina FOREIGN KEY (di_codigo)
    REFERENCES Disciplina(codigo)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

CREATE TABLE Oferecimento (
  ID SERIAL,
  pr_NUSP varchar(9) not NULL,
  di_codigo varchar(7) not NULL,
  semestre varchar(6) not NULL,
  CONSTRAINT pk_oferecimento PRIMARY KEY (ID),
  CONSTRAINT fk_ministra FOREIGN KEY (pr_NUSP, di_codigo)
    REFERENCES Ministra(pr_NUSP, di_codigo)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT check_semestre CHECK (char_length(semestre) = 6 AND semestre ~ '^[1-9][0-9]{3}\/[1-2]$')
);

CREATE TABLE Cursa (
  al_NUSP varchar(9) not NULL,
  of_id SERIAL,
  nota integer,
  CONSTRAINT pk_cursa PRIMARY KEY (al_NUSP, of_id),
  CONSTRAINT fk_aluno FOREIGN KEY (al_NUSP)
    REFERENCES Aluno(NUSP)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT fk_oferecimento FOREIGN KEY (of_id)
    REFERENCES Oferecimento(ID)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT check_nota CHECK (nota >= 0)
);

CREATE TABLE Trilha (
  codigo varchar(3) not NULL,
  nome varchar(64) not NULL,
  descricao text,
  cu_codigo varchar(64) not NULL,
  CONSTRAINT pk_trilha PRIMARY KEY (codigo),
  CONSTRAINT fk_curriculo FOREIGN KEY (cu_codigo)
    REFERENCES Curriculo(codigo)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT check_codigo CHECK (char_length(codigo) = 3 AND codigo ~ '^T[0-9]{2}$')
);

CREATE TABLE Modulo (
  codigo varchar(3) not NULL,
  nome varchar(64) not NULL,
  descricao text,
  tr_codigo varchar(64) not NULL,
  CONSTRAINT pk_modulo PRIMARY KEY (codigo),
  CONSTRAINT fk_trilha FOREIGN KEY (tr_codigo)
    REFERENCES Trilha(codigo)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT check_codigo CHECK (char_length(codigo) = 3 AND codigo ~ '^M[0-9]{2}$')
);

CREATE TABLE rel_dis_mod (
  di_codigo varchar(7) not NULL,
  mo_codigo varchar(3) not NULL,
  obrigatoria boolean not NULL,
  CONSTRAINT pk_rel_dis_mod PRIMARY KEY (di_codigo, mo_codigo),
  CONSTRAINT fk_disciplina FOREIGN KEY (di_codigo)
    REFERENCES Disciplina(codigo)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT fk_modulo FOREIGN KEY (mo_codigo)
    REFERENCES Modulo(codigo)
    ON DELETE CASCADE
    ON UPDATE CASCADE
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
  us_id SERIAL,
  pf_id SERIAL,
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
  pf_id SERIAL,
  se_id SERIAL,
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
