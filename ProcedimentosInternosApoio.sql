USE Base_Dados_SI2_1617SI_23

GO
--Demosntra o numero de Pre�os para um Equipamento de um certo TipoDura��o, no periodo entre @inicio e @fim
CREATE PROC Numero_de_Pre�os_No_Periodo
@inicio DATETIME = NULL, @fim DATETIME = NULL, @tipoDura��o VARCHAR(2) = NULL, @codigo INT = NULL
AS
	DECLARE @count INT;
	--Obt�m count de Pre�os  que come�a e ou acabam no periodo, do select seguinte
		--Obt�m os Pre�os dum certo TipoDura��o e com um certo C�digoEquipamento
	SELECT @count = COUNT(*) FROM(
		SELECT * FROM dbo.Pre�o WHERE TipoDura��o = @tipoDura��o AND C�digoEquipamento = @codigo)
	AS P
	WHERE (P.Inicio<@inicio AND @inicio<P.Fim) OR (P.Inicio<@fim AND @fim<P.Fim)

	RETURN @count;
GO

GO
--Obt�m todos os tempos extras que afetam um Aluguer que come�a em @inicio
CREATE PROC Fracoes_Tempo_Extra
@fim DATETIME = NULL, @inicio DATETIME = NULL, @tipoDura��o VARCHAR(2) = NULL
AS
	SET NOCOUNT ON
	DECLARE @fra�coesTempoExtra INTEGER = 0;
	--Obt�m a soma das Frac��oExtras dos TempoExtras resultantes no Inner Join, que s�o os TempoExrtas que 
	--ocorrem no periodo fornecido com o TipoDura��o tamb�m fornecido
		--Obt�m NumeroIdentificador das Promo��es que aconte�em no periodo fornecido
	--Junta em fun��o de NumeroIdentificador = NumeroIdentificadorPromo��o
		--Obt�m NumeroIdentificadorPromo��o e Frac��oExtra dos TempoExtras com o TipoDura��o fornecido
	SELECT @fra�coesTempoExtra =  COALESCE (SUM(Frac��oExtra),0) FROM(
		(SELECT NumeroIdentificador FROM dbo.Promo��o WHERE Fim>=@fim AND Inicio<=@inicio)
	AS Promo��esDisponivies
	INNER JOIN
		(SELECT NumeroIdentificadorPromo��o, Frac��oExtra FROM dbo.TempoExtra WHERE TipoDura��o=@tipoDura��o)
	AS TempoExtraDura��oCorrecta
	ON Promo��esDisponivies.NumeroIdentificador = TempoExtraDura��oCorrecta.NumeroIdentificadorPromo��o)
	PRINT(@fra�coesTempoExtra)
	RETURN @fra�coesTempoExtra
GO

GO
CREATE PROC Factor_Tipo_Dura��o
@tipoDura��o VARCHAR(2), @factor DECIMAL(10,2) = 00.00 OUTPUT
AS
	--Torna @factor no numero de minutos num certo bloco de tempo represerntado por TipoDura��o
	SELECT @factor =
	CASE @tipoDura��o
		WHEN 'mh' THEN 30.00
		WHEN 'h' THEN 60.00
		WHEN 'd' THEN 1440.00
		WHEN 's' THEN 10080.00
		ELSE 0.00
	END
GO

GO
--Devolve o numero de EquipamentoAlugados num certo periodo, represntado por inicioPeriodo e fimPeriodo
CREATE PROC Verificar_Equipamento_Alugado_No_Periodo
@inicioPeriodo DATETIME, @fimPeriodo DATETIME, @codigo INTEGER
AS
	DECLARE @count INT;
	--Torna @count no produto de COUNT nos EquipamentoAlugados com o C�digoEquipamento igual ao c�digo fornecido e que
	--aconte�em no periodo fornecido
		--Obt�m NumeroSerie dos Alugueres que come�am e ou acabam no periodo fornecido
	SELECT @count = COUNT(*) FROM EquipamentoAlugado WHERE C�digoEquipamento = @codigo AND NumeroSerieAluguer IN
		(SELECT NumeroSerie FROM Aluguer WHERE (Inicio<@inicioPeriodo AND FimComExtra>@inicioPeriodo)
			OR (Inicio<@fimPeriodo AND FimComExtra>@fimPeriodo))
	RETURN @count;
GO

