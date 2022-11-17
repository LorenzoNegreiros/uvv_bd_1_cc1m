
CREATE TABLE cargos (
                id_cargo VARCHAR(10) NOT NULL,
                cargo VARCHAR(35) NOT NULL,
                salario_minimo DECIMAL(8,2) NOT NULL,
                salario_maximo DECIMAL(8,2) NOT NULL,
                PRIMARY KEY (id_cargo)
);

ALTER TABLE cargos COMMENT 'Tabela que registra os cargos que exitem. Tambem registra a faixa salarial de cada cargo.';

ALTER TABLE cargos MODIFY COLUMN id_cargo VARCHAR(10) COMMENT 'Chave primaria. Registra um codigo UNICO para cada cargo.';

ALTER TABLE cargos MODIFY COLUMN cargo VARCHAR(35) COMMENT 'Nome do cargo.';

ALTER TABLE cargos MODIFY COLUMN salario_minimo DECIMAL(8, 2) COMMENT 'Salario minimo permitido para um cargo.';

ALTER TABLE cargos MODIFY COLUMN salario_maximo DECIMAL(8, 2) COMMENT 'Salario maximo permitido para um cargo.';


CREATE UNIQUE INDEX cargos_idx
 ON cargos
 ( cargo );

CREATE TABLE regioes (
                id_regiao INT NOT NULL,
                nome VARCHAR(25) NOT NULL,
                PRIMARY KEY (id_regiao)
);

ALTER TABLE regioes COMMENT 'Tabela que registra as regioes onde a empresa esta presente. Contem os numeros identificadores e os nomes de cada regiao.';

ALTER TABLE regioes MODIFY COLUMN id_regiao INTEGER COMMENT 'Tabela com numeros identificadores de cada regiao.';

ALTER TABLE regioes MODIFY COLUMN nome VARCHAR(25) COMMENT 'Nome da regiao.';


CREATE UNIQUE INDEX regioes_idx
 ON regioes
 ( nome );

CREATE TABLE paises (
                id_paises CHAR(2) NOT NULL,
                nome VARCHAR(50) NOT NULL,
                id_regiao INT NOT NULL,
                PRIMARY KEY (id_paises)
);

ALTER TABLE paises COMMENT 'Tabela que registra informacoes de cada pais onde a empresa tem sede.';

ALTER TABLE paises MODIFY COLUMN id_paises CHAR(2) COMMENT 'Chave primaria. Registra um cadigo UNICO para cada pais.';

ALTER TABLE paises MODIFY COLUMN nome VARCHAR(50) COMMENT 'Nome do pais.';

ALTER TABLE paises MODIFY COLUMN id_regiao INTEGER COMMENT 'FK vinda da tabela "regioes", coluna "id_regiao". Resgistra em que regiao um pais esta localizado.';


CREATE UNIQUE INDEX paises_idx
 ON paises
 ( nome );

CREATE TABLE localizacoes (
                id_localizacao INT NOT NULL,
                endereco VARCHAR(50),
                cep VARCHAR(12),
                cidade VARCHAR(50),
                uf VARCHAR(25),
                id_paises CHAR(2) NOT NULL,
                PRIMARY KEY (id_localizacao)
);

ALTER TABLE localizacoes COMMENT 'Essa tabela registra as localizacoes exatadas de cada estabeleciamento da empresa.';

ALTER TABLE localizacoes MODIFY COLUMN id_localizacao INTEGER COMMENT 'Chave primaria. Registra um codigo UNICO para cada localizacao.';

ALTER TABLE localizacoes MODIFY COLUMN endereco VARCHAR(50) COMMENT 'Endereco (logradouro, numero) de um escritorio ou facilidade da empresa.';

ALTER TABLE localizacoes MODIFY COLUMN cep VARCHAR(12) COMMENT 'CEP do endereco.';

ALTER TABLE localizacoes MODIFY COLUMN cidade VARCHAR(50) COMMENT 'Cidade em que esta localizado o escritorio ou outra facilidade da empresa.';

ALTER TABLE localizacoes MODIFY COLUMN uf VARCHAR(25) COMMENT 'Estado (abreviado ou por extenso) onde esta localizado o escritorio e/ou facilidade da empresa.';

ALTER TABLE localizacoes MODIFY COLUMN id_paises CHAR(2) COMMENT 'FK vinda da tabela "paises", coluna "id_paises". Resgistra em que pais esta registrada a localizacao do escritorio ou facilidade da empresa.';


CREATE TABLE departamento (
                id_departamento INT NOT NULL,
                nome VARCHAR(50),
                id_localizacao INT NOT NULL,
                id_gerente INT NOT NULL,
                PRIMARY KEY (id_departamento)
);

ALTER TABLE departamento COMMENT 'Tabela que registra os departamentos da empresa. Tambem registra o gerente de cada departamento.';

ALTER TABLE departamento MODIFY COLUMN id_departamento INTEGER COMMENT 'Chave primaria. Registra um codigo UNICO cada departamento.';

ALTER TABLE departamento MODIFY COLUMN nome VARCHAR(50) COMMENT 'Nome do departamento.';

ALTER TABLE departamento MODIFY COLUMN id_localizacao INTEGER COMMENT 'FK vinda da tabela "localizacoes", coluna "id_localizacao". Resgistra onde certo departamento esta localizado.';

ALTER TABLE departamento MODIFY COLUMN id_gerente INTEGER COMMENT 'FK vinda da tabela "empregados", coluna "id_empregado". Resgistra o gerente de certo departamento. Todo gerente e um empregado.';


CREATE UNIQUE INDEX departamento_idx
 ON departamento
 ( nome );

