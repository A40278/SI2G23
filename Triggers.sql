USE Base_Dados_SI2_1617SI_23

GO
--Garante que não podem existir 2 Preços para o mesmo Equipamento no mesmo perido e mesmo TipoDuração 
CREATE TRIGGER Adicionar_Preço
ON Version01.Preço
AFTER
INSERT, UPDATE
AS
	SET NOCOUNT ON;
	--Obtém o inicio e fim do Perido em conta
	DECLARE @inicio DATETIME, @fim DATETIME, @codigo INTEGER, @tipoDuração VARCHAR(2), @count INTEGER;
	SELECT @inicio = Inicio, @fim = Fim, @codigo = CódigoEquipamento, @tipoDuração = TipoDuração FROM INSERTED;

	--Obtém o numero de Preços existentes do Equipamento desejado, no perido e com o TipoDuração desejado 
	EXEC @count = Numero_de_Preços_No_Periodo @inicio, @fim, @tipoDuração, @codigo
	IF ( @count > 1)
		BEGIN
			--Se houver mais que um remove-se o que fui introduzido, aquele que chamou este trigger
			RAISERROR('Não se pode introduzir um preço com a validade dada, ja existindo um preço na mesma situção para o periodo fornecido'
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
	DECLARE @numeroSerie INTEGER, @fim DATETIME, @inicio DATETIME, @tipoDuração VARCHAR(2), @fimExtra DATETIME;
	DECLARE @fraçcoesTempoExtra INTEGER = 0, @factor DECIMAL(10,2) = 0.00;

	--Obtém-se os valores necessarios para obter FimComExtra
	SELECT  @fim=Fim, @inicio=Inicio, @tipoDuração=TipoDuração, @numeroSerie = NumeroSerie FROM INSERTED;
	
	--Obtém o numero de blocos temporais do TipoDuração do Aluguer dos TempoExtras que afetam o Aluguer
	EXEC @fraçcoesTempoExtra = Fracoes_Tempo_Extra @fim, @inicio, @tipoDuração
	EXEC Factor_Tipo_Duração @tipoDuração, @factor OUTPUT;

	--Junta a Fim do Aluguer o numero de minutos igual aos minutos extras obtidos pelos TempoExtras que afetam o Aluguer
	SET @fimExtra = DATEADD(mi,@fraçcoesTempoExtra*@factor,@fim);

	--Adiciona-se FimComExtra ao Aluguer introduzido
	UPDATE Version01.Aluguer SET FimComExtra = @fimExtra WHERE NumeroSerie = @numeroSerie;
	RETURN;
GO

GO
--Verifica que pode-se adicionar um Equipamento a lista de EquipamentoAlugados ao Aluguer
--e caso for possivel obtem o preço de desconto desse alugamento e incrementa o Preço do Alguere pelo preço obtido
CREATE TRIGGER Adicionar_Equipamento_Aluguer
ON Version01.EquipamentoAlugado
INSTEAD OF
INSERT
AS
	DECLARE @numeroSerie INTEGER, @codigo INTEGER, @nomeTipo VARCHAR(150);
	SELECT @numeroSerie = NumeroSerieAluguer, @codigo = CódigoEquipamento FROM INSERTED;

	DECLARE @tipoDuração VARCHAR(2), @inicio DATETIME, @fim DATETIME, @fimComExtra DATETIME, @return INTEGER;
	SELECT @tipoDuração = TipoDuração, @inicio = Inicio, @fim = Fim, @fimComExtra = FimComExtra FROM dbo.Aluguer WHERE NumeroSerie = @numeroSerie;
	
	--Verifica se o Aluguer já acabou
	SET NOCOUNT ON
	IF (GetDate()>@fimComExtra)
	BEGIN
		--Aluguer já acabou, não se pode introduzir mais Equipamentos
		RAISERROR('O aluguer já acabou e por não se pode intruduzir novos Equipamentos',16,1)
		RETURN
	END
	
	--Verifica se o Equipamento não se encontra ocupado por outro Aluguer no perido do Aluguer onde se quer introduzir o Equipamento
	EXEC  @return = Verificar_Equipamento_Alugado_No_Periodo @inicio, @fimComExtra, @codigo;
	IF(@return > 0)
		BEGIN
			--Caso o Equipamento estiver ocupado levanta um erro e acaba o trigger
			RAISERROR('O item requesitado já encontra-se alugado para o periodo do alugamento',16,1)
			RETURN
		END

	DECLARE @preço DECIMAL(10,2), @deconto DECIMAL(10,2), @ret INT, @preçoAluguer DECIMAL(10,2);

	--Verifica se o Equipamento tem um preço para o perido do Aluguer onde se quer introduzir o Equipamento
	--Caso tiver obtém os preços e dseconto que compoem um EquipamentoAlugado
	EXEC @ret = Calcular_Preço_De_Aluguer @codigo, @tipoDuração, @inicio, @fim, @preço OUTPUT, @deconto OUTPUT, @preçoAluguer OUTPUT
	if(@ret=-1)
		BEGIN
			--Caso o Equipamento não tiver um Preço para o periodo levanta um erro e acaba o trigger
			RAISERROR('O item requesitado não tem preço para a situação desejada',16,1)
			RETURN
		END
	
	--Introduz o EquipamentoAlugado basiado nos valores fornecidos pelo utilizador e os valores obtidos durante o trigger
	INSERT INTO Version01.EquipamentoAlugado (NumeroSerieAluguer, CódigoEquipamento, PreçoOriginal, PreçoFinal, Desconto)
	VALUES(@numeroSerie, @codigo, @preço, @preçoAluguer, @deconto);

	--Incrementa o Preço do Aluguer pelo o PreçoFinal do EquipamentoAlugado introduzido
	UPDATE Version01.Aluguer
	SET Preço = Preço + @preçoAluguer
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
	--Verifica se o Aluguer já acabou, caso já acabou o Aluguer não pode ser removido
	IF (GetDate()>(SELECT FimComExtra FROM DELETED))
	BEGIN
		--O Aluguer já acabou , por isso não pode ser removido
		RAISERROR('O aluguer já acabou e não pode ser removido',16,1)
		RETURN
	END

	--O Aluguer ainda não acabou , por isso pode ser, e ira ser, removido
	DELETE FROM Version01.Aluguer WHERE NumeroSerie=(SELECT NumeroSerie FROM DELETED); 

	RETURN;
GO
