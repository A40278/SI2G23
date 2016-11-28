USE Base_Dados_SI2_1617SI_23

BEGIN TRAN
	SET NOCOUNT ON;
	DECLARE @promo��o INT, @promo��o2 INT;
	
	--Introdu��o do Tipo necessario para a Promo��o--
	INSERT INTO Tipo(Nome, Descri��o) VALUES ('Canoa', 'canoa simples');
	INSERT INTO Tipo(Nome, Descri��o) VALUES ('Remos', 'remos simples');
	--Introdu��o do Tipo necessario para a Promo��o--

	--Introdu��o da Promo��o para o Desconto--
	INSERT INTO dbo.Promo��o (Descri��o, Inicio, Fim) VALUES ('Desconto Teste', '2016-04-01 00:00:00', '2016-07-31 00:00:00');
	SET @promo��o = @@IDENTITY;
	--Introdu��o da Promo��o para o Desconto--

	--Torna-se a Promo��o num Desconto--
	INSERT INTO dbo.Desconto(NumeroIdentificadorPromo��o,Valor) VALUES (@promo��o, 0.32);
	EXEC @promo��o2 = Inserir_Desconto 'Segundo Desconto Teste','2016-04-01 00:00:00', '2016-07-31 00:00:00',0.22;
	--Torna-se a Promo��o num Desconto--

	--Erro 1, a Promo��o j� � um Desconto--
	PRINT('--Erro 1, a Promo��o j� � um Desconto--');
	INSERT INTO dbo.TempoExtra (NumeroIdentificadorPromo��o, Frac��oExtra, TipoDura��o) VALUES (@promo��o,3,'h');
	PRINT('--Erro 1, a Promo��o j� � um Desconto--');
	--Erro 1, a Promo��o j� � um Desconto--

	SELECT * FROM TempoExtra WHERE NumeroIdentificadorPromo��o = @promo��o;
	SELECT * FROM Desconto WHERE NumeroIdentificadorPromo��o = @promo��o OR NumeroIdentificadorPromo��o = @promo��o2;
	
	--Da os Tipos de Equipamentos que o Desconto afecta--
	INSERT INTO dbo.Tipo_Desconto(NumeroIdentificadorDesconto,NomeTipo) VALUES(@promo��o,'Canoa')
	INSERT INTO dbo.Tipo_Desconto(NumeroIdentificadorDesconto,NomeTipo) VALUES(@promo��o,'Remos')
	--Da os Tipos de Equipamentos que o Desconto afecta--

	--Erro 2, n�o existe o Tipo desejado--
	PRINT('Erro 2, n�o existe o Tipo desejado')
	INSERT INTO dbo.Tipo_Desconto(NumeroIdentificadorDesconto,NomeTipo) VALUES(@promo��o,'Canoa Grande')
	PRINT('Erro 2, n�o existe o Tipo desejado')
	--Erro 2, n�o existe o Tipo desejado--

	SELECT * FROM Tipo_Desconto WHERE NumeroIdentificadorDesconto = @promo��o;
	
	--Atera o Inicio da Promo��o--	
	UPDATE dbo.Promo��o
	SET Inicio = '2016-05-30 00:00:00'
	WHERE NumeroIdentificador = @promo��o
	SELECT * FROM Promo��o WHERE NumeroIdentificador = @promo��o;
	--Atera o Inicio da Promo��o--	

	--Altera o Valor do Desconto--
	UPDATE dbo.Desconto
	SET Valor = 0.22
	WHERE NumeroIdentificadorPromo��o = @promo��o
	SELECT * FROM Desconto WHERE NumeroIdentificadorPromo��o = @promo��o;
	--Altera o Valor do Desconto--

	SELECT * FROM Promo��o WHERE NumeroIdentificador = @promo��o;
	SELECT * FROM Desconto WHERE NumeroIdentificadorPromo��o = @promo��o;
	
	--Remove a Promo��o, o que tamb�m remove o Desconto, o que em si remove os Tipo_Descontos associados ao Desconto-- 
	DELETE FROM dbo.Promo��o WHERE NumeroIdentificador = @promo��o;
	--Remove a Promo��o, o que tamb�m remove o Desconto, o que em si remove os Tipo_Descontos associados ao Desconto-- 

	SELECT * FROM Promo��o WHERE NumeroIdentificador = @promo��o;
	SELECT * FROM Desconto WHERE NumeroIdentificadorPromo��o = @promo��o;
	SELECT * FROM Tipo_Desconto WHERE NumeroIdentificadorDesconto = @promo��o;

ROLLBACK TRAN