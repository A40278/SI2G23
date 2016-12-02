GO
IF DB_ID ('Base_Dados_SI2_1617SI_23') IS NULL
	CREATE DATABASE Base_Dados_SI2_1617SI_23;
GO

USE Base_Dados_SI2_1617SI_23

INSERT INTO dbo.Tipo(Nome, Descrição) VALUES('Canoa','Canoa simples')
INSERT INTO dbo.Tipo(Nome, Descrição) VALUES('Gaivota','Gaivota simples')
INSERT INTO dbo.Tipo(Nome, Descrição) VALUES('Mota de Agua','Mota de Agua simples')
INSERT INTO dbo.Tipo(Nome, Descrição) VALUES('Remos','Remos simples')

INSERT INTO dbo.Equipamento(Descrição, NomeTipo) VALUES ('uma canoa vermelha','Canoa')
INSERT INTO dbo.Equipamento(Descrição, NomeTipo) VALUES ('uma canoa azul','Canoa')
INSERT INTO dbo.Equipamento(Descrição, NomeTipo) VALUES ('uma canoa vermelha','Canoa')

INSERT INTO dbo.Equipamento(Descrição, NomeTipo) VALUES ('uma gaivota azul','Gaivota')
INSERT INTO dbo.Equipamento(Descrição, NomeTipo) VALUES ('uma gaivota azul','Gaivota')

INSERT INTO dbo.Equipamento(Descrição, NomeTipo) VALUES ('uma mota de agua vermelha','Mota de Agua')
INSERT INTO dbo.Equipamento(Descrição, NomeTipo) VALUES ('uma mota de agua  vermelha','Mota de Agua')
INSERT INTO dbo.Equipamento(Descrição, NomeTipo) VALUES ('uma mota de agua  vermelha','Mota de Agua')
INSERT INTO dbo.Equipamento(Descrição, NomeTipo) VALUES ('uma mota de agua  vermelha','Mota de Agua')

INSERT INTO dbo.Equipamento(Descrição, NomeTipo) VALUES ('um par de Remos vermelhos','Remos')
INSERT INTO dbo.Equipamento(Descrição, NomeTipo) VALUES ('um par de Remos verdos','Remos')
INSERT INTO dbo.Equipamento(Descrição, NomeTipo) VALUES ('um par de Remos verdos','Remos')

--Ocupados na semana
INSERT INTO dbo.Equipamento(Descrição, NomeTipo) VALUES ('uma gaivota vermelha','Gaivota')
INSERT INTO dbo.Equipamento(Descrição, NomeTipo) VALUES ('uma canoa verde','Canoa')
INSERT INTO dbo.Equipamento(Descrição, NomeTipo) VALUES ('um par de Remos pretos','Remos')

--Ocupados na semana

INSERT INTO dbo.Preço (CódigoEquipamento, Inicio, Fim, TipoDuração, Valor) VALUES(1, '2016-01-01 00:00:00', '2016-05-01 00:00:00',
'h',20.50)
INSERT INTO dbo.Preço (CódigoEquipamento, Inicio, Fim, TipoDuração, Valor) VALUES(1, '2016-05-01 00:01:00', '2016-08-01 00:00:00',
'h',10.50)
INSERT INTO dbo.Preço (CódigoEquipamento, Inicio, Fim, TipoDuração, Valor) VALUES(1, '2016-08-01 00:01:00', '2016-12-31 23:59:00',
'h',30.50)

INSERT INTO dbo.Preço (CódigoEquipamento, Inicio, Fim, TipoDuração, Valor) VALUES(1, '2016-01-01 00:00:00', '2016-05-01 00:00:00',
'mh',10.00)
INSERT INTO dbo.Preço (CódigoEquipamento, Inicio, Fim, TipoDuração, Valor) VALUES(1, '2016-05-01 00:01:00', '2016-08-01 00:00:00',
'mh',5.00)
INSERT INTO dbo.Preço (CódigoEquipamento, Inicio, Fim, TipoDuração, Valor) VALUES(1, '2016-08-01 00:01:00', '2016-12-31 23:59:00',
'mh',15.00)

INSERT INTO dbo.Preço (CódigoEquipamento, Inicio, Fim, TipoDuração, Valor) VALUES(2, '2016-01-01 00:00:00', '2016-05-01 00:00:00',
'h',27.00)
INSERT INTO dbo.Preço (CódigoEquipamento, Inicio, Fim, TipoDuração, Valor) VALUES(2, '2016-05-01 00:01:00', '2016-08-01 00:00:00',
'h',17.00)
INSERT INTO dbo.Preço (CódigoEquipamento, Inicio, Fim, TipoDuração, Valor) VALUES(2, '2016-08-01 00:01:00', '2016-12-31 23:59:00',
'h',37.00)