GO
--Obt�m o Valor do Pre�o para um Equipamento que ocorre num certo periodo fornecido
CREATE PROC Equipamento_Alugado_Pre�o
@codigo INT, @tipoDura��o VARCHAR(2), @inicio DATETIME, @fim DATETIME, @pre�o DECIMAL(10,2) OUTPUT
AS
	--Obt�m o Valor do Pre�o para um Equipamento que ocorre num certo periodo fornecido
	SELECT @pre�o = Valor FROM dbo.Pre�o WHERE Inicio<=@inicio AND Fim>=@inicio AND TipoDura��o = @tipoDura��o AND 
		C�digoEquipamento = @codigo;

	--Caso n�o hover um Pre�o para o Equipamento desejado no period desejado ent�o devolve-se -1
	IF(@pre�o IS NULL)
		RETURN -1;

	DECLARE @blocoTemporal DECIMAL(10,2), @factor DECIMAL(10,2);
	
	--Cria @blocoTemporal que � igual ao numero de vezes que o periodo do Aluguer pode ser dividio num bloco do 
	--TipoDura��o do mesmo
	EXEC Factor_Tipo_Dura��o @tipoDura��o, @factor OUTPUT;
	SELECT @blocoTemporal = CEILING(DATEDIFF(MI,@inicio,@fim) / @factor)

	--Multiplica @pre�o por @blocoTemporal para obt�r o pre�o completo do Equipamento no Aluguer
	SET @pre�o = (@pre�o*@blocoTemporal);
GO

GO
--Obt�m a Soma dos Descontos que afetam um Equipamento no periodo do Aluguer
CREATE PROC Equipamento_Alugado_Desconto
@codigo INT, @inicio DATETIME, @decontoTotal DECIMAL(10,2) OUTPUT
AS
	--Obt�m a Soma dos Descontos que afetam um Equipamento no periodo do Aluguer
		--Ob�tem NumeroIdentificador de qualquer Desconto que afeta o Aluguer e o Equipamento a verificar
			--Obt�m NumeroIdentificador de qualquer Promo��o que exista no inicio do Aluguer, Promo��o que afeta tal Aluguer
		--Junta em fun��o de NumeroIdentificador = NumeroIdentificadorDesconto
			--Obt�m NumeroIdentificadorDesconto do Tipo_Descontos que afetam o Tipo do Equipamento a verificar
				--Obt�m NomeTipo do Equipamento a verificar
	SELECT @decontoTotal = COALESCE(SUM(Valor),0) FROM dbo.Desconto WHERE 
	NumeroIdentificadorPromo��o IN
		(SELECT Promo��oNoPeriodo.NumeroIdentificador FROM (
			(SELECT NumeroIdentificador FROM dbo.Promo��o WHERE Inicio<=@inicio AND Fim>=@inicio) 
		AS Promo��oNoPeriodo
		INNER JOIN
			(SELECT NumeroIdentificadorDesconto FROM dbo.Tipo_Desconto WHERE NomeTipo = 
				(SELECT NomeTipo FROM Equipamento WHERE C�digo = @codigo))
		AS Tipo_DescontoDoTipo
		ON Promo��oNoPeriodo.NumeroIdentificador = Tipo_DescontoDoTipo.NumeroIdentificadorDesconto))
	
	RETURN 0;
GO

GO
--Calcula o pre�o total de um Equipamento para um Aluguer, contando com o Desconto
CREATE PROC Calcular_Pre�o_De_Aluguer
@c�digoEquipamento INT, @tipoDura��o VARCHAR(2), @inicio DATETIME, @fim DATETIME, @pre�o DECIMAL(10,2) OUTPUT, @desconto DECIMAL(10,2) OUTPUT, @pre�oAluguer DECIMAL(10,2) OUTPUT
AS
	DECLARE @ret INT;
	--Obt�m o pre�o do Equipamento a verificar
	EXEC @ret = Equipamento_Alugado_Pre�o @c�digoEquipamento, @tipoDura��o, @inicio, @fim, @pre�o OUTPUT;
	
	IF(@ret=-1)
		--Caso o pre�o n�o existe envia um -1, que sinaliza erro
		RETURN -1;
	
	--Obt�m o desconto que afeta o Equipamento no Aluguer
	EXEC Equipamento_Alugado_Desconto @c�digoEquipamento, @inicio, @desconto OUTPUT;

	--Calcula o pre�o total com o pre�o e desconto obtidos nos procedimentos anteriores
	SET @pre�oAluguer = @pre�o - (@pre�o*@desconto);
GO

