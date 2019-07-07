DROP DATABASE IF EXISTS people;
CREATE DATABASE people;
\c people;

-------------------------------
--         DDL
-------------------------------

CREATE TABLE Pessoa (
  CPF varchar(11) not NULL,
  nome varchar(255) not NULL,
  sexo varchar(1),
  data_nascimento date,
  us_id INTEGER NOT NULL,
  CONSTRAINT pk_pessoa PRIMARY KEY (CPF),
  CONSTRAINT sk_us_id UNIQUE (us_id),
  CONSTRAINT check_CPF  CHECK (char_length(CPF) = 11 AND CPF ~ '^[0-9]+$'),
  CONSTRAINT check_sexo CHECK (sexo='M' OR sexo='F' OR sexo='O')
);

CREATE TABLE Professor (
  pe_CPF varchar(11) not NULL,
  NUSP varchar(9) not NULL,
  instituto varchar(128) not NULL,
  CONSTRAINT pk_nusp PRIMARY KEY (NUSP),
  CONSTRAINT fk_pessoa FOREIGN KEY (pe_CPF)
    REFERENCES Pessoa(CPF)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT check_NUSP CHECK (NUSP ~ '^[0-9]+$')
);

CREATE TABLE Administrador (
  pe_CPF varchar(11) not NULL,
  NUSP varchar(9) not NULL,
  cargo varchar(64),
  CONSTRAINT pk_adm PRIMARY KEY (NUSP),
  CONSTRAINT fk_pessoa FOREIGN KEY (pe_CPF)
    REFERENCES Pessoa(CPF)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT check_NUSP CHECK (NUSP ~ '^[0-9]+$')
);

CREATE TABLE Aluno (
  pe_CPF varchar(11) not NULL,
  NUSP varchar(9) not NULL,
  cu_codigo varchar(64) not NULL,
  CONSTRAINT pk_aluno PRIMARY KEY (NUSP),
  CONSTRAINT fk_pessoa FOREIGN KEY (pe_CPF)
    REFERENCES Pessoa(CPF)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT check_NUSP CHECK (NUSP ~ '^[0-9]+$')
);


-------------------------------
--         DML
-------------------------------

INSERT INTO Pessoa 
    (CPF, nome, sexo, data_nascimento, us_id) 
VALUES
    ('95811319061', 'Gabriel Russo', 'M', '2017-03-14', 1),
    ('95811319062', 'Luis Gustavo Bitencourt', 'M', '2017-03-15', 2),
    ('95811319063', 'Victor Hugo Miranda', 'M', '2017-03-16', 3),
    ('95811319064', 'Victor Aliende da Matta', 'M', '2017-03-17', 4),
    ('95811319065', 'Carlos Eduardo Ferreira', 'M', '2017-03-18', 5),
    ('95811319066', 'João Eduardo Ferreira', 'M', '2017-03-19', 6),
    ('95811319067', 'Marcelo Finger', 'M', '2017-03-20', 7),
    ('95811319068', 'Germano Neunfeld', 'M', '2017-03-14', 8),
    ('95811319069', 'Marcel Kenji', 'M', '2017-03-15', 9),
    ('95811319060', 'Cristina Fernandes', 'M', '2017-03-16', 10),
    ('95811319071', 'a', 'M', '2017-03-14', 11),
    ('95811319072', 'b', 'M', '2017-03-15', 12),
    ('95811319073', 'c', 'M', '2017-03-16', 13),
    ('95811319074', 'd', 'M', '2017-03-17', 14),
    ('95811319075', 'e', 'M', '2017-03-18', 15),
    ('95811319076', 'f', 'M', '2017-03-19', 16),
    ('95811319077', 'g', 'M', '2017-03-20', 17),
    ('95811319078', 'h', 'M', '2017-03-14', 18),
    ('95811319079', 'i', 'M', '2017-03-15', 19),
    ('95811319070', 'j', 'M', '2017-03-16', 20),
    ('95811319081', 'k', 'M', '2017-03-14', 21),
    ('95811319082', 'l', 'M', '2017-03-15', 22),
    ('95811319083', 'm', 'M', '2017-03-16', 23),
    ('95811319084', 'n', 'M', '2017-03-17', 24),
    ('95811319085', 'o', 'M', '2017-03-18', 25),
    ('95811319086', 'p', 'M', '2017-03-19', 26),
    ('95811319087', 'q', 'M', '2017-03-20', 27),
    ('95811319088', 'r', 'M', '2017-03-14', 28),
    ('95811319089', 's', 'M', '2017-03-15', 29),
    ('95811319080', 't', 'M', '2017-03-16', 30),
    ('95811319090', 'u', 'M', '2017-03-16', 31);

INSERT INTO Professor 
    (pe_CPF, NUSP, instituto) 
VALUES
    ('95811319061', '9298100', 'IME'),
    ('95811319062', '9298101', 'IME'),
    ('95811319063', '9298102', 'IME'),
    ('95811319064', '9298103', 'IME'),
    ('95811319065', '9298104', 'IME'),
    ('95811319066', '9298105', 'IME'),
    ('95811319067', '9298106', 'IME'),
    ('95811319068', '9298107', 'IME'),
    ('95811319069', '9298108', 'IME'),
    ('95811319060', '9298109', 'IME');

INSERT INTO Administrador 
    (pe_CPF, NUSP, cargo) 
VALUES
    ('95811319071', '9298110', 'assistente administrativo'),
    ('95811319072', '9298111', 'auxiliar administrativo'),
    ('95811319073', '9298112', 'secretario'),
    ('95811319074', '9298113', 'subsecretario'),
    ('95811319075', '9298114', 'secretario'),
    ('95811319076', '9298115', 'secretario'),
    ('95811319077', '9298116', 'auxiliar administrativo'),
    ('95811319078', '9298117', 'auxiliar administrativo'),
    ('95811319079', '9298118', 'assistente administrativo'),
    ('95811319070', '9298119', 'secretario');

INSERT INTO Aluno 
    (pe_CPF, NUSP, cu_codigo) 
VALUES
    ('95811319081', '9298120', '45'),
    ('95811319082', '9298121', '46'),
    ('95811319083', '9298122', '47'),
    ('95811319084', '9298123', '48'),
    ('95811319085', '9298124', '49'),
    ('95811319086', '9298125', '40'),
    ('95811319087', '9298126', '41'),
    ('95811319088', '9298127', '42'),
    ('95811319089', '9298128', '43'),
    ('95811319063', '9298102', '45'),
    ('95811319080', '9298129', '44');