USE Base_Dados_SI2_1617SI_23


GO
--Verifica se Aluguer pode ser alterado, caso poder altera os valores de acordo com o necessario
CREATE TRIGGER Alterar_Aluguer
ON Version01.Aluguer
INSTEAD OF
UPDATE
AS
	--Verifica se o ALuguer já acabou
	IF (GetDate()>(SELECT FimComExtra FROM DELETED))
	BEGIN
		--Caso o Aluguer já acabou, não se pode alterar o Aluguer e por isso levante-se um erro e acaba-se o trigger
		RAISERROR('O aluguer já acabou e não pode ser alterado',16,1)
		RETURN
	END

	DECLARE @codigoC INT, @numeroE INT;
	--Verifica se só CódigoCliente e/ou NumeroEmpregado foram alterados 
	IF(COLUMNS_UPDATED() & 255 >=  2 AND COLUMNS_UPDATED() & 255 <= 6)
		BEGIN
			--Caso só CódigoCliente e/ou NumeroEmpregado foram alterados, então altera-se esse elementos e acaba-se o Trigger
			SELECT @codigoC = CódigoCliente, @numeroE = NumeroEmpregado FROM INSERTED;
			UPDATE Version01.Aluguer SET CódigoCliente = @codigoC, NumeroEmpregado = @numeroE WHERE NumeroSerie = (SELECT NumeroSerie FROM DELETED);
			RETURN
		END

	DECLARE @numeroSerie INT, @fim DATETIME;
	SELECT @numeroSerie = NumeroSerie, @fim = FimComExtra FROM DELETED;
	DECLARE @novoFim DATETIME;
	SELECT @novoFim = Fim FROM INSERTED;

	--Caso Fim foi alterdado é necessario obter o novo FimComExtra, em função do novo Fim
	IF(UPDATE(Fim))
		BEGIN
			DECLARE @fimOriginal DATETIME, @dateDiff INT;
			SELECT @fimOriginal = Fim FROM DELETED;
			
			--Obtém a diferença, em minutos, entre o FimComExra e Fim antes de aconteçer o Update 
			SET @dateDiff = DATEDIFF (mi, @fimOriginal , @fim);

			--Obtém o valor do novo FimComExtra juntando ao novo Fim a diferença obtida no ponto anterior 
			SET @fim = DATEADD(mi,@dateDiff,@novoFim);   
			PRINT(@fim)
		END

	DECLARE @tipoDuração VARCHAR(2), @inicio DATETIME;
	SELECT @tipoDuração = TipoDuração, @inicio = Inicio, @codigoC = CódigoCliente, @numeroE = NumeroEmpregado FROM INSERTED;

	--Verifica se um ou mais dos Equipamentos do Aluguer encontram-se ocupados por outros Alugueres no perido do Aluguer atual

	--Obtém os EquipamentoAlugados associados ao Aluguer a alterar, que encontram-se ocupados no perido do Aluguer por outro Aluguer
	--no mesmo periodo que o Aluguer a alterar
		--Obtém os EquipamentoAlugados associados ao Aluguer a alterar
		--Obtém NumeroSerie dos Aluguers dos outros Alugueres, os Alugueres que não são o Aluguer a alterar que começam e/ou acabam
		--no periodo do Aluguer a alterar
	IF EXISTS (
	SELECT * FROM EquipamentoAlugado WHERE CódigoEquipamento IN
		(SELECT CódigoEquipamento FROM EquipamentoAlugado WHERE NumeroSerieAluguer = @numeroSerie)
	AND NumeroSerieAluguer IN
		(SELECT NumeroSerie FROM 
			(SELECT NumeroSerie, Inicio, FimComExtra FROM Aluguer WHERE   NumeroSerie != @numeroSerie)AS
			 AlugueresDiferentes WHERE
			 (Inicio<@fim AND FimComExtra>@fim) OR (Inicio<@inicio AND FimComExtra>@inicio)
		)
	)
		BEGIN
			--Caso exista um Elemento na situação anteriro levanta-se um erro e acaba-se o trigger
			RAISERROR('Não se pode realizar a alteração porque um dos equipamentos do Aluguer já encontram-se ocupados para o novo periodo do Aluguer',16,1)
			RETURN
		END


	DECLARE @numeroDePreçosParaOsEquipamentos INT;

	--Obtém o numero de Preços que existem para os EquipamentoAlugados associados ao Aluguer, com TipoDuração igual ao TipoDuração
	--do Aluguer a alterar e que exite no Inicio do Aluguer
		--Obtém CódigoEquipamento de EquipamentoAlugado de outros Aluguers
	SELECT @numeroDePreçosParaOsEquipamentos = COUNT(*) FROM Preço
	WHERE CódigoEquipamento IN 
		(SELECT CódigoEquipamento FROM EquipamentoAlugado WHERE NumeroSerieAluguer = @numeroSerie)
	AND TipoDuração = @tipoDuração AND Inicio<=@inicio AND Fim>=@inicio;

	--Verifica se o numero anteriro é desigual ao numero de EquipamentoAlugados associados ao Aluguer
	IF(@numeroDePreçosParaOsEquipamentos != (SELECT COUNT(*) FROM EquipamentoAlugado WHERE NumeroSerieAluguer = @numeroSerie))
		BEGIN
			--Caso o numero anteriro for desigual ao numero de EquipamentoAlugados associados ao Aluguer então levanta-se um erro e acaba-se o trigger
			RAISERROR('Não se pode realizar a alteração porque um dos equipamentos do Aluguer não tem um preço para o momento',16,1)
			RETURN
		END

	DECLARE @codigo INT, @preço DECIMAL(10,2), @desconto DECIMAL(10,2), @preçoAluguer DECIMAL(10,2)
	
	DECLARE @novoPreço DECIMAL(10,2) = 0.00;

	--Obtém o Cursos com CódigoEquipamento e Desconto de todos os EquipamentoAlugados associados ao Aluguer a alterar
	DECLARE cursorChange CURSOR LOCAL FAST_FORWARD FOR 
		SELECT CódigoEquipamento, Desconto FROM dbo.EquipamentoAlugado WHERE NumeroSerieAluguer = @numeroSerie;
	OPEN cursorChange;

	--Obtém cada elemento do Cursor anterior
	FETCH NEXT FROM cursorChange INTO @codigo, @desconto;
	WHILE @@fetch_status = 0
		BEGIN
			--Para cada elemento obtem-se os novos PreçoOriginal e novos PreçoFinal, usando Calcular_Preço_De_Aluguer_Sem_Desconto
			EXEC Calcular_Preço_De_Aluguer_Sem_Desconto @codigo, @tipoDuração, @inicio, @novoFim, @desconto ,@preço OUTPUT, @preçoAluguer OUTPUT;

			--Altera-se o valores possivieis, incluindo PreçoOriginal e PreçoFinal, usando os valores calculados no ponto anteriror
			--usandoa as chaves primarias dos elementos antes da alteração do Aluguer
			UPDATE Version01.EquipamentoAlugado SET PreçoOriginal = @preço, PreçoFinal = @preçoAluguer WHERE CódigoEquipamento = @codigo
				AND NumeroSerieAluguer = @numeroSerie;

			--Incrementa-se @novoPreço pelo o PreçoFinal obtido
			SET @novoPreço = @novoPreço + @preçoAluguer;
			FETCH NEXT FROM cursorChange INTO @codigo, @desconto;
		END
	DEALLOCATE cursorChange;  

	PRINT(@fim)
	--ALteta-se os valores possivies com os valores obtidos, usando a chave estrangeira antes da alteração do Aluguer
	UPDATE Version01.Aluguer 
		SET Preço = @novoPreço, Inicio = @inicio, TipoDuração = @tipoDuração, Fim = @novoFim, FimComExtra = @fim, CódigoCliente = @codigoC, NumeroEmpregado = @numeroE
		WHERE NumeroSerie = @numeroSerie;
	RETURN;