INSERT INTO dbo.Preço (CódigoEquipamento, Inicio, Fim, TipoDuração, Valor) VALUES(2, '2016-01-01 00:00:00', '2016-05-01 00:00:00',
'mh',13.50)
INSERT INTO dbo.Preço (CódigoEquipamento, Inicio, Fim, TipoDuração, Valor) VALUES(2, '2016-05-01 00:01:00', '2016-08-01 00:00:00',
'mh',8.90)
INSERT INTO dbo.Preço (CódigoEquipamento, Inicio, Fim, TipoDuração, Valor) VALUES(2, '2016-08-01 00:01:00', '2016-12-31 23:59:00',
'mh',7.10)

INSERT INTO dbo.Preço (CódigoEquipamento, Inicio, Fim, TipoDuração, Valor) VALUES(2, '2016-01-01 00:00:00', '2016-05-01 00:00:00',
'd',50.45)
INSERT INTO dbo.Preço (CódigoEquipamento, Inicio, Fim, TipoDuração, Valor) VALUES(2, '2016-05-01 00:01:00', '2016-08-01 00:00:00',
'd',55.05)
INSERT INTO dbo.Preço (CódigoEquipamento, Inicio, Fim, TipoDuração, Valor) VALUES(2, '2016-08-01 00:01:00', '2016-12-31 23:59:00',
'd',53.50)

INSERT INTO dbo.Preço (CódigoEquipamento, Inicio, Fim, TipoDuração, Valor) VALUES(3, '2016-01-01 00:00:00', '2016-05-01 00:00:00',
'h',15.75)
INSERT INTO dbo.Preço (CódigoEquipamento, Inicio, Fim, TipoDuração, Valor) VALUES(3, '2016-05-01 00:01:00', '2016-07-01 00:00:00',
'h',20.00)
INSERT INTO dbo.Preço (CódigoEquipamento, Inicio, Fim, TipoDuração, Valor) VALUES(3, '2016-07-01 00:01:00', '2016-10-31 00:00:00',
'h',18.90)
INSERT INTO dbo.Preço (CódigoEquipamento, Inicio, Fim, TipoDuração, Valor) VALUES(3, '2016-10-31 00:01:00', '2016-12-31 23:59:00',
'h',22.50)

INSERT INTO dbo.Preço (CódigoEquipamento, Inicio, Fim, TipoDuração, Valor) VALUES(3, '2016-01-01 00:00:00', '2016-05-01 00:00:00',
'mh',7.50)
INSERT INTO dbo.Preço (CódigoEquipamento, Inicio, Fim, TipoDuração, Valor) VALUES(3, '2016-05-01 00:01:00', '2016-07-01 00:00:00',
'mh',8.00)
INSERT INTO dbo.Preço (CódigoEquipamento, Inicio, Fim, TipoDuração, Valor) VALUES(3, '2016-07-01 00:01:00', '2016-10-31 00:00:00',
'mh',6.70)
INSERT INTO dbo.Preço (CódigoEquipamento, Inicio, Fim, TipoDuração, Valor) VALUES(3, '2016-10-31 00:01:00', '2016-12-31 23:59:00',
'mh',10.30)

INSERT INTO dbo.Preço (CódigoEquipamento, Inicio, Fim, TipoDuração, Valor) VALUES(3, '2016-01-01 00:00:00', '2016-05-01 00:00:00',
'd',30.30)
INSERT INTO dbo.Preço (CódigoEquipamento, Inicio, Fim, TipoDuração, Valor) VALUES(3, '2016-05-01 00:01:00', '2016-07-01 00:00:00',
'd',45.50)
INSERT INTO dbo.Preço (CódigoEquipamento, Inicio, Fim, TipoDuração, Valor) VALUES(3, '2016-07-01 00:01:00', '2016-10-31 00:00:00',
'd',34.80)
INSERT INTO dbo.Preço (CódigoEquipamento, Inicio, Fim, TipoDuração, Valor) VALUES(3, '2016-10-31 00:01:00', '2016-12-31 23:59:00',
'd',22.50)

INSERT INTO dbo.Preço (CódigoEquipamento, Inicio, Fim, TipoDuração, Valor) VALUES(4, '2016-01-01 00:00:00', '2016-05-01 00:00:00',
'h',10.90)
INSERT INTO dbo.Preço (CódigoEquipamento, Inicio, Fim, TipoDuração, Valor) VALUES(4, '2016-05-01 00:01:00', '2016-08-01 00:00:00',
'h',13.75)
INSERT INTO dbo.Preço (CódigoEquipamento, Inicio, Fim, TipoDuração, Valor) VALUES(4, '2016-08-01 00:01:00', '2016-12-31 23:59:00',
'h',15.00)

