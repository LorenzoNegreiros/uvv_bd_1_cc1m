CREATE SCHEMA hr

CREATE TABLE hr.cargos (
                id_cargo VARCHAR(10) NOT NULL,
                cargo VARCHAR(35) NOT NULL,
                salario_minimo NUMERIC(8,2) NOT NULL,
                salario_maximo NUMERIC(8,2) NOT NULL,
                CONSTRAINT cargos_pk PRIMARY KEY (id_cargo)
);
COMMENT ON TABLE hr.cargos IS 'Tabela que registra os cargos que exitem. Tambem registra a faixa salarial de cada cargo.';
COMMENT ON COLUMN hr.cargos.id_cargo IS 'Chave primaria. Registra um codigo UNICO para cada cargo.';
COMMENT ON COLUMN hr.cargos.cargo IS 'Nome do cargo.';
COMMENT ON COLUMN hr.cargos.salario_minimo IS 'Salario minimo permitido para um cargo.';
COMMENT ON COLUMN hr.cargos.salario_maximo IS 'Salario maximo permitido para um cargo.';


CREATE UNIQUE INDEX cargos_idx
 ON hr.cargos
 ( cargo );

CREATE TABLE hr.regioes (
                id_regiao INTEGER NOT NULL,
                nome VARCHAR(25) NOT NULL,
                CONSTRAINT regioes_pk PRIMARY KEY (id_regiao)
);
COMMENT ON TABLE hr.regioes IS 'Tabela que registra as regioes onde a empresa esta presente. Contem os numeros identificadores e os nomes de cada regiao.';
COMMENT ON COLUMN hr.regioes.id_regiao IS 'Tabela com numeros identificadores de cada regiao.';
COMMENT ON COLUMN hr.regioes.nome IS 'Nome da regiao.';


CREATE UNIQUE INDEX regioes_idx
 ON hr.regioes
 ( nome );

CREATE TABLE hr.paises (
                id_paises CHAR(2) NOT NULL,
                nome VARCHAR(50) NOT NULL,
                id_regiao INTEGER NOT NULL,
                CONSTRAINT paises_pk PRIMARY KEY (id_paises)
);
COMMENT ON TABLE hr.paises IS 'Tabela que registra informacoes de cada pais onde a empresa tem sede.';
COMMENT ON COLUMN hr.paises.id_paises IS 'Chave primaria. Registra um cadigo UNICO para cada pais.';
COMMENT ON COLUMN hr.paises.nome IS 'Nome do pais.';
COMMENT ON COLUMN hr.paises.id_regiao IS 'FK vinda da tabela "regioes", coluna "id_regiao". Resgistra em que regiao um pais esta localizado.';


CREATE UNIQUE INDEX paises_idx
 ON hr.paises
 ( nome );

CREATE TABLE hr.localizacoes (
                id_localizacao INTEGER NOT NULL,
                endereco VARCHAR(50),
                cep VARCHAR(12),
                cidade VARCHAR(50),
                uf VARCHAR(25),
                id_paises CHAR(2) NOT NULL,
                CONSTRAINT localizacoes_pk PRIMARY KEY (id_localizacao)
);
COMMENT ON TABLE hr.localizacoes IS 'Essa tabela registra as localizacoes exatadas de cada estabeleciamento da empresa.';
COMMENT ON COLUMN hr.localizacoes.id_localizacao IS 'Chave primaria. Registra um codigo UNICO para cada localizacao.';
COMMENT ON COLUMN hr.localizacoes.endereco IS 'Endereco (logradouro, numero) de um escritorio ou facilidade da empresa.';
COMMENT ON COLUMN hr.localizacoes.cep IS 'CEP do endereco.';
COMMENT ON COLUMN hr.localizacoes.cidade IS 'Cidade em que esta localizado o escritorio ou outra facilidade da empresa.';
COMMENT ON COLUMN hr.localizacoes.uf IS 'Estado (abreviado ou por extenso) onde esta localizado o escritorio e/ou facilidade da empresa.';
COMMENT ON COLUMN hr.localizacoes.id_paises IS 'FK vinda da tabela "paises", coluna "id_paises". Resgistra em que pais esta registrada a localizacao do escritorio ou facilidade da empresa.';


CREATE TABLE hr.departamento (
                id_departamento INTEGER NOT NULL,
                nome VARCHAR(50),
                id_localizacao INTEGER NOT NULL,
                id_gerente INTEGER NOT NULL,
                CONSTRAINT departamento_pk PRIMARY KEY (id_departamento)
);
COMMENT ON TABLE hr.departamento IS 'Tabela que registra os departamentos da empresa. Tambem registra o gerente de cada departamento.';
COMMENT ON COLUMN hr.departamento.id_departamento IS 'Chave primaria. Registra um codigo UNICO cada departamento.';
COMMENT ON COLUMN hr.departamento.nome IS 'Nome do departamento.';
COMMENT ON COLUMN hr.departamento.id_localizacao IS 'FK vinda da tabela "localizacoes", coluna "id_localizacao". Resgistra onde certo departamento esta localizado.';
COMMENT ON COLUMN hr.departamento.id_gerente IS 'FK vinda da tabela "empregados", coluna "id_empregado". Resgistra o gerente de certo departamento. Todo gerente e um empregado.';


CREATE UNIQUE INDEX departamento_idx
 ON hr.departamento
 ( nome );

