USE Base_Dados_SI2_1617SI_23

GO
CREATE TRIGGER Verificar_Datas_de_Preço
ON Version01.Preço
AFTER
INSERT, UPDATE
AS
	SET NOCOUNT ON;
	DECLARE @inicio DATETIME, @fim DATETIME, @codigo INTEGER, @tipoDuração VARCHAR(2), @count INTEGER;
	SELECT @inicio = Inicio, @fim = Fim, @codigo = CódigoEquipamento, @tipoDuração = TipoDuração FROM INSERTED;
	EXEC @count = Numero_de_Preços_No_Periodo @inicio, @fim, @tipoDuração, @codigo
	IF ( @count > 1)
		BEGIN
			--DELETE Version01.Preço WHERE Inicio = @inicio AND CódigoEquipamento = @codigo AND TipoDuração = @tipoDuração
			RAISERROR('Não se pode introduzir um preço com a validade dada, ja existindo um preço na mesma situção para o periodo fornecido'
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
	DECLARE @numeroSerie INTEGER, @fim DATETIME, @inicio DATETIME, @tipoDuração VARCHAR(2), @fimExtra DATETIME;
	DECLARE @fraçcoesTempoExtra INTEGER = 0, @factor DECIMAL(10,2) = 0.00;

	SELECT  @fim=Fim, @inicio=Inicio, @tipoDuração=TipoDuração, @numeroSerie = NumeroSerie FROM INSERTED;
	
	EXEC @fraçcoesTempoExtra = Fracoes_Tempo_Extra @fim, @inicio, @tipoDuração
	EXEC Factor_Tipo_Duração @tipoDuração, @factor OUTPUT;

	SET @fimExtra = DATEADD(mi,@fraçcoesTempoExtra*@factor,@fim);

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
	SELECT @numeroSerie = NumeroSerieAluguer, @codigo = CódigoEquipamento FROM INSERTED;

	DECLARE @tipoDuração VARCHAR(2), @inicio DATETIME, @fim DATETIME, @fimComExtra DATETIME, @return INTEGER;
	SELECT @tipoDuração = TipoDuração, @inicio = Inicio, @fim = Fim, @fimComExtra = FimComExtra FROM dbo.Aluguer WHERE NumeroSerie = @numeroSerie;
	
	SET NOCOUNT ON
	IF (GetDate()>@fimComExtra)
	BEGIN
		RAISERROR('O aluguer já acabou e por não se pode intruduzir novos Equipamentos',16,1)
		RETURN
	END
	
	EXEC  @return = Verificar_Equipamento_Alugado_No_Periodo @inicio, @fimComExtra, @codigo;
	IF(@return > 0)
		BEGIN
			PRINT('O item requesitado já encontra-se alugado para o periodo do alugamento')
			RAISERROR('O item requesitado já encontra-se alugado para o periodo do alugamento',16,1)
			RETURN
		END

	DECLARE @preço DECIMAL(10,2), @deconto DECIMAL(10,2), @ret INT, @preçoAluguer DECIMAL(10,2);

	EXEC @ret = Calcular_Preço_De_Aluguer @codigo, @tipoDuração, @inicio, @fim, @preço OUTPUT, @deconto OUTPUT, @preçoAluguer OUTPUT
	if(@ret=-1)
		BEGIN
			RAISERROR('O item requesitado não tem preço para a situação desejada',16,1)
			RETURN
		END
	
	INSERT INTO dbo.EquipamentoAlugado (NumeroSerieAluguer, CódigoEquipamento, PreçoOriginal, PreçoFinal, Desconto)
	VALUES(@numeroSerie, @codigo, @preço, @preçoAluguer, @deconto);

	UPDATE Version01.Aluguer
	SET Preço = Preço + @preçoAluguer
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

	IF EXISTS(SELECT * FROM dbo.Aluguer WHERE CódigoCliente = @numero AND FimComExtra<GetDate())
		BEGIN
			RAISERROR('Um Aluguer do Empregado já acabou e não pode ser removido',16,1)
			RETURN
		END
	DELETE FROM dbo.Empregado WHERE Numero = @numero;
	RETURN;
GO