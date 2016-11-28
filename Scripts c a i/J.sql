BEGIN TRAN
	DECLARE @equipamento1 INT, @equipamento2 INT, @equipamento3 INT, @equipamento4 INT, @equipamento5 INT;    
	DECLARE @client INT, @empregado INT;
	DECLARE @aluguer1 INT, @aluguer2 INT, @aluguer3 INT, @aluguer4 INT, @aluguer5 INT;    

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
	INSERT INTO dbo.Equipamento(Descri��o, NomeTipo) VALUES ('quinta canoa','Canoa Grande')

	SET @equipamento5 = @@IDENTITY
	SET @equipamento4 = @equipamento5 - 1
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

	INSERT INTO dbo.Pre�o (C�digoEquipamento, Inicio, Fim, TipoDura��o, Valor) VALUES(@equipamento5, @pre�oInicio, @pre�oFim,
'd',20.00)
	--Introduzir os Pre�os para os Equipamentos--

	DECLARE @inicioA DATETIME, @fimA DATETIME, @inicioB DATETIME, @fimB DATETIME;
	SET @inicioA =  DATEADD(d,-20,@now);
	SET @fimA =  DATEADD(d,9,@now);
	SET @inicioB =  DATEADD(d,1,@fimA);
	SET @fimB =  DATEADD(d,30,@now);

	--Introduzir os Alugueres para ocuparem certos Equipamnetos em certos periodos--
	INSERT INTO dbo.Aluguer(TipoDura��o, Inicio, Fim, C�digoCliente, NumeroEmpregado) VALUES ('d',@inicioA,  DATEADD(d,-10,@now),
@client, @empregado)

	INSERT INTO dbo.Aluguer(TipoDura��o, Inicio, Fim, C�digoCliente, NumeroEmpregado) VALUES ('d',  DATEADD(d,-10,@now),  @now,
@client, @empregado)

	INSERT INTO dbo.Aluguer(TipoDura��o, Inicio, Fim, C�digoCliente, NumeroEmpregado) VALUES ('d', @now, @fimA,
@client, @empregado)

	INSERT INTO dbo.Aluguer(TipoDura��o, Inicio, Fim, C�digoCliente, NumeroEmpregado) VALUES ('d', @inicioB, DATEADD(d,20,@now),
@client, @empregado)

	INSERT INTO dbo.Aluguer(TipoDura��o, Inicio, Fim, C�digoCliente, NumeroEmpregado) VALUES ('d', DATEADD(d,20,@now), @fimB,
@client, @empregado)
	
	SET @aluguer5 = @@IDENTITY
	SET @aluguer4 = @aluguer5 - 1
	SET @aluguer3 = @aluguer4 - 1
	SET @aluguer2 = @aluguer3 - 1
	SET @aluguer1 = @aluguer2 - 1
	--Introduzir os Alugueres para ocuparem certos Equipamnetos em certos periodos--

	--Introduzir os EquipamentoAlugado ocuparar certos Equipamnetos em certos periodos--
	INSERT INTO dbo.EquipamentoAlugado(NumeroSerieAluguer,C�digoEquipamento) VALUES (@aluguer1,@equipamento1)
	INSERT INTO dbo.EquipamentoAlugado(NumeroSerieAluguer,C�digoEquipamento) VALUES (@aluguer2,@equipamento2)
	INSERT INTO dbo.EquipamentoAlugado(NumeroSerieAluguer,C�digoEquipamento) VALUES (@aluguer3,@equipamento3)
	INSERT INTO dbo.EquipamentoAlugado(NumeroSerieAluguer,C�digoEquipamento) VALUES (@aluguer4,@equipamento4)
	INSERT INTO dbo.EquipamentoAlugado(NumeroSerieAluguer,C�digoEquipamento) VALUES (@aluguer5,@equipamento5)
	--Introduzir os EquipamentoAlugado ocuparar certos Equipamnetos em certos periodos--

	--O quatro e quinto Equipamentos est�o livres neste periodo--
	EXEC Listar_Equipamentos_Disponiveis_Periodo_Tipo
	@inicioA,  @fimA, 'Canoa Grande'
	--O quatro e quinto Equipamentos est�o livres neste periodo--

	--O primeiro, segundo e terceiro Equipamentos est�o livres neste periodo--
	EXEC Listar_Equipamentos_Disponiveis_Periodo_Tipo
	@inicioB, @fimB, 'Canoa Grande'
	--O primeiro, segundo e terceiro Equipamentos est�o livres neste periodo--

	--O primeiro, segunda e quinto Equipamentos est�o livres neste periodo--
	EXEC Listar_Equipamentos_Disponiveis_Periodo_Tipo
	@fimA, @inicioB, 'Canoa Grande'
	--O primeiro, segunda e quinto Equipamentos est�o livres neste periodo--

ROLLBACK TRAN