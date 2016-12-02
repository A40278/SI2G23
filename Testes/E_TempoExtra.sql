USE Base_Dados_SI2_1617SI_23

BEGIN TRAN
	SET NOCOUNT ON;

	DECLARE @promoção INT, @promoção2 INT;
	DECLARE @now DATETIME;
	SET @now = GETDATE();

	--Introdução da Promoção para o TempoExtra--
	INSERT INTO dbo.Promoção (Descrição, Inicio, Fim)  VALUES ('Desconto Teste', @now, DATEADD(d,5,@now));
	SET @promoção = @@IDENTITY;
	--Introdução da Promoção para o TempoExtra--
	
	SELECT * FROM Promoção WHERE NumeroIdentificador = @promoção;

	--Torna a Promoção no tipo TempoExtra--
	INSERT INTO dbo.TempoExtra (NumeroIdentificadorPromoção, FracçãoExtra, TipoDuração) VALUES (@promoção,3,'h');
	DECLARE @inicio DATETIME = DATEADD(d,-3,@now), @fim DATETIME = DATEADD(d,3,@now);
	EXEC @promoção2 = Inserir_TempoExtra 'Segundo Tempo Extra Teste',@inicio , @fim, 5, 'mh'
	--Torna a Promoção no tipo TempoExtra--

	--Erro 1, a Promoção já é um TempoExtra--
	PRINT('Erro 1, a Promoção já é um TempoExtra');
	INSERT INTO dbo.Desconto(NumeroIdentificadorPromoção,Valor) VALUES (@promoção,0.55);
	PRINT('Erro 1, a Promoção já é um TempoExtra');
	--Erro 1, a Promoção já é um TempoExtra--

	SELECT * FROM Promoção WHERE NumeroIdentificador = @promoção OR  NumeroIdentificador = @promoção2;
	SELECT * FROM Desconto WHERE NumeroIdentificadorPromoção = @promoção;
	SELECT * FROM TempoExtra WHERE NumeroIdentificadorPromoção = @promoção OR NumeroIdentificadorPromoção = @promoção2;

	--Atera o Inicio da Promoção--	
	UPDATE dbo.Promoção
	SET Inicio = DATEADD(d,-3,@now)
	WHERE NumeroIdentificador = @promoção
	SELECT * FROM Promoção WHERE NumeroIdentificador = @promoção;
	--Atera o Inicio da Promoção--	

	--Atera o TipoDuração do TempoExtra--	
	UPDATE dbo.TempoExtra
	SET FracçãoExtra = 5, TipoDuração = 'mh'
	WHERE NumeroIdentificadorPromoção = @promoção;
	--Atera o TipoDuração do TempoExtra--	

	SELECT * FROM Promoção WHERE NumeroIdentificador = @promoção;
	SELECT * FROM dbo.TempoExtra WHERE NumeroIdentificadorPromoção = @promoção;

	--Remove a Promoção, o que também remove o TempoExtra-- 
	DELETE FROM dbo.Promoção WHERE NumeroIdentificador = @promoção;
	--Remove a Promoção, o que também remove o TempoExtra-- 

	SELECT * FROM Promoção WHERE NumeroIdentificador = @promoção;
	SELECT * FROM dbo.TempoExtra WHERE NumeroIdentificadorPromoção = @promoção;
ROLLBACK TRAN
