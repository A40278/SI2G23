USE Base_Dados_SI2_1617SI_23;

IF OBJECT_ID(N'Version01.Promoção_para_TempoExtra') IS NOT NULL
	DROP TRIGGER Version01.Promoção_para_TempoExtra;
IF OBJECT_ID(N'Version01.Promoção_para_Desconto') IS NOT NULL
	DROP TRIGGER Version01.Promoção_para_Desconto;
IF OBJECT_ID(N'Version01.Verificar_Datas_de_Preço') IS NOT NULL
	DROP TRIGGER Version01.Verificar_Datas_de_Preço;

IF OBJECT_ID(N'Promoção_para_TempoExtra') IS NOT NULL
	DROP TRIGGER Promoção_para_TempoExtra;
IF OBJECT_ID(N'Promoção_para_Desconto') IS NOT NULL
	DROP TRIGGER Promoção_para_Desconto;
IF OBJECT_ID(N'Verificar_Datas_de_Preço') IS NOT NULL
	DROP TRIGGER Verificar_Datas_de_Preço;

GO
--Garante que não podem existir 2 Preços para o mesmo Equipamento no mesmo perido e mesmo TipoDuração
CREATE TRIGGER Verificar_Datas_de_Preço
ON dbo.Preço
INSTEAD OF
INSERT, UPDATE
AS
	SET NOCOUNT ON;
	--Obtém o inicio e fim do Perido em conta
	DECLARE @inicio DATETIME, @fim DATETIME, @codigo INTEGER, @tipoDuração VARCHAR(2), @valor DECIMAL(10,2);
	SELECT @inicio = Inicio, @fim = Fim, @codigo = CódigoEquipamento, @tipoDuração = TipoDuração, @valor = Valor FROM INSERTED;

	--Obtém o numero de Preços existentes do Equipamento desejado, no perido e com o TipoDuração desejado
	DECLARE @count INTEGER;
	EXEC @count = Numero_de_Preços_No_Periodo @inicio, @fim, @tipoDuração, @codigo
	IF ( @count > 0)
		BEGIN
			--Se houver mais que um Preço levanta-se um erro e acaba-se o trigger
			RAISERROR('Não se pode introduzir um preço com a validade dada, ja existindo um preço na mesma situção para o periodo fornecido'
			,16,1);
			RETURN;
		END

	IF EXISTS(SELECT * FROM DELETED)
		BEGIN
			--Caso foi um UPDATE que chamou este trigger
			DECLARE @inicioAntigo DATETIME, @codigoAntigo INTEGER, @tipoDuraçãoAntigo VARCHAR(2);
			SELECT @inicioAntigo = Inicio, @codigoAntigo = CódigoEquipamento, @tipoDuraçãoAntigo = TipoDuração FROM DELETED
			--Altera-se o valores possivies para os valores introduzidos, usando a chave primaria antes da alteração
			UPDATE Version01.Preço
				SET Inicio = @inicio, Fim = @fim, TipoDuração = @tipoDuração, Valor = @valor, CódigoEquipamento = @codigo
				WHERE CódigoEquipamento = @codigoAntigo AND Inicio = @inicioAntigo AND TipoDuração = @tipoDuraçãoAntigo;
			RETURN;
		END

	--Caso foi um INSERT que chamou este trigger
	--Então introduz-se os novos valores
	INSERT INTO Version01.Preço(CódigoEquipamento,Inicio,Fim,Valor,TipoDuração) VALUES (@codigo, @inicio, @fim, @valor, @tipoDuração);
	RETURN
GO

GO
--Verifca se a Promoção associada ao Desconto que se quer introduzir ou alterar, não encontra-se já associado a um TempoExtra
CREATE TRIGGER Promoção_para_Desconto
ON dbo.Desconto
INSTEAD OF
INSERT, UPDATE
AS
	SET NOCOUNT ON
	--Verifca se a Promoção associada ao Desconto que se quer introduzir ou alterar, não encontra-se já associado a um TempoExtra
	IF EXISTS( SELECT * FROM TempoExtra WHERE NumeroIdentificadorPromoção = (SELECT NumeroIdentificadorPromoção FROM INSERTED))
		BEGIN
			--Caso tal aconteçer levanta-se um erro e termina-se o trigger
			RAISERROR('Já existe um tempo extra com NumeroIdentificadorPromoção fornecido'
			,16,1)
			RETURN
		END
	DECLARE @numeroId INT, @valor DECIMAL(10,2);
	SELECT @numeroId = NumeroIdentificadorPromoção, @valor = Valor FROM INSERTED;
	IF EXISTS(SELECT * FROM DELETED)
		BEGIN
			--Caso foi um UPDATE que chamou este trigger
			DECLARE @numeroIdAntigo INT;
			--Altera-se o valores possivies para os valores introduzidos, usando a chave primaria antes da alteração
			SELECT @numeroIdAntigo = NumeroIdentificadorPromoção FROM DELETED
			UPDATE Version01.Desconto SET  NumeroIdentificadorPromoção = @numeroId, Valor = @valor WHERE NumeroIdentificadorPromoção = @numeroIdAntigo;
			RETURN;
		END

	--Caso foi um INSERT que chamou este trigger
	--Então introduz-se os novos valores
	INSERT INTO Version01.Desconto(NumeroIdentificadorPromoção,Valor) VALUES (@numeroId, @valor);
	RETURN
GO

GO
--Verifca se a Promoção associada ao TempoExra que se quer introduzir ou alterar, não encontra-se já associado a um Desconto
CREATE TRIGGER Promoção_para_TempoExtra
ON dbo.TempoExtra
INSTEAD OF
INSERT, UPDATE
AS
	SET NOCOUNT ON
	--Verifca se a Promoção associada ao TempoExra que se quer introduzir ou alterar, não encontra-se já associado a um Desconto
	IF EXISTS( SELECT * FROM Desconto WHERE NumeroIdentificadorPromoção = (SELECT NumeroIdentificadorPromoção FROM INSERTED))
		BEGIN
			--Caso tal aconteçer levanta-se um erro e termina-se o trigger
			RAISERROR('Já existe um tempo extra com NumeroIdentificadorPromoção fornecido'
			,16,1)
			RETURN
		END
	DECLARE @numeroId INT, @fracçãoExtra DECIMAL(10,2), @tipoDuração VARCHAR(2);
	SELECT @numeroId = NumeroIdentificadorPromoção, @fracçãoExtra = FracçãoExtra, @tipoDuração = TipoDuração FROM INSERTED;
	IF EXISTS(SELECT * FROM DELETED)
		BEGIN
			--Caso foi um UPDATE que chamou este trigger
			DECLARE @numeroIdAntigo INT;
			SELECT @numeroIdAntigo = NumeroIdentificadorPromoção FROM DELETED
			--Altera-se o valores possivies para os valores introduzidos, usando a chave primaria antes da alteração
			UPDATE Version01.TempoExtra SET  NumeroIdentificadorPromoção = @numeroId, FracçãoExtra = @fracçãoExtra, TipoDuração = @tipoDuração
				WHERE NumeroIdentificadorPromoção = @numeroIdAntigo;
			RETURN;
		END

	--Caso foi um INSERT que chamou este trigger
	--Então introduz-se os novos valores
	INSERT INTO dbo.TempoExtra (NumeroIdentificadorPromoção, FracçãoExtra, TipoDuração) VALUES (@numeroId,@fracçãoExtra,@tipoDuração);
	RETURN
GO