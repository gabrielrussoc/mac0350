# EP3 MAC0350

## Docker

O EP roda inteiramente em containers do Docker. Os containers são definidos em
`docker-compose.yml`.

### Banco de dados

Há um container para o banco de dados, que roda o Postgres na porta `5432`,
aceitando requisições do usuário `postgres`, sem nenhuma senha.

### API

Há um container para a API, que roda um app em Flask (Python 3) na porta `5000`.

### Front-end

Há um container para o front-end, que roda um app simples em Node na porta `3000`,que apenas serve o bundle de Javascript do React.