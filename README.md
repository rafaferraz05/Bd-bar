# Projeto Bar

Sistema desenvolvido com Spring Boot, JDBC e MySQL, com interface HTML simples para operações CRUD.

## Tecnologias usadas
- Java 17
- Spring Boot
- MySQL
- Eclipse
- HTML/CSS/JavaScript

## Como abrir no Eclipse
1. Baixar o projeto do GitHub
2. Abrir o Eclipse
3. File > Import > Existing Maven Projects
4. Selecionar a pasta do projeto
5. Finalizar

## Como configurar o banco
1. Abrir o MySQL Workbench
2. Executar o arquivo `banco_bar.sql`
3. Conferir usuário e senha do MySQL na classe `ConnectionFactory`

## Como rodar
1. Abrir a classe `BarApplication.java`
2. Run As > Java Application
3. Acessar no navegador:
   - `http://localhost:8080/index.html`

## Funcionalidades
### Cliente
- Adicionar
- Editar
- Remover
- Listar

### Produto
- Adicionar
- Editar
- Remover
- Listar

## Observação
Se a porta 8080 estiver ocupada, alterar no arquivo `application.properties`.
