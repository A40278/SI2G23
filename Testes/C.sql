USE Base_Dados_SI2_1617SI_23

BEGIN TRAN
	SET NOCOUNT ON;
	DECLARE @cliente1 INT, @cliente2 INT, @cliente3 INT, @cliente4 INT;

	--Introdu��o de um Cliente correcto--
	INSERT INTO dbo.Cliente(Nome, NumeroFiscal, Morada) VALUES ('Jo�o Lopes', 552334475, 'Rua Sol Amarelo 57');
	--Introdu��o de um Cliente correcto--

	--Introdu��o de um Cliente correcto, com um valor NULL--
	INSERT INTO dbo.Cliente(Nome, NumeroFiscal, Morada) VALUES (Null, 012223354, 'Rua Pilar Compaso 57');
	--Introdu��o de um Cliente correcto, com um valor NULL--

	--Introdu��o de um Cliente correcto, com dois valores NULL--
	INSERT INTO dbo.Cliente(Nome, NumeroFiscal, Morada) VALUES ('Rute Hollen', NULL, NULL);
	--Introdu��o de um Cliente correcto, com dois valores NULL--

	--Introdu��o de um Cliente correcto, com todo NULL--
	INSERT INTO dbo.Cliente(Nome, NumeroFiscal, Morada) VALUES (Null, NULL, NULL);
	--Introdu��o de um Cliente correcto, com todo NULL--

	SET @cliente4 = @@IDENTITY;
	SET @cliente3 = @cliente4 -1;
	SET @cliente2 = @cliente3 -1;
	SET @cliente1 = @cliente2 -1;

	--Erro 1, o NumeroFiscal fornecido � repetido--
	PRINT('Erro 1, o NumeroFiscal fornecido � repetido');
	INSERT INTO dbo.Cliente(Nome, NumeroFiscal, Morada) VALUES (Null, 012223354, NULL);
	PRINT('Erro 1, o NumeroFiscal fornecido � repetido');
	--Erro 1, o NumeroFiscal fornecido � repetido--

	--Erro 2, o NumeroFiscal fornecido � negativo--
	PRINT('Erro 2, o NumeroFiscal fornecido � negativo');
	INSERT INTO dbo.Cliente(Nome, NumeroFiscal, Morada) VALUES (Null, -1, NULL);
	PRINT('Erro 2, o NumeroFiscal fornecido � negativo');
	--Erro 2, o NumeroFiscal fornecido � negativo--
	
	SELECT * FROM Cliente WHERE C�digo = @cliente1 OR C�digo = @cliente2 OR C�digo = @cliente3 OR C�digo = @cliente4;
	
	--Alterar o NumeroFiscal do segundo Cliente--
	UPDATE dbo.Cliente SET NumeroFiscal = 77700020 WHERE C�digo = @cliente2;
	--Alterar o NumeroFiscal do segundo Cliente--

	--Alterar o Nome do terceiro Cliente--
	UPDATE dbo.Cliente  SET Nome = 'Luisa Tavares' WHERE C�digo = @cliente3;
	--Alterar o Nome do terceiro Cliente--

	--Alterar o Nome do primeiro Cliente para NULL--
	UPDATE dbo.Cliente  SET Nome = NULL, NumeroFiscal = NULL, Morada = NULL WHERE C�digo = @cliente1
	--Alterar o Nome do primeiro Cliente para NULL--

	SELECT * FROM Cliente WHERE C�digo = @cliente1 OR C�digo = @cliente2 OR C�digo = @cliente3;

	--Remover os Clientes--
	DELETE FROM dbo.Cliente WHERE C�digo = @cliente1
	DELETE FROM dbo.Cliente WHERE C�digo = @cliente2
	--Remover os Clientes--
	
	SELECT * FROM Cliente WHERE C�digo = @cliente1 OR C�digo = @cliente2;
ROLLBACK TRAN