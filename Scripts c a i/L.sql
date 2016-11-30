USE Base_Dados_SI2_1617SI_23;

BEGIN TRAN
	SET NOCOUNT ON;
	DECLARE @cliente INT, @empregado INT, @canoa INT, @gaivota INT, @mota INT, @aluguer INT, @aluguer1 INT, @aluguer2 INT, @aluguer3 INT;
	DECLARE @now DATETIME, @promo��o INT, @inicio DATETIME, @fim DATETIME, @tempoExtra INT = 2;
	SET @now = GETDATE();
	SET @inicio = DATEADD(d,-6,@now)
	SET @fim = DATEADD(d,8,@now)


	EXEC @promo��o = Inserir_TempoExtra 'Segundo Tempo Extra Teste', @inicio, @fim, @tempoExtra, 'h'

	--Introduze-se os Tipos dos Equipamentos que iram ser alugados nos Alugueres--
	INSERT INTO dbo.Tipo(Nome, Descri��o) VALUES('Gaivota','Gaivota simples')
	--Introduze-se os Tipos dos Equipamentos que iram ser alugados nos Alugueres--

	--Introduze-se o Cliente para os Alugueres--
	INSERT INTO dbo.Cliente(Nome, NumeroFiscal, Morada) VALUES ('Laura Vicentes', 996585201, 'Rua Cauda-de-Boi 33');
	SET @cliente = @@IDENTITY
	--Introduze-se o Cliente para os Alugueres--

	--Introduze-se o Empregado para os Alugueres--
	INSERT INTO dbo.Empregado(Nome) VALUES ('Pedro Tomas');
	SET @empregado = @@IDENTITY
	--Introduze-se o Empregado para os Alugueres--

	--Introduze-se os Equipamentos para os Alugueres--
	INSERT INTO dbo.Equipamento(Descri��o, NomeTipo) VALUES ('uma gaivota amarela','Gaivota')
	SET @gaivota = @@IDENTITY
	--Introduze-se os Equipamentos para os Alugueres--

	--Introduze-se o Pre�o dos Equipamentos para os Alugueres--
	INSERT INTO dbo.Pre�o (C�digoEquipamento, Inicio, Fim, TipoDura��o, Valor) VALUES(@gaivota, @inicio,  @fim,
	'h',10.15)
	INSERT INTO dbo.Pre�o (C�digoEquipamento, Inicio, Fim, TipoDura��o, Valor) VALUES(@gaivota, @inicio,  @fim,
	'mh',5.00)
	--Introduze-se o Pre�o dos Equipamentos para os Alugueres--

	--Introduze-se os Alugueres--
	INSERT INTO dbo.Aluguer(TipoDura��o, Inicio, Fim, C�digoCliente, NumeroEmpregado) VALUES ('h', DATEADD(hh,1,@now), DATEADD(hh,3,@now),
	@cliente, @empregado)

	INSERT INTO dbo.Aluguer(TipoDura��o, Inicio, Fim, C�digoCliente, NumeroEmpregado) VALUES ('h', DATEADD(hh,3+@tempoExtra,@now), DATEADD(hh,7,@now),
	@cliente, @empregado)

	INSERT INTO dbo.Aluguer(TipoDura��o, Inicio, Fim, C�digoCliente, NumeroEmpregado) VALUES ('h', DATEADD(hh,9+@tempoExtra,@now), DATEADD(hh,18,@now),
	@cliente, @empregado)

	SET @aluguer2 = @@IDENTITY
	SET @aluguer1 = @aluguer2-1;
	SET @aluguer = @aluguer1-1;
	--Introduze-se os Alugueres--

	--Aluga-se os Equipamentos--
	INSERT INTO dbo.EquipamentoAlugado(NumeroSerieAluguer,C�digoEquipamento) VALUES (@aluguer,@gaivota)
	INSERT INTO dbo.EquipamentoAlugado(NumeroSerieAluguer,C�digoEquipamento) VALUES (@aluguer1,@gaivota)
	INSERT INTO dbo.EquipamentoAlugado(NumeroSerieAluguer,C�digoEquipamento) VALUES (@aluguer2,@gaivota)
	--Aluga-se os Equipamentos--

	
	SELECT * FROM Aluguer

	--Erro 1, n�o pode ser alterado FimComExtra--
	PRINT('Erro 1, n�o pode ser alterado FimComExtra');
	UPDATE Aluguer SET FimComExtra = DATEADD(hh,20,@now) WHERE NumeroSerie = @aluguer2;
	PRINT('Erro 1, n�o pode ser alterado FimComExtra');
	--Erro 1, n�o pode ser alterado FimComExtras--

	--Erro 2, n�o pode ser alterado Pre�o--
	PRINT('Erro 2, n�o pode ser alterado Pre�o');
	UPDATE Aluguer SET Pre�o = 20.96 WHERE NumeroSerie = @aluguer1;
	PRINT('Erro 2, n�o pode ser alterado Pre�o');
	--Erro 2, n�o pode ser alterado Pre�o--

	--Erro 3, n�o pode ser alterado Pre�o e FimComExtra--
	PRINT('Erro 3, n�o pode ser alterado Pre�o e FimComExtra');
	UPDATE Aluguer SET Pre�o = 20.96, FimComExtra = DATEADD(hh,20,@now) WHERE NumeroSerie = @aluguer;
	PRINT('Erro 3, n�o pode ser alterado Pre�o e FimComExtra');
	--Erro 3, n�o pode ser alterado Pre�o e FimComExtra--

	--Erro 4, o Alguer passa para o periodo do primeiro Aluguer que j� ocupa o Equipamento--
	PRINT('Erro 4, o Alguer passa para o periodo do primeiro Aluguer que j� ocupa o Equipamento');
	UPDATE Aluguer SET Inicio = DATEADD(hh,2,@now)  WHERE NumeroSerie = @aluguer1;
	PRINT('Erro 4, o Alguer passa para o periodo do primeiro Aluguer que j� ocupa o Equipamento');
	--Erro 4, o Alguer passa para o periodo do primeiro Aluguer que j� ocupa o Equipamento--

	--Erro 5, o Alguer passa para o periodo do terceiro Aluguer que j� ocupa o Equipamento--
	PRINT('Erro 5, o Alguer passa para o periodo do terceiro Aluguer que j� ocupa o Equipamento');
	UPDATE Aluguer SET Fim = DATEADD(hh,10,@now) WHERE NumeroSerie = @aluguer1;
	PRINT('Erro 5, o Alguer passa para o periodo do terceiro Aluguer que j� ocupa o Equipamento');
	--Erro 5, o Alguer passa para o periodo do terceiro Aluguer que j� ocupa o Equipamento--

	--Erro 6, n�o existe Pre�o para o Equipamento TipoDura��o d--
	PRINT('Erro 6, n�o existe Pre�o para o Equipamento TipoDura��o d');
	UPDATE Aluguer SET TipoDura��o = 'd' WHERE NumeroSerie = @aluguer2;
	PRINT('Erro 6, n�o existe Pre�o para o Equipamento TipoDura��o d');
	--Erro 6, n�o existe Pre�o para o Equipamento TipoDura��o d--

	--Erro 7, n�o existe Pre�o para o Equipamento no novo periodo--
	PRINT('Erro 7, n�o existe Pre�o para o Equipamento no novo periodo');
	UPDATE Aluguer SET Inicio = DATEADD(d,9,@now), Fim = DATEADD(d,10,@now) WHERE NumeroSerie = @aluguer2;
	PRINT('Erro 7, n�o existe Pre�o para o Equipamento no novo periodo');
	--Erro 7, n�o existe Pre�o para o Equipamento no novo periodo--

	--Altera-se o TipoDura��o para mh--
	--Novo pre�o = 5.00 * ((7 Horas * 2) = 14 mh) = 70 
	UPDATE Aluguer SET TipoDura��o = 'mh' WHERE NumeroSerie = @aluguer2;
	--Altera-se o TipoDura��o para mh--

	--Altera-se o Fim por mais 2 horas--
	--Novo Pre�o 20.30 + ((2*10.15) = 20.30) = 40.60
	UPDATE Aluguer SET Fim = DATEADD(hh,9,@now) WHERE NumeroSerie = @aluguer1;
	--Altera-se o Fim por mais 2 horas--

	--Introduze-se Aluguere ultrapassado--
	--conta-se com o TempoExtra--
	INSERT INTO dbo.Aluguer(TipoDura��o, Inicio, Fim, C�digoCliente, NumeroEmpregado) VALUES ('h', DATEADD(hh,-5,@now), DATEADD(hh,-3,@now),
	@cliente, @empregado)
	SET @aluguer3 = @@IDENTITY
	--Introduze-se Aluguere ultrapassado--

	--Erro 8, n�o se pode adicionar Equipamentos a Alugueres finalizados--
	PRINT('Erro 8, n�o se pode adicionar Equipamentos a Alugueres finalizados')
	INSERT INTO dbo.EquipamentoAlugado(NumeroSerieAluguer,C�digoEquipamento) VALUES (@aluguer3,@gaivota)
	PRINT('Erro 8, n�o se pode adicionar Equipamentos a Alugueres finalizados')
	--Erro 8, n�o se pode adicionar Equipamentos a Alugueres finalizados--

	--Erro 9, n�o se pode alterar a Alugueres finalizados--
	PRINT('Erro 9, n�o se pode alterar a Alugueres finalizados')
	UPDATE Aluguer SET TipoDura��o = 'mh' WHERE NumeroSerie = @aluguer3;
	PRINT('Erro 9, n�o se pode alterar a Alugueres finalizados')
	--Erro 9, n�o se pode alterar a Alugueres finalizados--

	SELECT * FROM Aluguer

	SELECT * FROM EquipamentoAlugado
ROLLBACK TRAN