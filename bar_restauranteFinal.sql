CREATE DATABASE IF NOT EXISTS bar_restaurante;
USE bar_restaurante;

CREATE TABLE categoria (
  id_categoria   INT           NOT NULL AUTO_INCREMENT,
  nome_categoria VARCHAR(60)   NOT NULL,
  CONSTRAINT pk_categoria PRIMARY KEY (id_categoria)
);

CREATE TABLE produto (
  id_produto   INT            NOT NULL AUTO_INCREMENT,
  nome         VARCHAR(100)   NOT NULL,
  preco        DECIMAL(8,2)   NOT NULL,
  id_categoria INT            NOT NULL,
  CONSTRAINT pk_produto      PRIMARY KEY (id_produto),
  CONSTRAINT fk_produto_cat  FOREIGN KEY (id_categoria)
    REFERENCES categoria(id_categoria)
    ON DELETE RESTRICT,
  CONSTRAINT chk_preco CHECK (preco > 0)
);

CREATE TABLE cliente (
  id_cliente      INT          NOT NULL AUTO_INCREMENT,
  nome            VARCHAR(100) NOT NULL,
  data_nascimento DATE         NOT NULL,
  CONSTRAINT pk_cliente PRIMARY KEY (id_cliente)
);

CREATE TABLE telefone (
  id_cliente INT         NOT NULL,
  numero     VARCHAR(20) NOT NULL,
  CONSTRAINT pk_telefone     PRIMARY KEY (id_cliente, numero),
  CONSTRAINT fk_telefone_cli FOREIGN KEY (id_cliente)
    REFERENCES cliente(id_cliente)
    ON DELETE CASCADE
);

CREATE TABLE mesa (
  id_mesa    INT NOT NULL AUTO_INCREMENT,
  capacidade INT NOT NULL,
  CONSTRAINT pk_mesa        PRIMARY KEY (id_mesa),
  CONSTRAINT chk_capacidade CHECK (capacidade > 0)
);

CREATE TABLE reserva (
  id_reserva INT      NOT NULL AUTO_INCREMENT,
  horario    DATETIME NOT NULL,
  pessoas    INT      NOT NULL,
  id_cliente INT      NOT NULL,
  id_mesa    INT      NOT NULL,
  CONSTRAINT pk_reserva      PRIMARY KEY (id_reserva),
  CONSTRAINT fk_reserva_cli  FOREIGN KEY (id_cliente)
    REFERENCES cliente(id_cliente)
    ON DELETE CASCADE,
  CONSTRAINT fk_reserva_mesa FOREIGN KEY (id_mesa)
    REFERENCES mesa(id_mesa)
    ON DELETE RESTRICT,
  CONSTRAINT chk_pessoas CHECK (pessoas > 0)
);

CREATE TABLE comanda (
  id_comanda INT         NOT NULL AUTO_INCREMENT,
  status     VARCHAR(20) NOT NULL DEFAULT 'aberta',
  id_cliente INT         NOT NULL,
  id_mesa    INT         NOT NULL,
  CONSTRAINT pk_comanda      PRIMARY KEY (id_comanda),
  CONSTRAINT fk_comanda_cli  FOREIGN KEY (id_cliente)
    REFERENCES cliente(id_cliente)
    ON DELETE RESTRICT,
  CONSTRAINT fk_comanda_mesa FOREIGN KEY (id_mesa)
    REFERENCES mesa(id_mesa)
    ON DELETE RESTRICT,
  CONSTRAINT chk_status CHECK (status IN ('aberta', 'fechada', 'cancelada'))
);

CREATE TABLE pagamento (
  id_pagamento    INT          NOT NULL AUTO_INCREMENT,
  valor           DECIMAL(8,2) NOT NULL,
  forma_pagamento VARCHAR(20)  NOT NULL DEFAULT 'dinheiro',
  id_comanda      INT          NOT NULL,
  CONSTRAINT pk_pagamento     PRIMARY KEY (id_pagamento),
  CONSTRAINT uq_pag_comanda   UNIQUE (id_comanda),
  CONSTRAINT fk_pagamento_cmd FOREIGN KEY (id_comanda)
    REFERENCES comanda(id_comanda)
    ON DELETE CASCADE,
  CONSTRAINT chk_valor  CHECK (valor > 0),
  CONSTRAINT chk_forma  CHECK (forma_pagamento IN ('dinheiro', 'cartao', 'pix'))
);

