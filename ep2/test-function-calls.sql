select cadastro('a@z.com', '1234', '10000000701', 'nelson', 'M', '2019-01-01');

select insere_professor('10000000701', '9298041', 'IME', 'DCC');
select insere_aluno('10000000701', '9298041', '45');
select insere_administrador('10000000701', '9298041', 'ze ruela');

select insere_curriculo('45x', '9298041', 'bcc 45x', 'IME', 'Reformulado 2020');
select insere_disciplina('MAC0876', 'Introducao a introducao', 'DCC', 'Bla', 4);
select insere_trilha('T34', 'Teoria', 'Bla bla', '45x');
select insere_modulo('M12', 'Algoritmos', 'Descricao', 'T34');

select insere_ministra('9298041', 'MAC0876');
select insere_planeja('9298041', 'MAC0876');
select insere_oferecimento('9298041', 'MAC0876', '2019/1');
select insere_cursa('9298041', (SELECT id from Oferecimento WHERE di_codigo='MAC0876'));
select insere_disciplina_no_modulo('MAC0876', 'M12', TRUE);

select authorize((select us_id from users where us_email='a@z.com'), 'insere_aluno') = 'true' AS teste_authorize;
select authorize((select us_id from users where us_email='a@z.com'), 'banana') = 'false' AS test_unauthorize;

select * from get_curriculos('9298041');
select * from get_trilhas('45x');
select * from get_modulos('T34');
select * from get_disciplinas_do_modulo('M12');
select * from get_disciplinas_do_curriculo('45');

select get_disciplinas_cursadas('9298041');
select get_disciplinas_planejadas('9298041');
select get_creditos_cursados('9298041');
select get_creditos_planejados('9298041');

select get_alunos_do_oferecimento((SELECT ID FROM Oferecimento WHERE di_codigo = 'MAC0876' AND pr_NUSP = '9298041'));
select get_disciplinas_ministradas('9298041');
select get_disciplinas_oferecidas('9298041');
