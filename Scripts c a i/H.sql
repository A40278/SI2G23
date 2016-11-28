USE Base_Dados_SI2_1617SI_23;

BEGIN TRAN
	SET NOCOUNT ON;
	DECLARE @cliente INT, @empregado INT, @canoa INT, @gaivota INT, @mota INT, @aluguer INT, @aluguer2 INT;
	DECLARE @now DATETIME;
	SET @now = GETDATE();

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
	INSERT INTO dbo.Preço (CódigoEquipamento, Inicio, Fim, TipoDuração, Valor) VALUES(@gaivota,  DATEADD(d,-6,@now),  DATEADD(d,8,@now),
	'h',10.15)
	--Introduze-se o Preço dos Equipamentos para os Alugueres--

	--Introduze-se os Alugueres--
	INSERT INTO dbo.Aluguer(TipoDuração, Inicio, Fim, CódigoCliente, NumeroEmpregado) VALUES ('h', DATEADD(d,5,@now), DATEADD(d,7,@now),
	@cliente, @empregado)

	INSERT INTO dbo.Aluguer(TipoDuração, Inicio, Fim, CódigoCliente, NumeroEmpregado) VALUES ('h', DATEADD(d,-5,@now), DATEADD(d,-1,@now),
	@cliente, @empregado)

	SET @aluguer2 = @@IDENTITY
	SET @aluguer = @aluguer2-1;
	--Introduze-se os Alugueres--

	--Aluga-se os Equipamentos--
	INSERT INTO dbo.EquipamentoAlugado(NumeroSerieAluguer,CódigoEquipamento) VALUES (@aluguer,@gaivota)
	INSERT INTO dbo.EquipamentoAlugado(NumeroSerieAluguer,CódigoEquipamento) VALUES (@aluguer2,@gaivota)
	--Aluga-se os Equipamentos--

	SELECT * FROM EquipamentoAlugado WHERE NumeroSerieAluguer = @aluguer

	SELECT * FROM Aluguer WHERE NumeroSerie = @aluguer

	--É possivel remover este Aluguer--
	DELETE  FROM Aluguer WHERE NumeroSerie = @aluguer
	--É possivel remover este Aluguer--

	SELECT * FROM EquipamentoAlugado WHERE NumeroSerieAluguer = @aluguer

	SELECT * FROM Aluguer WHERE NumeroSerie = @aluguer

	SELECT * FROM Equipamento WHERE Código = @canoa OR Código = @gaivota;

	SELECT * FROM Empregado WHERE Numero = @empregado;

	SELECT * FROM Cliente WHERE Código = @cliente;

	--Erro 1, não é possivel remover este Aluguer, sendo que já começou--
	PRINT('Erro 1, não é possivel remover este Aluguer, sendo que já começou');
	DELETE  FROM Aluguer WHERE NumeroSerie = @aluguer2;
	PRINT('Erro 1, não é possivel remover este Aluguer, sendo que já começou');
	--Erro 1, não é possivel remover este Aluguer, sendo que já começou--
ROLLBACK TRAN