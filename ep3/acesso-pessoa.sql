DROP DATABASE IF EXISTS acesso_pessoa;
CREATE DATABASE acesso_pessoa;
\c acesso_pessoa;

CREATE TABLE rel_pes_usr (
    pes_id SERIAL NOT NULL,
    usr_id SERIAL NOT NULL
);