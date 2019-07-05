-------------------------------
--         DDL
-------------------------------

DROP DATABASE IF EXISTS curriculum;
CREATE DATABASE curriculum;
\c curriculum;

CREATE TABLE Curriculo (
  codigo varchar(64) not NULL,
  ad_NUSP varchar(9) not NULL,
  nome varchar(255) not NULL,
  instituto varchar(128) not NULL,
  descricao text,
  CONSTRAINT pk_curriculo PRIMARY KEY (codigo)
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

-------------------------------
--         FUNCTIONS
-------------------------------

/*
Cadastra um novo currículo.
  @param codigo: código do currículo
  @param ad_NUSP: número USP do administrador do currículo
  @param nome: nome do currículo
  @param instituto: instituto do currículo
  @param descricao: descrição do currículo
*/
CREATE OR REPLACE FUNCTION insere_curriculo(
  codigo varchar(64),
  ad_NUSP varchar(9),
  nome varchar(255),
  instituto varchar(128),
  descricao text
)
RETURNS void AS $$
BEGIN
  INSERT INTO Curriculo (codigo, ad_NUSP, nome, instituto, descricao)
  VALUES (codigo, ad_NUSP, nome, instituto, descricao);
END; $$
LANGUAGE plpgsql;

------------------------------------------------------------------------

/*
Cadastra uma nova disciplina.
  @param codigo: código da disciplina a ser atualizada
  @param nome: nome da disciplina
  @param departamento: departamento da disciplina
  @param descricao: descrição da disciplina
  @param creditos: descrição da disciplina
*/
CREATE OR REPLACE FUNCTION insere_disciplina(
  codigo varchar(7),
  nome varchar(128),
  departamento varchar(128),
  descricao text,
  creditos integer
)
RETURNS void AS $$
BEGIN
  INSERT INTO Disciplina (codigo, nome, departamento, descricao, creditos)
  VALUES (codigo, nome, departamento, descricao, creditos);
END; $$
LANGUAGE plpgsql;

------------------------------------------------------------------------

/*
Cadastra uma nova trilha.
  @param codigo: código da trilha
  @param nome: nome da trilha
  @param descricao: descrição da trilha
  @param cu_codigo: código do curriculo da trilha
*/
CREATE OR REPLACE FUNCTION insere_trilha(
  codigo varchar(3),
  nome varchar(64),
  descricao text,
  cu_codigo varchar(64)
)
RETURNS void AS $$
BEGIN
  INSERT INTO Trilha (codigo, nome, descricao, cu_codigo)
  VALUES (codigo, nome, descricao, cu_codigo);
END; $$
LANGUAGE plpgsql;

------------------------------------------------------------------------

/*
Cadastra um novo módulo.
  @param codigo: código do módulo
  @param nome: nome do módulo
  @param descricao: descrição do módulo
  @param tr_codigo: código da trilha do módulo
*/
CREATE OR REPLACE FUNCTION insere_modulo(
  codigo varchar(3),
  nome varchar(64),
  descricao text,
  tr_codigo varchar(64)
)
RETURNS void AS $$
BEGIN
  INSERT INTO Modulo (codigo, nome, descricao, tr_codigo)
  VALUES (codigo, nome, descricao, tr_codigo);
END; $$
LANGUAGE plpgsql;

------------------------------------------------------------------------

/*
Insere uma disciplina no módulo
  @param di_codigo: código da disciplina
  @param mo_codulo: código do módulo
  @param obrigatoria: booleano
*/
CREATE OR REPLACE FUNCTION insere_disciplina_no_modulo(
  di_codigo varchar(7),
  mo_codigo varchar(3),
  obrigatoria boolean
)
RETURNS void AS $$
BEGIN
  INSERT INTO rel_dis_mod (di_codigo, mo_codigo, obrigatoria)
  VALUES (di_codigo, mo_codigo, obrigatoria);
END; $$
LANGUAGE plpgsql;

------------------------------------------------------------------------

/*
Remove um relacionamento rel_dis_mod.
  @param disciplina_codigo: código da disciplina
  @param modulo_codigo: código do módulo
*/
CREATE OR REPLACE FUNCTION deleta_rel_dis_mod(
  disciplina_codigo varchar(7),
  modulo_codigo varchar(3)
)
RETURNS void AS $$
BEGIN
  DELETE FROM rel_dis_mod
      WHERE di_codigo = disciplina_codigo
          AND mo_codigo = modulo_codigo;

END; $$
LANGUAGE plpgsql;

------------------------------------------------------------------------

/*
Remove uma disciplina.
  @param dis_codigo: código da disciplina
*/
CREATE OR REPLACE FUNCTION deleta_disciplina(
  dis_codigo varchar(7)
)
RETURNS void AS $$
BEGIN
  DELETE FROM Disciplina
      WHERE codigo = dis_codigo;

END; $$
LANGUAGE plpgsql;

------------------------------------------------------------------------

/*
Remove um currículo.
  @param cur_codigo: código do currículo
*/
CREATE OR REPLACE FUNCTION deleta_curriculo(
  cur_codigo varchar(64)
)
RETURNS void AS $$
BEGIN
  DELETE FROM Curriculo
      WHERE codigo = cur_codigo;

END; $$
LANGUAGE plpgsql;

------------------------------------------------------------------------

/*
Remove uma trilha.
  @param trilha_codigo: código da trilha
*/
CREATE OR REPLACE FUNCTION deleta_trilha(
  trilha_codigo varchar(3)
)
RETURNS void AS $$
BEGIN
  DELETE FROM Curriculo
      WHERE codigo = trilha_codigo;

END; $$
LANGUAGE plpgsql;

------------------------------------------------------------------------

/*
Remove um módulo.
  @param mod_codigo: código do módulo
*/
CREATE OR REPLACE FUNCTION deleta_modulo(
  mod_codigo varchar(3)
)
RETURNS void AS $$
BEGIN
  DELETE FROM Curriculo
      WHERE codigo = mod_codigo;

END; $$
LANGUAGE plpgsql;

------------------------------------------------------------------------

/*
Retorna lista de curriculos de um administrador
  @param ad_nusp: número USP do administrador

  @return set: lista de currículos
*/
CREATE OR REPLACE FUNCTION lista_curriculos(
  ad_nusp varchar(9)
)
RETURNS SETOF Curriculo AS $$
BEGIN
  RETURN QUERY
  SELECT * FROM Curriculo
  WHERE Curriculo.ad_NUSP = lista_curriculos.ad_nusp;
END; $$  
LANGUAGE plpgsql;

------------------------------------------------------------------------

/*
Retorna lista de trilhas de um currículo
  @param cu_codigo: código do currículo

  @return set: lista de trilhas
*/
CREATE OR REPLACE FUNCTION lista_trilhas(
  cu_codigo varchar(64)
)
RETURNS SETOF Trilha AS $$
BEGIN
  RETURN QUERY
  SELECT * FROM Trilha
  WHERE Trilha.cu_codigo = lista_trilhas.cu_codigo;
END; $$  
LANGUAGE plpgsql;

------------------------------------------------------------------------

/*
Retorna lista de módulos de uma  trilha
  @param tr_codigo: código da trilha

  @return set: lista de módulos
*/
CREATE OR REPLACE FUNCTION lista_modulos(
  tr_codigo varchar(3)
)
RETURNS SETOF Modulo AS $$
BEGIN
  RETURN QUERY
  SELECT * FROM Modulo
  WHERE Modulo.tr_codigo = lista_modulos.tr_codigo;
END; $$  
LANGUAGE plpgsql;

------------------------------------------------------------------------

/*
Retorna lista de disciplinas de um módulo
  @param mo_codigo: código do módulo

  @return set: lista de disciplinas
*/
CREATE OR REPLACE FUNCTION lista_disciplinas_do_modulo(
  mo_codigo varchar(3)
)
RETURNS SETOF Disciplina AS $$
BEGIN
  RETURN QUERY
  SELECT Disciplina.* FROM rel_dis_mod
  INNER JOIN Disciplina on Disciplina.codigo = rel_dis_mod.di_codigo
  WHERE rel_dis_mod.mo_codigo = lista_disciplinas_do_modulo.mo_codigo;
END; $$  
LANGUAGE plpgsql;

------------------------------------------------------------------------

/*
Retorna lista de disciplinas de um currículo
  @param cu_codigo: código do currículo

  @return set: lista de disciplinas
*/
CREATE OR REPLACE FUNCTION lista_disciplinas_do_curriculo(
  cu_codigo varchar(64)
)
RETURNS SETOF Disciplina AS $$
BEGIN
  RETURN QUERY
  SELECT d.*
  FROM lista_trilhas(cu_codigo) t, LATERAL lista_modulos(t.codigo) m, LATERAL lista_disciplinas_do_modulo(m.codigo) d;
END; $$  
LANGUAGE plpgsql;

------------------------------------------------------------------------

/*
Atualiza um curriculo.
  @param cu_codigo: código do curriculo a ser atualizado
  @param cu_ad_NUSP: número USP do administrador do currículo
  @param cu_nome: nome do currículo
  @param cu_instituto: instituto do currículo
  @param cu_descricao: descrição do curriculo
*/
CREATE OR REPLACE FUNCTION atualiza_curriculo(
  cu_codigo varchar(64),
  cu_ad_NUSP varchar(9),
  cu_nome varchar(255),
  cu_instituto varchar(128),
  cu_descricao text
)
RETURNS void AS $$
BEGIN
  UPDATE Curriculo
  SET ad_NUSP = cu_ad_NUSP,
      nome = cu_nome,
      instituto = cu_instituto,
      descricao = cu_descricao
  WHERE codigo = cu_codigo;
END; $$
LANGUAGE plpgsql;

------------------------------------------------------------------------

/*
Atualiza uma disciplina.
  @param di_codigo: código da disciplina a ser atualizada
  @param di_nome: nome da disciplina
  @param di_departamento: departamento da disciplina
  @param di_descricao: descrição da disciplina
  @param di_creditos: descrição da disciplina
*/
CREATE OR REPLACE FUNCTION atualiza_disciplina(
  di_codigo varchar(7),
  di_nome varchar(128),
  di_departamento varchar(128),
  di_descricao text,
  di_creditos integer
)
RETURNS void AS $$
BEGIN
  UPDATE Disciplina
  SET nome = di_nome,
      departamento = di_departamento,
      descricao = di_descricao,
      creditos = di_creditos
  WHERE codigo = di_codigo;
END; $$
LANGUAGE plpgsql;

------------------------------------------------------------------------

/*
Atualiza uma trilha.
  @param codigo: código da trilha
  @param nome: nome da trilha
  @param descricao: descrição da trilha
  @param cu_codigo: código do curriculo da trilha
*/
CREATE OR REPLACE FUNCTION atualiza_trilha(
  codigo varchar(3),
  nome varchar(64),
  descricao text,
  cu_codigo varchar(64)
)
RETURNS void AS $$
#variable_conflict use_column
BEGIN
  UPDATE Trilha
  SET nome = atualiza_trilha.nome,
      descricao = atualiza_trilha.descricao,
      cu_codigo = atualiza_trilha.cu_codigo
  WHERE codigo = atualiza_trilha.codigo;
END; $$
LANGUAGE plpgsql;

------------------------------------------------------------------------

/*
Atualiza um módulo.
  @param codigo: código do módulo
  @param nome: nome do módulo
  @param descricao: descrição do módulo
  @param tr_codigo: código da trilha do módulo
*/
CREATE OR REPLACE FUNCTION atualiza_modulo(
  codigo varchar(3),
  nome varchar(64),
  descricao text,
  tr_codigo varchar(64)
)
RETURNS void AS $$
#variable_conflict use_column
BEGIN
  UPDATE Modulo
  SET nome = atualiza_modulo.nome,
      descricao = atualiza_modulo.descricao,
      tr_codigo = atualiza_modulo.tr_codigo
  WHERE codigo = atualiza_modulo.codigo;
END; $$
LANGUAGE plpgsql;

------------------------------------------------------------------------

/*
Atualiza se uma disciplina é obrigatória em um módulo.
  @param di_codigo: código da disciplina
  @param mo_codigo: código do módulo
  @param obrigatoria: booleano
*/
CREATE OR REPLACE FUNCTION atualiza_obrigatoria(
  di_codigo varchar(7),
  mo_codigo varchar(3),
  obrigatoria boolean
)
RETURNS void AS $$
#variable_conflict use_column
BEGIN
  UPDATE rel_dis_mod
  SET obrigatoria = atualiza_obrigatoria.obrigatoria
  WHERE (di_codigo = atualiza_obrigatoria.di_codigo AND mo_codigo = atualiza_obrigatoria.mo_codigo);
END; $$
LANGUAGE plpgsql;

-------------------------------
--         DML
-------------------------------

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