INSERT INTO dbo.Preço (CódigoEquipamento, Inicio, Fim, TipoDuração, Valor) VALUES(4, '2016-01-01 00:00:00', '2016-05-01 00:00:00',
'mh',7.30)
INSERT INTO dbo.Preço (CódigoEquipamento, Inicio, Fim, TipoDuração, Valor) VALUES(4, '2016-05-01 00:01:00', '2016-08-01 00:00:00',
'mh',8.02)
INSERT INTO dbo.Preço (CódigoEquipamento, Inicio, Fim, TipoDuração, Valor) VALUES(4, '2016-08-01 00:01:00', '2016-12-31 23:59:00',
'mh',10.35)

--pode ser removido
INSERT INTO dbo.Preço (CódigoEquipamento, Inicio, Fim, TipoDuração, Valor) VALUES(4, '2017-01-01 00:00:00', '2017-05-31 23:59:00',
'd',10.70)
--pode ser removido

--ocupado na semana
INSERT INTO dbo.Preço (CódigoEquipamento, Inicio, Fim, TipoDuração, Valor) VALUES(5, '2017-01-01 00:00:00', '2017-05-31 23:59:00',
'd',10.35)
--ocupado na semana

INSERT INTO dbo.Preço (CódigoEquipamento, Inicio, Fim, TipoDuração, Valor) VALUES(5, '2016-01-01 00:00:00', '2016-05-01 00:00:00',
'h',11.80)
INSERT INTO dbo.Preço (CódigoEquipamento, Inicio, Fim, TipoDuração, Valor) VALUES(5, '2016-05-01 00:01:00', '2016-08-01 00:00:00',
'h',13.60)
INSERT INTO dbo.Preço (CódigoEquipamento, Inicio, Fim, TipoDuração, Valor) VALUES(5, '2016-08-01 00:01:00', '2016-12-31 23:59:00',
'h',16.70)

INSERT INTO dbo.Preço (CódigoEquipamento, Inicio, Fim, TipoDuração, Valor) VALUES(5, '2016-01-01 00:00:00', '2016-05-01 00:00:00',
'mh',8.50)
INSERT INTO dbo.Preço (CódigoEquipamento, Inicio, Fim, TipoDuração, Valor) VALUES(5, '2016-05-01 00:01:00', '2016-08-01 00:00:00',
'mh',10.00)
INSERT INTO dbo.Preço (CódigoEquipamento, Inicio, Fim, TipoDuração, Valor) VALUES(5, '2016-08-01 00:01:00', '2016-12-31 23:59:00',
'mh',11.30)

INSERT INTO dbo.Preço (CódigoEquipamento, Inicio, Fim, TipoDuração, Valor) VALUES(5, '2016-01-01 00:00:00', '2016-05-01 00:00:00',
'd',37.30)
INSERT INTO dbo.Preço (CódigoEquipamento, Inicio, Fim, TipoDuração, Valor) VALUES(5, '2016-05-01 00:01:00', '2016-07-01 00:00:00',
'd',45.80)
INSERT INTO dbo.Preço (CódigoEquipamento, Inicio, Fim, TipoDuração, Valor) VALUES(5, '2016-07-01 00:01:00', '2016-10-31 00:00:00',
'd',40.40)
INSERT INTO dbo.Preço (CódigoEquipamento, Inicio, Fim, TipoDuração, Valor) VALUES(5, '2016-10-31 00:01:00', '2016-12-31 23:59:00',
'd',38.65)

INSERT INTO dbo.Preço (CódigoEquipamento, Inicio, Fim, TipoDuração, Valor) VALUES(6, '2016-01-01 00:00:00', '2016-05-01 00:00:00',
'h',20.90)
INSERT INTO dbo.Preço (CódigoEquipamento, Inicio, Fim, TipoDuração, Valor) VALUES(6, '2016-05-01 00:01:00', '2016-08-01 00:00:00',
'h',13.75)
INSERT INTO dbo.Preço (CódigoEquipamento, Inicio, Fim, TipoDuração, Valor) VALUES(6, '2016-08-01 00:01:00', '2016-12-31 23:59:00',
'h',15.00)

INSERT INTO dbo.Preço (CódigoEquipamento, Inicio, Fim, TipoDuração, Valor) VALUES(6, '2016-01-01 00:00:00', '2016-05-01 00:00:00',
'mh',7.30)
INSERT INTO dbo.Preço (CódigoEquipamento, Inicio, Fim, TipoDuração, Valor) VALUES(6, '2016-05-01 00:01:00', '2016-08-01 00:00:00',
'mh',8.02)
INSERT INTO dbo.Preço (CódigoEquipamento, Inicio, Fim, TipoDuração, Valor) VALUES(6, '2016-08-01 00:01:00', '2016-12-31 23:59:00',
'mh',10.35)