GO

/*

DROP TRIGGER Version01.Alterar_Aluguer
GO
CREATE TRIGGER Alterar_Aluguer
ON Version01.Aluguer
AFTER
UPDATE
AS
	IF(UPDATE(FIM))
		BEGIN
			DECLARE @fimOr DATETIME, @fimExOr DATETIME, @fimNvo DATETIME, @fimExNvo DATETIME, @ns INT;
			SELECT @fimExOr = FimComExtra, @fimOr = Fim FROM DELETED;
			SELECT @fimNvo = Fim, @ns = NumeroSerie FROM INSERTED;
			DECLARE @dateDiff INT = DATEDIFF(mi,@fimOr,@fimExOr);
			UPDATE dbo.Aluguer SET FimComExtra = @fimExNvo WHERE NumeroSerie = @ns
		END
		
	RETURN
GO
*/
GO
--Verifica se pode-se remover o EquipamentoAlugado, caso poder remove-se o mesmo e altera-se Aluguer de acordo
CREATE TRIGGER Remover_EquipamentoAlugado
ON Version01.EquipamentoAlugado
AFTER
DELETE
AS
	DECLARE @fimComExtra DATETIME, @numeroSerie INT;
	SELECT @numeroSerie = NumeroSerieAluguer FROM DELETED
	SELECT @fimComExtra = FimComExtra FROM Aluguer WHERE NumeroSerie = @numeroSerie;

	--Verifica-se o Aluguer associado ao EquipamentoAlugado a remover já acabou
	IF (GetDate()>@fimComExtra)
	BEGIN
		--Caso tal Aluguer já ter acabado, então não se pode remover o EquipamentoAlugado e por isso levanta-se um erro e acaba-se o trigger
		RAISERROR('O Aluguer já acabou e não pode ser removido um Equipamento no Aluguer',16,1)
		ROLLBACK
		RETURN
	END

	--Caso pode-se remover o EquipamentoAlugado, altera-se o Preço do Aluguer associado ao EquipamentoAlugado pelo PreçoFinal do mesmo
	UPDATE Version01.Aluguer SET Preço = Preço - (SELECT PreçoFinal FROM DELETED) WHERE NumeroSerie = @numeroSerie;