GO
--Calcula o pre�o total de um Equipamento para um Aluguer, contando com o Desconto, mas recebendo este
CREATE PROC Calcular_Pre�o_De_Aluguer_Sem_Desconto
@c�digoEquipamento INT, @tipoDura��o VARCHAR(2), @inicio DATETIME, @fim DATETIME,  @desconto DECIMAL(10,2), @pre�o DECIMAL(10,2) OUTPUT, @pre�oAluguer DECIMAL(10,2) OUTPUT
AS
	--Obt�m o pre�o do Equipamento a verificar
	EXEC Equipamento_Alugado_Pre�o @c�digoEquipamento, @tipoDura��o, @inicio, @fim, @pre�o OUTPUT;

	--Calcula o pre�o total com o pre�o obtido no procedimento anteriore e desconto fornecido 
	SET @pre�oAluguer = @pre�o - (@pre�o*@desconto);
GO

GO
--Introduz uma Promo��o e utiliza esta para introduzir um Desconto
CREATE PROC Inserir_Desconto
@descri��o VARCHAR(50), @inicio DATETIME, @fim DATETIME, @valor DECIMAL(2,2)
AS
	DECLARE @id INT;
	--Introduz uma Promo��o
	INSERT INTO dbo.Promo��o (Descri��o, Inicio, Fim) VALUES ( @descri��o, @inicio, @fim);

	--Obt�m a chave principal da Promo��o introduzida
	SET @id = @@IDENTITY

	--Introduz um Desconto com a chave principal obtida no ponto anterior
	INSERT INTO dbo.Desconto(NumeroIdentificadorPromo��o,Valor) VALUES (@id, @valor)
	RETURN @id;
GO

GO
--Introduz uma Promo��o e utiliza esta para introduzir um TempoExtra
CREATE PROC Inserir_TempoExtra
@descri��o VARCHAR(50), @inicio DATETIME, @fim DATETIME, @frac��oExtra INTEGER, @tipoDura��o VARCHAR(2)
AS
	DECLARE @id INT;
	--Introduz uma Promo��o
	INSERT INTO dbo.Promo��o (Descri��o, Inicio, Fim) VALUES ( @descri��o, @inicio, @fim);

	--Obt�m a chave principal da Promo��o introduzida
	SET @id = @@IDENTITY

	--Introduz um TempoExtra com a chave principal obtida no ponto anterior
	INSERT INTO  dbo.TempoExtra (NumeroIdentificadorPromo��o, Frac��oExtra, TipoDura��o) VALUES (@id, @frac��oExtra, @tipoDura��o)
	RETURN @id;
GO

GO
CREATE PROC Alterar_Desconto
@descri��o VARCHAR(50), @inicio DATETIME = NULL, @fim DATETIME = NULL, @valor DECIMAL(2,2), @numero INT
AS
	UPDATE dbo.Desconto SET Valor = @valor WHERE NumeroIdentificadorPromo��o = @numero;
	UPDATE dbo.Promo��o SET Descri��o = @descri��o, Inicio = @inicio, Fim = @fim WHERE NumeroIdentificador = @numero;
GO

GO
CREATE PROC Alterar_TempoExtra
@descri��o VARCHAR(50), @inicio DATETIME = NULL, @fim DATETIME = NULL, @extra INTEGER, @tipoDuracao VARCHAR(2), @numero INT
AS
	UPDATE dbo.TempoExtra SET TipoDura��o = @tipoDuracao, Frac��oExtra = @extra WHERE NumeroIdentificadorPromo��o = @numero;
	UPDATE dbo.Promo��o SET Descri��o = @descri��o, Inicio = @inicio, Fim = @fim WHERE NumeroIdentificador = @numero;
GO

GO
CREATE PROC Obter_Aluguers_Datas
@inicioPeriodo DATETIME, @fimPeriodo DATETIME
AS
	SELECT NumeroSerie, TipoDura��o, C�digoCliente,C�digoEquipamento FROM 
	EquipamentoAlugado
	INNER JOIN
	(SELECT NumeroSerie, TipoDura��o, C�digoCliente FROM Aluguer WHERE 
		(@inicioPeriodo<=Inicio AND Inicio<=@fimPeriodo)
		OR (Inicio<=@inicioPeriodo AND FimComExtra>=@fimPeriodo)
		OR (@inicioPeriodo<=Fim AND FimComExtra<=@fimPeriodo)) AS A
	ON A.NumeroSerie = EquipamentoAlugado.NumeroSerieAluguer
GO

