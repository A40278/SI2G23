USE Base_Dados_SI2_1617SI_23

GO
CREATE TRIGGER Alterar_Aluguer
ON dbo.Aluguer
INSTEAD OF
UPDATE
AS
	IF (GetDate()>(SELECT FimComExtra FROM DELETED))
	BEGIN
		RAISERROR('O aluguer j� acabou e n�o pode ser alterado',16,1)
		RETURN
	END

	IF(COLUMNS_UPDATED() & 192) > 0
		BEGIN
			RAISERROR('N�o se pode alterar Pre�o ou FimComExtra',16,1)
			RETURN
		END

	DECLARE @codigoC INT, @numeroE INT;
	IF(UPDATE(C�digoCliente) OR UPDATE(NumeroEmpregado))
		BEGIN
			SELECT @codigoC = C�digoCliente, @numeroE = NumeroEmpregado FROM INSERTED;
			UPDATE Aluguer SET C�digoCliente = @codigoC, NumeroEmpregado = @numeroE WHERE NumeroSerie = (SELECT NumeroSerie FROM DELETED);
			RETURN
		END

	DECLARE @numeroSerie INT, @fim DATETIME;
	SELECT @numeroSerie = NumeroSerie, @fim = FimComExtra FROM DELETED;
	DECLARE @novoFim DATETIME;
	SELECT @novoFim = Fim FROM INSERTED;

	IF(UPDATE(Fim))
		BEGIN
			DECLARE @fimOriginal DATETIME, @dateDiff INT;
			SELECT @fimOriginal = Fim FROM DELETED;
			
			SET @dateDiff = DATEDIFF (mi, @fimOriginal , @fim);
			SET @fim = DATEADD(mi,@dateDiff,@novoFim);   
		END

	DECLARE @tipoDura��o VARCHAR(2), @inicio DATETIME;
	SELECT @tipoDura��o = TipoDura��o, @inicio = Inicio, @codigoC = C�digoCliente, @numeroE = NumeroEmpregado FROM INSERTED;

	IF EXISTS (SELECT * FROM EquipamentoAlugado WHERE C�digoEquipamento IN
		(SELECT C�digoEquipamento FROM EquipamentoAlugado WHERE NumeroSerieAluguer = @numeroSerie)
	AND NumeroSerieAluguer IN
		(SELECT NumeroSerie FROM 
			(SELECT NumeroSerie, Inicio, FimComExtra FROM Aluguer WHERE   NumeroSerie != @numeroSerie)AS
			 AlugueresDiferentes WHERE
			 (Inicio<@fim AND FimComExtra>@fim) OR (Inicio<@inicio AND FimComExtra>@inicio)
		)
	)
		BEGIN
			RAISERROR('N�o se pode realizar a altera��o porque um dos equipamentos do Aluguer j� encontram-se ocupados para o novo periodo do Aluguer',16,1)
			RETURN
		END


	DECLARE @numeroDePre�osParaOsEquipamentos INT;

	SELECT @numeroDePre�osParaOsEquipamentos = COUNT(*) FROM Pre�o
		WHERE C�digoEquipamento IN (SELECT C�digoEquipamento FROM EquipamentoAlugado WHERE NumeroSerieAluguer = @numeroSerie)
		AND TipoDura��o = @tipoDura��o AND Inicio<=@inicio AND Fim>=@inicio;

	IF(@numeroDePre�osParaOsEquipamentos != (SELECT COUNT(*) FROM EquipamentoAlugado WHERE NumeroSerieAluguer = @numeroSerie))
		BEGIN
			RAISERROR('N�o se pode realizar a altera��o porque um dos equipamentos do Aluguer n�o tem um pre�o para o momento',16,1)
			RETURN
		END

	DECLARE @codigo INT, @pre�o DECIMAL(10,2), @desconto DECIMAL(10,2), @pre�oAluguer DECIMAL(10,2)
	
	DECLARE @novoPre�o DECIMAL(10,2) = 0.00;

	DECLARE cursorChange CURSOR LOCAL FAST_FORWARD FOR 
		SELECT C�digoEquipamento, Desconto FROM dbo.EquipamentoAlugado WHERE NumeroSerieAluguer = @numeroSerie;
	OPEN cursorChange;

	FETCH NEXT FROM cursorChange INTO @codigo, @desconto;
	WHILE @@fetch_status = 0
		BEGIN
			EXEC Calcular_Pre�o_De_Aluguer_Sem_Desconto @codigo, @tipoDura��o, @inicio, @novoFim, @desconto ,@pre�o OUTPUT, @pre�oAluguer OUTPUT;
			UPDATE EquipamentoAlugado SET Pre�oOriginal = @pre�o, Pre�oFinal = @pre�oAluguer WHERE C�digoEquipamento = @codigo
				AND NumeroSerieAluguer = @numeroSerie;
			SET @novoPre�o = @novoPre�o + @pre�oAluguer;
			FETCH NEXT FROM cursorChange INTO @codigo, @desconto;
		END
	DEALLOCATE cursorChange;  

	UPDATE Aluguer 
		SET Pre�o = @novoPre�o, TipoDura��o = @tipoDura��o, Fim = @novoFim, FimComExtra = @fim, C�digoCliente = @codigoC, NumeroEmpregado = @numeroE
		WHERE NumeroSerie = @numeroSerie;
	RETURN;
GO

GO
CREATE TRIGGER Remover_EquipamentoAlugado
ON dbo.EquipamentoAlugado
INSTEAD OF
DELETE
AS
	DECLARE @fimComExtra DATETIME, @numeroSerie INT;
	SELECT @numeroSerie = NumeroSerieAluguer FROM DELETED
	SELECT @fimComExtra = FimComExtra FROM Aluguer WHERE NumeroSerie = @numeroSerie;
	IF (GetDate()>@fimComExtra)
	BEGIN
		RAISERROR('O Aluguer j� acabou e n�o pode ser removido um Equipamento no Aluguer',16,1)
		RETURN
	END

	UPDATE Version01.Aluguer SET Pre�o = Pre�o - (SELECT Pre�oFinal FROM DELETED) WHERE NumeroSerie = @numeroSerie;
	DELETE EquipamentoAlugado WHERE NumeroSerieAluguer = @numeroSerie AND C�digoEquipamento = (SELECT C�digoEquipamento FROM DELETED)
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
CREATE TRIGGER Remover_Aluguer
ON dbo.Aluguer
INSTEAD OF
DELETE
AS
	IF (GetDate()>(SELECT FimComExtra FROM DELETED))
	BEGIN
		RAISERROR('O aluguer j� acabou e n�o pode ser removido',16,1)
		RETURN
	END

	DELETE FROM dbo.Aluguer WHERE NumeroSerie=(SELECT NumeroSerie FROM DELETED); 

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

	IF EXISTS(SELECT * FROM dbo.Aluguer WHERE C�digoCliente = @c�digoCliente AND FimComExtra<GetDate())
		BEGIN
			RAISERROR('Um Aluguer do Cliente j� acabou e n�o pode ser removido',16,1)
			RETURN
		END
	DELETE FROM dbo.Cliente WHERE C�digo = @c�digoCliente;
	RETURN;
GO