--ocupado na semana
INSERT INTO dbo.Preço (CódigoEquipamento, Inicio, Fim, TipoDuração, Valor) VALUES(6, '2016-08-01 00:01:00', '2016-12-31 23:59:00',
'd',22.35)
--ocupado na semana

INSERT INTO dbo.Preço (CódigoEquipamento, Inicio, Fim, TipoDuração, Valor) VALUES(7, '2016-01-01 00:00:00', '2016-05-01 00:00:00',
'h',20.90)
INSERT INTO dbo.Preço (CódigoEquipamento, Inicio, Fim, TipoDuração, Valor) VALUES(7, '2016-05-01 00:01:00', '2016-08-01 00:00:00',
'h',13.60)
INSERT INTO dbo.Preço (CódigoEquipamento, Inicio, Fim, TipoDuração, Valor) VALUES(7, '2016-08-01 00:01:00', '2016-12-31 23:59:00',
'h',16.70)

INSERT INTO dbo.Preço (CódigoEquipamento, Inicio, Fim, TipoDuração, Valor) VALUES(7, '2016-01-01 00:00:00', '2016-05-01 00:00:00',
'mh',8.50)
INSERT INTO dbo.Preço (CódigoEquipamento, Inicio, Fim, TipoDuração, Valor) VALUES(7, '2016-05-01 00:01:00', '2016-08-01 00:00:00',
'mh',10.00)
INSERT INTO dbo.Preço (CódigoEquipamento, Inicio, Fim, TipoDuração, Valor) VALUES(7, '2016-08-01 00:01:00', '2016-12-31 23:59:00',
'mh',11.30)


--pode ser removido
INSERT INTO dbo.Preço (CódigoEquipamento, Inicio, Fim, TipoDuração, Valor) VALUES(7, '2017-01-01 00:00:00', '2017-05-31 23:59:00',
'd',45.35)
--pode ser removido

INSERT INTO dbo.Preço (CódigoEquipamento, Inicio, Fim, TipoDuração, Valor) VALUES(8, '2016-01-01 00:00:00', '2016-05-01 00:00:00',
'h',20.90)
INSERT INTO dbo.Preço (CódigoEquipamento, Inicio, Fim, TipoDuração, Valor) VALUES(8, '2016-05-01 00:01:00', '2016-08-01 00:00:00',
'h',13.75)
INSERT INTO dbo.Preço (CódigoEquipamento, Inicio, Fim, TipoDuração, Valor) VALUES(8, '2016-08-01 00:01:00', '2016-12-31 23:59:00',
'h',15.00)

INSERT INTO dbo.Preço (CódigoEquipamento, Inicio, Fim, TipoDuração, Valor) VALUES(8, '2016-01-01 00:00:00', '2016-05-01 00:00:00',
'mh',7.30)
INSERT INTO dbo.Preço (CódigoEquipamento, Inicio, Fim, TipoDuração, Valor) VALUES(8, '2016-05-01 00:01:00', '2016-08-01 00:00:00',
'mh',8.02)
INSERT INTO dbo.Preço (CódigoEquipamento, Inicio, Fim, TipoDuração, Valor) VALUES(8, '2016-08-01 00:01:00', '2016-12-31 23:59:00',
'mh',10.35)

INSERT INTO dbo.Preço (CódigoEquipamento, Inicio, Fim, TipoDuração, Valor) VALUES(8, '2016-01-01 00:00:00', '2016-05-01 00:00:00',
'd',40.30)
INSERT INTO dbo.Preço (CódigoEquipamento, Inicio, Fim, TipoDuração, Valor) VALUES(8, '2016-05-01 00:01:00', '2016-08-01 00:00:00',
'd',30.02)
INSERT INTO dbo.Preço (CódigoEquipamento, Inicio, Fim, TipoDuração, Valor) VALUES(8, '2016-08-01 00:01:00', '2016-12-31 23:59:00',
'd',42.35)

INSERT INTO dbo.Preço (CódigoEquipamento, Inicio, Fim, TipoDuração, Valor) VALUES(9, '2016-01-01 00:00:00', '2016-05-01 00:00:00',
'h',20.90)
INSERT INTO dbo.Preço (CódigoEquipamento, Inicio, Fim, TipoDuração, Valor) VALUES(9, '2016-05-01 00:01:00', '2016-08-01 00:00:00',
'h',13.60)
INSERT INTO dbo.Preço (CódigoEquipamento, Inicio, Fim, TipoDuração, Valor) VALUES(9, '2016-08-01 00:01:00', '2016-12-31 23:59:00',
'h',16.70)

