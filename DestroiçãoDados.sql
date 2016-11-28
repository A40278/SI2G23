GO
IF DB_ID ('Base_Dados_SI2_1617SI_23') IS NOT NULL
	BEGIN
	USE Base_Dados_SI2_1617SI_23;
	IF OBJECT_ID(N'Version01.Preço') IS NOT NULL
		DELETE FROM Version01.Preço;
	IF OBJECT_ID(N'Version01.EquipamentoAlugado') IS NOT NULL
		DELETE FROM Version01.EquipamentoAlugado;
	IF OBJECT_ID(N'Version01.Equipamento') IS NOT NULL
		DELETE FROM Version01.Equipamento;
	IF OBJECT_ID(N'Version01.Tipo_Desconto') IS NOT NULL
		DELETE FROM Version01.Tipo_Desconto;
	IF OBJECT_ID(N'Version01.Tipo') IS NOT NULL
		DELETE FROM Version01.Tipo;
	IF OBJECT_ID(N'Version01.Desconto') IS NOT NULL
		DELETE FROM Version01.Desconto;
	IF OBJECT_ID(N'Version01.TempoExtra') IS NOT NULL
		DELETE FROM Version01.TempoExtra;
	IF OBJECT_ID(N'Version01.Aluguer') IS NOT NULL
		DELETE FROM Version01.Aluguer;
	IF OBJECT_ID(N'Version01.Cliente') IS NOT NULL
		DELETE FROM Version01.Cliente;
	IF OBJECT_ID(N'Version01.Empregado') IS NOT NULL
		DELETE FROM Version01.Empregado;
	IF OBJECT_ID(N'Version01.Promoção') IS NOT NULL
		DELETE FROM Version01.Promoção;
	END
GO