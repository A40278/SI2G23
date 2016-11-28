BEGIN TRAN
	SET NOCOUNT ON;

	DECLARE @equipamento1 INT, @equipamento2 INT, @equipamento3 INT, @equipamento4 INT, @equipamento5 INT, @equipamento6 INT;    
	DECLARE @client INT, @empregado INT;
	DECLARE @aluguer1 INT, @aluguer2 INT, @aluguer3 INT, @aluguer4 INT, @aluguer5 INT, @aluguer6 INT;    

	--Declarar as varaivies tempo em fun��o do momento em que o script corre--
	DECLARE @now DATETIME, @pre�oInicio DATETIME, @pre�oFim DATETIME;
	SET @now = GETDATE();
	SET @pre�oInicio = DATEADD(m,-1,@now);
	SET @pre�oFim = DATEADD(m,1,@now);
	--Declarar as varaivies tempo em fun��o do momento em que o script corre--

	--Introduzir o Tipo para os Equipamentos--
	INSERT INTO dbo.Tipo(Nome, Descri��o) VALUES('Canoa Grande','canoa grande')
	--Introduzir o Tipo para os Equipamentos--

	--Introduzir os Equipamentos--
	INSERT INTO dbo.Equipamento(Descri��o, NomeTipo) VALUES ('primeira canoa','Canoa Grande')
	INSERT INTO dbo.Equipamento(Descri��o, NomeTipo) VALUES ('segunda canoa','Canoa Grande')
	INSERT INTO dbo.Equipamento(Descri��o, NomeTipo) VALUES ('terceira canoa','Canoa Grande')
	INSERT INTO dbo.Equipamento(Descri��o, NomeTipo) VALUES ('quarta canoa','Canoa Grande')

	SET @equipamento4 = @@IDENTITY
	SET @equipamento3 = @equipamento4 - 1
	SET @equipamento2 = @equipamento3 - 1
	SET @equipamento1 = @equipamento2 - 1
	--Introduzir os Equipamentos--

	--Introduzir o Cliente para os Aluguers que alguam os Equipamentos--
	INSERT INTO dbo.Cliente(Nome, NumeroFiscal, Morada) VALUES ('Rui Arvore', 875693220, 'Rua Lua Minha 57')
	SET @client = @@IDENTITY
	--Introduzir o Cliente para os Aluguers que alguam os Equipamentos--

	--Introduzir o Empregado para os Aluguers que alguam os Equipamentos--
	INSERT INTO dbo.Empregado(Nome) VALUES ('Gon�alo Palha')
	SET @empregado = @@IDENTITY
	--Introduzir o Empregado para os Aluguers que alguam os Equipamentos--

	--Introduzir os Pre�os para os Equipamentos--
	INSERT INTO dbo.Pre�o (C�digoEquipamento, Inicio, Fim, TipoDura��o, Valor) VALUES(@equipamento1, @pre�oInicio, @pre�oFim,
'd',20.00)
	INSERT INTO dbo.Pre�o (C�digoEquipamento, Inicio, Fim, TipoDura��o, Valor) VALUES(@equipamento2, @pre�oInicio, @pre�oFim,
'd',20.00)
	INSERT INTO dbo.Pre�o (C�digoEquipamento, Inicio, Fim, TipoDura��o, Valor) VALUES(@equipamento3, @pre�oInicio, @pre�oFim,
'd',20.00)
	INSERT INTO dbo.Pre�o (C�digoEquipamento, Inicio, Fim, TipoDura��o, Valor) VALUES(@equipamento4, @pre�oInicio, @pre�oFim,
'd',20.00)
	--Introduzir os Pre�os para os Equipamentos--

	--Introduzir os Alugueres para ocuparem certos Equipamnetos em certos periodos--
	INSERT INTO dbo.Aluguer(TipoDura��o, Inicio, Fim, C�digoCliente, NumeroEmpregado) VALUES ('d', DATEADD(d,-1,@now), DATEADD(d,1,@now),
@client, @empregado)

	INSERT INTO dbo.Aluguer(TipoDura��o, Inicio, Fim, C�digoCliente, NumeroEmpregado) VALUES ('d', DATEADD(d,-3,@now),  DATEADD(mi,-1,@now),
@client, @empregado)

	INSERT INTO dbo.Aluguer(TipoDura��o, Inicio, Fim, C�digoCliente, NumeroEmpregado) VALUES ('d', DATEADD(mi,1,@now), DATEADD(hh,2,@now),
@client, @empregado)

	INSERT INTO dbo.Aluguer(TipoDura��o, Inicio, Fim, C�digoCliente, NumeroEmpregado) VALUES ('d', DATEADD(hh,-5,@now),  DATEADD(hh,1,@now),
@client, @empregado)

	SET @aluguer4 = @@IDENTITY
	SET @aluguer3 = @aluguer4 - 1
	SET @aluguer2 = @aluguer3 - 1
	SET @aluguer1 = @aluguer2 - 1
	--Introduzir os Alugueres para ocuparem certos Equipamnetos em certos periodos--
	
	--Introduzir os EquipamentoAlugado ocuparar certos Equipamnetos em certos periodos--
	INSERT INTO dbo.EquipamentoAlugado(NumeroSerieAluguer,C�digoEquipamento) VALUES (@aluguer1,@equipamento1)
	INSERT INTO dbo.EquipamentoAlugado(NumeroSerieAluguer,C�digoEquipamento) VALUES (@aluguer2,@equipamento2)
	INSERT INTO dbo.EquipamentoAlugado(NumeroSerieAluguer,C�digoEquipamento) VALUES (@aluguer3,@equipamento3)
	INSERT INTO dbo.EquipamentoAlugado(NumeroSerieAluguer,C�digoEquipamento) VALUES (@aluguer4,@equipamento4)
	--Introduzir os EquipamentoAlugado ocuparar certos Equipamnetos em certos periodos--

	--S� o terceiro equipamento esta livre--
	EXEC Listar_Equipamentos_Disponiveis_Ultima_Semana
	--S� o terceiro equipamento esta livre--
ROLLBACK TRAN