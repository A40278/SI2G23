GO
IF DB_ID ('Base_Dados_SI2_1617SI_23') IS NOT NULL
	BEGIN
	USE Base_Dados_SI2_1617SI_23;
	IF OBJECT_ID(N'Version01.Pre�o') IS NOT NULL
		ALTER TABLE Version01.Pre�o DROP CONSTRAINT FK_Pre�o_Equipamento;
		TRUNCATE TABLE Version01.Pre�o;
	IF OBJECT_ID(N'Version01.EquipamentoAlugado') IS NOT NULL
		ALTER TABLE Version01.EquipamentoAlugado DROP CONSTRAINT FK_EquipamentoAlugado_Equipamento;
		ALTER TABLE Version01.EquipamentoAlugado DROP CONSTRAINT FK_EquipamentoAlugado_Aluguer;
		TRUNCATE TABLE Version01.EquipamentoAlugado;
	IF OBJECT_ID(N'Version01.Equipamento') IS NOT NULL
		ALTER TABLE Version01.Equipamento DROP CONSTRAINT FK_Equipamento_Tipo;
		TRUNCATE TABLE Version01.Equipamento;
	IF OBJECT_ID(N'Version01.Tipo_Desconto') IS NOT NULL
		ALTER TABLE Version01.Tipo_Desconto DROP CONSTRAINT FK_Tipo_Desconto_Tipo;
		ALTER TABLE Version01.Tipo_Desconto DROP CONSTRAINT FK_Tipo_Desconto_Desconto;
		TRUNCATE TABLE Version01.Tipo_Desconto;
	IF OBJECT_ID(N'Version01.Tipo') IS NOT NULL
		TRUNCATE TABLE Version01.Tipo;
	IF OBJECT_ID(N'Version01.Desconto') IS NOT NULL
		ALTER TABLE Version01.Desconto DROP CONSTRAINT FK_Desconto_Promo��o;
		TRUNCATE TABLE Version01.Desconto;
	IF OBJECT_ID(N'Version01.TempoExtra') IS NOT NULL
		ALTER TABLE Version01.TempoExtra DROP CONSTRAINT FK_TempoExtra_Promo��o;
		TRUNCATE TABLE Version01.TempoExtra;
	IF OBJECT_ID(N'Version01.Aluguer') IS NOT NULL
		ALTER TABLE Version01.Aluguer DROP CONSTRAINT FK_Aluguer_Cliente;
		ALTER TABLE Version01.Aluguer DROP CONSTRAINT FK_Aluguer_Empregado;
		TRUNCATE TABLE Version01.Aluguer;
	IF OBJECT_ID(N'Version01.Cliente') IS NOT NULL
		TRUNCATE TABLE Version01.Cliente;
	IF OBJECT_ID(N'Version01.Empregado') IS NOT NULL
		TRUNCATE TABLE Version01.Empregado;
	IF OBJECT_ID(N'Version01.Promo��o') IS NOT NULL
		TRUNCATE TABLE Version01.Promo��o;

	IF OBJECT_ID(N'Version01.Pre�o') IS NOT NULL
		ALTER TABLE Version01.Pre�o ADD CONSTRAINT FK_Pre�o_Equipamento 
			FOREIGN KEY (C�digoEquipamento) REFERENCES Version01.Equipamento(C�digo) ON DELETE CASCADE;
	IF OBJECT_ID(N'Version01.EquipamentoAlugado') IS NOT NULL
		ALTER TABLE Version01.EquipamentoAlugado ADD CONSTRAINT FK_EquipamentoAlugado_Equipamento 
			FOREIGN KEY (C�digoEquipamento) REFERENCES Version01.Equipamento(C�digo) ON DELETE CASCADE;
		ALTER TABLE Version01.EquipamentoAlugado ADD CONSTRAINT FK_EquipamentoAlugado_Aluguer
			FOREIGN KEY (NumeroSerieAluguer) REFERENCES Version01.Aluguer(NumeroSerie) ON DELETE CASCADE;
	IF OBJECT_ID(N'Version01.Equipamento') IS NOT NULL
		ALTER TABLE Version01.Equipamento ADD CONSTRAINT FK_Equipamento_Tipo
			FOREIGN KEY(NomeTipo) REFERENCES Version01.Tipo(Nome) ON DELETE CASCADE
	IF OBJECT_ID(N'Version01.Tipo_Desconto') IS NOT NULL
		ALTER TABLE Version01.Tipo_Desconto ADD CONSTRAINT FK_Tipo_Desconto_Tipo 
			FOREIGN KEY(NomeTipo) REFERENCES Version01.Tipo(Nome) ON DELETE CASCADE;
		ALTER TABLE Version01.Tipo_Desconto ADD CONSTRAINT FK_Tipo_Desconto_Desconto
			FOREIGN KEY(NumeroIdentificadorDesconto) REFERENCES Version01.Desconto(NumeroIdentificadorPromo��o) ON DELETE CASCADE;
	IF OBJECT_ID(N'Version01.Desconto') IS NOT NULL
		ALTER TABLE Version01.Desconto ADD CONSTRAINT FK_Desconto_Promo��o 
			FOREIGN KEY (NumeroIdentificadorPromo��o) REFERENCES Version01.Promo��o(NumeroIdentificador) ON DELETE CASCADE;
	IF OBJECT_ID(N'Version01.TempoExtra') IS NOT NULL
		ALTER TABLE Version01.TempoExtra ADD CONSTRAINT FK_TempoExtra_Promo��o 
			FOREIGN KEY (NumeroIdentificadorPromo��o) REFERENCES Version01.Promo��o(NumeroIdentificador) ON DELETE CASCADE;
	IF OBJECT_ID(N'Version01.Aluguer') IS NOT NULL
		ALTER TABLE Version01.Aluguer ADD CONSTRAINT FK_Aluguer_Cliente 
			FOREIGN KEY (C�digoCliente) REFERENCES Version01.Cliente(C�digo) ON DELETE CASCADE;
		ALTER TABLE Version01.Aluguer ADD CONSTRAINT FK_Aluguer_Empregado 
			FOREIGN KEY (NumeroEmpregado) REFERENCES Version01.Empregado(Numero) ON DELETE CASCADE;
	END
GO