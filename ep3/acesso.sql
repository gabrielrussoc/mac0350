DROP DATABASE IF EXISTS acesso;
CREATE DATABASE acesso;
\c acesso;

CREATE TABLE usuario(
    id SERIAL NOT NULL,
    nome text,
    PRIMARY KEY (id)
);