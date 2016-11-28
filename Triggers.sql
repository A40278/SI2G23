USE Base_Dados_SI2_1617SI_23

GO
CREATE TRIGGER Check_Dates_Pre�o
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
CREATE TRIGGER Promo��o_para_Desconto
ON Version01.Desconto
AFTER
INSERT, UPDATE
AS
	SET NOCOUNT ON
	IF EXISTS( SELECT * FROM TempoExtra WHERE NumeroIdentificadorPromo��o = (SELECT NumeroIdentificadorPromo��o FROM INSERTED))
		BEGIN
			RAISERROR('J� existe um tempo extra com NumeroIdentificadorPromo��o fornecido'
			,16,1)
			ROLLBACK TRANSACTION;
			RETURN;
		END
	RETURN
GO

GO
CREATE TRIGGER Promo��o_para_TempoExtra
ON Version01.TempoExtra
AFTER
INSERT, UPDATE
AS
	SET NOCOUNT ON
	IF EXISTS( SELECT * FROM Desconto WHERE NumeroIdentificadorPromo��o = (SELECT NumeroIdentificadorPromo��o FROM INSERTED))
		BEGIN
			RAISERROR('J� existe um tempo extra com NumeroIdentificadorPromo��o fornecido'
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
	DECLARE @numeroSerie INTEGER, @fim DATETIME, @inicio DATETIME, @tipoDura��o VARCHAR(2), @fimExtra DATETIME;
	DECLARE @mumeroEmpregado INTEGER, @c�digoCliente INTEGER, @fra�coesTempoExtra INTEGER = 0, @factor DECIMAL(10,2) = 0.00;

	SELECT  @fim=Fim, @inicio=Inicio, @tipoDura��o=TipoDura��o, @mumeroEmpregado = NumeroEmpregado, @c�digoCliente = C�digoCliente FROM INSERTED;
	
	EXEC @fra�coesTempoExtra = Fracoes_Tempo_Extra @fim, @inicio, @tipoDura��o
	EXEC Factor_Tipo_Dura��o @tipoDura��o, @factor OUTPUT;

	SET @fimExtra = DATEADD(mi,@fra�coesTempoExtra*@factor,@fim);

	INSERT INTO Version01.Aluguer (TipoDura��o, Inicio, Fim, FimComExtra, C�digoCliente, NumeroEmpregado) 
	VALUES(@tipoDura��o, @inicio,@fim ,@fimExtra,@c�digoCliente,@mumeroEmpregado);

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
	SELECT @numeroSerie = NumeroSerieAluguer, @codigo = C�digoEquipamento FROM INSERTED;

	IF NOT EXISTS (SELECT * FROM dbo.Aluguer WHERE NumeroSerie = @numeroSerie)
		BEGIN
			RAISERROR('N�o existe o Aluguer desejado',16,1)
			RETURN
		END

	IF NOT EXISTS (SELECT * FROM dbo.Equipamento WHERE C�digo = @codigo)
		BEGIN
			RAISERROR('N�o existe o Equipamento desejado',16,1)
			RETURN
		END

	DECLARE @tipoDura��o VARCHAR(2), @inicio DATETIME, @fim DATETIME, @fimComExtra DATETIME, @return INTEGER;
	SELECT @tipoDura��o = TipoDura��o, @inicio = Inicio, @fim = Fim, @fimComExtra = FimComExtra FROM dbo.Aluguer WHERE NumeroSerie = @numeroSerie;

	EXEC  @return = Verificar_Equipamento_Alugado_No_Periodo @inicio, @fim, @codigo;
	IF(@return > 0)
		BEGIN
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

	INSERT INTO Version01.EquipamentoAlugado (NumeroSerieAluguer, C�digoEquipamento, Pre�oOriginal, Pre�oFinal, Desconto)
	VALUES(@numeroSerie, @codigo, @pre�o, @pre�oAluguer, @deconto);


	UPDATE Version01.Aluguer
	SET Pre�o = Pre�o + @pre�oAluguer
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
		RAISERROR('O aluguer j� come�ou e n�o pode ser removido',16,1)
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
	DECLARE @c�digoCliente INT;
	SELECT @c�digoCliente = C�digo FROM DELETED;

	DECLARE @numeroSerieAluguer INTEGER, @inicio DATETIME;
	DECLARE cursorChange CURSOR LOCAL FAST_FORWARD FOR 
		SELECT NumeroSerie, Inicio FROM dbo.Aluguer WHERE C�digoCliente = @c�digoCliente;
	OPEN cursorChange;

	FETCH NEXT FROM cursorChange INTO @numeroSerieAluguer, @inicio;
	WHILE @@fetch_status = 0
		BEGIN
			IF (GetDate()>@inicio)
				BEGIN
					UPDATE Version01.Aluguer SET C�digoCliente = NULL WHERE NumeroSerie = @numeroSerieAluguer; 
				END
			FETCH NEXT FROM cursorChange INTO @numeroSerieAluguer, @inicio;
		END
	DEALLOCATE cursorChange;  
	DELETE FROM dbo.Cliente WHERE C�digo = @c�digoCliente;
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
					UPDATE Version01.Aluguer SET C�digoCliente = NULL WHERE NumeroSerie = @numeroSerieAluguer; 
				END
			FETCH NEXT FROM cursorChange INTO @numeroSerieAluguer, @inicio;
		END
	DEALLOCATE cursorChange;  
	DELETE FROM dbo.Empregado WHERE Numero = @numero;
	RETURN;
GO