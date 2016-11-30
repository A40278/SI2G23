USE Base_Dados_SI2_1617SI_23

BEGIN TRAN
	SET NOCOUNT ON;

	DECLARE @promo��o INT, @promo��o2 INT;
	DECLARE @now DATETIME;
	SET @now = GETDATE();

	--Introdu��o da Promo��o para o TempoExtra--
	INSERT INTO dbo.Promo��o (Descri��o, Inicio, Fim)  VALUES ('Desconto Teste', @now, DATEADD(d,5,@now));
	SET @promo��o = @@IDENTITY;
	--Introdu��o da Promo��o para o TempoExtra--
	
	SELECT * FROM Promo��o WHERE NumeroIdentificador = @promo��o;

	--Torna a Promo��o no tipo TempoExtra--
	INSERT INTO dbo.TempoExtra (NumeroIdentificadorPromo��o, Frac��oExtra, TipoDura��o) VALUES (@promo��o,3,'h');
	DECLARE @inicio DATETIME = DATEADD(d,-3,@now), @fim DATETIME = DATEADD(d,3,@now);
	EXEC @promo��o2 = Inserir_TempoExtra 'Segundo Tempo Extra Teste',@inicio , @fim, 5, 'mh'
	--Torna a Promo��o no tipo TempoExtra--

	--Erro 1, a Promo��o j� � um TempoExtra--
	PRINT('Erro 1, a Promo��o j� � um TempoExtra');
	INSERT INTO dbo.Desconto(NumeroIdentificadorPromo��o,Valor) VALUES (@promo��o,0.55);
	PRINT('Erro 1, a Promo��o j� � um TempoExtra');
	--Erro 1, a Promo��o j� � um TempoExtra--

	SELECT * FROM Promo��o WHERE NumeroIdentificador = @promo��o OR  NumeroIdentificador = @promo��o2;
	SELECT * FROM Desconto WHERE NumeroIdentificadorPromo��o = @promo��o;
	SELECT * FROM TempoExtra WHERE NumeroIdentificadorPromo��o = @promo��o OR NumeroIdentificadorPromo��o = @promo��o2;

	--Atera o Inicio da Promo��o--	
	UPDATE dbo.Promo��o
	SET Inicio = DATEADD(d,-3,@now)
	WHERE NumeroIdentificador = @promo��o
	SELECT * FROM Promo��o WHERE NumeroIdentificador = @promo��o;
	--Atera o Inicio da Promo��o--	

	--Atera o TipoDura��o do TempoExtra--	
	UPDATE dbo.TempoExtra
	SET Frac��oExtra = 5, TipoDura��o = 'mh'
	WHERE NumeroIdentificadorPromo��o = @promo��o;
	--Atera o TipoDura��o do TempoExtra--	

	SELECT * FROM Promo��o WHERE NumeroIdentificador = @promo��o;
	SELECT * FROM dbo.TempoExtra WHERE NumeroIdentificadorPromo��o = @promo��o;

	--Remove a Promo��o, o que tamb�m remove o TempoExtra-- 
	DELETE FROM dbo.Promo��o WHERE NumeroIdentificador = @promo��o;
	--Remove a Promo��o, o que tamb�m remove o TempoExtra-- 

	SELECT * FROM Promo��o WHERE NumeroIdentificador = @promo��o;
	SELECT * FROM dbo.TempoExtra WHERE NumeroIdentificadorPromo��o = @promo��o;
ROLLBACK TRAN
