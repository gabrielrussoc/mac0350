DROP DATABASE IF EXISTS acesso_pessoa;
CREATE DATABASE acesso_pessoa;
\c acesso_pessoa;

CREATE EXTENSION postgres_fdw;

CREATE SERVER acesso_server
    FOREIGN DATA WRAPPER postgres_fdw
    OPTIONS (host 'localhost', port '5432', dbname 'acesso');

CREATE SERVER pessoa_server
    FOREIGN DATA WRAPPER postgres_fdw
    OPTIONS (host 'localhost', port '5432', dbname 'pessoa');

CREATE FOREIGN TABLE pessoa_foreign (
    id SERIAL NOT NULL,
    nome text
)
SERVER pessoa_server
OPTIONS (table_name 'pessoa');

CREATE FOREIGN TABLE usuario_foreign (
    id SERIAL NOT NULL,
    nome text
)
SERVER acesso_server
OPTIONS (table_name 'usuario');

CREATE USER MAPPING FOR gabriel
SERVER pessoa_server
OPTIONS (user 'gabriel');

CREATE TABLE rel_pes_usr (
    pes_id SERIAL NOT NULL,
    usr_id SERIAL NOT NULL,
    FOREIGN KEY (pes_id) REFERENCES pessoa_foreign (id),
    FOREIGN KEY (usr_id) REFERENCES usuario_foreign (id)
);