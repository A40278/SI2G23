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
CREATE TRIGGER Verificar_Datas_de_Preço
ON dbo.Preço
INSTEAD OF
INSERT, UPDATE
AS
	SET NOCOUNT ON;
	DECLARE @inicio DATETIME, @fim DATETIME, @codigo INTEGER, @tipoDuração VARCHAR(2), @valor DECIMAL(10,2);
	SELECT @inicio = Inicio, @fim = Fim, @codigo = CódigoEquipamento, @tipoDuração = TipoDuração, @valor = Valor FROM INSERTED;

	DECLARE @count INTEGER;
	EXEC @count = Numero_de_Preços_No_Periodo @inicio, @fim, @tipoDuração, @codigo
	IF ( @count > 0)
		BEGIN
			RAISERROR('Não se pode introduzir um preço com a validade dada, ja existindo um preço na mesma situção para o periodo fornecido'
			,16,1);
			RETURN;
		END
	IF EXISTS(SELECT * FROM DELETED)
		BEGIN
			DECLARE @inicioAntigo DATETIME, @codigoAntigo INTEGER, @tipoDuraçãoAntigo VARCHAR(2);
			SELECT @inicioAntigo = Inicio, @codigoAntigo = CódigoEquipamento, @tipoDuraçãoAntigo = TipoDuração FROM DELETED
			UPDATE Version01.Preço
			SET Inicio = @inicio, Fim = @fim, TipoDuração = @tipoDuração, Valor = @valor, CódigoEquipamento = @codigo
			WHERE CódigoEquipamento = @codigoAntigo AND Inicio = @inicioAntigo AND TipoDuração = @tipoDuraçãoAntigo;
			RETURN;
		END
	INSERT INTO Version01.Preço(CódigoEquipamento,Inicio,Fim,Valor,TipoDuração) VALUES (@codigo, @inicio, @fim, @valor, @tipoDuração);
	RETURN
GO

GO
CREATE TRIGGER Promoção_para_Desconto
ON dbo.Desconto
INSTEAD OF
INSERT, UPDATE
AS
	SET NOCOUNT ON
	IF EXISTS( SELECT * FROM TempoExtra WHERE NumeroIdentificadorPromoção = (SELECT NumeroIdentificadorPromoção FROM INSERTED))
		BEGIN
			RAISERROR('Já existe um tempo extra com NumeroIdentificadorPromoção fornecido'
			,16,1)
			RETURN
		END
	DECLARE @numeroId INT, @valor DECIMAL(10,2);
	SELECT @numeroId = NumeroIdentificadorPromoção, @valor = Valor FROM INSERTED;
	IF EXISTS(SELECT * FROM DELETED)
		BEGIN
			DECLARE @numeroIdAntigo INT;
			SELECT @numeroIdAntigo = NumeroIdentificadorPromoção FROM DELETED
			UPDATE Version01.Desconto SET  NumeroIdentificadorPromoção = @numeroId, Valor = @valor WHERE NumeroIdentificadorPromoção = @numeroIdAntigo;
			RETURN;
		END
	INSERT INTO Version01.Desconto(NumeroIdentificadorPromoção,Valor) VALUES (@numeroId, @valor);
	RETURN
GO

GO
CREATE TRIGGER Promoção_para_TempoExtra
ON dbo.TempoExtra
INSTEAD OF
INSERT, UPDATE
AS
	SET NOCOUNT ON
	IF EXISTS( SELECT * FROM Desconto WHERE NumeroIdentificadorPromoção = (SELECT NumeroIdentificadorPromoção FROM INSERTED))
		BEGIN
			RAISERROR('Já existe um tempo extra com NumeroIdentificadorPromoção fornecido'
			,16,1)
			RETURN
		END
	DECLARE @numeroId INT, @fracçãoExtra DECIMAL(10,2), @tipoDuração VARCHAR(2);
	SELECT @numeroId = NumeroIdentificadorPromoção, @fracçãoExtra = FracçãoExtra, @tipoDuração = TipoDuração FROM INSERTED;
	IF EXISTS(SELECT * FROM DELETED)
		BEGIN
			DECLARE @numeroIdAntigo INT;
			SELECT @numeroIdAntigo = NumeroIdentificadorPromoção FROM DELETED
			UPDATE Version01.TempoExtra SET  NumeroIdentificadorPromoção = @numeroId, FracçãoExtra = @fracçãoExtra, TipoDuração = @tipoDuração
				WHERE NumeroIdentificadorPromoção = @numeroIdAntigo;
			RETURN;
		END
	INSERT INTO dbo.TempoExtra (NumeroIdentificadorPromoção, FracçãoExtra, TipoDuração) VALUES (@numeroId,@fracçãoExtra,@tipoDuração);
	RETURN
GO