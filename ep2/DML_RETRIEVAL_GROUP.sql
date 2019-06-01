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
RETURNS SETOF Curriculo AS $$
BEGIN
    RETURN QUERY
    SELECT * FROM Curriculo
    WHERE Curriculo.ad_NUSP = get_curriculos.ad_nusp;
END; $$  
LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION get_trilhas(
    cu_codigo varchar(64)
)
RETURNS SETOF Trilha AS $$
BEGIN
    RETURN QUERY
    SELECT * FROM Trilha
    WHERE Trilha.cu_codigo = get_trilhas.cu_codigo;
END; $$  
LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION get_modulos(
    tr_codigo varchar(3)
)
RETURNS SETOF Modulo AS $$
BEGIN
    RETURN QUERY
    SELECT * FROM Modulo
    WHERE Modulo.tr_codigo = get_modulos.tr_codigo;
END; $$  
LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION get_disciplinas_do_modulo(
    mo_codigo varchar(3)
)
RETURNS SETOF Disciplina AS $$
BEGIN
    RETURN QUERY
    SELECT Disciplina.* FROM rel_dis_mod
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
    SELECT d.*
    FROM get_trilhas(cu_codigo) t, LATERAL get_modulos(t.codigo) m, LATERAL get_disciplinas_do_modulo(m.codigo) d;
END; $$  
LANGUAGE plpgsql;