CREATE TABLE funcionario (
  CPF            CHAR(11)     NOT NULL,
  nome           VARCHAR(100) NOT NULL,
  salario        DECIMAL(8,2) NOT NULL,
  rua            VARCHAR(100) NOT NULL,
  bairro         VARCHAR(60)  NOT NULL,
  estado         CHAR(2)      NOT NULL,
  CEP            CHAR(8)      NOT NULL,
  numero         VARCHAR(10)  NOT NULL,
  CPF_supervisor CHAR(11)     NULL,
  CONSTRAINT pk_funcionario     PRIMARY KEY (CPF),
  CONSTRAINT fk_func_supervisor FOREIGN KEY (CPF_supervisor)
    REFERENCES funcionario(CPF)
    ON DELETE SET NULL,
  CONSTRAINT chk_salario CHECK (salario > 0)
);

CREATE TABLE bartender (
  CPF                   CHAR(11)     NOT NULL,
  especialidade_bebidas VARCHAR(100) NOT NULL,
  CONSTRAINT pk_bartender      PRIMARY KEY (CPF),
  CONSTRAINT fk_bartender_func FOREIGN KEY (CPF)
    REFERENCES funcionario(CPF)
    ON DELETE CASCADE
);

CREATE TABLE cozinheiro (
  CPF     CHAR(11)     NOT NULL,
  cozinha VARCHAR(100) NOT NULL,
  CONSTRAINT pk_cozinheiro      PRIMARY KEY (CPF),
  CONSTRAINT fk_cozinheiro_func FOREIGN KEY (CPF)
    REFERENCES funcionario(CPF)
    ON DELETE CASCADE
);

CREATE TABLE garcom (
  CPF               CHAR(11)     NOT NULL,
  setor_atendimento VARCHAR(100) NOT NULL,
  CONSTRAINT pk_garcom      PRIMARY KEY (CPF),
  CONSTRAINT fk_garcom_func FOREIGN KEY (CPF)
    REFERENCES funcionario(CPF)
    ON DELETE CASCADE
);

CREATE TABLE atendimento (
  id_atendimento INT          NOT NULL AUTO_INCREMENT,
  id_comanda     INT          NOT NULL,
  id_produto     INT          NOT NULL,
  CPF            CHAR(11)     NOT NULL,
  quantidade     INT          NOT NULL DEFAULT 1,
  observacao     VARCHAR(255) NULL,
  CONSTRAINT pk_atendimento       PRIMARY KEY (id_atendimento),
  CONSTRAINT fk_atend_comanda     FOREIGN KEY (id_comanda)
    REFERENCES comanda(id_comanda)
    ON DELETE CASCADE,
  CONSTRAINT fk_atend_produto     FOREIGN KEY (id_produto)
    REFERENCES produto(id_produto)
    ON DELETE RESTRICT,
  CONSTRAINT fk_atend_funcionario FOREIGN KEY (CPF)
    REFERENCES funcionario(CPF)
    ON DELETE RESTRICT,
  CONSTRAINT chk_quantidade CHECK (quantidade > 0)
);


INSERT INTO categoria (nome_categoria) VALUES
  ('Bebidas'),
  ('Petiscos'),
  ('Pratos Principais'),
  ('Sobremesas'),
  ('Drinks');


INSERT INTO produto (nome, preco, id_categoria) VALUES
  ('Cerveja Heineken',    12.00, 1),
  ('Suco de Laranja',      8.00, 1),
  ('Batata Frita',        18.00, 2),
  ('Calabresa Acebolada', 25.00, 2),
  ('Frango Grelhado',     42.00, 3),
  ('Filé de Tilápia',     48.00, 3),
  ('Pudim',               14.00, 4),
  ('Caipirinha',          20.00, 5);

INSERT INTO cliente (nome, data_nascimento) VALUES
  ('Ana Lima',       '1995-03-12'),
  ('Carlos Souza',   '1988-07-25'),
  ('Maria Oliveira', '2000-11-08'),
  ('João Ferreira',  '1992-05-30'),
  ('Beatriz Costa',  '1998-09-14');
  
INSERT INTO telefone (id_cliente, numero) VALUES
  (1, '81991110001'),
  (2, '81992220002'),
  (2, '81993330003'),
  (3, '81994440004'),
  (4, '81995550005'),
  (5, '81996660006');

INSERT INTO mesa (capacidade) VALUES
  (4),
  (6),
  (2),
  (8);


INSERT INTO reserva (horario, pessoas, id_cliente, id_mesa) VALUES
  ('2025-06-01 19:00:00', 4, 1, 1),
  ('2025-06-01 20:00:00', 6, 2, 2),
  ('2025-06-02 18:30:00', 2, 3, 3),
  ('2025-06-02 21:00:00', 8, 4, 4);

