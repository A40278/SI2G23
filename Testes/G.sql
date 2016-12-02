USE Base_Dados_SI2_1617SI_23;

BEGIN TRAN
	SET NOCOUNT ON;

	DECLARE @cliente INT, @empregado INT, @canoa INT, @gaivota INT, @mota INT, @aluguer INT, @aluguer1 INT, @aluguer2 INT;
	DECLARE @tempoExtra1 INT, @tempoExtra2 INT, @tempoExtra3 INT, @desconto1 INT, @desconto2 INT, @desconto3 INT , @desconto4 INT;
	DECLARE @now DATETIME = GETDATE();

	--Instruduzir os Tipos para os Equipamentos e Descontos--
	INSERT INTO Tipo(Nome, Descrição) VALUES ('Canoa', 'canoa simples');
	INSERT INTO Tipo(Nome, Descrição) VALUES ('Remos', 'remos simples');
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

	--Neste é o Primeiro--
	INSERT INTO dbo.Preço (CódigoEquipamento, Inicio, Fim, TipoDuração, Valor) VALUES(@canoa,  DATEADD(hh,1,@now), DATEADD(hh,5,@now),
	'h',10.15) --10.15 * 3 = 30.45-- 
	INSERT INTO dbo.Preço (CódigoEquipamento, Inicio, Fim, TipoDuração, Valor) VALUES(@canoa, DATEADD(hh,5,@now), DATEADD(hh,6,@now),
	'h',12.20)
	INSERT INTO dbo.Preço (CódigoEquipamento, Inicio, Fim, TipoDuração, Valor) VALUES(@canoa, DATEADD(hh,6,@now), DATEADD(hh,7,@now),
	'h',11.50)
	
	--Neste é o Segundo--
	INSERT INTO dbo.Preço (CódigoEquipamento, Inicio, Fim, TipoDuração, Valor) VALUES(@gaivota, DATEADD(hh,1,@now), DATEADD(hh,2,@now),
	'h',7.80)
	INSERT INTO dbo.Preço (CódigoEquipamento, Inicio, Fim, TipoDuração, Valor) VALUES(@gaivota, DATEADD(hh,2,@now), DATEADD(hh,5,@now),
	'h',8.60) --8.60 * 3 = 25-80--
	INSERT INTO dbo.Preço (CódigoEquipamento, Inicio, Fim, TipoDuração, Valor) VALUES(@gaivota, DATEADD(hh,5,@now), DATEADD(hh,7,@now),
	'h',8.20)
	
	
	--Neste é o Terceiro--
	INSERT INTO dbo.Preço (CódigoEquipamento, Inicio, Fim, TipoDuração, Valor) VALUES(@mota, DATEADD(hh,1,@now), DATEADD(hh,2,@now),
	'h',20.50)
	INSERT INTO dbo.Preço (CódigoEquipamento, Inicio, Fim, TipoDuração, Valor) VALUES(@mota, DATEADD(hh,2,@now), DATEADD(hh,3,@now),
	'h',23.00)
	INSERT INTO dbo.Preço (CódigoEquipamento, Inicio, Fim, TipoDuração, Valor) VALUES(@mota, DATEADD(hh,3,@now), DATEADD(hh,7,@now),
	'h',22.75)--22.75 * 3 = 28.25--
	--Intruduzir os Preços dos Equipamentos para o Aluguer--

	--Intruduzir os TemposExtras para o Aluguer--
	--É unica que conta--
	EXEC @tempoExtra1 = Inserir_TempoExtra 'Primeiro Tempo Extra Teste', '2016-07-05 00:00:00', '2016-07-20 00:00:00', 2, 'h'

	--Tempo correcto, tipo de duração errado--
	EXEC @tempoExtra2 = Inserir_TempoExtra 'Segundo Tempo Extra Teste', '2016-07-05 00:00:00', '2016-07-20 00:00:00', 2, 'mh'

	--Tempo errado, tipo de duração correcto--
	EXEC @tempoExtra3 = Inserir_TempoExtra 'Terceiro Tempo Extra Teste', '2016-07-01 00:00:00', '2016-07-04 00:00:00', 1, 'h'

	--Intruduzir os TemposExtras para o Aluguer--

	--Intruduzir os Descontos para o Aluguer--
	--Afecta a Canoa e a Mora de Agua--
	EXEC @desconto1 = Inserir_Desconto 'Primeiro Desconto Teste', '2016-07-05 00:00:00', '2016-07-20 00:00:00',0.25;

	--Não afecta nenhum artigo do Aluguer, afecta Tipo fora do Aluguer--
	EXEC @desconto2 = Inserir_Desconto 'Segundo Desconto Teste', '2016-07-05 00:00:00', '2016-07-20 00:00:00',0.20;

	--Não afecta nenhum artigo do Aluguer, tempo da promoção fora do Aluguer--
	EXEC @desconto3 = Inserir_Desconto 'Terceiro Desconto Teste', '2016-07-09 00:00:00', '2016-07-20 00:00:00',0.15;

	--Afecta a Mota de Agua do Aluguer--
	EXEC @desconto4 = Inserir_Desconto 'Quarto Desconto Teste', '2016-07-05 00:00:00', '2016-07-20 00:00:00',0.05;

	--Intruduzir os Descontos para o Aluguer--
	
	--Dar um Tipo afectados por cada Desconto--
	INSERT INTO dbo.Tipo_Desconto(NumeroIdentificadorDesconto,NomeTipo) VALUES(@desconto1,'Canoa')
	INSERT INTO dbo.Tipo_Desconto(NumeroIdentificadorDesconto,NomeTipo) VALUES(@desconto1,'Mota de Agua')
	INSERT INTO dbo.Tipo_Desconto(NumeroIdentificadorDesconto,NomeTipo) VALUES(@desconto2,'Remos')
	INSERT INTO dbo.Tipo_Desconto(NumeroIdentificadorDesconto,NomeTipo) VALUES(@desconto3,'Canoa')
	INSERT INTO dbo.Tipo_Desconto(NumeroIdentificadorDesconto,NomeTipo) VALUES(@desconto4,'Gaivota')
	INSERT INTO dbo.Tipo_Desconto(NumeroIdentificadorDesconto,NomeTipo) VALUES(@desconto4,'Mota de Agua')
	--Dar um Tipo afectados por cada Desconto--

	--Com os descontos--
	/*
	Canoa, afectada 25% desconto, 22.84, 91.35-22.84 = 68.51
	Remos, afectados 5% desconto, 3.87 77.40-3.87 = 73.53
	Mota de Agua, afectada 30% desconto, 61.42 204.75-61.42 = 143.33
	*/
	--Com os descontos--

	--Intruduzir Aluguer--
	INSERT INTO dbo.Aluguer(TipoDuração, Inicio, Fim, CódigoCliente, NumeroEmpregado) VALUES ('h', DATEADD(hh,4,@now), DATEADD(hh,7,@now),
	@cliente, @empregado)
	INSERT INTO dbo.Aluguer(TipoDuração, Inicio, Fim, CódigoCliente, NumeroEmpregado) VALUES ('h', DATEADD(hh,8,@now), DATEADD(hh,10,@now),
	@cliente, @empregado)
	INSERT INTO dbo.Aluguer(TipoDuração, Inicio, Fim, CódigoCliente, NumeroEmpregado) VALUES ('h', DATEADD(hh,3,@now), DATEADD(hh,6,@now),
	@cliente, @empregado)
	SET @aluguer2 = @@IDENTITY
	SET @aluguer1 = @aluguer2 - 1
	SET @aluguer = @aluguer1 - 1
	--Intruduzir Aluguer--

	--Intruduzir os Equipamentos alugados no Aluguer--
	INSERT INTO dbo.EquipamentoAlugado(NumeroSerieAluguer,CódigoEquipamento) VALUES (@aluguer,@canoa)
	INSERT INTO dbo.EquipamentoAlugado(NumeroSerieAluguer,CódigoEquipamento) VALUES (@aluguer,@mota)
	INSERT INTO dbo.EquipamentoAlugado(NumeroSerieAluguer,CódigoEquipamento) VALUES (@aluguer,@gaivota)
	--Intruduzir os Equipamentos alugados no Aluguer--

	--Erro 1, o Equipamento não tem preço para o periodo do Aluguer--
	PRINT('Erro 1, o Equipamento não tem preço para o periodo do Aluguer')
	INSERT INTO dbo.EquipamentoAlugado(NumeroSerieAluguer,CódigoEquipamento) VALUES (@aluguer1,@canoa)
	PRINT('Erro 1, o Equipamento não tem preço para o periodo do Aluguer')
	--Erro 1, o Equipamento não tem preço para o periodo do Aluguer--

	--Erro 2, o Equipamento já se encontra ocupado no periodo do Aluguer--
	PRINT('Erro 2, o Equipamento já se encontra ocupado no periodo do Aluguer')
	INSERT INTO dbo.EquipamentoAlugado(NumeroSerieAluguer,CódigoEquipamento) VALUES (@aluguer2,@canoa)
	PRINT('Erro 2, o Equipamento já se encontra ocupado no periodo do Aluguer')
	--Erro 2, o Equipamento já se encontra ocupado no periodo do Aluguer--

	SELECT * FROM EquipamentoAlugado WHERE NumeroSerieAluguer = @aluguer

	SELECT * FROM Aluguer WHERE NumeroSerie = @aluguer
ROLLBACK TRAN