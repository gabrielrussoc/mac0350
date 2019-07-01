DROP DATABASE IF EXISTS pessoa;
CREATE DATABASE pessoa;
\c pessoa;

CREATE TABLE pessoa(
    id SERIAL NOT NULL,
    nome text,
    PRIMARY KEY (id)
);