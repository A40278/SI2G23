USE Base_Dados_SI2_1617SI_23

BEGIN TRAN
	SET NOCOUNT ON;
	DECLARE @cliente1 INT, @cliente2 INT, @cliente3 INT, @cliente4 INT;

	--Introdução de um Cliente correcto--
	INSERT INTO dbo.Cliente(Nome, NumeroFiscal, Morada) VALUES ('João Lopes', 552334475, 'Rua Sol Amarelo 57');
	--Introdução de um Cliente correcto--

	--Introdução de um Cliente correcto, com um valor NULL--
	INSERT INTO dbo.Cliente(Nome, NumeroFiscal, Morada) VALUES (Null, 012223354, 'Rua Pilar Compaso 57');
	--Introdução de um Cliente correcto, com um valor NULL--

	--Introdução de um Cliente correcto, com dois valores NULL--
	INSERT INTO dbo.Cliente(Nome, NumeroFiscal, Morada) VALUES ('Rute Hollen', NULL, NULL);
	--Introdução de um Cliente correcto, com dois valores NULL--

	--Introdução de um Cliente correcto, com todo NULL--
	INSERT INTO dbo.Cliente(Nome, NumeroFiscal, Morada) VALUES (Null, NULL, NULL);
	--Introdução de um Cliente correcto, com todo NULL--

	SET @cliente4 = @@IDENTITY;
	SET @cliente3 = @cliente4 -1;
	SET @cliente2 = @cliente3 -1;
	SET @cliente1 = @cliente2 -1;

	--Erro 1, o NumeroFiscal fornecido é repetido--
	PRINT('Erro 1, o NumeroFiscal fornecido é repetido');
	INSERT INTO dbo.Cliente(Nome, NumeroFiscal, Morada) VALUES (Null, 012223354, NULL);
	PRINT('Erro 1, o NumeroFiscal fornecido é repetido');
	--Erro 1, o NumeroFiscal fornecido é repetido--

	--Erro 2, o NumeroFiscal fornecido é negativo--
	PRINT('Erro 2, o NumeroFiscal fornecido é negativo');
	INSERT INTO dbo.Cliente(Nome, NumeroFiscal, Morada) VALUES (Null, -1, NULL);
	PRINT('Erro 2, o NumeroFiscal fornecido é negativo');
	--Erro 2, o NumeroFiscal fornecido é negativo--
	
	SELECT * FROM Cliente WHERE Código = @cliente1 OR Código = @cliente2 OR Código = @cliente3 OR Código = @cliente4;
	
	--Alterar o NumeroFiscal do segundo Cliente--
	UPDATE dbo.Cliente SET NumeroFiscal = 77700020 WHERE Código = @cliente2;
	--Alterar o NumeroFiscal do segundo Cliente--

	--Alterar o Nome do terceiro Cliente--
	UPDATE dbo.Cliente  SET Nome = 'Luisa Tavares' WHERE Código = @cliente3;
	--Alterar o Nome do terceiro Cliente--

	--Alterar o Nome do primeiro Cliente para NULL--
	UPDATE dbo.Cliente  SET Nome = NULL, NumeroFiscal = NULL, Morada = NULL WHERE Código = @cliente1
	--Alterar o Nome do primeiro Cliente para NULL--

	SELECT * FROM Cliente WHERE Código = @cliente1 OR Código = @cliente2 OR Código = @cliente3;

	--Remover os Clientes--
	DELETE FROM dbo.Cliente WHERE Código = @cliente1
	DELETE FROM dbo.Cliente WHERE Código = @cliente2
	--Remover os Clientes--
	
	SELECT * FROM Cliente WHERE Código = @cliente1 OR Código = @cliente2;
ROLLBACK TRAN