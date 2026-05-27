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

1. Baixar o projeto do GitHub.
2. Abrir o Eclipse.
3. Ir em `File > Import > Existing Maven Projects`.
4. Selecionar a pasta do projeto.
5. Finalizar.

## Como configurar o banco

1. Abrir o MySQL Workbench.
2. Executar o arquivo `bar_restauranteFinal.sql`.
3. O banco criado será `bar_restaurante`.
4. Conferir usuário e senha do MySQL na classe `ConnectionFactory`.

A classe `ConnectionFactory` deve apontar para:

```java
jdbc:mysql://localhost:3306/bar_restaurante
```

Caso necessário, alterar a senha local do MySQL em:

```java
private static final String PASS = "SUA_SENHA";
```

## Como rodar

1. Abrir a classe `BarApplication.java`.
2. Clicar com o botão direito.
3. Selecionar `Run As > Java Application`.
4. Acessar no navegador:

```text
http://localhost:8080/index.html
```

Para acessar o dashboard:

```text
http://localhost:8080/dashboard.html
```

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

## Dashboard

Para rodar o dashboard, é necessário adicionar o arquivo:

```text
src/main/java/com/rafael/bar/controller/DashboardController.java
```

Esse controller cria os endpoints `/dashboard/*`, que serão consumidos pelo HTML do dashboard.

Também é necessário adicionar o arquivo:

```text
src/main/resources/static/dashboard.html
```

A tela do dashboard será acessada em:

```text
http://localhost:8080/dashboard.html
```

## Banco de dados para o dashboard

No MySQL Workbench, verificar se as views existem:

```sql
SHOW FULL TABLES WHERE Table_type = 'VIEW';
```

Precisam aparecer:

- `vw_comandas_abertas`
- `vw_produtos_acima_media`

Também é necessário verificar se existe a tabela de log:

```sql
CREATE TABLE IF NOT EXISTS log_salario (
    id_log          INT           NOT NULL AUTO_INCREMENT,
    cpf_funcionario CHAR(11)      NOT NULL,
    salario_antigo  DECIMAL(10,2) NOT NULL,
    salario_novo    DECIMAL(10,2) NOT NULL,
    data_alteracao  TIMESTAMP     NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT pk_log_salario PRIMARY KEY (id_log)
);
```

Além disso, o banco deve conter:

- `calcular_total_comanda`
- `calcular_idade_cliente`
- `atualizar_salario_funcionario`
- trigger `log_alteracao_salario`

## Endpoints do DashboardController

| Endpoint | O que faz |
|---|---|
| `GET /dashboard/funcionarios` | KPI de funcionários |
| `GET /dashboard/comandas-abertas` | Usa a view `vw_comandas_abertas` |
| `GET /dashboard/produtos-acima-media` | Usa a view `vw_produtos_acima_media` |
| `GET /dashboard/total-comanda/{id}` | Usa a função `calcular_total_comanda` |
| `GET /dashboard/idade-cliente/{id}` | Usa a função `calcular_idade_cliente` |
| `POST /dashboard/atualizar-salario` | Usa procedure para atualizar salário e acionar trigger |
| `GET /dashboard/log-salario` | Lista a tabela `log_salario` |

## Observação

Se a porta 8080 estiver ocupada, alterar no arquivo `application.properties`.

Exemplo:

```properties
server.port=8081
```

Depois acessar:

```text
http://localhost:8081/index.html
http://localhost:8081/dashboard.html
```

Sempre que adicionar ou alterar um controller, reiniciar o Spring Boot rodando novamente a classe `BarApplication.java`.
