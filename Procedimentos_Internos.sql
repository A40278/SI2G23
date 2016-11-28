GO
IF DB_ID ('Base_Dados_SI2_1617SI_23') IS NULL
	CREATE DATABASE Base_Dados_SI2_1617SI_23;
GO

USE Base_Dados_SI2_1617SI_23

GO

CREATE PROC Inserir_Aluguer_e_Cliente
@tipoDura��o VARCHAR(2), @inicio DATETIME, @fim DATETIME, @numeroEmpregado INTEGER,
@nome VARCHAR(150) = NULL, @numeroFiscal INTEGER = NULL, @morada VARCHAR(150) = NULL
AS
	INSERT INTO dbo.Cliente(Nome, NumeroFiscal, Morada) VALUES ( @nome, @numeroFiscal, @morada);
	INSERT INTO dbo.Aluguer(TipoDura��o, Inicio, Fim, C�digoCliente, NumeroEmpregado)
	VALUES (@tipoDura��o, @inicio, @fim, @@IDENTITY, @numeroEmpregado)
GO

GO
CREATE PROC Listar_Equipamentos_Disponiveis_Periodo_Tipo
@inicioPeriodo DATETIME, @fimPeriodo DATETIME, @tipo VARCHAR(150)
AS
	SELECT * FROM Equipamento WHERE NomeTipo = @tipo AND C�digo NOT IN (
		SELECT C�digoEquipamento FROM EquipamentoAlugado WHERE NumeroSerieAluguer IN(
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
	SELECT * FROM Equipamento WHERE C�digo NOT IN (
		SELECT C�digoEquipamento FROM EquipamentoAlugado WHERE NumeroSerieAluguer IN
			(SELECT NumeroSerie FROM Aluguer WHERE 
				(@inicio<=Inicio AND Inicio<=@fim)
				OR (Inicio<=@inicio AND Fim>=@fim)
				OR (@inicio<=Fim AND Fim<=@fim)))
GO

GO
CREATE PROC Inserir_Desconto
@descri��o VARCHAR(50), @inicio DATETIME, @fim DATETIME, @valor DECIMAL(2,2)
AS
	DECLARE @id INT;
	INSERT INTO dbo.Promo��o (Descri��o, Inicio, Fim) VALUES ( @descri��o, @inicio, @fim);
	SET @id = @@IDENTITY
	INSERT INTO dbo.Desconto(NumeroIdentificadorPromo��o,Valor) VALUES (@id, @valor)
	RETURN @id;
GO

GO
CREATE PROC Inserir_TempoExtra
@descri��o VARCHAR(50), @inicio DATETIME, @fim DATETIME, @frac��oExtra INTEGER, @tipoDura��o VARCHAR(2)
AS
	DECLARE @id INT;
	INSERT INTO dbo.Promo��o (Descri��o, Inicio, Fim) VALUES ( @descri��o, @inicio, @fim);
	SET @id = @@IDENTITY
	INSERT INTO  dbo.TempoExtra (NumeroIdentificadorPromo��o, Frac��oExtra, TipoDura��o) VALUES (@id, @frac��oExtra, @tipoDura��o)
	RETURN @id;
GO