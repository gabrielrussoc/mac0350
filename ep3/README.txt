Victor Hugo M. Pinto NUSP: 10297720
Victor Aliende da Matta NUSP: 9298145
Gabriel de Russo e Carmo NUSP: 9298041
Luis Gustavo Bitencourt Almeida NUSP: 9298207

------------------------------------
INSTRUÇÕES DE USO
------------------------------------

Para facilitar a execução da aplicação em múltiplos ambientes, decidimos usar
Docker (https://www.docker.com/). Basta baixar a Engine do Docker, disponível
em https://hub.docker.com/search/?type=edition&offering=community para os mais
variados sistemas operacionais e dentro do diretório API, rodar 

$ docker-compose up

O front-end da aplicação estará disponível no browser em http://localhost:3000

OBSERVAÇÃO: Ctrl-C para todos os containers iniciados por docker-compose up.
Entretanto, se por algum motivo um erro ocorrer na tentativa de para-los,
eles continuam rodando no background. Para verificar que não há nenhum container
rodando, execute

$ docker ps

e garanta que a lista está vazia. Caso não esteja, basta rodar

$ docker stop <CONTAINER ID>

para todo container em execução.

------------------------------------
USUÁRIOS PADRÃO
------------------------------------

Alguns dos usuários já cadastrados na base são (email:senha):

VISITANTE       russo@gmail.com:capivara
ALUNO           vh@gmail.com:grafinhos
ADMINSITRADOR   damara@gmail.com:senha
PROFESSOR       jef@usp.br:db

------------------------------------
RODANDO OS ARQUIVOS *CLEAN.sql
------------------------------------

Como nosso banco de dados roda dentro de um container do docker, rodar um
arquivo .sql requer um comando do docker. Para facilitar, temos o script
API/clean_db.sh que roda TODOS os arquivos *CLEAN.sql. Caso deseje-se rodar
apenas alguns, basta comentar as linhas indesejadas.

------------------------------------
ACESSANDO UM SHELL DO POSTGRES
------------------------------------

Para acessar um shell do Postgres, basta rodar (com o container em execução):

$ docker exec -it mac0350_ep3_postgres psql postgres postgres

Note que tudo que vem depois de psql são argumentos para o binário, podendo
ser modificados livremente de acordo com a necessidade. Veja psql --help.