GO

GO
--Verifca se a Promoção associada ao Desconto que se quer introduzir ou alterar, não encontra-se já associado a um TempoExtra
CREATE TRIGGER Promoção_para_Desconto
ON Version01.Desconto
AFTER
INSERT, UPDATE
AS
	SET NOCOUNT ON
	--Verifca se a Promoção associada ao Desconto que se quer introduzir ou alterar, não encontra-se já associado a um TempoExtra
	IF EXISTS( SELECT * FROM TempoExtra WHERE NumeroIdentificadorPromoção = (SELECT NumeroIdentificadorPromoção FROM INSERTED))
		BEGIN
			--Caso tal aconteçer levanta-se um erro e realiza-se um Roollback para remover o Desconto problematico
			RAISERROR('Já existe um tempo extra com NumeroIdentificadorPromoção fornecido'
			,16,1)
			ROLLBACK TRANSACTION;
			RETURN;
		END
	RETURN
GO

GO
--Verifca se a Promoção associada ao TempoExra que se quer introduzir ou alterar, não encontra-se já associado a um Desconto
CREATE TRIGGER Promoção_para_TempoExtra
ON Version01.TempoExtra
AFTER
INSERT, UPDATE
AS
	SET NOCOUNT ON
	--Verifca se a Promoção associada ao TempoExra que se quer introduzir ou alterar, não encontra-se já associado a um Desconto
	IF EXISTS( SELECT * FROM Desconto WHERE NumeroIdentificadorPromoção = (SELECT NumeroIdentificadorPromoção FROM INSERTED))
		BEGIN
			--Caso tal aconteçer levanta-se um erro e realiza-se um Roollback para remover o TempoExtra problematico
			RAISERROR('Já existe um tempo extra com NumeroIdentificadorPromoção fornecido'
			,16,1);
			ROLLBACK TRANSACTION;
			RETURN;
		END
	RETURN
GO

GO
--Verifica se um Cliente pode ser removido, caso poder remove-se o Cliente
CREATE TRIGGER Remover_Cliente
ON Version01.Cliente
INSTEAD OF
DELETE
AS
	DECLARE @códigoCliente INT;
	SELECT @códigoCliente = Código FROM DELETED;
	
	--Verifca se existe um Aluguer associado ao Cliente que se quer remover que já tenha acabado
	IF EXISTS(SELECT * FROM dbo.Aluguer WHERE CódigoCliente = @códigoCliente AND FimComExtra<GetDate())
		BEGIN
			--Caso exister levanta-se um erro e acaba-se o trigger
			RAISERROR('O Cliente esta associado a um Aluguer que já acabou, que não pode ser removido, dai Cliente também não pode ser removido',16,1)
			RETURN
		END
	DELETE FROM Version01.Cliente WHERE Código = @códigoCliente;
	RETURN;
GO

GO
--Verifica se um Empregado pode ser removido, caso poder remove-se o Empregado
CREATE TRIGGER Remover_Empregado
ON Version01.Empregado
INSTEAD OF
DELETE
AS
	DECLARE @numero INT;
	SELECT @numero = Numero FROM DELETED;

	--Verifca se existe um Aluguer associado ao Empregado que se quer remover que já tenha acabado
	IF EXISTS(SELECT * FROM dbo.Aluguer WHERE NumeroEmpregado = @numero AND FimComExtra<GetDate())
		BEGIN
			--Caso exister levanta-se um erro e acaba-se o trigger
			RAISERROR('O Empregado esta associado a um Aluguer que já acabou, que não pode ser removido, dai Empregado também não pode ser removido',16,1)
			RETURN
		END

	--Caso não exister remove-se o Empregado
	DELETE FROM Version01.Empregado WHERE Numero = @numero;
	RETURN;
GO

GO
--Verifica se um Equipamento pode ser removido, caso poder remove-se o Equipamento
CREATE TRIGGER Remover_Equipamento
ON Version01.Equipamento
AFTER
DELETE
AS
	DECLARE @codigo INT;
	SELECT @codigo = Código FROM DELETED;

	--Verifca se existe um Aluguer associado a um EquipamentoAlugado associado ao Equipamento que se quer remover
	IF EXISTS (SELECT * FROM Aluguer WHERE FimComExtra<GetDate() AND NumeroSerie IN
		(SELECT NumeroSerieAluguer FROM EquipamentoAlugado WHERE CódigoEquipamento = @codigo))
		BEGIN
			--Caso exister levanta-se um erro e acaba-se o trigger
			RAISERROR('O Equipamento esta associado a um Aluguer que já acabou, que não pode ser removido, dai Equipamento também não pode ser removido',16,1)
			ROLLBACK
			RETURN
		END

	RETURN;
GO
