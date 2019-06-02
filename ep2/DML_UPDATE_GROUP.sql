CREATE OR REPLACE FUNCTION update_curriculo(
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

CREATE OR REPLACE FUNCTION update_disciplina(
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

CREATE OR REPLACE FUNCTION update_nota(
  al_NUSP varchar(9),
  of_id integer,
  nota integer
)
RETURNS void AS $$
#variable_conflict use_column
BEGIN
  UPDATE Cursa
  SET nota = update_nota.nota
  WHERE (al_NUSP = update_nota.al_NUSP AND of_id = update_nota.of_id);
END; $$
LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION update_trilha(
  codigo varchar(3),
  nome varchar(64),
  descricao text,
  cu_codigo varchar(64)
)
RETURNS void AS $$
#variable_conflict use_column
BEGIN
  UPDATE Trilha
  SET nome = update_trilha.nome,
      descricao = update_trilha.descricao,
      cu_codigo = update_trilha.cu_codigo
  WHERE codigo = update_trilha.codigo;
END; $$
LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION update_modulo(
  codigo varchar(3),
  nome varchar(64),
  descricao text,
  tr_codigo varchar(64)
)
RETURNS void AS $$
#variable_conflict use_column
BEGIN
  UPDATE Modulo
  SET nome = update_modulo.nome,
      descricao = update_modulo.descricao,
      tr_codigo = update_modulo.tr_codigo
  WHERE codigo = update_modulo.codigo;
END; $$
LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION update_obrigatoria(
  di_codigo varchar(7),
  mo_codigo varchar(3),
  obrigatoria boolean
)
RETURNS void AS $$
#variable_conflict use_column
BEGIN
  UPDATE rel_dis_mod
  SET obrigatoria = update_obrigatoria.obrigatoria
  WHERE (di_codigo = update_obrigatoria.di_codigo AND mo_codigo = update_obrigatoria.mo_codigo);
END; $$
LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION update_password(
  us_id       integer,
  us_password TEXT
)
RETURNS void AS $$
#variable_conflict use_column
BEGIN
  UPDATE users
  SET us_password = crypt(update_password.us_password, gen_salt('bf'))
  WHERE us_id = update_password.us_id;
END; $$
LANGUAGE plpgsql;
