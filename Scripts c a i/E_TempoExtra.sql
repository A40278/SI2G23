USE Base_Dados_SI2_1617SI_23

BEGIN TRAN
	SET NOCOUNT ON;

	DECLARE @promo��o INT, @promo��o2 INT;

	--Introdu��o da Promo��o para o TempoExtra--
	INSERT INTO dbo.Promo��o (Descri��o, Inicio, Fim) VALUES ('Tempo Extra Teste', '2016-04-01 00:00:00', '2016-07-31 00:00:00');
	SET @promo��o = @@IDENTITY;
	--Introdu��o da Promo��o para o TempoExtra--
	
	SELECT * FROM Promo��o WHERE NumeroIdentificador = @promo��o;

	--Torna a Promo��o no tipo TempoExtra--
	INSERT INTO dbo.TempoExtra (NumeroIdentificadorPromo��o, Frac��oExtra, TipoDura��o) VALUES (@promo��o,3,'h');
	EXEC @promo��o2 = Inserir_TempoExtra 'Segundo Tempo Extra Teste', '2016-04-01 00:00:00', '2016-07-31 00:00:00', 5, 'mh'
	--Torna a Promo��o no tipo TempoExtra--

	--Erro 1, a Promo��o j� � um TempoExtra--
	PRINT('Erro 1, a Promo��o j� � um TempoExtra');
	INSERT INTO dbo.Desconto(NumeroIdentificadorPromo��o,Valor) VALUES (@promo��o,0.55);
	PRINT('Erro 1, a Promo��o j� � um TempoExtra');
	--Erro 1, a Promo��o j� � um TempoExtra--

	SELECT * FROM Desconto WHERE NumeroIdentificadorPromo��o = @promo��o;
	SELECT * FROM TempoExtra WHERE NumeroIdentificadorPromo��o = @promo��o OR NumeroIdentificadorPromo��o = @promo��o2;

	--Atera o Inicio da Promo��o--	
	UPDATE dbo.Promo��o
	SET Inicio = '2016-05-30 00:00:00'
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

	/*
	--Introdu��o a promo��o para o TempoExtra, para demonstrar Erro 2--
	INSERT INTO dbo.Promo��o (Descri��o, Inicio, Fim) VALUES ('Tempo Extra Teste', '2016-04-01 00:00:00', '2016-07-31 00:00:00');
	SET @id = @@IDENTITY;
	--Introdu��o a promo��o para o TempoExtra, para demonstrar Erro 2--

	--Erro 2, n�o existe o TipoDura��o 'y'--
	PRINT('Erro 2, n�o existe o TipoDura��o ''y''');
	INSERT INTO dbo.TempoExtra (NumeroIdentificadorPromo��o, Frac��oExtra, TipoDura��o) VALUES (@id,3,'y');
	PRINT('Erro 2, n�o existe o TipoDura��o ''y''');
	--Erro 2, n�o existe o TipoDura��o 'y'--
	*/

ROLLBACK TRAN