INSERT INTO dbo.Preço (CódigoEquipamento, Inicio, Fim, TipoDuração, Valor) VALUES(9, '2016-01-01 00:00:00', '2016-05-01 00:00:00',
'mh',8.50)
INSERT INTO dbo.Preço (CódigoEquipamento, Inicio, Fim, TipoDuração, Valor) VALUES(9, '2016-05-01 00:01:00', '2016-08-01 00:00:00',
'mh',10.00)
INSERT INTO dbo.Preço (CódigoEquipamento, Inicio, Fim, TipoDuração, Valor) VALUES(9, '2016-08-01 00:01:00', '2016-12-31 23:59:00',
'mh',11.30)

INSERT INTO dbo.Preço (CódigoEquipamento, Inicio, Fim, TipoDuração, Valor) VALUES(11, '2016-01-01 00:00:00', '2016-05-01 00:00:00',
'h',5.30)
INSERT INTO dbo.Preço (CódigoEquipamento, Inicio, Fim, TipoDuração, Valor) VALUES(11, '2016-05-01 00:01:00', '2016-08-01 00:00:00',
'h',3.50)
INSERT INTO dbo.Preço (CódigoEquipamento, Inicio, Fim, TipoDuração, Valor) VALUES(11, '2016-08-01 00:01:00', '2016-12-31 23:59:00',
'h',7.90)

INSERT INTO dbo.Preço (CódigoEquipamento, Inicio, Fim, TipoDuração, Valor) VALUES(11, '2016-01-01 00:00:00', '2016-05-01 00:00:00',
'mh',2.30)
INSERT INTO dbo.Preço (CódigoEquipamento, Inicio, Fim, TipoDuração, Valor) VALUES(11, '2016-05-01 00:01:00', '2016-08-01 00:00:00',
'mh',0.40)
INSERT INTO dbo.Preço (CódigoEquipamento, Inicio, Fim, TipoDuração, Valor) VALUES(11, '2016-08-01 00:01:00', '2016-12-31 23:59:00',
'mh',4.80)

INSERT INTO dbo.Preço (CódigoEquipamento, Inicio, Fim, TipoDuração, Valor) VALUES(10, '2016-01-01 00:00:00', '2016-05-01 00:00:00',
'h',5.30)
INSERT INTO dbo.Preço (CódigoEquipamento, Inicio, Fim, TipoDuração, Valor) VALUES(10, '2016-05-01 00:01:00', '2016-08-01 00:00:00',
'h',3.50)
INSERT INTO dbo.Preço (CódigoEquipamento, Inicio, Fim, TipoDuração, Valor) VALUES(10, '2016-08-01 00:01:00', '2016-12-31 23:59:00',
'h',7.90)

INSERT INTO dbo.Preço (CódigoEquipamento, Inicio, Fim, TipoDuração, Valor) VALUES(10, '2016-01-01 00:00:00', '2016-05-01 00:00:00',
'mh',2.30)
INSERT INTO dbo.Preço (CódigoEquipamento, Inicio, Fim, TipoDuração, Valor) VALUES(10, '2016-05-01 00:01:00', '2016-08-01 00:00:00',
'mh',0.40)
INSERT INTO dbo.Preço (CódigoEquipamento, Inicio, Fim, TipoDuração, Valor) VALUES(10, '2016-08-01 00:01:00', '2016-12-31 23:59:00',
'mh',4.80)

INSERT INTO dbo.Preço (CódigoEquipamento, Inicio, Fim, TipoDuração, Valor) VALUES(12, '2016-01-01 00:00:00', '2016-05-01 00:00:00',
'h',6.75)
INSERT INTO dbo.Preço (CódigoEquipamento, Inicio, Fim, TipoDuração, Valor) VALUES(12, '2016-05-01 00:01:00', '2016-07-01 00:00:00',
'h',6.00)
INSERT INTO dbo.Preço (CódigoEquipamento, Inicio, Fim, TipoDuração, Valor) VALUES(12, '2016-07-01 00:01:00', '2016-10-31 00:00:00',
'h',7.90)
INSERT INTO dbo.Preço (CódigoEquipamento, Inicio, Fim, TipoDuração, Valor) VALUES(12, '2016-10-31 00:01:00', '2016-12-31 23:59:00',
'h',7.30)

INSERT INTO dbo.Preço (CódigoEquipamento, Inicio, Fim, TipoDuração, Valor) VALUES(12, '2016-01-01 00:00:00', '2016-05-01 00:00:00',
'mh',2.00)
INSERT INTO dbo.Preço (CódigoEquipamento, Inicio, Fim, TipoDuração, Valor) VALUES(12, '2016-05-01 00:01:00', '2016-07-01 00:00:00',
'mh',2.50)
INSERT INTO dbo.Preço (CódigoEquipamento, Inicio, Fim, TipoDuração, Valor) VALUES(12, '2016-07-01 00:01:00', '2016-10-31 00:00:00',
'mh',2.25)
INSERT INTO dbo.Preço (CódigoEquipamento, Inicio, Fim, TipoDuração, Valor) VALUES(12, '2016-10-31 00:01:00', '2016-12-31 23:59:00',
'mh',3.30)

