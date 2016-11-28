USE Base_Dados_SI2_1617SI_23

BEGIN TRAN
	SET NOCOUNT ON;
	DECLARE @promoção INT, @promoção2 INT;
	
	--Introdução do Tipo necessario para a Promoção--
	INSERT INTO Tipo(Nome, Descrição) VALUES ('Canoa', 'canoa simples');
	INSERT INTO Tipo(Nome, Descrição) VALUES ('Remos', 'remos simples');
	--Introdução do Tipo necessario para a Promoção--

	--Introdução da Promoção para o Desconto--
	INSERT INTO dbo.Promoção (Descrição, Inicio, Fim) VALUES ('Desconto Teste', '2016-04-01 00:00:00', '2016-07-31 00:00:00');
	SET @promoção = @@IDENTITY;
	--Introdução da Promoção para o Desconto--

	--Torna-se a Promoção num Desconto--
	INSERT INTO dbo.Desconto(NumeroIdentificadorPromoção,Valor) VALUES (@promoção, 0.32);
	EXEC @promoção2 = Inserir_Desconto 'Segundo Desconto Teste','2016-04-01 00:00:00', '2016-07-31 00:00:00',0.22;
	--Torna-se a Promoção num Desconto--

	--Erro 1, a Promoção já é um Desconto--
	PRINT('--Erro 1, a Promoção já é um Desconto--');
	INSERT INTO dbo.TempoExtra (NumeroIdentificadorPromoção, FracçãoExtra, TipoDuração) VALUES (@promoção,3,'h');
	PRINT('--Erro 1, a Promoção já é um Desconto--');
	--Erro 1, a Promoção já é um Desconto--

	SELECT * FROM TempoExtra WHERE NumeroIdentificadorPromoção = @promoção;
	SELECT * FROM Desconto WHERE NumeroIdentificadorPromoção = @promoção OR NumeroIdentificadorPromoção = @promoção2;
	
	--Da os Tipos de Equipamentos que o Desconto afecta--
	INSERT INTO dbo.Tipo_Desconto(NumeroIdentificadorDesconto,NomeTipo) VALUES(@promoção,'Canoa')
	INSERT INTO dbo.Tipo_Desconto(NumeroIdentificadorDesconto,NomeTipo) VALUES(@promoção,'Remos')
	--Da os Tipos de Equipamentos que o Desconto afecta--

	--Erro 2, não existe o Tipo desejado--
	PRINT('Erro 2, não existe o Tipo desejado')
	INSERT INTO dbo.Tipo_Desconto(NumeroIdentificadorDesconto,NomeTipo) VALUES(@promoção,'Canoa Grande')
	PRINT('Erro 2, não existe o Tipo desejado')
	--Erro 2, não existe o Tipo desejado--

	SELECT * FROM Tipo_Desconto WHERE NumeroIdentificadorDesconto = @promoção;
	
	--Atera o Inicio da Promoção--	
	UPDATE dbo.Promoção
	SET Inicio = '2016-05-30 00:00:00'
	WHERE NumeroIdentificador = @promoção
	SELECT * FROM Promoção WHERE NumeroIdentificador = @promoção;
	--Atera o Inicio da Promoção--	

	--Altera o Valor do Desconto--
	UPDATE dbo.Desconto
	SET Valor = 0.22
	WHERE NumeroIdentificadorPromoção = @promoção
	SELECT * FROM Desconto WHERE NumeroIdentificadorPromoção = @promoção;
	--Altera o Valor do Desconto--

	SELECT * FROM Promoção WHERE NumeroIdentificador = @promoção;
	SELECT * FROM Desconto WHERE NumeroIdentificadorPromoção = @promoção;
	
	--Remove a Promoção, o que também remove o Desconto, o que em si remove os Tipo_Descontos associados ao Desconto-- 
	DELETE FROM dbo.Promoção WHERE NumeroIdentificador = @promoção;
	--Remove a Promoção, o que também remove o Desconto, o que em si remove os Tipo_Descontos associados ao Desconto-- 

	SELECT * FROM Promoção WHERE NumeroIdentificador = @promoção;
	SELECT * FROM Desconto WHERE NumeroIdentificadorPromoção = @promoção;
	SELECT * FROM Tipo_Desconto WHERE NumeroIdentificadorDesconto = @promoção;

ROLLBACK TRAN