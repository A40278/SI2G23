USE Base_Dados_SI2_1617SI_23;

BEGIN TRAN
	SET NOCOUNT ON;
	DECLARE @cliente INT, @empregado INT, @canoa INT, @gaivota INT, @mota INT, @aluguer INT, @aluguer1 INT, @aluguer2 INT, @aluguer3 INT;
	DECLARE @now DATETIME, @promoção INT, @inicio DATETIME, @fim DATETIME, @tempoExtra INT = 2;
	SET @now = GETDATE();
	SET @inicio = DATEADD(d,-6,@now)
	SET @fim = DATEADD(d,8,@now)


	EXEC @promoção = Inserir_TempoExtra 'Segundo Tempo Extra Teste', @inicio, @fim, @tempoExtra, 'h'

	--Introduze-se os Tipos dos Equipamentos que iram ser alugados nos Alugueres--
	INSERT INTO dbo.Tipo(Nome, Descrição) VALUES('Gaivota','Gaivota simples')
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
	INSERT INTO dbo.Equipamento(Descrição, NomeTipo) VALUES ('uma gaivota amarela','Gaivota')
	SET @gaivota = @@IDENTITY
	--Introduze-se os Equipamentos para os Alugueres--

	--Introduze-se o Preço dos Equipamentos para os Alugueres--
	INSERT INTO dbo.Preço (CódigoEquipamento, Inicio, Fim, TipoDuração, Valor) VALUES(@gaivota, @inicio,  @fim,
	'h',10.15)
	INSERT INTO dbo.Preço (CódigoEquipamento, Inicio, Fim, TipoDuração, Valor) VALUES(@gaivota, @inicio,  @fim,
	'mh',5.00)
	--Introduze-se o Preço dos Equipamentos para os Alugueres--

	--Introduze-se os Alugueres--
	INSERT INTO dbo.Aluguer(TipoDuração, Inicio, Fim, CódigoCliente, NumeroEmpregado) VALUES ('h', DATEADD(hh,1,@now), DATEADD(hh,3,@now),
	@cliente, @empregado)

	INSERT INTO dbo.Aluguer(TipoDuração, Inicio, Fim, CódigoCliente, NumeroEmpregado) VALUES ('h', DATEADD(hh,3+@tempoExtra,@now), DATEADD(hh,7,@now),
	@cliente, @empregado)

	INSERT INTO dbo.Aluguer(TipoDuração, Inicio, Fim, CódigoCliente, NumeroEmpregado) VALUES ('h', DATEADD(hh,9+@tempoExtra,@now), DATEADD(hh,18,@now),
	@cliente, @empregado)

	SET @aluguer2 = @@IDENTITY
	SET @aluguer1 = @aluguer2-1;
	SET @aluguer = @aluguer1-1;
	--Introduze-se os Alugueres--

	--Aluga-se os Equipamentos--
	INSERT INTO dbo.EquipamentoAlugado(NumeroSerieAluguer,CódigoEquipamento) VALUES (@aluguer,@gaivota)
	INSERT INTO dbo.EquipamentoAlugado(NumeroSerieAluguer,CódigoEquipamento) VALUES (@aluguer1,@gaivota)
	INSERT INTO dbo.EquipamentoAlugado(NumeroSerieAluguer,CódigoEquipamento) VALUES (@aluguer2,@gaivota)
	--Aluga-se os Equipamentos--

	
	SELECT * FROM Aluguer

	--Erro 1, não pode ser alterado FimComExtra--
	PRINT('Erro 1, não pode ser alterado FimComExtra');
	UPDATE Aluguer SET FimComExtra = DATEADD(hh,20,@now) WHERE NumeroSerie = @aluguer2;
	PRINT('Erro 1, não pode ser alterado FimComExtra');
	--Erro 1, não pode ser alterado FimComExtras--

	--Erro 2, não pode ser alterado Preço--
	PRINT('Erro 2, não pode ser alterado Preço');
	UPDATE Aluguer SET Preço = 20.96 WHERE NumeroSerie = @aluguer1;
	PRINT('Erro 2, não pode ser alterado Preço');
	--Erro 2, não pode ser alterado Preço--

	--Erro 3, não pode ser alterado Preço e FimComExtra--
	PRINT('Erro 3, não pode ser alterado Preço e FimComExtra');
	UPDATE Aluguer SET Preço = 20.96, FimComExtra = DATEADD(hh,20,@now) WHERE NumeroSerie = @aluguer;
	PRINT('Erro 3, não pode ser alterado Preço e FimComExtra');
	--Erro 3, não pode ser alterado Preço e FimComExtra--

	--Erro 4, o Alguer passa para o periodo do primeiro Aluguer que já ocupa o Equipamento--
	PRINT('Erro 4, o Alguer passa para o periodo do primeiro Aluguer que já ocupa o Equipamento');
	UPDATE Aluguer SET Inicio = DATEADD(hh,2,@now)  WHERE NumeroSerie = @aluguer1;
	PRINT('Erro 4, o Alguer passa para o periodo do primeiro Aluguer que já ocupa o Equipamento');
	--Erro 4, o Alguer passa para o periodo do primeiro Aluguer que já ocupa o Equipamento--

	--Erro 5, o Alguer passa para o periodo do terceiro Aluguer que já ocupa o Equipamento--
	PRINT('Erro 5, o Alguer passa para o periodo do terceiro Aluguer que já ocupa o Equipamento');
	UPDATE Aluguer SET Fim = DATEADD(hh,10,@now) WHERE NumeroSerie = @aluguer1;
	PRINT('Erro 5, o Alguer passa para o periodo do terceiro Aluguer que já ocupa o Equipamento');
	--Erro 5, o Alguer passa para o periodo do terceiro Aluguer que já ocupa o Equipamento--

	--Erro 6, não existe Preço para o Equipamento TipoDuração d--
	PRINT('Erro 6, não existe Preço para o Equipamento TipoDuração d');
	UPDATE Aluguer SET TipoDuração = 'd' WHERE NumeroSerie = @aluguer2;
	PRINT('Erro 6, não existe Preço para o Equipamento TipoDuração d');
	--Erro 6, não existe Preço para o Equipamento TipoDuração d--

	--Erro 7, não existe Preço para o Equipamento no novo periodo--
	PRINT('Erro 7, não existe Preço para o Equipamento no novo periodo');
	UPDATE Aluguer SET Inicio = DATEADD(d,9,@now), Fim = DATEADD(d,10,@now) WHERE NumeroSerie = @aluguer2;
	PRINT('Erro 7, não existe Preço para o Equipamento no novo periodo');
	--Erro 7, não existe Preço para o Equipamento no novo periodo--

	--Altera-se o TipoDuração para mh--
	--Novo preço = 5.00 * ((7 Horas * 2) = 14 mh) = 70 
	UPDATE Aluguer SET TipoDuração = 'mh' WHERE NumeroSerie = @aluguer2;
	--Altera-se o TipoDuração para mh--

	--Altera-se o Fim por mais 2 horas--
	--Novo Preço 20.30 + ((2*10.15) = 20.30) = 40.60
	UPDATE Aluguer SET Fim = DATEADD(hh,9,@now) WHERE NumeroSerie = @aluguer1;
	--Altera-se o Fim por mais 2 horas--

	--Introduze-se Aluguere ultrapassado--
	--conta-se com o TempoExtra--
	INSERT INTO dbo.Aluguer(TipoDuração, Inicio, Fim, CódigoCliente, NumeroEmpregado) VALUES ('h', DATEADD(hh,-5,@now), DATEADD(hh,-3,@now),
	@cliente, @empregado)
	SET @aluguer3 = @@IDENTITY
	--Introduze-se Aluguere ultrapassado--

	--Erro 8, não se pode adicionar Equipamentos a Alugueres finalizados--
	PRINT('Erro 8, não se pode adicionar Equipamentos a Alugueres finalizados')
	INSERT INTO dbo.EquipamentoAlugado(NumeroSerieAluguer,CódigoEquipamento) VALUES (@aluguer3,@gaivota)
	PRINT('Erro 8, não se pode adicionar Equipamentos a Alugueres finalizados')
	--Erro 8, não se pode adicionar Equipamentos a Alugueres finalizados--

	--Erro 9, não se pode alterar a Alugueres finalizados--
	PRINT('Erro 9, não se pode alterar a Alugueres finalizados')
	UPDATE Aluguer SET TipoDuração = 'mh' WHERE NumeroSerie = @aluguer3;
	PRINT('Erro 9, não se pode alterar a Alugueres finalizados')
	--Erro 9, não se pode alterar a Alugueres finalizados--

	SELECT * FROM Aluguer

	SELECT * FROM EquipamentoAlugado
ROLLBACK TRAN