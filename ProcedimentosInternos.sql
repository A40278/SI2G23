USE Base_Dados_SI2_1617SI_23

GO
--permite introduzir um Cliente e um Aluguer com uma só ação 
CREATE PROC Inserir_Aluguer_e_Cliente
@tipoDuração VARCHAR(2), @inicio DATETIME, @fim DATETIME, @numeroEmpregado INTEGER,
@nome VARCHAR(150) = NULL, @numeroFiscal INTEGER = NULL, @morada VARCHAR(150) = NULL
AS
	--Começa por introduzir o Cliente
	INSERT INTO dbo.Cliente(Nome, NumeroFiscal, Morada) VALUES ( @nome, @numeroFiscal, @morada);
	--Introduz o Aluguer, tendo em conta que @@IDENTITY representa o valor identity mais recentemente criado, ou queira dize
	--o numero identificador do Cliente introduzido
	INSERT INTO dbo.Aluguer(TipoDuração, Inicio, Fim, CódigoCliente, NumeroEmpregado)
	VALUES (@tipoDuração, @inicio, @fim, @@IDENTITY, @numeroEmpregado)
GO

GO
--lista todos os Equipamentos não ocupados num periodo, ente @inicioPeriodo e @fimPeriodo de um certo Tipo
CREATE PROC Listar_Equipamentos_Disponiveis_Periodo_Tipo
@inicioPeriodo DATETIME, @fimPeriodo DATETIME, @tipo VARCHAR(150)
AS
	--Obtém os Equipamentos do Tipo recebido que ainda não foram encontram-se ocupados no perido 
		--Obtém os CódigoEquipamentos dos EquipamenteAlugados ocupados no periodo
			--Obtém os NumeroSeries dos Alugueres que começam e ou acabam no periodo
	SELECT * FROM Equipamento WHERE NomeTipo = @tipo AND Código NOT IN (
		SELECT CódigoEquipamento FROM EquipamentoAlugado WHERE NumeroSerieAluguer IN(
			SELECT NumeroSerie FROM Aluguer WHERE 
				(@inicioPeriodo<=Inicio AND Inicio<=@fimPeriodo)
				OR (Inicio<=@inicioPeriodo AND FimComExtra>=@fimPeriodo)
				OR (@inicioPeriodo<=Fim AND FimComExtra<=@fimPeriodo)))
GO

GO
--lista todos os Equipamentos não ocupados na ultima semana
CREATE PROC Listar_Equipamentos_Disponiveis_Ultima_Semana
AS
	DECLARE @fim DATETIME, @inicio DATETIME
	--fim da semana
	SET @fim = GETDATE();
	--inicio da semana
	SET @inicio = DATEADD(dd,-7,@fim);
	--Obtém os Equipamentos do Tipo recebido que ainda não foram encontram-se ocupados na semana
		--Obtém os CódigoEquipamentos dos EquipamenteAlugados ocupados na semana
			--Obtém os NumeroSeries dos Alugueres que começam e ou acabam na semana
	SELECT * FROM Equipamento WHERE Código NOT IN (
		SELECT CódigoEquipamento FROM EquipamentoAlugado WHERE NumeroSerieAluguer IN
			(SELECT NumeroSerie FROM Aluguer WHERE 
				(@inicio<=Inicio AND Inicio<=@fim)
				OR (Inicio<=@inicio AND Fim>=@fim)
				OR (@inicio<=Fim AND Fim<=@fim)))
GO