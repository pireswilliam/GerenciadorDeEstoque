create database estoque;

use estoque;


# criar tabela : fornecedor --------------------------------


CREATE TABLE fornecedor (
  forn_codigo int(10) NOT NULL auto_increment ,
  forn_nome varchar(45),
  forn_cep int(12),
  forn_rua varchar(25),
  forn_numero int(5),
  forn_cidade varchar(45),
  forn_telefone int(15),
  primary key (forn_codigo)
  )default charset =utf8;
  

select * from fornecedor;



# criar tabela : transportadora-----------------------------


CREATE TABLE transportadora (
  transp_codigo int(10) NOT NULL auto_increment,
  transp_nome varchar(45),
  transp_cep int(12),
  transp_rua varchar(25),
  transp_numero int(5),
  transp_cidade varchar(45),
  transp_telefone int(15),
  primary key (transp_codigo)
  )default charset =utf8;


## criar tabela : itemEntrada-----------------------------------

CREATE TABLE itementrada (
  itensEnt_codigo int(10) NOT NULL auto_increment,
  itensEnt_nome varchar(45),
  itensEnt_data varchar(10),
  itensEnt_quantidade int(10),
  itensEnt_valorCusto double(10,2),
  primary key (itensEnt_codigo)
)default charset =utf8;



## criar tabela : itemSaida-------------------------------------

CREATE TABLE itemsaida (
  itensSaida_codigo int(10) NOT NULL auto_increment,
  itensSaida_nome varchar(45),
  itensSaida_data varchar(10),
  itensSaida_quantidade int(10),
  itensSaida_valorVenda double(10,2),
  primary key (itensSaida_codigo)
)default charset =utf8;



## criar tabela : setor -------------------------------------

CREATE TABLE setor(
  setor_codigo int(10) NOT NULL auto_increment,
  setor_nome varchar(45),
  setor_descricao varchar(30),
  primary key (setor_codigo)
)default charset =utf8;

##--adicionando as chaves estrangeiras da tabela : fornecedor

alter table fornecedor add column transp_codigo int;
alter table fornecedor
add foreign key (transp_codigo)
references transportadora(transp_codigo);

## adicionando as chaves estrangeiras da tabela : itementrada

alter table itementrada add column forn_codigo int;
alter table itementrada
add foreign key (forn_codigo)
references fornecedor(forn_codigo);

## adicionando as chaves estrangeiras da tabela : itemSaida

alter table itemsaida add column forn_codigo int;
alter table itemsaida
add foreign key (forn_codigo)
references fornecedor(forn_codigo);


alter table itemsaida add column setor_codigo int;
alter table itemsaida
add foreign key (setor_codigo)
references setor(setor_codigo);

##----------------------- inserir dados nas tabelas

insert into fornecedor
(forn_nome, forn_cep, forn_rua, forn_numero, forn_cidade, forn_telefone)
values
('Forte Entrega','72589895','Bispo Lagos','02','Brasília','30425879'),
('Jorge Distribuidora','89596350','Avenida Augusto','10','Minas Gerais','33368987'),
('Zen Alimentos','72589665','Alagados','13','Brasília','33789865'),
('Inova Forn','96852233','Avenida Pinheiro','05','Goias','30235896'),
('Forn Higiene','5698878','Pinheiro Lima','09','Rio Janeiro','40445898');

insert into transportadora
(transp_nome, transp_cep, transp_rua, transp_numero, transp_cidade, transp_telefone)
values
('Forte Transporte','89756320','Avenida Lima Costa','20','Brasília','30335589'),
('Liquid Trans','35898871','Avenida Mangueira','01 ','Rio Janeiro','40589632'),
('Aragao LTDA','87455232','Avenida Tavares','11 ','Brasília','33759865'),
('Bertolini GO LTDA','63589989','Avenida Pinheiro Lucio','08','Goias','30335569');

insert into itementrada
(itensent_nome, itensent_data, itensent_quantidade, itensent_valorcusto)
values
('Condicionador','15-09-2017','80','3.29'),
('Leite','02-09-2017','55','1.89'),
('Macarrão','09-03-2017','60','2.20'),
('Biscoito Mabel','08-08-2017','37','1.59'),
('Vinho','08-05-2017','45','10.89');

insert into itemsaida
(itenssaida_nome, itenssaida_data, itenssaida_quantidade, itenssaida_valorvenda)
values
('Desifetante','18-09-2017','20','3.99'),
('Leite Condensado','09-13-2017','36','4.49'),
('Biscoito Bauducco','01-09-2017','50','4.50'),
('Iorgurte Batavo','29-08-2017','57','2.59'),
('Refrigerante Sprite','17-08-2017','90','6.89'),
('Creme Dental','19-09-2017','40','0.99');

insert into setor
(setor_nome, setor_descricao)
values
('Mercenaria','Alimentos'),
('Perfumaria','Higiene'),
('Bebidas','Destilados'),
('Higiene Pessoal','Uso Pessoal');