INSERT INTO funcionario (CPF, nome, salario, rua, bairro, estado, CEP, numero, CPF_supervisor) VALUES
  ('11111111111', 'Roberto Alves',   3500.00, 'Rua das Flores',    'Boa Vista',  'PE', '52000000', '10',   NULL),
  ('22222222222', 'Fernanda Dias',   2800.00, 'Av. Agamenon',      'Derby',      'PE', '52010000', '200',  '11111111111'),
  ('33333333333', 'Lucas Martins',   2600.00, 'Rua do Hospício',   'Boa Vista',  'PE', '52020000', '35',   '11111111111'),
  ('44444444444', 'Patrícia Nunes',  2700.00, 'Rua Imperial',      'São José',   'PE', '52030000', '88',   '11111111111'),
  ('55555555555', 'Thiago Barros',   2500.00, 'Rua da Aurora',     'Soledade',   'PE', '52040000', '5',    '11111111111');

INSERT INTO bartender (CPF, especialidade_bebidas) VALUES
  ('22222222222', 'Drinks tropicais'),
  ('55555555555', 'Coquetéis clássicos');

INSERT INTO cozinheiro (CPF, cozinha) VALUES
  ('33333333333', 'Culinária nordestina'),
  ('44444444444', 'Grelhados e frutos do mar');


INSERT INTO garcom (CPF, setor_atendimento) VALUES
  ('11111111111', 'Salão principal');


INSERT INTO comanda (status, id_cliente, id_mesa) VALUES
  ('fechada',  1, 1),
  ('fechada',  2, 2),
  ('aberta',   3, 3),
  ('aberta',   4, 4);


INSERT INTO pagamento (valor, forma_pagamento, id_comanda) VALUES
  (74.00, 'pix',     1),
  (85.00, 'cartao',  2);


INSERT INTO atendimento (id_comanda, id_produto, CPF, quantidade, observacao) VALUES
  (1, 1, '11111111111', 2, NULL),
  (1, 3, '11111111111', 1, 'sem sal'),
  (1, 7, '11111111111', 1, NULL),
  (2, 5, '11111111111', 2, 'bem passado'),
  (2, 8, '22222222222', 3, NULL),
  (3, 4, '11111111111', 1, 'sem cebola');
  
DELIMITER //
CREATE FUNCTION calcular_idade_cliente(
    nascimento DATE
)
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE idade INT;

    IF nascimento IS NULL THEN
        SET idade = 0;
    ELSE
        SET idade = TIMESTAMPDIFF(YEAR, nascimento, CURDATE());
    END IF;

    RETURN idade;
END//
DELIMITER ;


DELIMITER //
CREATE FUNCTION calcular_total_comanda(
    p_id_comanda INT
)
RETURNS DECIMAL(10,2)
NOT DETERMINISTIC
READS SQL DATA
BEGIN
    DECLARE total DECIMAL(10,2);
 
    SELECT SUM(p.preco * a.quantidade)
    INTO total
    FROM atendimento a
    JOIN produto p ON a.id_produto = p.id_produto
    WHERE a.id_comanda = p_id_comanda;
 
    RETURN IFNULL(total, 0);
END//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE atualizar_salario_funcionario(
    IN p_cpf       CHAR(11),
    IN p_novo_salario DECIMAL(10,2)
)
BEGIN
    UPDATE funcionario
    SET salario = p_novo_salario
    WHERE CPF = p_cpf;
END//
DELIMITER ;


DELIMITER //
CREATE PROCEDURE aplicar_aumento_por_cargo(
    IN p_cargo      VARCHAR(20),   -- 'garcom', 'cozinheiro' ou 'bartender'
    IN p_percentual DECIMAL(5,2),  -- ex: 10.00 para 10%
    IN p_teto       DECIMAL(10,2)  -- salário máximo permitido
)
BEGIN
    DECLARE v_cpf        CHAR(11);
    DECLARE v_salario    DECIMAL(10,2);
    DECLARE v_novo       DECIMAL(10,2);
    DECLARE fim          INT DEFAULT FALSE;

    DECLARE cursor_cargo CURSOR FOR
        SELECT f.CPF, f.salario
        FROM funcionario f
        WHERE f.CPF IN (
            SELECT CPF FROM garcom     WHERE p_cargo = 'garcom'
            UNION
            SELECT CPF FROM cozinheiro WHERE p_cargo = 'cozinheiro'
            UNION
            SELECT CPF FROM bartender  WHERE p_cargo = 'bartender'
        );

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET fim = TRUE;

    OPEN cursor_cargo;

    loop_cargo: LOOP
        FETCH cursor_cargo INTO v_cpf, v_salario;

        IF fim THEN
            LEAVE loop_cargo;
        END IF;

        SET v_novo = v_salario * (1 + p_percentual / 100);

        IF v_novo <= p_teto THEN
            UPDATE funcionario
            SET salario = v_novo
            WHERE CPF = v_cpf;
        END IF;

    END LOOP;

    CLOSE cursor_cargo;