CREATE TABLE hr.empregados (
                id_empregado INTEGER NOT NULL,
                nome VARCHAR(75) NOT NULL,
                email VARCHAR(35) NOT NULL,
                telefone VARCHAR(20),
                data_contratacao DATE NOT NULL,
                id_cargo VARCHAR(10) NOT NULL,
                salario NUMERIC(8,2) NOT NULL,
                comissao NUMERIC(4,2) NOT NULL,
                id_departamento INTEGER NOT NULL,
                id_supervisor INTEGER NOT NULL,
                CONSTRAINT empregados_pk PRIMARY KEY (id_empregado)
);
COMMENT ON TABLE hr.empregados IS 'Tabela que registra dados dos empregados.';
COMMENT ON COLUMN hr.empregados.id_empregado IS 'Chave primaria. Registra um codigo UNICO para cada empregado.';
COMMENT ON COLUMN hr.empregados.nome IS 'Nome COMPLETO do empregado.';
COMMENT ON COLUMN hr.empregados.email IS 'Email do empregado.';
COMMENT ON COLUMN hr.empregados.telefone IS 'Telefone do empregado.';
COMMENT ON COLUMN hr.empregados.data_contratacao IS 'Data em que o empregado comecou a trabalhar em seu atual cargo.';
COMMENT ON COLUMN hr.empregados.id_cargo IS 'FK vinda da tabela "cargos", coluna "id_cargo". Resgistra o atual cargo de certo empregado.';
COMMENT ON COLUMN hr.empregados.salario IS 'Salario mensal de cada empregado.';
COMMENT ON COLUMN hr.empregados.comissao IS 'Porcentagem de comissao de certo empregado.';
COMMENT ON COLUMN hr.empregados.id_departamento IS 'FK vinda da tabela "departamento", coluna "id_departamento". Registra em qual departamento certo empregado trabalha.';
COMMENT ON COLUMN hr.empregados.id_supervisor IS 'FK vinda da propria tabela "empregados", coluna "id_empregados". Registra o supervisor de um empregado. (Todo supervisor e um empregado)';


CREATE UNIQUE INDEX empredados_idx
 ON hr.empregados
 ( email );

CREATE TABLE hr.historico_cargos (
                id_empregado INTEGER NOT NULL,
                data_inicial DATE NOT NULL,
                data_final DATE NOT NULL,
                id_cargo VARCHAR(10) NOT NULL,
                id_departamento INTEGER NOT NULL,
                CONSTRAINT historico_cargos_pk PRIMARY KEY (id_empregado, data_inicial)
);
COMMENT ON TABLE hr.historico_cargos IS 'Essa tabela armazena dados atuais e antigos de cada empregado. Se um empregado mudar de dapartamento e/ou cargo, novos dados devem ser registrados.';
COMMENT ON COLUMN hr.historico_cargos.id_empregado IS '"PFK" que vem da tabela "empregados", coluna "id_empregado". Forma uma chave primaria composta juntamente com a coluna "data_inicial".';
COMMENT ON COLUMN hr.historico_cargos.data_inicial IS 'Forma uma chave primaria composta juntamente com a coluna "id_empregado". Registra a data em que certo empregado come�ou em certo cargo. Deve ser menor do que a coluna "data_final".';
COMMENT ON COLUMN hr.historico_cargos.data_final IS 'Ultimo dia em que um empregado trabalhou em certo cargo. Deve ser maior do que a coluna "data_inicial"';
COMMENT ON COLUMN hr.historico_cargos.id_cargo IS 'FK vinda da tabela "cargos", coluna "id_cargo". Resgistra o cargo anterior em que certo empregado trabalhava.';
COMMENT ON COLUMN hr.historico_cargos.id_departamento IS 'FK vinda da tabela "departamento", coluna "id_departamento". Resgistra o departamento anterior em que certo empregado trabalhava.';


ALTER TABLE hr.historico_cargos ADD CONSTRAINT cargos_historico_cargos_fk
FOREIGN KEY (id_cargo)
REFERENCES hr.cargos (id_cargo)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE hr.empregados ADD CONSTRAINT cargos_empregados_fk
FOREIGN KEY (id_cargo)
REFERENCES hr.cargos (id_cargo)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE hr.paises ADD CONSTRAINT regioes_paises_fk
FOREIGN KEY (id_regiao)
REFERENCES hr.regioes (id_regiao)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE hr.localizacoes ADD CONSTRAINT paises_localizacoes_fk
FOREIGN KEY (id_paises)
REFERENCES hr.paises (id_paises)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE hr.departamento ADD CONSTRAINT localizacoes_departamento_fk
FOREIGN KEY (id_localizacao)
REFERENCES hr.localizacoes (id_localizacao)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE hr.historico_cargos ADD CONSTRAINT departamento_historico_cargos_fk
FOREIGN KEY (id_departamento)
REFERENCES hr.departamento (id_departamento)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE hr.empregados ADD CONSTRAINT departamento_empregados_fk
FOREIGN KEY (id_departamento)
REFERENCES hr.departamento (id_departamento)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE hr.empregados ADD CONSTRAINT empregados_empregados_fk
FOREIGN KEY (id_supervisor)
REFERENCES hr.empregados (id_empregado)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE hr.departamento ADD CONSTRAINT empregados_departamento_fk
FOREIGN KEY (id_gerente)
REFERENCES hr.empregados (id_empregado)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE hr.historico_cargos ADD CONSTRAINT empregados_historico_cargos_fk
FOREIGN KEY (id_empregado)
REFERENCES hr.empregados (id_empregado)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;
