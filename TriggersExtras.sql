USE Base_Dados_SI2_1617SI_23


GO
--Verifica se Aluguer pode ser alterado, caso poder altera os valores de acordo com o necessario
CREATE TRIGGER Alterar_Aluguer
ON Version01.Aluguer
INSTEAD OF
UPDATE
AS
	--Verifica se o ALuguer j� acabou
	IF (GetDate()>(SELECT FimComExtra FROM DELETED))
	BEGIN
		--Caso o Aluguer j� acabou, n�o se pode alterar o Aluguer e por isso levante-se um erro e acaba-se o trigger
		RAISERROR('O aluguer j� acabou e n�o pode ser alterado',16,1)
		RETURN
	END

	DECLARE @codigoC INT, @numeroE INT;
	--Verifica se s� C�digoCliente e/ou NumeroEmpregado foram alterados 
	IF(COLUMNS_UPDATED() & 255 >=  2 AND COLUMNS_UPDATED() & 255 <= 6)
		BEGIN
			--Caso s� C�digoCliente e/ou NumeroEmpregado foram alterados, ent�o altera-se esse elementos e acaba-se o Trigger
			SELECT @codigoC = C�digoCliente, @numeroE = NumeroEmpregado FROM INSERTED;
			UPDATE Version01.Aluguer SET C�digoCliente = @codigoC, NumeroEmpregado = @numeroE WHERE NumeroSerie = (SELECT NumeroSerie FROM DELETED);
			RETURN
		END

	DECLARE @numeroSerie INT, @fim DATETIME;
	SELECT @numeroSerie = NumeroSerie, @fim = FimComExtra FROM DELETED;
	DECLARE @novoFim DATETIME;
	SELECT @novoFim = Fim FROM INSERTED;

	--Caso Fim foi alterdado � necessario obter o novo FimComExtra, em fun��o do novo Fim
	IF(UPDATE(Fim))
		BEGIN
			DECLARE @fimOriginal DATETIME, @dateDiff INT;
			SELECT @fimOriginal = Fim FROM DELETED;
			
			--Obt�m a diferen�a, em minutos, entre o FimComExra e Fim antes de aconte�er o Update 
			SET @dateDiff = DATEDIFF (mi, @fimOriginal , @fim);

			--Obt�m o valor do novo FimComExtra juntando ao novo Fim a diferen�a obtida no ponto anterior 
			SET @fim = DATEADD(mi,@dateDiff,@novoFim);   
			PRINT(@fim)
		END

	DECLARE @tipoDura��o VARCHAR(2), @inicio DATETIME;
	SELECT @tipoDura��o = TipoDura��o, @inicio = Inicio, @codigoC = C�digoCliente, @numeroE = NumeroEmpregado FROM INSERTED;

	--Verifica se um ou mais dos Equipamentos do Aluguer encontram-se ocupados por outros Alugueres no perido do Aluguer atual

	--Obt�m os EquipamentoAlugados associados ao Aluguer a alterar, que encontram-se ocupados no perido do Aluguer por outro Aluguer
	--no mesmo periodo que o Aluguer a alterar
		--Obt�m os EquipamentoAlugados associados ao Aluguer a alterar
		--Obt�m NumeroSerie dos Aluguers dos outros Alugueres, os Alugueres que n�o s�o o Aluguer a alterar que come�am e/ou acabam
		--no periodo do Aluguer a alterar
	IF EXISTS (
	SELECT * FROM EquipamentoAlugado WHERE C�digoEquipamento IN
		(SELECT C�digoEquipamento FROM EquipamentoAlugado WHERE NumeroSerieAluguer = @numeroSerie)
	AND NumeroSerieAluguer IN
		(SELECT NumeroSerie FROM 
			(SELECT NumeroSerie, Inicio, FimComExtra FROM Aluguer WHERE   NumeroSerie != @numeroSerie)AS
			 AlugueresDiferentes WHERE
			 (Inicio<@fim AND FimComExtra>@fim) OR (Inicio<@inicio AND FimComExtra>@inicio)
		)
	)
		BEGIN
			--Caso exista um Elemento na situa��o anteriro levanta-se um erro e acaba-se o trigger
			RAISERROR('N�o se pode realizar a altera��o porque um dos equipamentos do Aluguer j� encontram-se ocupados para o novo periodo do Aluguer',16,1)
			RETURN
		END


	DECLARE @numeroDePre�osParaOsEquipamentos INT;

	--Obt�m o numero de Pre�os que existem para os EquipamentoAlugados associados ao Aluguer, com TipoDura��o igual ao TipoDura��o
	--do Aluguer a alterar e que exite no Inicio do Aluguer
		--Obt�m C�digoEquipamento de EquipamentoAlugado de outros Aluguers
	SELECT @numeroDePre�osParaOsEquipamentos = COUNT(*) FROM Pre�o
	WHERE C�digoEquipamento IN 
		(SELECT C�digoEquipamento FROM EquipamentoAlugado WHERE NumeroSerieAluguer = @numeroSerie)
	AND TipoDura��o = @tipoDura��o AND Inicio<=@inicio AND Fim>=@inicio;

	--Verifica se o numero anteriro � desigual ao numero de EquipamentoAlugados associados ao Aluguer
	IF(@numeroDePre�osParaOsEquipamentos != (SELECT COUNT(*) FROM EquipamentoAlugado WHERE NumeroSerieAluguer = @numeroSerie))
		BEGIN
			--Caso o numero anteriro for desigual ao numero de EquipamentoAlugados associados ao Aluguer ent�o levanta-se um erro e acaba-se o trigger
			RAISERROR('N�o se pode realizar a altera��o porque um dos equipamentos do Aluguer n�o tem um pre�o para o momento',16,1)
			RETURN
		END

	DECLARE @codigo INT, @pre�o DECIMAL(10,2), @desconto DECIMAL(10,2), @pre�oAluguer DECIMAL(10,2)
	
	DECLARE @novoPre�o DECIMAL(10,2) = 0.00;

	--Obt�m o Cursos com C�digoEquipamento e Desconto de todos os EquipamentoAlugados associados ao Aluguer a alterar
	DECLARE cursorChange CURSOR LOCAL FAST_FORWARD FOR 
		SELECT C�digoEquipamento, Desconto FROM dbo.EquipamentoAlugado WHERE NumeroSerieAluguer = @numeroSerie;
	OPEN cursorChange;

	--Obt�m cada elemento do Cursor anterior
	FETCH NEXT FROM cursorChange INTO @codigo, @desconto;
	WHILE @@fetch_status = 0
		BEGIN
			--Para cada elemento obtem-se os novos Pre�oOriginal e novos Pre�oFinal, usando Calcular_Pre�o_De_Aluguer_Sem_Desconto
			EXEC Calcular_Pre�o_De_Aluguer_Sem_Desconto @codigo, @tipoDura��o, @inicio, @novoFim, @desconto ,@pre�o OUTPUT, @pre�oAluguer OUTPUT;

			--Altera-se o valores possivieis, incluindo Pre�oOriginal e Pre�oFinal, usando os valores calculados no ponto anteriror
			--usandoa as chaves primarias dos elementos antes da altera��o do Aluguer
			UPDATE Version01.EquipamentoAlugado SET Pre�oOriginal = @pre�o, Pre�oFinal = @pre�oAluguer WHERE C�digoEquipamento = @codigo
				AND NumeroSerieAluguer = @numeroSerie;

			--Incrementa-se @novoPre�o pelo o Pre�oFinal obtido
			SET @novoPre�o = @novoPre�o + @pre�oAluguer;
			FETCH NEXT FROM cursorChange INTO @codigo, @desconto;
		END
	DEALLOCATE cursorChange;  

	PRINT(@fim)
	--ALteta-se os valores possivies com os valores obtidos, usando a chave estrangeira antes da altera��o do Aluguer
	UPDATE Version01.Aluguer 
		SET Pre�o = @novoPre�o, Inicio = @inicio, TipoDura��o = @tipoDura��o, Fim = @novoFim, FimComExtra = @fim, C�digoCliente = @codigoC, NumeroEmpregado = @numeroE
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

	--Verifica-se o Aluguer associado ao EquipamentoAlugado a remover j� acabou
	IF (GetDate()>@fimComExtra)
	BEGIN
		--Caso tal Aluguer j� ter acabado, ent�o n�o se pode remover o EquipamentoAlugado e por isso levanta-se um erro e acaba-se o trigger
		RAISERROR('O Aluguer j� acabou e n�o pode ser removido um Equipamento no Aluguer',16,1)
		ROLLBACK
		RETURN
	END

	--Caso pode-se remover o EquipamentoAlugado, altera-se o Pre�o do Aluguer associado ao EquipamentoAlugado pelo Pre�oFinal do mesmo
	UPDATE Version01.Aluguer SET Pre�o = Pre�o - (SELECT Pre�oFinal FROM DELETED) WHERE NumeroSerie = @numeroSerie;
