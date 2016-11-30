BEGIN TRAN
	SET NOCOUNT ON;

	DECLARE @equipamento1 INT, @equipamento2 INT, @equipamento3 INT;    
	DECLARE @client INT, @empregado INT;
	DECLARE @aluguer1 INT, @aluguer2 INT, @aluguer3 INT;    

	--Declarar as varaivies tempo em fun��o do momento em que o script corre--
	DECLARE @now DATETIME, @inicio DATETIME, @fim DATETIME;
	SET @now = GETDATE();
	SET @inicio = DATEADD(m,-1,@now);
	SET @fim = DATEADD(m,1,@now);
	--Declarar as varaivies tempo em fun��o do momento em que o script corre--

	--Faz que o segundo Aluguer ainda n�o tenha acabado--
	EXEC Inserir_TempoExtra 'Segundo Tempo Extra Teste', @inicio, @fim, 3, 'h'
	--Faz que o segundo Aluguer ainda n�o tenha acabado--

	--Introduzir o Tipo para os Equipamentos--
	INSERT INTO dbo.Tipo(Nome, Descri��o) VALUES('Canoa Grande','canoa grande')
	--Introduzir o Tipo para os Equipamentos--

	--Introduzir os Equipamentos--
	INSERT INTO dbo.Equipamento(Descri��o, NomeTipo) VALUES ('primeira canoa','Canoa Grande')
	INSERT INTO dbo.Equipamento(Descri��o, NomeTipo) VALUES ('segunda canoa','Canoa Grande')
	INSERT INTO dbo.Equipamento(Descri��o, NomeTipo) VALUES ('terceira canoa','Canoa Grande')

	SET @equipamento3 = @@IDENTITY
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
	INSERT INTO dbo.Pre�o (C�digoEquipamento, Inicio, Fim, TipoDura��o, Valor) VALUES(@equipamento1, @inicio, @fim,
'h',20.00)
	INSERT INTO dbo.Pre�o (C�digoEquipamento, Inicio, Fim, TipoDura��o, Valor) VALUES(@equipamento2, @inicio, @fim,
'h',20.00)
	INSERT INTO dbo.Pre�o (C�digoEquipamento, Inicio, Fim, TipoDura��o, Valor) VALUES(@equipamento3, @inicio, @fim,
'h',20.00)
	--Introduzir os Pre�os para os Equipamentos--

	--Introduzir os Alugueres para ocuparem certos Equipamnetos em certos periodos--
	INSERT INTO dbo.Aluguer(TipoDura��o, Inicio, Fim, C�digoCliente, NumeroEmpregado) VALUES ('h', DATEADD(hh,-2,@now), DATEADD(hh,2,@now),
@client, @empregado)

	INSERT INTO dbo.Aluguer(TipoDura��o, Inicio, Fim, C�digoCliente, NumeroEmpregado) VALUES ('h', DATEADD(hh,-3,@now),  DATEADD(hh,-1,@now),
@client, @empregado)

	INSERT INTO dbo.Aluguer(TipoDura��o, Inicio, Fim, C�digoCliente, NumeroEmpregado) VALUES ('h', DATEADD(hh,1,@now), DATEADD(hh,2,@now),
@client, @empregado)

	SET @aluguer3 = @@IDENTITY
	SET @aluguer2 = @aluguer3 - 1
	SET @aluguer1 = @aluguer2 - 1
	--Introduzir os Alugueres para ocuparem certos Equipamnetos em certos periodos--
	
	--Introduzir os EquipamentoAlugado ocuparar certos Equipamnetos em certos periodos--
	INSERT INTO dbo.EquipamentoAlugado(NumeroSerieAluguer,C�digoEquipamento) VALUES (@aluguer1,@equipamento1)
	INSERT INTO dbo.EquipamentoAlugado(NumeroSerieAluguer,C�digoEquipamento) VALUES (@aluguer2,@equipamento2)
	INSERT INTO dbo.EquipamentoAlugado(NumeroSerieAluguer,C�digoEquipamento) VALUES (@aluguer3,@equipamento3)
	--Introduzir os EquipamentoAlugado ocuparar certos Equipamnetos em certos periodos--

	--S� o terceiro equipamento esta livre--
	EXEC Listar_Equipamentos_Disponiveis_Ultima_Semana
	--S� o terceiro equipamento esta livre--
ROLLBACK TRAN