DELETE FROM users;
ALTER SEQUENCE users_us_id_seq RESTART;

DELETE FROM Pessoa;

DELETE FROM Professor;

DELETE FROM Administrador;

DELETE FROM Curriculo;

DELETE FROM Aluno;

DELETE FROM Disciplina;

DELETE FROM Ministra;

DELETE FROM Planeja;

DELETE FROM Oferecimento;
ALTER SEQUENCE Oferecimento_ID_seq RESTART;

DELETE FROM Cursa;

DELETE FROM Trilha;

DELETE FROM Modulo;

DELETE FROM rel_dis_mod;

DELETE FROM Perfil;
ALTER SEQUENCE Perfil_id_seq RESTART;

DELETE FROM Servico;
ALTER SEQUENCE Servico_id_seq RESTART;

DELETE FROM us_pf;

DELETE FROM pf_se;