GO
IF DB_ID ('Base_Dados_SI2_1617SI_23') IS NULL
	CREATE DATABASE Base_Dados_SI2_1617SI_23;
GO

USE Base_Dados_SI2_1617SI_23

GO

CREATE PROC Inserir_Aluguer_e_Cliente
@tipoDuração VARCHAR(2), @inicio DATETIME, @fim DATETIME, @numeroEmpregado INTEGER,
@nome VARCHAR(150) = NULL, @numeroFiscal INTEGER = NULL, @morada VARCHAR(150) = NULL
AS
	INSERT INTO dbo.Cliente(Nome, NumeroFiscal, Morada) VALUES ( @nome, @numeroFiscal, @morada);
	INSERT INTO dbo.Aluguer(TipoDuração, Inicio, Fim, CódigoCliente, NumeroEmpregado)
	VALUES (@tipoDuração, @inicio, @fim, @@IDENTITY, @numeroEmpregado)
GO

GO
CREATE PROC Listar_Equipamentos_Disponiveis_Periodo_Tipo
@inicioPeriodo DATETIME, @fimPeriodo DATETIME, @tipo VARCHAR(150)
AS
	SELECT * FROM Equipamento WHERE NomeTipo = @tipo AND Código NOT IN (
		SELECT CódigoEquipamento FROM EquipamentoAlugado WHERE NumeroSerieAluguer IN(
			SELECT NumeroSerie FROM Aluguer WHERE 
				(@inicioPeriodo<=Inicio AND Inicio<=@fimPeriodo)
				OR (Inicio<=@inicioPeriodo AND FimComExtra>=@fimPeriodo)
				OR (@inicioPeriodo<=Fim AND FimComExtra<=@fimPeriodo)))
GO

GO
CREATE PROC Listar_Equipamentos_Disponiveis_Ultima_Semana
AS
	DECLARE @fim DATETIME, @inicio DATETIME
	SET @fim = GETDATE();
	SET @inicio = DATEADD(dd,-7,@fim);
	SELECT * FROM Equipamento WHERE Código NOT IN (
		SELECT CódigoEquipamento FROM EquipamentoAlugado WHERE NumeroSerieAluguer IN
			(SELECT NumeroSerie FROM Aluguer WHERE 
				(@inicio<=Inicio AND Inicio<=@fim)
				OR (Inicio<=@inicio AND Fim>=@fim)
				OR (@inicio<=Fim AND Fim<=@fim)))
GO

GO
CREATE PROC Inserir_Desconto
@descrição VARCHAR(50), @inicio DATETIME, @fim DATETIME, @valor DECIMAL(2,2)
AS
	DECLARE @id INT;
	INSERT INTO dbo.Promoção (Descrição, Inicio, Fim) VALUES ( @descrição, @inicio, @fim);
	SET @id = @@IDENTITY
	INSERT INTO dbo.Desconto(NumeroIdentificadorPromoção,Valor) VALUES (@id, @valor)
	RETURN @id;
GO

GO
CREATE PROC Inserir_TempoExtra
@descrição VARCHAR(50), @inicio DATETIME, @fim DATETIME, @fracçãoExtra INTEGER, @tipoDuração VARCHAR(2)
AS
	DECLARE @id INT;
	INSERT INTO dbo.Promoção (Descrição, Inicio, Fim) VALUES ( @descrição, @inicio, @fim);
	SET @id = @@IDENTITY
	INSERT INTO  dbo.TempoExtra (NumeroIdentificadorPromoção, FracçãoExtra, TipoDuração) VALUES (@id, @fracçãoExtra, @tipoDuração)
	RETURN @id;
GO