INSERT INTO dbo.Preço (CódigoEquipamento, Inicio, Fim, TipoDuração, Valor) VALUES(12, '2016-01-01 00:00:00', '2016-05-01 00:00:00',
'd',12.30)
INSERT INTO dbo.Preço (CódigoEquipamento, Inicio, Fim, TipoDuração, Valor) VALUES(12, '2016-05-01 00:01:00', '2016-07-01 00:00:00',
'd',11.50)
INSERT INTO dbo.Preço (CódigoEquipamento, Inicio, Fim, TipoDuração, Valor) VALUES(12, '2016-07-01 00:01:00', '2016-10-31 00:00:00',
'd',13.80)
INSERT INTO dbo.Preço (CódigoEquipamento, Inicio, Fim, TipoDuração, Valor) VALUES(12, '2016-10-31 00:01:00', '2016-12-31 23:59:00',
'd',11.70)

INSERT INTO dbo.Cliente(Nome, NumeroFiscal, Morada) VALUES ('Alberto Correia', 366625532, 'Rua Lua Minha 57')
INSERT INTO dbo.Cliente(Nome, NumeroFiscal, Morada) VALUES ('João Mendes', 772000232, 'Rua Sol Brilho 30')
INSERT INTO dbo.Cliente(Nome, NumeroFiscal, Morada) VALUES (Null, Null, Null)
INSERT INTO dbo.Cliente(Nome, NumeroFiscal, Morada) VALUES ('Maria Coelho', 888213002, 'Rua Vinda Boa 28')
INSERT INTO dbo.Cliente(Nome, NumeroFiscal, Morada) VALUES (Null, Null, Null)

INSERT INTO dbo.Empregado(Nome) VALUES ('Ana Golvas')
INSERT INTO dbo.Empregado(Nome) VALUES ('Catia Miras')
INSERT INTO dbo.Empregado(Nome) VALUES ('Diogo Lopes')
INSERT INTO dbo.Empregado(Nome) VALUES ('Rui Pomas')

INSERT INTO dbo.Promoção (Descrição, Inicio, Fim) VALUES ('Primeiro Tempo Extra', '2016-04-01 00:00:00', '2016-07-31 00:00:00')
INSERT INTO dbo.Promoção (Descrição, Inicio, Fim) VALUES ('Segunda Tempo Extra', '2016-01-31 00:00:00', '2016-02-05 00:00:00')
INSERT INTO dbo.Promoção (Descrição, Inicio, Fim) VALUES ('Terceira Tempo Extra', '2016-01-31 00:00:00', '2016-02-05 00:00:00')
INSERT INTO dbo.Promoção (Descrição, Inicio, Fim) VALUES ('Quarta Tempo Extra', '2016-07-01 00:00:00', '2016-12-31 00:00:00')
INSERT INTO dbo.Promoção (Descrição, Inicio, Fim) VALUES ('Quinto Tempo Extra', '2016-05-08 00:00:00', '2016-10-01 00:00:00')

INSERT INTO dbo.Promoção (Descrição, Inicio, Fim) VALUES ('Primeiro Desconto', '2016-04-01 00:00:00', '2016-05-31 00:00:00')
INSERT INTO dbo.Promoção (Descrição, Inicio, Fim) VALUES ('Segunda Desconto', '2016-04-01 00:00:00', '2016-05-31 00:00:00')
INSERT INTO dbo.Promoção (Descrição, Inicio, Fim) VALUES ('Terceira Desconto', '2016-04-01 00:00:00', '2016-05-31 00:00:00')
INSERT INTO dbo.Promoção (Descrição, Inicio, Fim) VALUES ('Quarto Desconto', '2016-10-31 00:00:00', '2016-12-20 00:00:00')
INSERT INTO dbo.Promoção (Descrição, Inicio, Fim) VALUES ('Quinto Desconto', '2016-01-05 00:00:00', '2016-01-31 00:00:00')
INSERT INTO dbo.Promoção (Descrição, Inicio, Fim) VALUES ('Sexto Desconto', '2016-04-24 00:00:00', '2016-04-26 00:00:00')

INSERT INTO dbo.Promoção (Descrição, Inicio, Fim) VALUES ('Sexto Tempo Extra', '2016-05-20 00:00:00', '2016-05-31 00:00:00')
INSERT INTO dbo.Promoção (Descrição, Inicio, Fim) VALUES ('Setimo Tempo Extra', '2016-08-01 00:00:00', '2016-09-30 00:00:00')

