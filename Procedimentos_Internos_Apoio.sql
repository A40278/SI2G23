GO
IF DB_ID ('Base_Dados_SI2_1617SI_23') IS NULL
	CREATE DATABASE Base_Dados_SI2_1617SI_23;
GO

USE Base_Dados_SI2_1617SI_23

GO

--(@inicio<=P.Inicio AND P.Inicio<=@fim) OR (P.Inicio<=@inicio AND P.Fim>=@fim) OR (@inicio<=P.Fim AND P.Fim<=@fim)--

GO
CREATE PROC Numero_de_Pre�os_No_Periodo
@inicio DATETIME = NULL, @fim DATETIME = NULL, @tipoDura��o VARCHAR(2) = NULL, @codigo INT = NULL
AS
	DECLARE @count INT;

	SELECT @count = COUNT(*) FROM(
		SELECT * FROM dbo.Pre�o WHERE TipoDura��o = @tipoDura��o AND C�digoEquipamento = @codigo)
	AS P
	WHERE (P.Inicio<=@inicio AND @inicio<=P.Fim) OR (P.Inicio<=@fim AND @fim<=P.Fim)

	RETURN @count;
GO

GO
CREATE PROC Fracoes_Tempo_Extra
@fim DATETIME = NULL, @inicio DATETIME = NULL, @tipoDura��o VARCHAR(2) = NULL
AS
	SET NOCOUNT ON
	DECLARE @fra�coesTempoExtra INTEGER = 0;

	SELECT @fra�coesTempoExtra =  COALESCE (SUM(Frac��oExtra),0) FROM(
		(SELECT NumeroIdentificador FROM dbo.Promo��o WHERE Fim>=@fim AND Inicio<=@inicio)
	AS Promo��esDisponivies
	INNER JOIN
		(SELECT NumeroIdentificadorPromo��o, Frac��oExtra FROM dbo.TempoExtra WHERE TipoDura��o=@tipoDura��o)
	AS TempoExtraDura��oCorrecta
	ON Promo��esDisponivies.NumeroIdentificador = TempoExtraDura��oCorrecta.NumeroIdentificadorPromo��o)
	
	RETURN @fra�coesTempoExtra
GO

GO
CREATE PROC Factor_Tipo_Dura��o
@tipoDura��o VARCHAR(2), @factor DECIMAL(10,2) = 00.00 OUTPUT
AS
	SELECT @factor =
	CASE @tipoDura��o
		WHEN 'mh' THEN 30.00
		WHEN 'h' THEN 60.00
		WHEN 'd' THEN 1440.00
		WHEN 's' THEN 10080.00
		ELSE 0.00
	END
GO

GO
CREATE PROC Verificar_Equipamento_Alugado_No_Periodo
@inicioPeriodo DATETIME, @fimPeriodo DATETIME, @codigo INTEGER
AS
	DECLARE @count INT;
	SELECT @count = COUNT(*) FROM EquipamentoAlugado WHERE C�digoEquipamento = @codigo AND NumeroSerieAluguer IN
			(SELECT NumeroSerie FROM Aluguer WHERE (Inicio<=@inicioPeriodo AND Fim>=@inicioPeriodo)
			OR (Inicio<=@fimPeriodo AND Fim>=@fimPeriodo))
	RETURN @count;
GO

GO
CREATE PROC Equipamento_Alugado_Pre�o
@codigo INT, @tipoDura��o VARCHAR(2), @inicio DATETIME, @fim DATETIME, @pre�o DECIMAL(10,2) OUTPUT
AS
	SELECT @pre�o = Valor FROM dbo.Pre�o WHERE Inicio<=@inicio AND Fim>=@inicio AND TipoDura��o = @tipoDura��o AND 
		C�digoEquipamento = @codigo;

	IF(@pre�o IS NULL)
		RETURN -1;
	
	DECLARE @blocoTemporal DECIMAL(10,2), @factor DECIMAL(10,2);

	EXEC Factor_Tipo_Dura��o @tipoDura��o, @factor OUTPUT;
	SELECT @blocoTemporal = CEILING(DATEDIFF(MI,@inicio,@fim) / @factor)
	SET @pre�o = (@pre�o*@blocoTemporal);
	
GO
CREATE PROC Equipamento_Alugado_Desconto
@codigo INT, @inicio DATETIME, @decontoTotal DECIMAL(10,2) OUTPUT
AS
	SELECT @decontoTotal = COALESCE(SUM(Valor),0) FROM dbo.Desconto WHERE 
	NumeroIdentificadorPromo��o IN
		(SELECT Promo��oNoPeriodo.NumeroIdentificador FROM (
			(SELECT NumeroIdentificador FROM dbo.Promo��o WHERE Inicio<=@inicio AND Fim>=@inicio) 
		AS Promo��oNoPeriodo
		INNER JOIN
			(SELECT NumeroIdentificadorDesconto FROM dbo.Tipo_Desconto WHERE NomeTipo = (SELECT NomeTipo FROM Equipamento WHERE C�digo = @codigo))
		AS Tipo_DescontoDoTipo
		ON Promo��oNoPeriodo.NumeroIdentificador = Tipo_DescontoDoTipo.NumeroIdentificadorDesconto))
	
	RETURN 0;
GO

GO
CREATE PROC Calcular_Pre�o_De_Aluguer
@c�digoEquipamento INT, @tipoDura��o VARCHAR(2), @inicio DATETIME, @fim DATETIME, @pre�o DECIMAL(10,2) OUTPUT, @desconto DECIMAL(10,2) OUTPUT, @pre�oAluguer DECIMAL(10,2) OUTPUT
AS
	DECLARE @ret INT;
	EXEC @ret = Equipamento_Alugado_Pre�o @c�digoEquipamento, @tipoDura��o, @inicio, @fim, @pre�o OUTPUT;
	IF(@ret=-1)
		RETURN -1;
	EXEC Equipamento_Alugado_Desconto @c�digoEquipamento, @inicio, @desconto OUTPUT;
	SET @pre�oAluguer = @pre�o - (@pre�o*@desconto);
GO