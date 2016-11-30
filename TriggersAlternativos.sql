USE Base_Dados_SI2_1617SI_23;

IF OBJECT_ID(N'Version01.Promo��o_para_TempoExtra') IS NOT NULL
	DROP TRIGGER Version01.Promo��o_para_TempoExtra;
IF OBJECT_ID(N'Version01.Promo��o_para_Desconto') IS NOT NULL
	DROP TRIGGER Version01.Promo��o_para_Desconto;
IF OBJECT_ID(N'Version01.Verificar_Datas_de_Pre�o') IS NOT NULL
	DROP TRIGGER Version01.Verificar_Datas_de_Pre�o;

IF OBJECT_ID(N'Promo��o_para_TempoExtra') IS NOT NULL
	DROP TRIGGER Promo��o_para_TempoExtra;
IF OBJECT_ID(N'Promo��o_para_Desconto') IS NOT NULL
	DROP TRIGGER Promo��o_para_Desconto;
IF OBJECT_ID(N'Verificar_Datas_de_Pre�o') IS NOT NULL
	DROP TRIGGER Verificar_Datas_de_Pre�o;

GO
CREATE TRIGGER Verificar_Datas_de_Pre�o
ON dbo.Pre�o
INSTEAD OF
INSERT, UPDATE
AS
	SET NOCOUNT ON;
	DECLARE @inicio DATETIME, @fim DATETIME, @codigo INTEGER, @tipoDura��o VARCHAR(2), @valor DECIMAL(10,2);
	SELECT @inicio = Inicio, @fim = Fim, @codigo = C�digoEquipamento, @tipoDura��o = TipoDura��o, @valor = Valor FROM INSERTED;

	DECLARE @count INTEGER;
	EXEC @count = Numero_de_Pre�os_No_Periodo @inicio, @fim, @tipoDura��o, @codigo
	IF ( @count > 0)
		BEGIN
			RAISERROR('N�o se pode introduzir um pre�o com a validade dada, ja existindo um pre�o na mesma situ��o para o periodo fornecido'
			,16,1);
			RETURN;
		END
	IF EXISTS(SELECT * FROM DELETED)
		BEGIN
			DECLARE @inicioAntigo DATETIME, @codigoAntigo INTEGER, @tipoDura��oAntigo VARCHAR(2);
			SELECT @inicioAntigo = Inicio, @codigoAntigo = C�digoEquipamento, @tipoDura��oAntigo = TipoDura��o FROM DELETED
			UPDATE Version01.Pre�o
			SET Inicio = @inicio, Fim = @fim, TipoDura��o = @tipoDura��o, Valor = @valor, C�digoEquipamento = @codigo
			WHERE C�digoEquipamento = @codigoAntigo AND Inicio = @inicioAntigo AND TipoDura��o = @tipoDura��oAntigo;
			RETURN;
		END
	INSERT INTO Version01.Pre�o(C�digoEquipamento,Inicio,Fim,Valor,TipoDura��o) VALUES (@codigo, @inicio, @fim, @valor, @tipoDura��o);
	RETURN
GO

GO
CREATE TRIGGER Promo��o_para_Desconto
ON dbo.Desconto
INSTEAD OF
INSERT, UPDATE
AS
	SET NOCOUNT ON
	IF EXISTS( SELECT * FROM TempoExtra WHERE NumeroIdentificadorPromo��o = (SELECT NumeroIdentificadorPromo��o FROM INSERTED))
		BEGIN
			RAISERROR('J� existe um tempo extra com NumeroIdentificadorPromo��o fornecido'
			,16,1)
			RETURN
		END
	DECLARE @numeroId INT, @valor DECIMAL(10,2);
	SELECT @numeroId = NumeroIdentificadorPromo��o, @valor = Valor FROM INSERTED;
	IF EXISTS(SELECT * FROM DELETED)
		BEGIN
			DECLARE @numeroIdAntigo INT;
			SELECT @numeroIdAntigo = NumeroIdentificadorPromo��o FROM DELETED
			UPDATE Version01.Desconto SET  NumeroIdentificadorPromo��o = @numeroId, Valor = @valor WHERE NumeroIdentificadorPromo��o = @numeroIdAntigo;
			RETURN;
		END
	INSERT INTO Version01.Desconto(NumeroIdentificadorPromo��o,Valor) VALUES (@numeroId, @valor);
	RETURN
GO

GO
CREATE TRIGGER Promo��o_para_TempoExtra
ON dbo.TempoExtra
INSTEAD OF
INSERT, UPDATE
AS
	SET NOCOUNT ON
	IF EXISTS( SELECT * FROM Desconto WHERE NumeroIdentificadorPromo��o = (SELECT NumeroIdentificadorPromo��o FROM INSERTED))
		BEGIN
			RAISERROR('J� existe um tempo extra com NumeroIdentificadorPromo��o fornecido'
			,16,1)
			RETURN
		END
	DECLARE @numeroId INT, @frac��oExtra DECIMAL(10,2), @tipoDura��o VARCHAR(2);
	SELECT @numeroId = NumeroIdentificadorPromo��o, @frac��oExtra = Frac��oExtra, @tipoDura��o = TipoDura��o FROM INSERTED;
	IF EXISTS(SELECT * FROM DELETED)
		BEGIN
			DECLARE @numeroIdAntigo INT;
			SELECT @numeroIdAntigo = NumeroIdentificadorPromo��o FROM DELETED
			UPDATE Version01.TempoExtra SET  NumeroIdentificadorPromo��o = @numeroId, Frac��oExtra = @frac��oExtra, TipoDura��o = @tipoDura��o
				WHERE NumeroIdentificadorPromo��o = @numeroIdAntigo;
			RETURN;
		END
	INSERT INTO dbo.TempoExtra (NumeroIdentificadorPromo��o, Frac��oExtra, TipoDura��o) VALUES (@numeroId,@frac��oExtra,@tipoDura��o);
	RETURN
GO