INSERT INTO dbo.Promoção (Descrição, Inicio, Fim) VALUES ('Setimo Desconto', '2016-04-20 00:00:00', '2016-05-10 00:00:00')
INSERT INTO dbo.Promoção (Descrição, Inicio, Fim) VALUES ('Oitavo Desconto', '2016-07-02 00:00:00', '2016-07-07 00:00:00')

INSERT INTO dbo.TempoExtra (NumeroIdentificadorPromoção, FracçãoExtra, TipoDuração) VALUES (1,2,'h')
INSERT INTO dbo.TempoExtra (NumeroIdentificadorPromoção, FracçãoExtra, TipoDuração) VALUES (2,2,'mh')
INSERT INTO dbo.TempoExtra (NumeroIdentificadorPromoção, FracçãoExtra, TipoDuração) VALUES (3,1,'h')
INSERT INTO dbo.TempoExtra (NumeroIdentificadorPromoção, FracçãoExtra, TipoDuração) VALUES (4,4,'d')
INSERT INTO dbo.TempoExtra (NumeroIdentificadorPromoção, FracçãoExtra, TipoDuração) VALUES (5,3,'mh')

INSERT INTO dbo.TempoExtra (NumeroIdentificadorPromoção, FracçãoExtra, TipoDuração) VALUES (12,1,'d')
INSERT INTO dbo.TempoExtra (NumeroIdentificadorPromoção, FracçãoExtra, TipoDuração) VALUES (13,6,'mh')

INSERT INTO dbo.Desconto(NumeroIdentificadorPromoção,Valor) VALUES (6, 0.22)
INSERT INTO dbo.Desconto(NumeroIdentificadorPromoção,Valor) VALUES (7, 0.20)
INSERT INTO dbo.Desconto(NumeroIdentificadorPromoção,Valor) VALUES (8, 0.15)
INSERT INTO dbo.Desconto(NumeroIdentificadorPromoção,Valor) VALUES (9, 0.10)
INSERT INTO dbo.Desconto(NumeroIdentificadorPromoção,Valor) VALUES (10, 0.05)
INSERT INTO dbo.Desconto(NumeroIdentificadorPromoção,Valor) VALUES (11, 0.50)

INSERT INTO dbo.Desconto(NumeroIdentificadorPromoção,Valor) VALUES (14, 0.15)
INSERT INTO dbo.Desconto(NumeroIdentificadorPromoção,Valor) VALUES (15, 0.25)

INSERT INTO dbo.Tipo_Desconto(NumeroIdentificadorDesconto,NomeTipo) VALUES(6,'Canoa')
INSERT INTO dbo.Tipo_Desconto(NumeroIdentificadorDesconto,NomeTipo) VALUES(6,'Remos')
INSERT INTO dbo.Tipo_Desconto(NumeroIdentificadorDesconto,NomeTipo) VALUES(7,'Gaivota')
INSERT INTO dbo.Tipo_Desconto(NumeroIdentificadorDesconto,NomeTipo) VALUES(8,'Remos')
INSERT INTO dbo.Tipo_Desconto(NumeroIdentificadorDesconto,NomeTipo) VALUES(8,'Mota de Agua')
INSERT INTO dbo.Tipo_Desconto(NumeroIdentificadorDesconto,NomeTipo) VALUES(9,'Mota de Agua')
INSERT INTO dbo.Tipo_Desconto(NumeroIdentificadorDesconto,NomeTipo) VALUES(10,'Canoa')
INSERT INTO dbo.Tipo_Desconto(NumeroIdentificadorDesconto,NomeTipo) VALUES(10,'Remos')
INSERT INTO dbo.Tipo_Desconto(NumeroIdentificadorDesconto,NomeTipo) VALUES(10,'Gaivota')
INSERT INTO dbo.Tipo_Desconto(NumeroIdentificadorDesconto,NomeTipo) VALUES(10,'Mota de Agua')
INSERT INTO dbo.Tipo_Desconto(NumeroIdentificadorDesconto,NomeTipo) VALUES(11,'Mota de Agua')
INSERT INTO dbo.Tipo_Desconto(NumeroIdentificadorDesconto,NomeTipo) VALUES(14,'Mota de Agua')
INSERT INTO dbo.Tipo_Desconto(NumeroIdentificadorDesconto,NomeTipo) VALUES(14,'Gaivota')
INSERT INTO dbo.Tipo_Desconto(NumeroIdentificadorDesconto,NomeTipo) VALUES(15,'Canoa')
INSERT INTO dbo.Tipo_Desconto(NumeroIdentificadorDesconto,NomeTipo) VALUES(15,'Remos')

