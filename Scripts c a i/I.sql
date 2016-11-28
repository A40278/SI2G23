BEGIN TRAN
	SET NOCOUNT ON;

	DECLARE @canoa INT;

	--Introduzir o Tipo para o Equipamento--
	INSERT INTO dbo.Tipo(Nome, Descrição) VALUES('Canoa Grande','canoa grande')
	--Introduzir o Tipo para o Equipamento--

	--Introduzir o Equipamento--
	INSERT INTO dbo.Equipamento(Descrição, NomeTipo) VALUES ('uma canoa Lilaz','Canoa Grande')
	SET @canoa = @@IDENTITY
	--Introduzir o Equipamento--

	--Introduzir os Preços para o Equipamento--
	INSERT INTO dbo.Preço (CódigoEquipamento, Inicio, Fim, TipoDuração, Valor) VALUES(@canoa, '2017-01-01 00:00:00', '2017-08-01 00:00:00',
	'h',10.15)
	INSERT INTO dbo.Preço (CódigoEquipamento, Inicio, Fim, TipoDuração, Valor) VALUES(@canoa, '2017-08-01 00:01:00', '2017-09-30 00:00:00',
	'h',12.20)
	INSERT INTO dbo.Preço (CódigoEquipamento, Inicio, Fim, TipoDuração, Valor) VALUES(@canoa, '2017-09-30 00:01:00', '2017-12-31 23:59:00',
	'h',11.50)
	--Introduzir os Preços para o Equipamento--

	--Erro 1, o Preço a introduzir acaba dentro do primeiro Preço--
	PRINT('Erro 1, o Preço a introduzir acaba dentro do primeiro Preço');
	INSERT INTO dbo.Preço (CódigoEquipamento, Inicio, Fim, TipoDuração, Valor) VALUES(@canoa, '2016-12-01 00:00:00', '2017-01-05 00:00:00',
	'h',12.20);
	PRINT('Erro 1, o Preço a introduzir acaba dentro do primeiro Preço');
	--Erro 1, o Preço a introduzir acaba dentro do primeiro Preço--

	--Erro 2, o Preço a introduzir encontra-se dentro do segundo Preço--
	PRINT('Erro 2, o Preço a introduzir encontra-se dentro do segundo Preço');
	INSERT INTO dbo.Preço (CódigoEquipamento, Inicio, Fim, TipoDuração, Valor) VALUES(@canoa, '2017-09-01 00:01:00', '2017-09-20 00:00:00',
	'h',12.20)
	PRINT('Erro 2, o Preço a introduzir encontra-se dentro do segundo Preço');
	--Erro 2, o Preço a introduzir encontra-se dentro do segundo Preço--

	--Erro 3, o Preço a introduzir começa dentro do terceiro Preço--
	PRINT('Erro 3, o Preço a introduzir começa dentro do terceiro Preço');
	INSERT INTO dbo.Preço (CódigoEquipamento, Inicio, Fim, TipoDuração, Valor) VALUES(@canoa, '2017-12-20 23:59:00', '2018-01-20 00:00:00',
	'h',12.20)
	PRINT('Erro 3, o Preço a introduzir começa dentro do terceiro Preço');
	--Erro 3, o Preço a introduzir começa dentro do terceiro Preço--

	SELECT * FROM dbo.Preço WHERE CódigoEquipamento = @canoa;

	--Alterar TipoDuração e Valor do Preço--
	UPDATE dbo.Preço SET TipoDuração = 'mh', Valor = 20.70
		WHERE CódigoEquipamento = @canoa AND Inicio = '2017-01-01 00:00:00' AND TipoDuração = 'h';
	--Alterar TipoDuração e Valor do Preço--

	--Erro 4, a alteração do Fim do Preço faz que o segundo Preço acabe no terceiro--
	PRINT('Erro 4, a alteração do Fim do Preço faz que o segundo Preço acabe no terceiro');
	UPDATE dbo.Preço SET Fim = '2017-09-30 00:02:00'
		WHERE CódigoEquipamento = @canoa AND Inicio = '2017-08-01 00:01:00' AND TipoDuração = 'h';
	PRINT('Erro 4, a alteração do Fim do Preço faz que o segundo Preço acabe no terceiro');
	--Erro 4, a alteração do Fim do Preço faz que o segundo Preço acabe no terceiro--

	SELECT * FROM dbo.Preço WHERE CódigoEquipamento = @canoa;

ROLLBACK TRAN

/*
	--Acaba no primerio--
	INSERT INTO dbo.Preço (CódigoEquipamento, Inicio, Fim, TipoDuração, Valor) VALUES(@canoa, '2016-12-01 00:00:00', '2017-01-05 00:00:00',
	'h',12.20)
	--Acaba do primerio--

	--Dentro do segundo--
	INSERT INTO dbo.Preço (CódigoEquipamento, Inicio, Fim, TipoDuração, Valor) VALUES(@canoa, '2017-09-01 00:01:00', '2017-09-20 00:00:00',
	'h',12.20)
	--Dentro do segundo--

	--Começa no terceiro--
	INSERT INTO dbo.Preço (CódigoEquipamento, Inicio, Fim, TipoDuração, Valor) VALUES(@canoa, '2017-12-20 23:59:00', '2018-01-20 00:00:00',
	'h',12.20)
	--Começa no terceiro--



	BEGIN TRY
		
	END TRY
	BEGIN CATCH
		EXECUTE usp_GetErrorInfo;  
	END CATCH
*/