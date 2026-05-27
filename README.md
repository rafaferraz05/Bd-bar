# Projeto Bar

Sistema desenvolvido com Spring Boot, JDBC e MySQL, com interface HTML simples para operações CRUD.

## Tecnologias usadas

- Java 17
- Spring Boot
- MySQL
- Eclipse
- HTML/CSS/JavaScript
- Postman

## Como abrir no Eclipse

1. Baixar o projeto do GitHub
2. Abrir o Eclipse
3. File > Import > Existing Maven Projects
4. Selecionar a pasta do projeto
5. Finalizar

## Como configurar o banco

1. Abrir o MySQL Workbench
2. Executar o arquivo `bar_restauranteFinal.sql`
3. O banco criado será `bar_restaurante`
4. Conferir usuário e senha do MySQL na classe `ConnectionFactory`

A classe `ConnectionFactory` deve apontar para:

```java
jdbc:mysql://localhost:3306/bar_restaurante

Acessar no navegador:
http://localhost:8080/index.html
Para acessar o dashboard:

http://localhost:8080/dashboard.html
