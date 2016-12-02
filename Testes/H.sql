USE Base_Dados_SI2_1617SI_23;

BEGIN TRAN
	SET NOCOUNT ON;
	DECLARE @cliente INT, @empregado INT, @canoa INT, @gaivota INT, @mota INT, @aluguer INT, @aluguer2 INT;
	DECLARE @now DATETIME;
	SET @now = GETDATE();

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
	INSERT INTO dbo.Pre�o (C�digoEquipamento, Inicio, Fim, TipoDura��o, Valor) VALUES(@gaivota,  DATEADD(d,-6,@now),  DATEADD(d,8,@now),
	'h',10.15)
	--Introduze-se o Pre�o dos Equipamentos para os Alugueres--

	--Introduze-se os Alugueres--
	INSERT INTO dbo.Aluguer(TipoDura��o, Inicio, Fim, C�digoCliente, NumeroEmpregado) VALUES ('h', DATEADD(hh,-1,@now), DATEADD(hh,7,@now),
	@cliente, @empregado)

	INSERT INTO dbo.Aluguer(TipoDura��o, Inicio, Fim, C�digoCliente, NumeroEmpregado) VALUES ('h', DATEADD(hh,-5,@now), DATEADD(hh,-2,@now),
	@cliente, @empregado)

	SET @aluguer2 = @@IDENTITY
	SET @aluguer = @aluguer2-1;
	--Introduze-se os Alugueres--

	--Aluga-se os Equipamentos--
	INSERT INTO dbo.EquipamentoAlugado(NumeroSerieAluguer,C�digoEquipamento) VALUES (@aluguer,@gaivota)
	--Aluga-se os Equipamentos--

	SELECT * FROM EquipamentoAlugado WHERE NumeroSerieAluguer = @aluguer OR NumeroSerieAluguer = @aluguer2

	SELECT * FROM Aluguer WHERE NumeroSerie = @aluguer OR  NumeroSerie = @aluguer2

	--� possivel remover este Aluguer--
	DELETE  FROM Aluguer WHERE NumeroSerie = @aluguer
	--� possivel remover este Aluguer--

	--Erro 1, n�o � possivel remover este Aluguer, sendo que j� acabou--
	PRINT('Erro 1, n�o � possivel remover este Aluguer, sendo que j� acabou');
	DELETE  FROM Aluguer WHERE NumeroSerie = @aluguer2;
	PRINT('Erro 1, n�o � possivel remover este Aluguer, sendo que j� acabou');
	--Erro 1, n�o � possivel remover este Aluguer, sendo que j� acabou--

	SELECT * FROM EquipamentoAlugado WHERE NumeroSerieAluguer = @aluguer OR NumeroSerieAluguer = @aluguer2

	SELECT * FROM Aluguer WHERE NumeroSerie = @aluguer OR  NumeroSerie = @aluguer2

	SELECT * FROM Equipamento WHERE C�digo = @canoa OR C�digo = @gaivota;

	SELECT * FROM Empregado WHERE Numero = @empregado;

	SELECT * FROM Cliente WHERE C�digo = @cliente;

ROLLBACK TRAN