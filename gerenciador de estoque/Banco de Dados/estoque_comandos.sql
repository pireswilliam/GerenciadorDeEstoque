#------UPDATES
update transportadora set transp_nome ='Fort Atacadista' where transp_codigo = 1;

update fornecedor set forn_cidade = 'São Paulo' where forn_codigo = 2;

update itementrada set itensEnt_data = '10-09-2017'where itensEnt_codigo = 1;

##-----DELETES

delete from fornecedor where forn_codigo ='6';

delete from itementrada where itensEnt_codigo ='6';

delete from setor where setor_codigo ='5';


#--------VIEW

create view vw_transportadores as select * from transportadora;
alter view vw_transportadores as select transp_nome, transp_rua, transp_cidade from transportadora
order by transp_cidade;
select * from vw_transportadores;

create view vw_setores as select * from setor;
alter view vw_setores as select setor_nome, setor_descricao from setor
order by setor_nome;
select * from vw_setores;


create view vw_itemsaidas as select * from itemsaida;
alter view vw_itemsaidas as select itenssaida_nome, itenssaida_data, itenssaida_valorvenda from itemsaida
order by itenssaida_data;
select * from vw_itemsaidas;

#----- 1 - Triggers

create table log_fornecedor(
forn_nome varchar(45),
comando varchar (15) NULL,
usuario varchar (20)NULL,
data_hora date
);

DELIMITER $$
USE `estoque_banco`$$
CREATE DEFINER = CURRENT_USER TRIGGER `estoque_banco`.`log_fornecedor_INSERT` AFTER INSERT ON fornecedor FOR EACH ROW
BEGIN
INSERT INTO log_fornecedor
SET comando = 'INSERT',
forn_nome = NEW.forn_nome,
usuario = CURRENT_USER,
data_hora= now();
END$$
DELIMITER ;

INSERT INTO fornecedor (forn_nome, forn_cep, forn_rua, forn_numero, forn_cidade, forn_telefone)
VALUES 
('Forte Fornecedor','87666552','Rua Augusto Lima','01','Minas Gerais','33258879');

select * from log_fornecedor;



#----- 2 - Triggers

create table log_transportadora(
transp_nome varchar(45),
transp_cidade varchar(45),
comando varchar (15) NULL,
usuario varchar (20)NULL,
data_hora date
);

DELIMITER $$
USE `estoque_banco`$$
CREATE DEFINER = CURRENT_USER TRIGGER `estoque_banco`.`log_transportadora_INSERT` after INSERT ON transportadora FOR EACH ROW
BEGIN
INSERT INTO log_transportadora
SET comando = 'INSERT',
transp_nome = NEW.transp_nome,
transp_cidade = NEW.transp_cidade,
usuario = CURRENT_USER,
data_hora= now();
END$$
DELIMITER ;



insert into transportadora
(transp_nome,transp_cep, transp_rua,transp_numero, transp_cidade, transp_telefone)
values
('Araguaia Transp','89562355','Avenida Alagos','03','Tocantins','33525879');

select * from log_transportadora;

#----- 3 - Triggers

create table log_itementrada(
itensEnt_nome varchar(45),
comando varchar (15) NULL,
usuario varchar (20)NULL,
data_hora date
);

DELIMITER $$
USE `estoque_banco`$$
CREATE DEFINER = CURRENT_USER TRIGGER `estoque_banco`.`tg_itementrada_UPDATE` AFTER UPDATE ON itementrada FOR EACH ROW
BEGIN
INSERT INTO log_itementrada
SET comando = 'UPDATE',
itensEnt_nome = OLD.itensEnt_nome,
usuario = CURRENT_USER,
data_hora= now();
END$$
DELIMITER ;

UPDATE itementrada SET itensEnt_nome = 'Agua Mineral' WHERE itensEnt_codigo = '1';

select * from log_itementrada;



#----- 1 - Store Procedure

DELIMITER $$ 
create procedure verificar_Fornecedores (in forn_nome int)
begin

Select * from fornecedor
limit forn_nome;

END$$
DELIMITER ;

call verificar_Fornecedores(4);

#----- 2 - Store Procedure

DELIMITER $$ 
create procedure verificar_qnt_ItemEntrada (out quantidade int)
begin

SELECT COUNT(*) INTO quantidade FROM itementrada;


END$$
DELIMITER ;

call verificar_qnt_ItemEntrada(@total);
SELECT @total;

#----- 3 - Store Procedure


DELIMITER $$ 
create procedure Cidades_Transportadoras (in transp_cidade varchar(45))
begin

SELECT COUNT(*) INTO transp_cidade FROM transportadora;

END$$
DELIMITER ;

call Cidades_Transportadoras(@total);
select @total;


##---------- BLOB

create table imagens (
id_img int (10),
img blob,
descricao varchar(20)
)default charset =utf8;

insert into imagens
(id_img, img, descricao)
values
('1','load_file("D:\Faculdade- 2017\arroz.jpg")','Alimento');

select * from imagens;

show variables like "secure_file_priv";


##---------------INDEX
USE estoque_banco;

# pra ter um controle de resposta dos nomes dos fornecedores cadastrados
create index indexx on fornecedor(forn_codigo);


select * FROM fornecedor;