END//
DELIMITER ;


CREATE TABLE IF NOT EXISTS log_salario (
    id_log          INT          NOT NULL AUTO_INCREMENT,
    cpf_funcionario CHAR(11)     NOT NULL,
    salario_antigo  DECIMAL(10,2) NOT NULL,
    salario_novo    DECIMAL(10,2) NOT NULL,
    data_alteracao  TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT pk_log_salario PRIMARY KEY (id_log)
);


DELIMITER //
CREATE TRIGGER log_alteracao_salario
AFTER UPDATE ON funcionario
FOR EACH ROW
BEGIN
    IF OLD.salario <> NEW.salario THEN
        INSERT INTO log_salario (cpf_funcionario, salario_antigo, salario_novo)
        VALUES (OLD.CPF, OLD.salario, NEW.salario);
    END IF;
END//
DELIMITER ;


DELIMITER //
CREATE TRIGGER fechar_comanda_apos_pagamento
AFTER INSERT ON pagamento
FOR EACH ROW
BEGIN
    UPDATE comanda
    SET status = 'fechada'
    WHERE id_comanda = NEW.id_comanda;
END//
DELIMITER ;


CREATE OR REPLACE VIEW vw_comandas_abertas AS
SELECT
    c.id_comanda,
    cli.nome         AS cliente,
    m.id_mesa,
    p.nome           AS produto,
    a.quantidade,
    a.observacao,
    f.nome           AS funcionario,
    c.status
FROM comanda c
JOIN cliente    cli ON c.id_cliente  = cli.id_cliente
JOIN mesa       m   ON c.id_mesa     = m.id_mesa
JOIN atendimento a  ON c.id_comanda  = a.id_comanda
JOIN produto    p   ON a.id_produto  = p.id_produto
JOIN funcionario f  ON a.CPF         = f.CPF
WHERE c.status = 'aberta';



CREATE OR REPLACE VIEW vw_produtos_acima_media AS
SELECT
    p.id_produto,
    p.nome           AS produto,
    p.preco,
    c.nome_categoria AS categoria
FROM produto p
JOIN categoria c ON p.id_categoria = c.id_categoria
WHERE p.preco > (
    SELECT AVG(preco) FROM produto
);

SELECT
    m.id_mesa,
    m.capacidade,
    COUNT(DISTINCT c.id_comanda) AS total_comandas,
    SUM(p.preco * a.quantidade)  AS total_faturado
FROM mesa m
JOIN comanda     c ON c.id_mesa     = m.id_mesa
JOIN atendimento a ON a.id_comanda  = c.id_comanda
JOIN produto     p ON p.id_produto  = a.id_produto
GROUP BY m.id_mesa, m.capacidade
HAVING SUM(p.preco * a.quantidade) > 50.00
ORDER BY total_faturado DESC;

SELECT
    c.id_comanda,
    p.nome       AS produto,
    a.quantidade,
    a.observacao,
    f.nome       AS funcionario
FROM atendimento a
JOIN comanda    c ON a.id_comanda = c.id_comanda
JOIN produto    p ON a.id_produto = p.id_produto
JOIN funcionario f ON a.CPF       = f.CPF
WHERE c.status = 'aberta';

SELECT
    cli.id_cliente,
    cli.nome,
    cli.data_nascimento
FROM cliente cli
LEFT JOIN reserva r ON cli.id_cliente = r.id_cliente
WHERE r.id_reserva IS NULL;

SELECT
    f.CPF,
    f.nome,
    f.salario
FROM funcionario f
WHERE f.salario > (
    SELECT AVG(salario) FROM funcionario
)
ORDER BY f.salario DESC;

CREATE INDEX idx_comanda_status
ON comanda(status);

CREATE INDEX idx_produto_categoria
ON produto(id_categoria);

CREATE INDEX idx_atendimento_comanda
ON atendimento(id_comanda);