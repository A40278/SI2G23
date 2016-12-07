USE Base_Dados_SI2_1617SI_23

GO
--Garante que n�o podem existir 2 Pre�os para o mesmo Equipamento no mesmo perido e mesmo TipoDura��o 
CREATE TRIGGER Adicionar_Pre�o
ON Version01.Pre�o
AFTER
INSERT, UPDATE
AS
	SET NOCOUNT ON;
	--Obt�m o inicio e fim do Perido em conta
	DECLARE @inicio DATETIME, @fim DATETIME, @codigo INTEGER, @tipoDura��o VARCHAR(2), @count INTEGER;
	SELECT @inicio = Inicio, @fim = Fim, @codigo = C�digoEquipamento, @tipoDura��o = TipoDura��o FROM INSERTED;

	--Obt�m o numero de Pre�os existentes do Equipamento desejado, no perido e com o TipoDura��o desejado 
	EXEC @count = Numero_de_Pre�os_No_Periodo @inicio, @fim, @tipoDura��o, @codigo
	IF ( @count > 1)
		BEGIN
			--Se houver mais que um remove-se o que fui introduzido, aquele que chamou este trigger
			RAISERROR('N�o se pode introduzir um pre�o com a validade dada, ja existindo um pre�o na mesma situ��o para o periodo fornecido'
			,16,1);
			ROLLBACK TRANSACTION;
			RETURN;
		END
	RETURN
GO

GO
--Adiciona-se ao Aluguer introduzido o valor FimComExtra, o Fim original mais a soma dos TempoExtras que afetam o Aluguer
CREATE TRIGGER Adicionar_Aluguer
ON Version01.Aluguer
AFTER
INSERT
AS
	SET NOCOUNT ON;
	DECLARE @numeroSerie INTEGER, @fim DATETIME, @inicio DATETIME, @tipoDura��o VARCHAR(2), @fimExtra DATETIME;
	DECLARE @fra�coesTempoExtra INTEGER = 0, @factor DECIMAL(10,2) = 0.00;

	--Obt�m-se os valores necessarios para obter FimComExtra
	SELECT  @fim=Fim, @inicio=Inicio, @tipoDura��o=TipoDura��o, @numeroSerie = NumeroSerie FROM INSERTED;
	
	--Obt�m o numero de blocos temporais do TipoDura��o do Aluguer dos TempoExtras que afetam o Aluguer
	EXEC @fra�coesTempoExtra = Fracoes_Tempo_Extra @fim, @inicio, @tipoDura��o
	EXEC Factor_Tipo_Dura��o @tipoDura��o, @factor OUTPUT;

	--Junta a Fim do Aluguer o numero de minutos igual aos minutos extras obtidos pelos TempoExtras que afetam o Aluguer
	SET @fimExtra = DATEADD(mi,@fra�coesTempoExtra*@factor,@fim);

	--Adiciona-se FimComExtra ao Aluguer introduzido
	UPDATE Version01.Aluguer SET FimComExtra = @fimExtra WHERE NumeroSerie = @numeroSerie;
	RETURN;
GO

GO
--Verifica que pode-se adicionar um Equipamento a lista de EquipamentoAlugados ao Aluguer
--e caso for possivel obtem o pre�o de desconto desse alugamento e incrementa o Pre�o do Alguere pelo pre�o obtido
CREATE TRIGGER Adicionar_Equipamento_Aluguer
ON Version01.EquipamentoAlugado
INSTEAD OF
INSERT
AS
	DECLARE @numeroSerie INTEGER, @codigo INTEGER, @nomeTipo VARCHAR(150);
	SELECT @numeroSerie = NumeroSerieAluguer, @codigo = C�digoEquipamento FROM INSERTED;

	DECLARE @tipoDura��o VARCHAR(2), @inicio DATETIME, @fim DATETIME, @fimComExtra DATETIME, @return INTEGER;
	SELECT @tipoDura��o = TipoDura��o, @inicio = Inicio, @fim = Fim, @fimComExtra = FimComExtra FROM dbo.Aluguer WHERE NumeroSerie = @numeroSerie;
	
	--Verifica se o Aluguer j� acabou
	SET NOCOUNT ON
	IF (GetDate()>@fimComExtra)
	BEGIN
		--Aluguer j� acabou, n�o se pode introduzir mais Equipamentos
		RAISERROR('O aluguer j� acabou e por n�o se pode intruduzir novos Equipamentos',16,1)
		RETURN
	END
	
	--Verifica se o Equipamento n�o se encontra ocupado por outro Aluguer no perido do Aluguer onde se quer introduzir o Equipamento
	EXEC  @return = Verificar_Equipamento_Alugado_No_Periodo @inicio, @fimComExtra, @codigo;
	IF(@return > 0)
		BEGIN
			--Caso o Equipamento estiver ocupado levanta um erro e acaba o trigger
			RAISERROR('O item requesitado j� encontra-se alugado para o periodo do alugamento',16,1)
			RETURN
		END

	DECLARE @pre�o DECIMAL(10,2), @deconto DECIMAL(10,2), @ret INT, @pre�oAluguer DECIMAL(10,2);

	--Verifica se o Equipamento tem um pre�o para o perido do Aluguer onde se quer introduzir o Equipamento
	--Caso tiver obt�m os pre�os e dseconto que compoem um EquipamentoAlugado
	EXEC @ret = Calcular_Pre�o_De_Aluguer @codigo, @tipoDura��o, @inicio, @fim, @pre�o OUTPUT, @deconto OUTPUT, @pre�oAluguer OUTPUT
	if(@ret=-1)
		BEGIN
			--Caso o Equipamento n�o tiver um Pre�o para o periodo levanta um erro e acaba o trigger
			RAISERROR('O item requesitado n�o tem pre�o para a situa��o desejada',16,1)
			RETURN
		END
	
	--Introduz o EquipamentoAlugado basiado nos valores fornecidos pelo utilizador e os valores obtidos durante o trigger
	INSERT INTO Version01.EquipamentoAlugado (NumeroSerieAluguer, C�digoEquipamento, Pre�oOriginal, Pre�oFinal, Desconto)
	VALUES(@numeroSerie, @codigo, @pre�o, @pre�oAluguer, @deconto);

	--Incrementa o Pre�o do Aluguer pelo o Pre�oFinal do EquipamentoAlugado introduzido
	UPDATE Version01.Aluguer
	SET Pre�o = Pre�o + @pre�oAluguer
	WHERE NumeroSerie = @numeroSerie;
	
	RETURN;
GO

GO
--Verifica se pode remover o Aluguer e remove caso podder
CREATE TRIGGER Remover_Aluguer
ON Version01.Aluguer
AFTER
DELETE
AS
	--Verifica se o Aluguer j� acabou, caso j� acabou o Aluguer n�o pode ser removido
	IF (GetDate()>(SELECT FimComExtra FROM DELETED))
	BEGIN
		--O Aluguer j� acabou , por isso n�o pode ser removido
		RAISERROR('O aluguer j� acabou e n�o pode ser removido',16,1)
		RETURN
	END

	--O Aluguer ainda n�o acabou , por isso pode ser, e ira ser, removido
	DELETE FROM Version01.Aluguer WHERE NumeroSerie=(SELECT NumeroSerie FROM DELETED); 

	RETURN;
GO
