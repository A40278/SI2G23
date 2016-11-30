USE Base_Dados_SI2_1617SI_23

GO
CREATE TRIGGER Verificar_Datas_de_Pre�o
ON Version01.Pre�o
AFTER
INSERT, UPDATE
AS
	SET NOCOUNT ON;
	DECLARE @inicio DATETIME, @fim DATETIME, @codigo INTEGER, @tipoDura��o VARCHAR(2), @count INTEGER;
	SELECT @inicio = Inicio, @fim = Fim, @codigo = C�digoEquipamento, @tipoDura��o = TipoDura��o FROM INSERTED;
	EXEC @count = Numero_de_Pre�os_No_Periodo @inicio, @fim, @tipoDura��o, @codigo
	IF ( @count > 1)
		BEGIN
			--DELETE Version01.Pre�o WHERE Inicio = @inicio AND C�digoEquipamento = @codigo AND TipoDura��o = @tipoDura��o
			RAISERROR('N�o se pode introduzir um pre�o com a validade dada, ja existindo um pre�o na mesma situ��o para o periodo fornecido'
			,16,1);
			ROLLBACK TRANSACTION;
			RETURN;
		END
	RETURN
GO

GO
CREATE TRIGGER Adicionar_Aluguer
ON Version01.Aluguer
AFTER
INSERT
AS
	SET NOCOUNT ON;
	DECLARE @numeroSerie INTEGER, @fim DATETIME, @inicio DATETIME, @tipoDura��o VARCHAR(2), @fimExtra DATETIME;
	DECLARE @fra�coesTempoExtra INTEGER = 0, @factor DECIMAL(10,2) = 0.00;

	SELECT  @fim=Fim, @inicio=Inicio, @tipoDura��o=TipoDura��o, @numeroSerie = NumeroSerie FROM INSERTED;
	
	EXEC @fra�coesTempoExtra = Fracoes_Tempo_Extra @fim, @inicio, @tipoDura��o
	EXEC Factor_Tipo_Dura��o @tipoDura��o, @factor OUTPUT;

	SET @fimExtra = DATEADD(mi,@fra�coesTempoExtra*@factor,@fim);

	UPDATE Version01.Aluguer SET FimComExtra = @fimExtra WHERE NumeroSerie = @numeroSerie;
	RETURN;
GO

GO
CREATE TRIGGER Adicionar_Equipamento_Aluguer
ON dbo.EquipamentoAlugado
INSTEAD OF
INSERT
AS
	DECLARE @numeroSerie INTEGER, @codigo INTEGER, @nomeTipo VARCHAR(150);
	SELECT @numeroSerie = NumeroSerieAluguer, @codigo = C�digoEquipamento FROM INSERTED;

	DECLARE @tipoDura��o VARCHAR(2), @inicio DATETIME, @fim DATETIME, @fimComExtra DATETIME, @return INTEGER;
	SELECT @tipoDura��o = TipoDura��o, @inicio = Inicio, @fim = Fim, @fimComExtra = FimComExtra FROM dbo.Aluguer WHERE NumeroSerie = @numeroSerie;
	
	SET NOCOUNT ON
	IF (GetDate()>@fimComExtra)
	BEGIN
		RAISERROR('O aluguer j� acabou e por n�o se pode intruduzir novos Equipamentos',16,1)
		RETURN
	END
	
	EXEC  @return = Verificar_Equipamento_Alugado_No_Periodo @inicio, @fimComExtra, @codigo;
	IF(@return > 0)
		BEGIN
			PRINT('O item requesitado j� encontra-se alugado para o periodo do alugamento')
			RAISERROR('O item requesitado j� encontra-se alugado para o periodo do alugamento',16,1)
			RETURN
		END

	DECLARE @pre�o DECIMAL(10,2), @deconto DECIMAL(10,2), @ret INT, @pre�oAluguer DECIMAL(10,2);

	EXEC @ret = Calcular_Pre�o_De_Aluguer @codigo, @tipoDura��o, @inicio, @fim, @pre�o OUTPUT, @deconto OUTPUT, @pre�oAluguer OUTPUT
	if(@ret=-1)
		BEGIN
			RAISERROR('O item requesitado n�o tem pre�o para a situa��o desejada',16,1)
			RETURN
		END
	
	INSERT INTO dbo.EquipamentoAlugado (NumeroSerieAluguer, C�digoEquipamento, Pre�oOriginal, Pre�oFinal, Desconto)
	VALUES(@numeroSerie, @codigo, @pre�o, @pre�oAluguer, @deconto);

	UPDATE Version01.Aluguer
	SET Pre�o = Pre�o + @pre�oAluguer
	WHERE NumeroSerie = @numeroSerie;
	
	RETURN;
GO

GO
CREATE TRIGGER Remover_Empregado
ON dbo.Empregado
INSTEAD OF
DELETE
AS
	DECLARE @numero INT;
	SELECT @numero = Numero FROM DELETED;

	IF EXISTS(SELECT * FROM dbo.Aluguer WHERE C�digoCliente = @numero AND FimComExtra<GetDate())
		BEGIN
			RAISERROR('Um Aluguer do Empregado j� acabou e n�o pode ser removido',16,1)
			RETURN
		END
	DELETE FROM dbo.Empregado WHERE Numero = @numero;
	RETURN;
GO