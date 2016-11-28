BEGIN TRAN
	SET NOCOUNT ON;

	DECLARE @canoa INT;

	--Introduzir o Tipo para o Equipamento--
	INSERT INTO dbo.Tipo(Nome, Descri��o) VALUES('Canoa Grande','canoa grande')
	--Introduzir o Tipo para o Equipamento--

	--Introduzir o Equipamento--
	INSERT INTO dbo.Equipamento(Descri��o, NomeTipo) VALUES ('uma canoa Lilaz','Canoa Grande')
	SET @canoa = @@IDENTITY
	--Introduzir o Equipamento--

	--Introduzir os Pre�os para o Equipamento--
	INSERT INTO dbo.Pre�o (C�digoEquipamento, Inicio, Fim, TipoDura��o, Valor) VALUES(@canoa, '2017-01-01 00:00:00', '2017-08-01 00:00:00',
	'h',10.15)
	INSERT INTO dbo.Pre�o (C�digoEquipamento, Inicio, Fim, TipoDura��o, Valor) VALUES(@canoa, '2017-08-01 00:01:00', '2017-09-30 00:00:00',
	'h',12.20)
	INSERT INTO dbo.Pre�o (C�digoEquipamento, Inicio, Fim, TipoDura��o, Valor) VALUES(@canoa, '2017-09-30 00:01:00', '2017-12-31 23:59:00',
	'h',11.50)
	--Introduzir os Pre�os para o Equipamento--

	--Erro 1, o Pre�o a introduzir acaba dentro do primeiro Pre�o--
	PRINT('Erro 1, o Pre�o a introduzir acaba dentro do primeiro Pre�o');
	INSERT INTO dbo.Pre�o (C�digoEquipamento, Inicio, Fim, TipoDura��o, Valor) VALUES(@canoa, '2016-12-01 00:00:00', '2017-01-05 00:00:00',
	'h',12.20);
	PRINT('Erro 1, o Pre�o a introduzir acaba dentro do primeiro Pre�o');
	--Erro 1, o Pre�o a introduzir acaba dentro do primeiro Pre�o--

	--Erro 2, o Pre�o a introduzir encontra-se dentro do segundo Pre�o--
	PRINT('Erro 2, o Pre�o a introduzir encontra-se dentro do segundo Pre�o');
	INSERT INTO dbo.Pre�o (C�digoEquipamento, Inicio, Fim, TipoDura��o, Valor) VALUES(@canoa, '2017-09-01 00:01:00', '2017-09-20 00:00:00',
	'h',12.20)
	PRINT('Erro 2, o Pre�o a introduzir encontra-se dentro do segundo Pre�o');
	--Erro 2, o Pre�o a introduzir encontra-se dentro do segundo Pre�o--

	--Erro 3, o Pre�o a introduzir come�a dentro do terceiro Pre�o--
	PRINT('Erro 3, o Pre�o a introduzir come�a dentro do terceiro Pre�o');
	INSERT INTO dbo.Pre�o (C�digoEquipamento, Inicio, Fim, TipoDura��o, Valor) VALUES(@canoa, '2017-12-20 23:59:00', '2018-01-20 00:00:00',
	'h',12.20)
	PRINT('Erro 3, o Pre�o a introduzir come�a dentro do terceiro Pre�o');
	--Erro 3, o Pre�o a introduzir come�a dentro do terceiro Pre�o--

	SELECT * FROM dbo.Pre�o WHERE C�digoEquipamento = @canoa;

	--Alterar TipoDura��o e Valor do Pre�o--
	UPDATE dbo.Pre�o SET TipoDura��o = 'mh', Valor = 20.70
		WHERE C�digoEquipamento = @canoa AND Inicio = '2017-01-01 00:00:00' AND TipoDura��o = 'h';
	--Alterar TipoDura��o e Valor do Pre�o--

	--Erro 4, a altera��o do Fim do Pre�o faz que o segundo Pre�o acabe no terceiro--
	PRINT('Erro 4, a altera��o do Fim do Pre�o faz que o segundo Pre�o acabe no terceiro');
	UPDATE dbo.Pre�o SET Fim = '2017-09-30 00:02:00'
		WHERE C�digoEquipamento = @canoa AND Inicio = '2017-08-01 00:01:00' AND TipoDura��o = 'h';
	PRINT('Erro 4, a altera��o do Fim do Pre�o faz que o segundo Pre�o acabe no terceiro');
	--Erro 4, a altera��o do Fim do Pre�o faz que o segundo Pre�o acabe no terceiro--

	SELECT * FROM dbo.Pre�o WHERE C�digoEquipamento = @canoa;

ROLLBACK TRAN

/*
	--Acaba no primerio--
	INSERT INTO dbo.Pre�o (C�digoEquipamento, Inicio, Fim, TipoDura��o, Valor) VALUES(@canoa, '2016-12-01 00:00:00', '2017-01-05 00:00:00',
	'h',12.20)
	--Acaba do primerio--

	--Dentro do segundo--
	INSERT INTO dbo.Pre�o (C�digoEquipamento, Inicio, Fim, TipoDura��o, Valor) VALUES(@canoa, '2017-09-01 00:01:00', '2017-09-20 00:00:00',
	'h',12.20)
	--Dentro do segundo--

	--Come�a no terceiro--
	INSERT INTO dbo.Pre�o (C�digoEquipamento, Inicio, Fim, TipoDura��o, Valor) VALUES(@canoa, '2017-12-20 23:59:00', '2018-01-20 00:00:00',
	'h',12.20)
	--Come�a no terceiro--



	BEGIN TRY
		
	END TRY
	BEGIN CATCH
		EXECUTE usp_GetErrorInfo;  
	END CATCH
*/