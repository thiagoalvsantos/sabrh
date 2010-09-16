-- ESTADO
Insert into TB_ESTADO (TX_SIGLA,TX_DESCRICAO) values ('PR','Paraná');
Insert into TB_ESTADO (TX_SIGLA,TX_DESCRICAO) values ('SC','Santa Catarina');
Insert into TB_ESTADO (TX_SIGLA,TX_DESCRICAO) values ('SP','São Paulo');

-- MUNICIPIO
Insert into TB_MUNICIPIO (CD_CODIGO,TX_DESCRICAO,TX_ESTADO) values (1,'Curitiba','PR');
Insert into TB_MUNICIPIO (CD_CODIGO,TX_DESCRICAO,TX_ESTADO) values (2,'Ponta Grossa','PR');
Insert into TB_MUNICIPIO (CD_CODIGO,TX_DESCRICAO,TX_ESTADO) values (3,'Londrina','PR');
Insert into TB_MUNICIPIO (CD_CODIGO,TX_DESCRICAO,TX_ESTADO) values (4,'Maringa','PR');
Insert into TB_MUNICIPIO (CD_CODIGO,TX_DESCRICAO,TX_ESTADO) values (5,'Foz do Iguaçú','PR');
Insert into TB_MUNICIPIO (CD_CODIGO,TX_DESCRICAO,TX_ESTADO) values (6,'Florianópolis','SC');
Insert into TB_MUNICIPIO (CD_CODIGO,TX_DESCRICAO,TX_ESTADO) values (7,'Lages','SC');
Insert into TB_MUNICIPIO (CD_CODIGO,TX_DESCRICAO,TX_ESTADO) values (8,'Canoinhas','SC');
Insert into TB_MUNICIPIO (CD_CODIGO,TX_DESCRICAO,TX_ESTADO) values (9,'Ferrugem','SC');
Insert into TB_MUNICIPIO (CD_CODIGO,TX_DESCRICAO,TX_ESTADO) values (10,'Praia do Rosa','SC');
Insert into TB_MUNICIPIO (CD_CODIGO,TX_DESCRICAO,TX_ESTADO) values (11,'Garopaba','SC');
Insert into TB_MUNICIPIO (CD_CODIGO,TX_DESCRICAO,TX_ESTADO) values (12,'Torres','SC');
Insert into TB_MUNICIPIO (CD_CODIGO,TX_DESCRICAO,TX_ESTADO) values (13,'São Paulo','SP');
Insert into TB_MUNICIPIO (CD_CODIGO,TX_DESCRICAO,TX_ESTADO) values (14,'Ourinhos','SP');
Insert into TB_MUNICIPIO (CD_CODIGO,TX_DESCRICAO,TX_ESTADO) values (15,'Assis','SP');
Insert into TB_MUNICIPIO (CD_CODIGO,TX_DESCRICAO,TX_ESTADO) values (16,'Campinas','SP');
Insert into TB_MUNICIPIO (CD_CODIGO,TX_DESCRICAO,TX_ESTADO) values (17,'São José dos Campos','SP');

-- USUARIO
--Insert into TB_USUARIO (CD_CODIGO,TX_CPF,TX_LOGIN,TX_NOME,IN_PERFIL,TX_SENHA,IN_STATUS,CD_MUNICIPIO) values (1,'000001','thiago','Thiago Alves','ADMINISTRADOR','admin','ATIVO',1);
--Insert into TB_USUARIO (CD_CODIGO,TX_CPF,TX_LOGIN,TX_NOME,IN_PERFIL,TX_SENHA,IN_STATUS,CD_MUNICIPIO) values (2,'000002','thiago2','Thiago Alves 2','PRODUTOR','admin','ATIVO',5);
--Insert into TB_USUARIO (CD_CODIGO,TX_CPF,TX_LOGIN,TX_NOME,IN_PERFIL,TX_SENHA,IN_STATUS,CD_MUNICIPIO) values (3,'000003','thiago3','Thiago Alves 3','ESPECIALISTA','admin','INATIVO',10);
--Insert into TB_USUARIO (CD_CODIGO,TX_CPF,TX_LOGIN,TX_NOME,IN_PERFIL,TX_SENHA,IN_STATUS,CD_MUNICIPIO) values (4,'000004','thiago4','Thiago Alves 4','ADMINISTRADOR','admin','ATIVO',14);
--Insert into TB_USUARIO (CD_CODIGO,TX_CPF,TX_LOGIN,TX_NOME,IN_PERFIL,TX_SENHA,IN_STATUS,CD_MUNICIPIO) values (5,'000005','thiago5','Thiago Alves 5','ESPECIALISTA','admin','INATIVO',17);
