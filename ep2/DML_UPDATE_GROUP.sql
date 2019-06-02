/*
Atualiza um curriculo.
  @param cu_codigo: código do curriculo a ser atualizado
  @param cu_ad_NUSP: número USP do administrador do currículo
  @param cu_nome: nome do currículo
  @param cu_instituto: instituto do currículo
  @param cu_descricao: descrição do curriculo
*/
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

/*
Atualiza uma disciplina.
  @param di_codigo: código da disciplina a ser atualizada
  @param di_nome: nome da disciplina
  @param di_departamento: departamento da disciplina
  @param di_descricao: descrição da disciplina
  @param di_creditos: descrição da disciplina
*/
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

/*
Atualiza a nota de um aluno.
  @param al_NUSP: número USP do aluno
  @param of_id: id do oferecimento cursado
  @param nota: inteiro 0-10
*/
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

/*
Atualiza uma trilha.
  @param codigo: código da trilha
  @param nome: nome da trilha
  @param descricao: descrição da trilha
  @param cu_codigo: código do curriculo da trilha
*/
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

/*
Atualiza um módulo.
  @param codigo: código do módulo
  @param nome: nome do módulo
  @param descricao: descrição do módulo
  @param tr_codigo: código da trilha do módulo
*/
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

/*
Atualiza se uma disciplina é obrigatória em um módulo.
  @param di_codigo: código da disciplina
  @param mo_codigo: código do módulo
  @param obrigatoria: booleano
*/
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

/*
Atualiza a senha de um usuário.
  @param us_id: id do usuário
  @param us_password: senha
*/
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
