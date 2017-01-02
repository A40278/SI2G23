GO
IF DB_ID ('Base_Dados_SI2_1617SI_23') IS NOT NULL
	BEGIN
	USE Base_Dados_SI2_1617SI_23;
	IF OBJECT_ID(N'Numero_de_Pre�os_No_Periodo') IS NOT NULL
		DROP PROC Numero_de_Pre�os_No_Periodo;
	IF OBJECT_ID(N'Fracoes_Tempo_Extra') IS NOT NULL
		DROP PROC Fracoes_Tempo_Extra;
	IF OBJECT_ID(N'Factor_Tipo_Dura��o') IS NOT NULL
		DROP PROC Factor_Tipo_Dura��o;
	IF OBJECT_ID(N'Verificar_Equipamento_Alugado_No_Periodo') IS NOT NULL
		DROP PROC Verificar_Equipamento_Alugado_No_Periodo;
	IF OBJECT_ID(N'Equipamento_Alugado_Pre�o') IS NOT NULL
		DROP PROC Equipamento_Alugado_Pre�o;
	IF OBJECT_ID(N'Equipamento_Alugado_Desconto') IS NOT NULL
		DROP PROC Equipamento_Alugado_Desconto;
	IF OBJECT_ID(N'Calculo_Pre�o') IS NOT NULL
		DROP PROC Calculo_Pre�o;
	IF OBJECT_ID(N'Calcular_Pre�o_De_Aluguer') IS NOT NULL
		DROP PROC Calcular_Pre�o_De_Aluguer;
	IF OBJECT_ID(N'Calcular_Pre�o_De_Aluguer_Sem_Desconto') IS NOT NULL
		DROP PROC Calcular_Pre�o_De_Aluguer_Sem_Desconto;
	IF OBJECT_ID(N'Inserir_Desconto') IS NOT NULL
		DROP PROC Inserir_Desconto;
	IF OBJECT_ID(N'Inserir_TempoExtra') IS NOT NULL
		DROP PROC Inserir_TempoExtra;
	IF OBJECT_ID(N'Inserir_Desconto_Com_Tipo') IS NOT NULL
		DROP PROC Inserir_Desconto_Com_Tipo;
	IF OBJECT_ID(N'Alterar_Desconto') IS NOT NULL
		DROP PROC Alterar_Desconto;
	IF OBJECT_ID(N'Obter_Aluguers_Datas') IS NOT NULL
		DROP PROC Obter_Aluguers_Datas;

	IF OBJECT_ID(N'Inserir_Aluguer_e_Cliente') IS NOT NULL
		DROP PROC Inserir_Aluguer_e_Cliente;
	IF OBJECT_ID(N'Listar_Equipamentos_Disponiveis_Periodo_Tipo') IS NOT NULL
		DROP PROC Listar_Equipamentos_Disponiveis_Periodo_Tipo;
	IF OBJECT_ID(N'Listar_Equipamentos_Disponiveis_Ultima_Semana') IS NOT NULL
		DROP PROC Listar_Equipamentos_Disponiveis_Ultima_Semana;
	


	IF OBJECT_ID(N'Version01.Promo��o_para_TempoExtra') IS NOT NULL
		DROP TRIGGER Version01.Promo��o_para_TempoExtra;
	IF OBJECT_ID(N'Version01.Promo��o_para_Desconto') IS NOT NULL
		DROP TRIGGER Version01.Promo��o_para_Desconto;
	IF OBJECT_ID(N'Version01.Verificar_Datas_de_Pre�o') IS NOT NULL
		DROP TRIGGER Version01.Verificar_Datas_de_Pre�o;
	IF OBJECT_ID(N'Version01.Adicionar_Pre�o') IS NOT NULL
		DROP TRIGGER Version01.Adicionar_Pre�o;
	IF OBJECT_ID(N'Version01.Adicionar_Aluguer') IS NOT NULL
		DROP TRIGGER Version01.Adicionar_Aluguer;
	IF OBJECT_ID(N'Version01.Adicionar_Equipamento_Aluguer') IS NOT NULL
		DROP TRIGGER Version01.Adicionar_Equipamento_Aluguer;
	IF OBJECT_ID(N'Version01.Remover_Aluguer') IS NOT NULL
		DROP TRIGGER Version01.Remover_Aluguer;
	IF OBJECT_ID(N'Version01.Remover_Cliente') IS NOT NULL
		DROP TRIGGER Version01.Remover_Cliente;
	IF OBJECT_ID(N'Version01.Remover_Empregado') IS NOT NULL
		DROP TRIGGER Version01.Remover_Empregado;
	IF OBJECT_ID(N'Version01.Alterar_Aluguer') IS NOT NULL
		DROP TRIGGER Version01.Alterar_Aluguer;
	IF OBJECT_ID(N'Version01.Remover_EquipamentoAlugado') IS NOT NULL
		DROP TRIGGER Version01.Remover_EquipamentoAlugado;
	IF OBJECT_ID(N'Version01.Remover_Equipamentp') IS NOT NULL
		DROP TRIGGER Version01.Remover_Equipamentp;

	IF OBJECT_ID(N'Version01.Pre�o') IS NOT NULL
		DROP TABLE Version01.Pre�o;
	IF OBJECT_ID(N'Version01.EquipamentoAlugado_Desconto') IS NOT NULL
		DROP TABLE Version01.EquipamentoAlugado_Desconto;
	IF OBJECT_ID(N'Version01.EquipamentoAlugado') IS NOT NULL
		DROP TABLE Version01.EquipamentoAlugado;
	IF OBJECT_ID(N'Version01.Equipamento') IS NOT NULL
		DROP TABLE Version01.Equipamento;
	IF OBJECT_ID(N'Version01.Tipo_Desconto') IS NOT NULL
		DROP TABLE Version01.Tipo_Desconto;
	IF OBJECT_ID(N'Version01.Tipo') IS NOT NULL
		DROP TABLE Version01.Tipo;
	IF OBJECT_ID(N'Version01.Desconto') IS NOT NULL
		DROP TABLE Version01.Desconto;
	IF OBJECT_ID(N'Version01.TempoExtra') IS NOT NULL
		DROP TABLE Version01.TempoExtra;
	IF OBJECT_ID(N'Version01.Aluguer') IS NOT NULL
		DROP TABLE Version01.Aluguer;
	IF OBJECT_ID(N'Version01.Cliente') IS NOT NULL
		DROP TABLE Version01.Cliente;
	IF OBJECT_ID(N'Version01.Empregado') IS NOT NULL
		DROP TABLE Version01.Empregado;
	IF OBJECT_ID(N'Version01.Promo��o') IS NOT NULL
		DROP TABLE Version01.Promo��o;

	IF OBJECT_ID(N'dbo.Pre�o') IS NOT NULL
		DROP VIEW dbo.Pre�o;
	IF OBJECT_ID(N'dbo.EquipamentoAlugado_Desconto') IS NOT NULL
		DROP VIEW dbo.EquipamentoAlugado_Desconto;
	IF OBJECT_ID(N'dbo.EquipamentoAlugado') IS NOT NULL
		DROP VIEW dbo.EquipamentoAlugado;
	IF OBJECT_ID(N'dbo.Equipamento') IS NOT NULL
		DROP VIEW dbo.Equipamento;
	IF OBJECT_ID(N'dbo.Tipo_Desconto') IS NOT NULL
		DROP VIEW dbo.Tipo_Desconto;
	IF OBJECT_ID(N'dbo.Tipo') IS NOT NULL
		DROP VIEW dbo.Tipo;
	IF OBJECT_ID(N'dbo.Desconto') IS NOT NULL
		DROP VIEW dbo.Desconto;
	IF OBJECT_ID(N'dbo.TempoExtra') IS NOT NULL
		DROP VIEW dbo.TempoExtra;
	IF OBJECT_ID(N'dbo.Aluguer') IS NOT NULL
		DROP VIEW dbo.Aluguer;
	IF OBJECT_ID(N'dbo.Cliente') IS NOT NULL
		DROP VIEW dbo.Cliente;
	IF OBJECT_ID(N'dbo.Empregado') IS NOT NULL
		DROP VIEW dbo.Empregado;
	IF OBJECT_ID(N'dbo.Promo��o') IS NOT NULL
		DROP VIEW dbo.Promo��o;
	IF OBJECT_ID ('Version01') IS NOT NULL
		DROP SCHEMA Version01;
	END
GO