USE Base_Dados_SI2_1617SI_23

GO
CREATE TRIGGER Alterar_Aluguer
ON dbo.Aluguer
INSTEAD OF
UPDATE
AS
	IF (GetDate()>(SELECT FimComExtra FROM DELETED))
	BEGIN
		RAISERROR('O aluguer já acabou e não pode ser alterado',16,1)
		RETURN
	END

	IF(COLUMNS_UPDATED() & 192) > 0
		BEGIN
			RAISERROR('Não se pode alterar Preço ou FimComExtra',16,1)
			RETURN
		END

	DECLARE @codigoC INT, @numeroE INT;
	IF(UPDATE(CódigoCliente) OR UPDATE(NumeroEmpregado))
		BEGIN
			SELECT @codigoC = CódigoCliente, @numeroE = NumeroEmpregado FROM INSERTED;
			UPDATE Aluguer SET CódigoCliente = @codigoC, NumeroEmpregado = @numeroE WHERE NumeroSerie = (SELECT NumeroSerie FROM DELETED);
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

	DECLARE @tipoDuração VARCHAR(2), @inicio DATETIME;
	SELECT @tipoDuração = TipoDuração, @inicio = Inicio, @codigoC = CódigoCliente, @numeroE = NumeroEmpregado FROM INSERTED;

	IF EXISTS (SELECT * FROM EquipamentoAlugado WHERE CódigoEquipamento IN
		(SELECT CódigoEquipamento FROM EquipamentoAlugado WHERE NumeroSerieAluguer = @numeroSerie)
	AND NumeroSerieAluguer IN
		(SELECT NumeroSerie FROM 
			(SELECT NumeroSerie, Inicio, FimComExtra FROM Aluguer WHERE   NumeroSerie != @numeroSerie)AS
			 AlugueresDiferentes WHERE
			 (Inicio<@fim AND FimComExtra>@fim) OR (Inicio<@inicio AND FimComExtra>@inicio)
		)
	)
		BEGIN
			RAISERROR('Não se pode realizar a alteração porque um dos equipamentos do Aluguer já encontram-se ocupados para o novo periodo do Aluguer',16,1)
			RETURN
		END


	DECLARE @numeroDePreçosParaOsEquipamentos INT;

	SELECT @numeroDePreçosParaOsEquipamentos = COUNT(*) FROM Preço
		WHERE CódigoEquipamento IN (SELECT CódigoEquipamento FROM EquipamentoAlugado WHERE NumeroSerieAluguer = @numeroSerie)
		AND TipoDuração = @tipoDuração AND Inicio<=@inicio AND Fim>=@inicio;

	IF(@numeroDePreçosParaOsEquipamentos != (SELECT COUNT(*) FROM EquipamentoAlugado WHERE NumeroSerieAluguer = @numeroSerie))
		BEGIN
			RAISERROR('Não se pode realizar a alteração porque um dos equipamentos do Aluguer não tem um preço para o momento',16,1)
			RETURN
		END

	DECLARE @codigo INT, @preço DECIMAL(10,2), @desconto DECIMAL(10,2), @preçoAluguer DECIMAL(10,2)
	
	DECLARE @novoPreço DECIMAL(10,2) = 0.00;

	DECLARE cursorChange CURSOR LOCAL FAST_FORWARD FOR 
		SELECT CódigoEquipamento, Desconto FROM dbo.EquipamentoAlugado WHERE NumeroSerieAluguer = @numeroSerie;
	OPEN cursorChange;

	FETCH NEXT FROM cursorChange INTO @codigo, @desconto;
	WHILE @@fetch_status = 0
		BEGIN
			EXEC Calcular_Preço_De_Aluguer_Sem_Desconto @codigo, @tipoDuração, @inicio, @novoFim, @desconto ,@preço OUTPUT, @preçoAluguer OUTPUT;
			UPDATE EquipamentoAlugado SET PreçoOriginal = @preço, PreçoFinal = @preçoAluguer WHERE CódigoEquipamento = @codigo
				AND NumeroSerieAluguer = @numeroSerie;
			SET @novoPreço = @novoPreço + @preçoAluguer;
			FETCH NEXT FROM cursorChange INTO @codigo, @desconto;
		END
	DEALLOCATE cursorChange;  

	UPDATE Aluguer 
		SET Preço = @novoPreço, TipoDuração = @tipoDuração, Fim = @novoFim, FimComExtra = @fim, CódigoCliente = @codigoC, NumeroEmpregado = @numeroE
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
		RAISERROR('O Aluguer já acabou e não pode ser removido um Equipamento no Aluguer',16,1)
		RETURN
	END

	UPDATE Version01.Aluguer SET Preço = Preço - (SELECT PreçoFinal FROM DELETED) WHERE NumeroSerie = @numeroSerie;
	DELETE EquipamentoAlugado WHERE NumeroSerieAluguer = @numeroSerie AND CódigoEquipamento = (SELECT CódigoEquipamento FROM DELETED)
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
CREATE TRIGGER Remover_Aluguer
ON dbo.Aluguer
INSTEAD OF
DELETE
AS
	IF (GetDate()>(SELECT FimComExtra FROM DELETED))
	BEGIN
		RAISERROR('O aluguer já acabou e não pode ser removido',16,1)
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
	DECLARE @códigoCliente INT;
	SELECT @códigoCliente = Código FROM DELETED;

	IF EXISTS(SELECT * FROM dbo.Aluguer WHERE CódigoCliente = @códigoCliente AND FimComExtra<GetDate())
		BEGIN
			RAISERROR('Um Aluguer do Cliente já acabou e não pode ser removido',16,1)
			RETURN
		END
	DELETE FROM dbo.Cliente WHERE Código = @códigoCliente;
	RETURN;
GO