GO
IF DB_ID ('Base_Dados_SI2_1617SI_23') IS NULL
	CREATE DATABASE Base_Dados_SI2_1617SI_23;
GO

USE Base_Dados_SI2_1617SI_23

GO

--(@inicio<=P.Inicio AND P.Inicio<=@fim) OR (P.Inicio<=@inicio AND P.Fim>=@fim) OR (@inicio<=P.Fim AND P.Fim<=@fim)--

GO
CREATE PROC Numero_de_Preços_No_Periodo
@inicio DATETIME = NULL, @fim DATETIME = NULL, @tipoDuração VARCHAR(2) = NULL, @codigo INT = NULL
AS
	DECLARE @count INT;

	SELECT @count = COUNT(*) FROM(
		SELECT * FROM dbo.Preço WHERE TipoDuração = @tipoDuração AND CódigoEquipamento = @codigo)
	AS P
	WHERE (P.Inicio<=@inicio AND @inicio<=P.Fim) OR (P.Inicio<=@fim AND @fim<=P.Fim)

	RETURN @count;
GO

GO
CREATE PROC Fracoes_Tempo_Extra
@fim DATETIME = NULL, @inicio DATETIME = NULL, @tipoDuração VARCHAR(2) = NULL
AS
	SET NOCOUNT ON
	DECLARE @fraçcoesTempoExtra INTEGER = 0;

	SELECT @fraçcoesTempoExtra =  COALESCE (SUM(FracçãoExtra),0) FROM(
		(SELECT NumeroIdentificador FROM dbo.Promoção WHERE Fim>=@fim AND Inicio<=@inicio)
	AS PromoçõesDisponivies
	INNER JOIN
		(SELECT NumeroIdentificadorPromoção, FracçãoExtra FROM dbo.TempoExtra WHERE TipoDuração=@tipoDuração)
	AS TempoExtraDuraçãoCorrecta
	ON PromoçõesDisponivies.NumeroIdentificador = TempoExtraDuraçãoCorrecta.NumeroIdentificadorPromoção)
	
	RETURN @fraçcoesTempoExtra
GO

GO
CREATE PROC Factor_Tipo_Duração
@tipoDuração VARCHAR(2), @factor DECIMAL(10,2) = 00.00 OUTPUT
AS
	SELECT @factor =
	CASE @tipoDuração
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
	SELECT @count = COUNT(*) FROM EquipamentoAlugado WHERE CódigoEquipamento = @codigo AND NumeroSerieAluguer IN
			(SELECT NumeroSerie FROM Aluguer WHERE (Inicio<=@inicioPeriodo AND Fim>=@inicioPeriodo)
			OR (Inicio<=@fimPeriodo AND Fim>=@fimPeriodo))
	RETURN @count;
GO

GO
CREATE PROC Equipamento_Alugado_Preço
@codigo INT, @tipoDuração VARCHAR(2), @inicio DATETIME, @fim DATETIME, @preço DECIMAL(10,2) OUTPUT
AS
	SELECT @preço = Valor FROM dbo.Preço WHERE Inicio<=@inicio AND Fim>=@inicio AND TipoDuração = @tipoDuração AND 
		CódigoEquipamento = @codigo;

	IF(@preço IS NULL)
		RETURN -1;
	
	DECLARE @blocoTemporal DECIMAL(10,2), @factor DECIMAL(10,2);

	EXEC Factor_Tipo_Duração @tipoDuração, @factor OUTPUT;
	SELECT @blocoTemporal = CEILING(DATEDIFF(MI,@inicio,@fim) / @factor)
	SET @preço = (@preço*@blocoTemporal);
	
GO
CREATE PROC Equipamento_Alugado_Desconto
@codigo INT, @inicio DATETIME, @decontoTotal DECIMAL(10,2) OUTPUT
AS
	SELECT @decontoTotal = COALESCE(SUM(Valor),0) FROM dbo.Desconto WHERE 
	NumeroIdentificadorPromoção IN
		(SELECT PromoçãoNoPeriodo.NumeroIdentificador FROM (
			(SELECT NumeroIdentificador FROM dbo.Promoção WHERE Inicio<=@inicio AND Fim>=@inicio) 
		AS PromoçãoNoPeriodo
		INNER JOIN
			(SELECT NumeroIdentificadorDesconto FROM dbo.Tipo_Desconto WHERE NomeTipo = (SELECT NomeTipo FROM Equipamento WHERE Código = @codigo))
		AS Tipo_DescontoDoTipo
		ON PromoçãoNoPeriodo.NumeroIdentificador = Tipo_DescontoDoTipo.NumeroIdentificadorDesconto))
	
	RETURN 0;
GO

GO
CREATE PROC Calcular_Preço_De_Aluguer
@códigoEquipamento INT, @tipoDuração VARCHAR(2), @inicio DATETIME, @fim DATETIME, @preço DECIMAL(10,2) OUTPUT, @desconto DECIMAL(10,2) OUTPUT, @preçoAluguer DECIMAL(10,2) OUTPUT
AS
	DECLARE @ret INT;
	EXEC @ret = Equipamento_Alugado_Preço @códigoEquipamento, @tipoDuração, @inicio, @fim, @preço OUTPUT;
	IF(@ret=-1)
		RETURN -1;
	EXEC Equipamento_Alugado_Desconto @códigoEquipamento, @inicio, @desconto OUTPUT;
	SET @preçoAluguer = @preço - (@preço*@desconto);
GO