GO

GO
--Verifca se a Promo��o associada ao Desconto que se quer introduzir ou alterar, n�o encontra-se j� associado a um TempoExtra
CREATE TRIGGER Promo��o_para_Desconto
ON Version01.Desconto
AFTER
INSERT, UPDATE
AS
	SET NOCOUNT ON
	--Verifca se a Promo��o associada ao Desconto que se quer introduzir ou alterar, n�o encontra-se j� associado a um TempoExtra
	IF EXISTS( SELECT * FROM TempoExtra WHERE NumeroIdentificadorPromo��o = (SELECT NumeroIdentificadorPromo��o FROM INSERTED))
		BEGIN
			--Caso tal aconte�er levanta-se um erro e realiza-se um Roollback para remover o Desconto problematico
			RAISERROR('J� existe um tempo extra com NumeroIdentificadorPromo��o fornecido'
			,16,1)
			ROLLBACK TRANSACTION;
			RETURN;
		END
	RETURN
GO

GO
--Verifca se a Promo��o associada ao TempoExra que se quer introduzir ou alterar, n�o encontra-se j� associado a um Desconto
CREATE TRIGGER Promo��o_para_TempoExtra
ON Version01.TempoExtra
AFTER
INSERT, UPDATE
AS
	SET NOCOUNT ON
	--Verifca se a Promo��o associada ao TempoExra que se quer introduzir ou alterar, n�o encontra-se j� associado a um Desconto
	IF EXISTS( SELECT * FROM Desconto WHERE NumeroIdentificadorPromo��o = (SELECT NumeroIdentificadorPromo��o FROM INSERTED))
		BEGIN
			--Caso tal aconte�er levanta-se um erro e realiza-se um Roollback para remover o TempoExtra problematico
			RAISERROR('J� existe um tempo extra com NumeroIdentificadorPromo��o fornecido'
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
	DECLARE @c�digoCliente INT;
	SELECT @c�digoCliente = C�digo FROM DELETED;
	
	--Verifca se existe um Aluguer associado ao Cliente que se quer remover que j� tenha acabado
	IF EXISTS(SELECT * FROM dbo.Aluguer WHERE C�digoCliente = @c�digoCliente AND FimComExtra<GetDate())
		BEGIN
			--Caso exister levanta-se um erro e acaba-se o trigger
			RAISERROR('O Cliente esta associado a um Aluguer que j� acabou, que n�o pode ser removido, dai Cliente tamb�m n�o pode ser removido',16,1)
			RETURN
		END
	DELETE FROM Version01.Cliente WHERE C�digo = @c�digoCliente;
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

	--Verifca se existe um Aluguer associado ao Empregado que se quer remover que j� tenha acabado
	IF EXISTS(SELECT * FROM dbo.Aluguer WHERE NumeroEmpregado = @numero AND FimComExtra<GetDate())
		BEGIN
			--Caso exister levanta-se um erro e acaba-se o trigger
			RAISERROR('O Empregado esta associado a um Aluguer que j� acabou, que n�o pode ser removido, dai Empregado tamb�m n�o pode ser removido',16,1)
			RETURN
		END

	--Caso n�o exister remove-se o Empregado
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
	SELECT @codigo = C�digo FROM DELETED;

	--Verifca se existe um Aluguer associado a um EquipamentoAlugado associado ao Equipamento que se quer remover
	IF EXISTS (SELECT * FROM Aluguer WHERE FimComExtra<GetDate() AND NumeroSerie IN
		(SELECT NumeroSerieAluguer FROM EquipamentoAlugado WHERE C�digoEquipamento = @codigo))
		BEGIN
			--Caso exister levanta-se um erro e acaba-se o trigger
			RAISERROR('O Equipamento esta associado a um Aluguer que j� acabou, que n�o pode ser removido, dai Equipamento tamb�m n�o pode ser removido',16,1)
			ROLLBACK
			RETURN
		END

	RETURN;
GO
