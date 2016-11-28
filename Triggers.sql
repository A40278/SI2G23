USE Base_Dados_SI2_1617SI_23

GO
CREATE TRIGGER Check_Dates_Preço
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
CREATE TRIGGER Promoção_para_Desconto
ON Version01.Desconto
AFTER
INSERT, UPDATE
AS
	SET NOCOUNT ON
	IF EXISTS( SELECT * FROM TempoExtra WHERE NumeroIdentificadorPromoção = (SELECT NumeroIdentificadorPromoção FROM INSERTED))
		BEGIN
			RAISERROR('Já existe um tempo extra com NumeroIdentificadorPromoção fornecido'
			,16,1)
			ROLLBACK TRANSACTION;
			RETURN;
		END
	RETURN
GO

GO
CREATE TRIGGER Promoção_para_TempoExtra
ON Version01.TempoExtra
AFTER
INSERT, UPDATE
AS
	SET NOCOUNT ON
	IF EXISTS( SELECT * FROM Desconto WHERE NumeroIdentificadorPromoção = (SELECT NumeroIdentificadorPromoção FROM INSERTED))
		BEGIN
			RAISERROR('Já existe um tempo extra com NumeroIdentificadorPromoção fornecido'
			,16,1);
			ROLLBACK TRANSACTION;
			RETURN;
		END
	RETURN
GO

GO
CREATE TRIGGER Insert_Aluguer
ON dbo.Aluguer
INSTEAD OF
INSERT
AS
	SET NOCOUNT ON;
	DECLARE @numeroSerie INTEGER, @fim DATETIME, @inicio DATETIME, @tipoDuração VARCHAR(2), @fimExtra DATETIME;
	DECLARE @mumeroEmpregado INTEGER, @códigoCliente INTEGER, @fraçcoesTempoExtra INTEGER = 0, @factor DECIMAL(10,2) = 0.00;

	SELECT  @fim=Fim, @inicio=Inicio, @tipoDuração=TipoDuração, @mumeroEmpregado = NumeroEmpregado, @códigoCliente = CódigoCliente FROM INSERTED;
	
	EXEC @fraçcoesTempoExtra = Fracoes_Tempo_Extra @fim, @inicio, @tipoDuração
	EXEC Factor_Tipo_Duração @tipoDuração, @factor OUTPUT;

	SET @fimExtra = DATEADD(mi,@fraçcoesTempoExtra*@factor,@fim);

	INSERT INTO Version01.Aluguer (TipoDuração, Inicio, Fim, FimComExtra, CódigoCliente, NumeroEmpregado) 
	VALUES(@tipoDuração, @inicio,@fim ,@fimExtra,@códigoCliente,@mumeroEmpregado);

	RETURN;
GO

GO
CREATE TRIGGER Adicionar_Equipamento_Aluguer
ON dbo.EquipamentoAlugado
INSTEAD OF
INSERT
AS
	SET NOCOUNT ON
	DECLARE @numeroSerie INTEGER, @codigo INTEGER, @nomeTipo VARCHAR(150);
	SELECT @numeroSerie = NumeroSerieAluguer, @codigo = CódigoEquipamento FROM INSERTED;

	IF NOT EXISTS (SELECT * FROM dbo.Aluguer WHERE NumeroSerie = @numeroSerie)
		BEGIN
			RAISERROR('Não existe o Aluguer desejado',16,1)
			RETURN
		END

	IF NOT EXISTS (SELECT * FROM dbo.Equipamento WHERE Código = @codigo)
		BEGIN
			RAISERROR('Não existe o Equipamento desejado',16,1)
			RETURN
		END

	DECLARE @tipoDuração VARCHAR(2), @inicio DATETIME, @fim DATETIME, @fimComExtra DATETIME, @return INTEGER;
	SELECT @tipoDuração = TipoDuração, @inicio = Inicio, @fim = Fim, @fimComExtra = FimComExtra FROM dbo.Aluguer WHERE NumeroSerie = @numeroSerie;

	EXEC  @return = Verificar_Equipamento_Alugado_No_Periodo @inicio, @fim, @codigo;
	IF(@return > 0)
		BEGIN
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

	INSERT INTO Version01.EquipamentoAlugado (NumeroSerieAluguer, CódigoEquipamento, PreçoOriginal, PreçoFinal, Desconto)
	VALUES(@numeroSerie, @codigo, @preço, @preçoAluguer, @deconto);


	UPDATE Version01.Aluguer
	SET Preço = Preço + @preçoAluguer
	WHERE NumeroSerie = @numeroSerie;

	RETURN;
GO

GO
CREATE TRIGGER Remover_Aluguer
ON dbo.Aluguer
INSTEAD OF
DELETE
AS
	IF (GetDate()>(SELECT Inicio FROM DELETED))
	BEGIN
		RAISERROR('O aluguer já começou e não pode ser removido',16,1)
		RETURN
	END

	DELETE FROM Version01.Aluguer WHERE NumeroSerie=(SELECT NumeroSerie FROM DELETED); 

	RETURN;
GO

GO
CREATE TRIGGER Remover_Cliente
ON dbo.Cliente
INSTEAD OF
DELETE
AS
	DECLARE @códigoCliente INT;
	SELECT @códigoCliente = Código FROM DELETED;

	DECLARE @numeroSerieAluguer INTEGER, @inicio DATETIME;
	DECLARE cursorChange CURSOR LOCAL FAST_FORWARD FOR 
		SELECT NumeroSerie, Inicio FROM dbo.Aluguer WHERE CódigoCliente = @códigoCliente;
	OPEN cursorChange;

	FETCH NEXT FROM cursorChange INTO @numeroSerieAluguer, @inicio;
	WHILE @@fetch_status = 0
		BEGIN
			IF (GetDate()>@inicio)
				BEGIN
					UPDATE Version01.Aluguer SET CódigoCliente = NULL WHERE NumeroSerie = @numeroSerieAluguer; 
				END
			FETCH NEXT FROM cursorChange INTO @numeroSerieAluguer, @inicio;
		END
	DEALLOCATE cursorChange;  
	DELETE FROM dbo.Cliente WHERE Código = @códigoCliente;
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

	DECLARE @numeroSerieAluguer INTEGER, @inicio DATETIME;
	DECLARE cursorChange CURSOR LOCAL FAST_FORWARD FOR 
		SELECT NumeroSerie, Inicio FROM dbo.Aluguer WHERE NumeroEmpregado = @numero;
	OPEN cursorChange;

	FETCH NEXT FROM cursorChange INTO @numeroSerieAluguer, @inicio;
	WHILE @@fetch_status = 0
		BEGIN
			IF (GetDate()>@inicio)
				BEGIN
					UPDATE Version01.Aluguer SET CódigoCliente = NULL WHERE NumeroSerie = @numeroSerieAluguer; 
				END
			FETCH NEXT FROM cursorChange INTO @numeroSerieAluguer, @inicio;
		END
	DEALLOCATE cursorChange;  
	DELETE FROM dbo.Empregado WHERE Numero = @numero;
	RETURN;
GO