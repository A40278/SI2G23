USE Base_Dados_SI2_1617SI_23

BEGIN TRAN
	SET NOCOUNT ON;

	DECLARE @promoção INT, @promoção2 INT;

	--Introdução da Promoção para o TempoExtra--
	INSERT INTO dbo.Promoção (Descrição, Inicio, Fim) VALUES ('Tempo Extra Teste', '2016-04-01 00:00:00', '2016-07-31 00:00:00');
	SET @promoção = @@IDENTITY;
	--Introdução da Promoção para o TempoExtra--
	
	SELECT * FROM Promoção WHERE NumeroIdentificador = @promoção;

	--Torna a Promoção no tipo TempoExtra--
	INSERT INTO dbo.TempoExtra (NumeroIdentificadorPromoção, FracçãoExtra, TipoDuração) VALUES (@promoção,3,'h');
	EXEC @promoção2 = Inserir_TempoExtra 'Segundo Tempo Extra Teste', '2016-04-01 00:00:00', '2016-07-31 00:00:00', 5, 'mh'
	--Torna a Promoção no tipo TempoExtra--

	--Erro 1, a Promoção já é um TempoExtra--
	PRINT('Erro 1, a Promoção já é um TempoExtra');
	INSERT INTO dbo.Desconto(NumeroIdentificadorPromoção,Valor) VALUES (@promoção,0.55);
	PRINT('Erro 1, a Promoção já é um TempoExtra');
	--Erro 1, a Promoção já é um TempoExtra--

	SELECT * FROM Desconto WHERE NumeroIdentificadorPromoção = @promoção;
	SELECT * FROM TempoExtra WHERE NumeroIdentificadorPromoção = @promoção OR NumeroIdentificadorPromoção = @promoção2;

	--Atera o Inicio da Promoção--	
	UPDATE dbo.Promoção
	SET Inicio = '2016-05-30 00:00:00'
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

	/*
	--Introdução a promoção para o TempoExtra, para demonstrar Erro 2--
	INSERT INTO dbo.Promoção (Descrição, Inicio, Fim) VALUES ('Tempo Extra Teste', '2016-04-01 00:00:00', '2016-07-31 00:00:00');
	SET @id = @@IDENTITY;
	--Introdução a promoção para o TempoExtra, para demonstrar Erro 2--

	--Erro 2, não existe o TipoDuração 'y'--
	PRINT('Erro 2, não existe o TipoDuração ''y''');
	INSERT INTO dbo.TempoExtra (NumeroIdentificadorPromoção, FracçãoExtra, TipoDuração) VALUES (@id,3,'y');
	PRINT('Erro 2, não existe o TipoDuração ''y''');
	--Erro 2, não existe o TipoDuração 'y'--
	*/

ROLLBACK TRAN
