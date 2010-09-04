--ESTADO
Insert into TB_ESTADO (TX_SIGLA,TX_DESCRICAO) values ('PR','Paraná');
Insert into TB_ESTADO (TX_SIGLA,TX_DESCRICAO) values ('SC','Santa Catarina');
Insert into TB_ESTADO (TX_SIGLA,TX_DESCRICAO) values ('SP','São Paulo');

--MUNICIPIO 
Insert into TB_MUNICIPIO (CD_CODIGO,TX_DESCRICAO,TX_ESTADO) values (1,'Curitiba','PR');

--USUARIO
Insert into TB_USUARIO (CD_CODIGO,TX_CPF,TX_LOGIN,TX_NOME,IN_PERFIL,TX_SENHA,IN_STATUS,CD_MUNICIPIO) values (1,'12345678901','thiago','Thiago Alves','a','admin','a',1);
