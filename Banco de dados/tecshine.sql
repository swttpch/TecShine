create database bdtecshine;
use bdtecshine;

-- -----------------------------------------------------
-- Table tb_administradora
-- -----------------------------------------------------
CREATE TABLE tb_administradora(
  id_adm INT NOT NULL auto_increment PRIMARY KEY,
  nome_razao_social_adm VARCHAR(45) NOT NULL,
  nome_adm VARCHAR(45) NOT NULL,
  telefone_adm VARCHAR(14) NULL,
  email_adm VARCHAR(45) NOT NULL,
  cep VARCHAR(9) NULL,
  endereco VARCHAR(45) NULL,
  numero VARCHAR(5) NULL,
  complemento VARCHAR(45) NULL,
  cnpj_adm CHAR(14) NOT NULL,
  senha_adm VARCHAR(30) NOT NULL
)auto_increment = 101 ;

insert into tb_administradora (nome_razao_social_adm, nome_adm, telefone_adm, email_adm, 
cep, endereco, numero, complemento, cnpj_adm, senha_adm)
values('Cora ltda','Cora Administradora de condominios','(11)2331-5132', 'cora@adm.com', '09990-360', 'Rua das Amoras', '32', 'bloco3', 12345678901234, 12345678),
('Alcaçuz ltda','Alcaçuz Administradora de condominios','(11)4562-5132', 'alcaçuz@adm.com', '09540-360', 'Rua das Pera', '25', 'bloco1', 43210987654321, 12345678);

-- -----------------------------------------------------
-- Table tb_condominio
-- -----------------------------------------------------
CREATE TABLE tb_condominio (
  id_cond INT NOT NULL auto_increment PRIMARY KEY,
  nome_razao_social_cond VARCHAR(45) NOT NULL,
  nome_cond VARCHAR(45) NOT NULL,
  telefone_cond VARCHAR(14) NULL,
  email_cond VARCHAR(45) NOT NULL,
  cep VARCHAR(9) NULL,
  endereco VARCHAR(45) NULL,
  numero VARCHAR(5) NULL,
  complemento VARCHAR(45) NULL,
  fk_adm INT NOT NULL,
  FOREIGN KEY (fk_adm) REFERENCES tb_administradora (id_adm)
)auto_increment = 1001;

insert into tb_condominio (nome_razao_social_cond, nome_cond, telefone_cond, email_cond, 
cep, endereco, numero, complemento, fk_adm)
values('Paulo Sergio ltda','Morada dos passaros','(11)2331-5132', 'morada@adm.com', '09230-300', 'Avenida Pedreira', '1058', null,101),
('Fortaleza ltda','Fortaleza real','(11)4562-2222', 'fortaleza@adm.com', '02450-340', 'Travessa Vieira', '887', null,102),
('Pedro Sampaio ltda','Vilagge Brasileiro','(11)2223-5132', 'vilagge@adm.com', '1350-360', 'Rua das Amadas', '321', null,101);

----------
-- Table tb_espaco
-- -----------------------------------------------------
CREATE TABLE tb_espaco (
  id_espaco INT NOT NULL auto_increment PRIMARY KEY,
  nome_espaco VARCHAR(45) NOT NULL,
  andar VARCHAR(2) NOT NULL,
  fk_cond INT NOT NULL,
  FOREIGN KEY (fk_cond) REFERENCES tb_condominio (id_cond)
)auto_increment = 2001;

insert into tb_espaco (nome_espaco, andar, fk_cond)
values('hall de entrada','1', 1001),
('corredor','3', 1002);

-- -----------------------------------------------------
-- Table tb_sensores
-- -----------------------------------------------------
CREATE TABLE tb_sensores (
  id_sensor INT NOT NULL auto_increment PRIMARY KEY,
  nome_sensor VARCHAR(45) NULL,
  fk_espaco INT NOT NULL,
  FOREIGN KEY (fk_espaco) REFERENCES tb_espaco (id_espaco)
)auto_increment = 3001;

insert into tb_sensores (nome_sensor, fk_espaco)
values('sensor hall 1', 2001),
('sensor andar 3', 2002),
('sensor hall 1', 2001);
-- -----------------------------------------------------
-- Table tb_movimentacao
-- -----------------------------------------------------
CREATE TABLE tb_movimentacao (
  id_mov INT NOT NULL auto_increment PRIMARY KEY,
  horario DATETIME NOT NULL,
  ativacao boolean NOT NULL, /*ele so aceita 1 ou 0 no insert*/
  fk_sensor INT NOT NULL,
  FOREIGN KEY (fk_sensor) REFERENCES tb_sensores (id_sensor)
)auto_increment = 10;

insert into tb_movimentacao (horario, ativacao, fk_sensor)
values('2021-10-15 09:34:21',1,3001),
('2020-04-02 22:34:21',1,3001),
('2021-06-15 10:40:21',1,3002);

select * from tb_administradora;
select * from tb_condominio;
select * from tb_espaco;
select * from tb_sensores;
select * from tb_movimentacao;

select tb_condominio.nome_cond as "o condomínio", tb_administradora.nome_adm as "Pertence a Administradora"from tb_condominio 
inner join tb_administradora 
	on tb_condominio.fk_adm = tb_administradora.id_adm;

select tb_condominio.nome_cond as "O condomínio", tb_administradora.nome_adm as "Que pertence a administradora:", tb_espaco.nome_espaco as "Possui o espaço:" from tb_condominio 
inner join tb_administradora 
	on tb_condominio.fk_adm = tb_administradora.id_adm
inner join tb_espaco 
	on tb_espaco.fk_cond = tb_condominio.id_cond;

select tb_condominio.nome_cond as "O condomínio", tb_administradora.nome_adm as "Pertence a Administradora" from tb_condominio 
inner join tb_administradora 
	on tb_condominio.fk_adm = tb_administradora.id_adm 
where id_cond = 1002;