CREATE TABLE empregados (
                id_empregado INT NOT NULL,
                nome VARCHAR(75) NOT NULL,
                email VARCHAR(35) NOT NULL,
                telefone VARCHAR(20),
                data_contratacao DATE NOT NULL,
                id_cargo VARCHAR(10) NOT NULL,
                salario DECIMAL(8,2) NOT NULL,
                comissao DECIMAL(4,2) NOT NULL,
                id_departamento INT NOT NULL,
                id_supervisor INT NOT NULL,
                PRIMARY KEY (id_empregado)
);

ALTER TABLE empregados COMMENT 'Tabela que registra dados dos empregados.';

ALTER TABLE empregados MODIFY COLUMN id_empregado INTEGER COMMENT 'Chave primaria. Registra um codigo UNICO para cada empregado.';

ALTER TABLE empregados MODIFY COLUMN nome VARCHAR(75) COMMENT 'Nome COMPLETO do empregado.';

ALTER TABLE empregados MODIFY COLUMN email VARCHAR(35) COMMENT 'Email do empregado.';

ALTER TABLE empregados MODIFY COLUMN telefone VARCHAR(20) COMMENT 'Telefone do empregado.';

ALTER TABLE empregados MODIFY COLUMN data_contratacao DATE COMMENT 'Data em que o empregado comecou a trabalhar em seu atual cargo.';

ALTER TABLE empregados MODIFY COLUMN id_cargo VARCHAR(10) COMMENT 'FK vinda da tabela "cargos", coluna "id_cargo". Resgistra o atual cargo de certo empregado.';

ALTER TABLE empregados MODIFY COLUMN salario DECIMAL(8, 2) COMMENT 'Salario mensal de cada empregado.';

ALTER TABLE empregados MODIFY COLUMN comissao DECIMAL(4, 2) COMMENT 'Porcentagem de comissao de certo empregado.';

ALTER TABLE empregados MODIFY COLUMN id_departamento INTEGER COMMENT 'FK vinda da tabela "departamento", coluna "id_departamento". Registra em qual departamento certo empregado trabalha.';

ALTER TABLE empregados MODIFY COLUMN id_supervisor INTEGER COMMENT 'FK vinda da propria tabela "empregados", coluna "id_empregados". Registra o supervisor de um empregado. (Todo supervisor e um empregado)';


CREATE UNIQUE INDEX empredados_idx
 ON empregados
 ( email );

CREATE TABLE historico_cargos (
                id_empregado INT NOT NULL,
                data_inicial DATE NOT NULL,
                data_final DATE NOT NULL,
                id_cargo VARCHAR(10) NOT NULL,
                id_departamento INT NOT NULL,
                PRIMARY KEY (id_empregado, data_inicial)
);

ALTER TABLE historico_cargos COMMENT 'Essa tabela armazena dados atuais e antigos de cada empregado. Se um empregado mudar de dapartamento e/ou cargo, novos dados devem ser registrados.';

ALTER TABLE historico_cargos MODIFY COLUMN id_empregado INTEGER COMMENT '"PFK" que vem da tabela "empregados", coluna "id_empregado". Forma uma chave primaria composta juntamente com a coluna "data_inicial".';

ALTER TABLE historico_cargos MODIFY COLUMN data_inicial DATE COMMENT 'Forma uma chave primaria composta juntamente com a coluna "id_empregado". Registra a data em que certo empregado comecou em certo cargo. Deve ser menor do que a coluna "data_final".';

ALTER TABLE historico_cargos MODIFY COLUMN data_final DATE COMMENT 'Ultimo dia em que um empregado trabalhou em certo cargo. Deve ser maior do que a coluna "data_inicial"';

ALTER TABLE historico_cargos MODIFY COLUMN id_cargo VARCHAR(10) COMMENT 'FK vinda da tabela "cargos", coluna "id_cargo". Resgistra o cargo anterior em que certo empregado trabalhava.';

ALTER TABLE historico_cargos MODIFY COLUMN id_departamento INTEGER COMMENT 'FK vinda da tabela "departamento", coluna "id_departamento". Resgistra o departamento anterior em que certo empregado trabalhava.';


ALTER TABLE historico_cargos ADD CONSTRAINT cargos_historico_cargos_fk
FOREIGN KEY (id_cargo)
REFERENCES cargos (id_cargo)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE empregados ADD CONSTRAINT cargos_empregados_fk
FOREIGN KEY (id_cargo)
REFERENCES cargos (id_cargo)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE paises ADD CONSTRAINT regioes_paises_fk
FOREIGN KEY (id_regiao)
REFERENCES regioes (id_regiao)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE localizacoes ADD CONSTRAINT paises_localizacoes_fk
FOREIGN KEY (id_paises)
REFERENCES paises (id_paises)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE departamento ADD CONSTRAINT localizacoes_departamento_fk
FOREIGN KEY (id_localizacao)
REFERENCES localizacoes (id_localizacao)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE historico_cargos ADD CONSTRAINT departamento_historico_cargos_fk
FOREIGN KEY (id_departamento)
REFERENCES departamento (id_departamento)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE empregados ADD CONSTRAINT departamento_empregados_fk
FOREIGN KEY (id_departamento)
REFERENCES departamento (id_departamento)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE empregados ADD CONSTRAINT empregados_empregados_fk
FOREIGN KEY (id_supervisor)
REFERENCES empregados (id_empregado)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE departamento ADD CONSTRAINT empregados_departamento_fk
FOREIGN KEY (id_gerente)
REFERENCES empregados (id_empregado)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE historico_cargos ADD CONSTRAINT empregados_historico_cargos_fk
FOREIGN KEY (id_empregado)
REFERENCES empregados (id_empregado)
ON DELETE NO ACTION
ON UPDATE NO ACTION;
