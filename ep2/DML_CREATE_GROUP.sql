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
RETURNS void AS $$
DECLARE new_id INTEGER;
BEGIN
  INSERT INTO users (us_email, us_password) 
  VALUES (us_email, crypt(us_pass, gen_salt('bf')))
  RETURNING us_id INTO new_id;

  INSERT INTO Pessoa (CPF, nome, sexo, data_nascimento, us_id)
  VALUES (pe_CPF, pe_nome, pe_sexo, pe_data_nascimento, new_id);

  INSERT INTO us_pf (us_id, pf_id)
  VALUES (new_id, (SELECT id FROM Perfil WHERE nome='visitante'));
END; $$  
LANGUAGE plpgsql;

------------------------------------------------------------------------

/*
Cadastra um novo aluno.
  @param pe_CPF: CPF do aluno
  @param NUSP: número USP do aluno
  @param cu_codigo: curriculo definido para o aluno
*/
CREATE OR REPLACE FUNCTION insere_aluno(
  pe_CPF varchar(11),
  NUSP varchar(9),
  cu_codigo varchar(64)
)
RETURNS void AS $$
BEGIN
  INSERT INTO Aluno (pe_CPF, NUSP, cu_codigo)
  VALUES (pe_CPF, NUSP, cu_codigo);

  INSERT INTO us_pf (us_id, pf_id)
  VALUES (
      (SELECT us_id FROM Pessoa WHERE CPF = pe_CPF), 
      (SELECT id FROM Perfil WHERE nome='aluno')
  );
END; $$
LANGUAGE plpgsql;

------------------------------------------------------------------------

/*
Cadastra um novo professor.
  @param pe_CPF: CPF do professor
  @param NUSP: número USP do aluno
  @param instituto: instituto do professor
  @param departamento: departamento do professor
*/
CREATE OR REPLACE FUNCTION insere_professor(
  pe_CPF varchar(11),
  NUSP varchar(9),
  instituto varchar(128),
  departamento varchar(128)
)
RETURNS void AS $$
BEGIN
  INSERT INTO Professor (pe_CPF, NUSP, instituto, departamento)
  VALUES (pe_CPF, NUSP, instituto, departamento);

  INSERT INTO us_pf (us_id, pf_id)
  VALUES (
      (SELECT us_id FROM Pessoa WHERE CPF = pe_CPF), 
      (SELECT id FROM Perfil WHERE nome='professor')
  );
END; $$
LANGUAGE plpgsql;

------------------------------------------------------------------------

/*
Cadastra um novo administrador.
  @param pe_CPF: CPF do administrador
  @param NUSP: número USP do administrador
  @param cargo: cargo do administrador
*/
CREATE OR REPLACE FUNCTION insere_administrador(
  pe_CPF varchar(11),
  NUSP varchar(9),
  cargo varchar(64)
)
RETURNS void AS $$
BEGIN
  INSERT INTO Administrador (pe_CPF, NUSP, cargo)
  VALUES (pe_CPF, NUSP, cargo);

  INSERT INTO us_pf (us_id, pf_id)
  VALUES (
      (SELECT us_id FROM Pessoa WHERE CPF = pe_CPF), 
      (SELECT id FROM Perfil WHERE nome='administrador')
  );
END; $$
LANGUAGE plpgsql;

------------------------------------------------------------------------

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

------------------------------------------------------------------------

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

------------------------------------------------------------------------

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

------------------------------------------------------------------------

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