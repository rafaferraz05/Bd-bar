CREATE DATABASE IF NOT EXISTS bar;
USE bar;

CREATE TABLE cliente (
    id_cliente INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    data_nascimento DATE
);

CREATE TABLE telefone (
    id_cliente INT,
    telefone VARCHAR(20),
    PRIMARY KEY (id_cliente, telefone),
    FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente)
);

CREATE TABLE mesa (
    num_mesa INT PRIMARY KEY,
    capacidade INT NOT NULL
);

CREATE TABLE reserva (
    num_reserva INT AUTO_INCREMENT PRIMARY KEY,
    horario DATETIME NOT NULL,
    pessoas INT NOT NULL,
    id_cliente INT,
    FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente)
);

CREATE TABLE categoria (
    id_categoria INT AUTO_INCREMENT PRIMARY KEY,
    nome_categoria VARCHAR(100) NOT NULL
);

CREATE TABLE produto (
    id_produto INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100),
    preco DECIMAL(10,2),
    id_categoria INT NOT NULL,
    FOREIGN KEY (id_categoria) REFERENCES categoria(id_categoria)
);

CREATE TABLE funcionario (
    cpf VARCHAR(14) PRIMARY KEY,
    nome VARCHAR(100),
    salario DECIMAL(10,2),
    rua VARCHAR(100),
    cep VARCHAR(10),
    estado VARCHAR(50),
    bairro VARCHAR(50),
    cpf_supervisor VARCHAR(14),
    FOREIGN KEY (cpf_supervisor) REFERENCES funcionario(cpf)
);

CREATE TABLE garcom (
    cpf VARCHAR(14) PRIMARY KEY,
    setor_atendimento VARCHAR(50),
    FOREIGN KEY (cpf) REFERENCES funcionario(cpf)
);

CREATE TABLE cozinheiro (
    cpf VARCHAR(14) PRIMARY KEY,
    cozinha VARCHAR(50),
    FOREIGN KEY (cpf) REFERENCES funcionario(cpf)
);

CREATE TABLE bartender (
    cpf VARCHAR(14) PRIMARY KEY,
    especialidade_bebidas VARCHAR(50),
    FOREIGN KEY (cpf) REFERENCES funcionario(cpf)
);

CREATE TABLE comanda (
    id_comanda INT AUTO_INCREMENT PRIMARY KEY,
    status VARCHAR(50),
    id_cliente INT,
    num_mesa INT,
    FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente),
    FOREIGN KEY (num_mesa) REFERENCES mesa(num_mesa)
);


CREATE TABLE pagamento (
    codigo INT AUTO_INCREMENT PRIMARY KEY,
    valor DECIMAL(10,2),
    forma VARCHAR(50),
    id_comanda INT,
    FOREIGN KEY (id_comanda) REFERENCES comanda(id_comanda)
);


CREATE TABLE atendimento (
    id_comanda INT,
    id_produto INT,
    cpf_funcionario VARCHAR(14),
    quantidade INT,
    observacao VARCHAR(255),
    PRIMARY KEY (id_comanda, id_produto, cpf_funcionario),
    FOREIGN KEY (id_comanda) REFERENCES comanda(id_comanda),
    FOREIGN KEY (id_produto) REFERENCES produto(id_produto),
    FOREIGN KEY (cpf_funcionario) REFERENCES funcionario(cpf)
);


INSERT INTO categoria (nome_categoria) VALUES ('Bebidas');