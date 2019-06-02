CREATE OR REPLACE FUNCTION delete_ministra(
    professor_NUSP varchar(9), 
    disciplina_codigo varchar(7)
)
RETURNS void AS $$
BEGIN
    DELETE FROM Ministra
        WHERE pr_NUSP = professor_NUSP
            AND di_codigo = disciplina_codigo
    
END; $$
LANGUAGE plpgsql;

------------------------------------------------------------------------

CREATE OR REPLACE FUNCTION delete_planeja(
    aluno_NUSP varchar(9),
    disciplina_codigo varchar(7)
)
RETURNS void AS $$
BEGIN
    DELETE FROM Planeja
        WHERE al_NUSP = aluno_NUSP
            AND di_codigo = disciplina_codigo

END; $$
LANGUAGE plpgsql;

------------------------------------------------------------------------

CREATE OR REPLACE FUNCTION delete_oferecimento(
    oferimento_id SERIAL
)
RETURNS void AS $$
BEGIN
    DELETE FROM Oferecimento
        WHERE ID = oferimento_id

END; $$
LANGUAGE plpgsql

------------------------------------------------------------------------

CREATE OR REPLACE FUNCTION delete_cursa(
    aluno_NUSP varchar(9),
    oferecimento_id SERIAL
)
RETURNS void AS $$
BEGIN
    DELETE FROM Planeja
        WHERE al_NUSP = aluno_NUSP
            AND of_id = oferecimento_id

END; $$
LANGUAGE plpgsql;

------------------------------------------------------------------------

CREATE OR REPLACE FUNCTION delete_rel_dis_mod(
    disciplina_codigo varchar(7),
    modulo_codigo varchar(3)
)
RETURNS void AS $$
BEGIN
    DELETE FROM rel_dis_mod
        WHERE di_codigo = disciplina_codigo
            AND mo_codigo = modulo_codigo

END; $$
LANGUAGE plpgsql;

------------------------------------------------------------------------

CREATE OR REPLACE FUNCTION delete_disciplina(
    dis_codigo varchar(7)
)
RETURNS void AS $$
BEGIN
    DELETE FROM Disciplina
        WHERE codigo = dis_codigo

END; $$
LANGUAGE plpgsql;

------------------------------------------------------------------------

CREATE OR REPLACE FUNCTION delete_curriculo(
    cur_codigo varchar(64)
)
RETURNS void AS $$
BEGIN
    DELETE FROM Curriculo
        WHERE codigo = cur_codigo

END; $$
LANGUAGE plpgsql;

------------------------------------------------------------------------

CREATE OR REPLACE FUNCTION delete_trilha(
    trilha_codigo varchar(3)
)
RETURNS void AS $$
BEGIN
    DELETE FROM Curriculo
        WHERE codigo = trilha_codigo

END; $$
LANGUAGE plpgsql;

------------------------------------------------------------------------

CREATE OR REPLACE FUNCTION delete_modulo(
    mod_codigo varchar(3)
)
RETURNS void AS $$
BEGIN
    DELETE FROM Curriculo
        WHERE codigo = mod_codigo

END; $$
LANGUAGE plpgsql;

------------------------------------------------------------------------