INSERT INTO dbo.Aluguer(TipoDuração, Inicio, Fim, CódigoCliente, NumeroEmpregado) VALUES ('d', '2016-07-05 00:00:00', '2016-07-31 00:00:00',
1, 2)
INSERT INTO dbo.Aluguer(TipoDuração, Inicio, Fim, CódigoCliente, NumeroEmpregado) VALUES ('mh', '2016-01-07 14:30:00', '2016-01-07 17:10:00',
1, 3)
INSERT INTO dbo.Aluguer(TipoDuração, Inicio, Fim, CódigoCliente, NumeroEmpregado) VALUES ('h', '2016-05-07 00:07:00', '2016-05-07 00:10:00',
2, 2)
INSERT INTO dbo.Aluguer(TipoDuração, Inicio, Fim, CódigoCliente, NumeroEmpregado) VALUES ('mh',  '2016-05-07 00:07:00', '2016-05-07 00:10:00',
3, 1)
INSERT INTO dbo.Aluguer(TipoDuração, Inicio, Fim, CódigoCliente, NumeroEmpregado) VALUES ('h', '2016-04-25 10:05:00', '2016-04-25 15:30:00',
4, 1)
INSERT INTO dbo.Aluguer(TipoDuração, Inicio, Fim, CódigoCliente, NumeroEmpregado) VALUES ('mh', '2016-07-10 10:00:00', '2016-07-10 13:00:00',
3, 3)
INSERT INTO dbo.Aluguer(TipoDuração, Inicio, Fim, CódigoCliente, NumeroEmpregado) VALUES ('mh', '2016-01-07 17:40:00', '2016-01-07 18:40:00',
3, 1)
INSERT INTO dbo.Aluguer(TipoDuração, Inicio, Fim, CódigoCliente, NumeroEmpregado) VALUES ('d', '2017-03-01 10:00:00', '2017-03-20 13:00:00',
2, 4)
INSERT INTO dbo.Aluguer(TipoDuração, Inicio, Fim, CódigoCliente, NumeroEmpregado) VALUES ('d', '2016-11-01 10:00:00', '2017-02-28 13:30:00',
5, 3)

INSERT INTO dbo.EquipamentoAlugado(NumeroSerieAluguer,CódigoEquipamento) VALUES (1,8)
INSERT INTO dbo.EquipamentoAlugado(NumeroSerieAluguer,CódigoEquipamento) VALUES (2,1)
INSERT INTO dbo.EquipamentoAlugado(NumeroSerieAluguer,CódigoEquipamento) VALUES (2,2)
INSERT INTO dbo.EquipamentoAlugado(NumeroSerieAluguer,CódigoEquipamento) VALUES (2,11)
INSERT INTO dbo.EquipamentoAlugado(NumeroSerieAluguer,CódigoEquipamento) VALUES (2,10)
INSERT INTO dbo.EquipamentoAlugado(NumeroSerieAluguer,CódigoEquipamento) VALUES (3,1)
INSERT INTO dbo.EquipamentoAlugado(NumeroSerieAluguer,CódigoEquipamento) VALUES (3,11)
INSERT INTO dbo.EquipamentoAlugado(NumeroSerieAluguer,CódigoEquipamento) VALUES (4,9)
INSERT INTO dbo.EquipamentoAlugado(NumeroSerieAluguer,CódigoEquipamento) VALUES (5,9)
INSERT INTO dbo.EquipamentoAlugado(NumeroSerieAluguer,CódigoEquipamento) VALUES (7,13)
INSERT INTO dbo.EquipamentoAlugado(NumeroSerieAluguer,CódigoEquipamento) VALUES (7,14)
INSERT INTO dbo.EquipamentoAlugado(NumeroSerieAluguer,CódigoEquipamento) VALUES (7,15)
INSERT INTO dbo.EquipamentoAlugado(NumeroSerieAluguer,CódigoEquipamento) VALUES (8,4)
INSERT INTO dbo.EquipamentoAlugado(NumeroSerieAluguer,CódigoEquipamento) VALUES (8,5)
INSERT INTO dbo.EquipamentoAlugado(NumeroSerieAluguer,CódigoEquipamento) VALUES (8,7)

INSERT INTO dbo.EquipamentoAlugado(NumeroSerieAluguer,CódigoEquipamento) VALUES (9,3)
INSERT INTO dbo.EquipamentoAlugado(NumeroSerieAluguer,CódigoEquipamento) VALUES (9,6)
INSERT INTO dbo.EquipamentoAlugado(NumeroSerieAluguer,CódigoEquipamento) VALUES (9,12)

SELECT * FROM EquipamentoAlugado WHERE NumeroSerieAluguer = 9

SELECT * FROM EquipamentoAlugado WHERE NumeroSerieAluguer = 3
SELECT * FROM Aluguer WHERE NumeroSerie = 3

SELECT * FROM EquipamentoAlugado WHERE NumeroSerieAluguer = 2 