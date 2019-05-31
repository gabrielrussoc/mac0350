CREATE OR REPLACE FUNCTION authorize(
    us_id INTEGER,
    se_nome varchar(64)
)
RETURNS BOOLEAN AS $$
BEGIN
    RETURN EXISTS (
        SELECT * FROM us_pf
        INNER JOIN pf_se ON us_pf.pf_id = pf_se.pf_id
        INNER JOIN Servico ON pf_se.se_id = Servico.id
        WHERE us_pf.us_id = authorize.us_id AND Servico.nome = authorize.se_nome 
    ) AS allowed;
END; $$  
LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION get_curriculos(
    ad_nusp varchar(9)
)
RETURNS TABLE (
  codigo varchar(64),
  nome varchar(255),
  instituto varchar(128),
  descricao text
) AS $$
BEGIN
    RETURN QUERY
    SELECT Curriculo.codigo, Curriculo.nome, Curriculo.instituto, Curriculo.descricao FROM Curriculo
    WHERE Curriculo.ad_NUSP = get_curriculos.ad_nusp;
END; $$  
LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION get_trilhas(
    cu_codigo varchar(64)
)
RETURNS TABLE (
  codigo varchar(3),
  nome varchar(64),
  descricao text
) AS $$
BEGIN
    RETURN QUERY
    SELECT Trilha.codigo, Trilha.nome, Trilha.descricao FROM Trilha
    WHERE Trilha.cu_codigo = get_trilhas.cu_codigo;
END; $$  
LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION get_modulos(
    tr_codigo varchar(3)
)
RETURNS TABLE (
  codigo varchar(3),
  nome varchar(64),
  descricao text
) AS $$
BEGIN
    RETURN QUERY
    SELECT Modulo.codigo, Modulo.nome, Modulo.descricao FROM Modulo
    WHERE Modulo.tr_codigo = get_modulos.tr_codigo;
END; $$  
LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION get_disciplinas_do_modulo(
    mo_codigo varchar(3)
)
RETURNS SETOF Disciplina AS $$
BEGIN
    RETURN QUERY
    SELECT Disciplina.codigo, Disciplina.nome, Disciplina.departamento, Disciplina.descricao, Disciplina.creditos FROM rel_dis_mod
    INNER JOIN Disciplina on Disciplina.codigo = rel_dis_mod.di_codigo
    WHERE rel_dis_mod.mo_codigo = get_disciplinas_do_modulo.mo_codigo;
END; $$  
LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION get_disciplinas_do_curriculo(
    cu_codigo varchar(64)
)
RETURNS SETOF Disciplina AS $$
BEGIN
    RETURN QUERY
    SELECT d.codigo, d.nome, d.departamento, d.descricao, d.creditos
    FROM get_trilhas(cu_codigo) t, LATERAL get_modulos(t.codigo) m, LATERAL get_disciplinas_do_modulo(m.codigo) d;
END; $$  
LANGUAGE plpgsql;