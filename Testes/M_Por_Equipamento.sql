USE Base_Dados_SI2_1617SI_23;

BEGIN TRAN
	SET NOCOUNT ON;

	DECLARE @cliente INT, @empregado INT, @canoa INT, @gaivota INT, @mota INT, @aluguer INT, @desconto1 INT;
	DECLARE @now DATETIME = GETDATE();

	--Instruduzir os Tipos para os Equipamentos e Descontos--
	INSERT INTO Tipo(Nome, Descrição) VALUES ('Canoa', 'canoa simples');
	INSERT INTO Tipo(Nome, Descrição) VALUES ('Gaivota', 'gaivota simples');
	INSERT INTO Tipo(Nome, Descrição) VALUES ('Mota de Agua', 'mota de agua simples');
	--Instruduzir os Tipos para os Equipamentos e Descontos--

	--Intruduzir o Cliente para o Aluguer--
	INSERT INTO dbo.Cliente(Nome, NumeroFiscal, Morada) VALUES ('Laura Vicentes', 996585201, 'Rua Cauda-de-Boi 33');
	SET @cliente = @@IDENTITY
	--Intruduzir o Cliente para o Aluguer--

	--Intruduzir o Empregado para o Aluguer-- 
	INSERT INTO dbo.Empregado(Nome) VALUES ('Pedro Tomas');
	SET @empregado = @@IDENTITY
	--Intruduzir o Empregado para o Aluguer--

	--Intruduzir o Equipamento para o Aluguer--
	INSERT INTO dbo.Equipamento(Descrição, NomeTipo) VALUES ('uma canoa Lilaz','Canoa')

	INSERT INTO dbo.Equipamento(Descrição, NomeTipo) VALUES ('uma gaivota amarela','Gaivota')

	INSERT INTO dbo.Equipamento(Descrição, NomeTipo) VALUES ('uma mota de agua roxo','Mota de Agua')
	SET @mota = @@IDENTITY;
	SET @gaivota = @mota - 1;
	SET @canoa = @gaivota - 1;
	--Intruduzir o Equipamento para o Aluguer--

	--Intruduzir os Preços dos Equipamentos para o Aluguer--
	DECLARE @inicioPreço DATETIME = DATEADD(d,-1,@now), @fimPreço DATETIME = DATEADD(d,1,@now)
	INSERT INTO dbo.Preço (CódigoEquipamento, Inicio, Fim, TipoDuração, Valor) VALUES(@canoa, @inicioPreço, @fimPreço, 'h',10.15) 
	
	INSERT INTO dbo.Preço (CódigoEquipamento, Inicio, Fim, TipoDuração, Valor) VALUES(@gaivota, @inicioPreço, @fimPreço, 'h',7.80)
	
	INSERT INTO dbo.Preço (CódigoEquipamento, Inicio, Fim, TipoDuração, Valor) VALUES(@mota, @inicioPreço, @fimPreço, 'h',22.75)

	--Intruduzir os Descontos para o Aluguer--
	EXEC @desconto1 = Inserir_Desconto 'Primeiro Desconto Teste', '2016-07-05 00:00:00', '2016-07-20 00:00:00',0.25;
	--Intruduzir os Descontos para o Aluguer--
	
	--Dar um Tipo afectados por cada Desconto--
	INSERT INTO dbo.Tipo_Desconto(NumeroIdentificadorDesconto,NomeTipo) VALUES(@desconto1,'Canoa')
	INSERT INTO dbo.Tipo_Desconto(NumeroIdentificadorDesconto,NomeTipo) VALUES(@desconto1,'Mota de Agua')
	--Dar um Tipo afectados por cada Desconto--

	--Intruduzir Aluguer--
	INSERT INTO dbo.Aluguer(TipoDuração, Inicio, Fim, CódigoCliente, NumeroEmpregado) VALUES ('h', DATEADD(hh,-3,@now), DATEADD(hh,4,@now),
	@cliente, @empregado)

	SET @aluguer = @@IDENTITY
	--Intruduzir Aluguer--

	--Intruduzir os Equipamentos alugados no Aluguer--
	INSERT INTO dbo.EquipamentoAlugado(NumeroSerieAluguer,CódigoEquipamento) VALUES (@aluguer,@canoa)
	INSERT INTO dbo.EquipamentoAlugado(NumeroSerieAluguer,CódigoEquipamento) VALUES (@aluguer,@mota)
	INSERT INTO dbo.EquipamentoAlugado(NumeroSerieAluguer,CódigoEquipamento) VALUES (@aluguer,@gaivota)
	
	--Intruduzir os Equipamentos alugados no Aluguer--

	SELECT * FROM EquipamentoAlugado

	SELECT * FROM Aluguer

	--Remove-se um Equipamento sem problemas--
	DELETE Equipamento WHERE Código = @mota;
	--Remove-se um Equipamento sem problemas--

	--Aletera-se Fim, assim o Alguer já acabou--
	UPDATE Aluguer SET Fim = DATEADD(hh,-1,@now)
	--Aletera-se Fim, assim o Alguer já acabou--

	--Erro 1, Aluguer já acabou por isso Equipamento não pode ser removido--
	PRINT('Erro 1, Aluguer já acabou por isso Equipamento não pode ser removido');
	DELETE dbo.Equipamento WHERE Código = @gaivota;
	PRINT('Erro 1, Aluguer já acabou por isso Equipamento não pode ser removido');
	--Erro 1, Aluguer já acabou por isso Equipamento não pode ser removido--

	SELECT * FROM EquipamentoAlugado

	SELECT * FROM Aluguer
ROLLBACK TRAN