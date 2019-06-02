/*
Remove um relacionamento ministra.
  @param pr_NUSP: número USP do professor que ministra a disciplina
  @param di_codigo: código da disciplina
*/
CREATE OR REPLACE FUNCTION delete_ministra(
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

------------------------------------------------------------------------

/*
Remove um relacionamento planeja.
  @param al_NUSP: número USP do aluno que planeja cursar a disciplina
  @param di_codigo: código da disciplina
*/
CREATE OR REPLACE FUNCTION delete_planeja(
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

------------------------------------------------------------------------

/*
Remove um oferecimento.
  @param oferimento_id: id do oferecimento
*/
CREATE OR REPLACE FUNCTION delete_oferecimento(
  oferimento_id INTEGER
)
RETURNS void AS $$
BEGIN
  DELETE FROM Oferecimento
      WHERE ID = oferimento_id;

END; $$
LANGUAGE plpgsql;

------------------------------------------------------------------------

/*
Remove um relacionamento cursa.
  @param al_NUSP: número USP aluno que cursa a disciplina
  @param of_id: id do oferecimento
*/
CREATE OR REPLACE FUNCTION delete_cursa(
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

------------------------------------------------------------------------

/*
Remove um relacionamento rel_dis_mod.
  @param disciplina_codigo: código da disciplina
  @param modulo_codigo: código do módulo
*/
CREATE OR REPLACE FUNCTION delete_rel_dis_mod(
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
CREATE OR REPLACE FUNCTION delete_disciplina(
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
CREATE OR REPLACE FUNCTION delete_curriculo(
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
CREATE OR REPLACE FUNCTION delete_trilha(
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
CREATE OR REPLACE FUNCTION delete_modulo(
  mod_codigo varchar(3)
)
RETURNS void AS $$
BEGIN
  DELETE FROM Curriculo
      WHERE codigo = mod_codigo;

END; $$
LANGUAGE plpgsql;

------------------------------------------------------------------------

