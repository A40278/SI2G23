USE Base_Dados_SI2_1617SI_23

GO
--Demosntra o numero de Preços para um Equipamento de um certo TipoDuração, no periodo entre @inicio e @fim
CREATE PROC Numero_de_Preços_No_Periodo
@inicio DATETIME = NULL, @fim DATETIME = NULL, @tipoDuração VARCHAR(2) = NULL, @codigo INT = NULL
AS
	DECLARE @count INT;
	--Obtém count de Preços  que começa e ou acabam no periodo, do select seguinte
		--Obtém os Preços dum certo TipoDuração e com um certo CódigoEquipamento
	SELECT @count = COUNT(*) FROM(
		SELECT * FROM dbo.Preço WHERE TipoDuração = @tipoDuração AND CódigoEquipamento = @codigo)
	AS P
	WHERE (P.Inicio<@inicio AND @inicio<P.Fim) OR (P.Inicio<@fim AND @fim<P.Fim)

	RETURN @count;
GO

GO
--Obtém todos os tempos extras que afetam um Aluguer que começa em @inicio
CREATE PROC Fracoes_Tempo_Extra
@fim DATETIME = NULL, @inicio DATETIME = NULL, @tipoDuração VARCHAR(2) = NULL
AS
	SET NOCOUNT ON
	DECLARE @fraçcoesTempoExtra INTEGER = 0;
	--Obtém a soma das FracçãoExtras dos TempoExtras resultantes no Inner Join, que são os TempoExrtas que 
	--ocorrem no periodo fornecido com o TipoDuração também fornecido
		--Obtém NumeroIdentificador das Promoções que aconteçem no periodo fornecido
	--Junta em função de NumeroIdentificador = NumeroIdentificadorPromoção
		--Obtém NumeroIdentificadorPromoção e FracçãoExtra dos TempoExtras com o TipoDuração fornecido
	SELECT @fraçcoesTempoExtra =  COALESCE (SUM(FracçãoExtra),0) FROM(
		(SELECT NumeroIdentificador FROM dbo.Promoção WHERE Fim>=@fim AND Inicio<=@inicio)
	AS PromoçõesDisponivies
	INNER JOIN
		(SELECT NumeroIdentificadorPromoção, FracçãoExtra FROM dbo.TempoExtra WHERE TipoDuração=@tipoDuração)
	AS TempoExtraDuraçãoCorrecta
	ON PromoçõesDisponivies.NumeroIdentificador = TempoExtraDuraçãoCorrecta.NumeroIdentificadorPromoção)
	PRINT(@fraçcoesTempoExtra)
	RETURN @fraçcoesTempoExtra
GO

GO
CREATE PROC Factor_Tipo_Duração
@tipoDuração VARCHAR(2), @factor DECIMAL(10,2) = 00.00 OUTPUT
AS
	--Torna @factor no numero de minutos num certo bloco de tempo represerntado por TipoDuração
	SELECT @factor =
	CASE @tipoDuração
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
	--Torna @count no produto de COUNT nos EquipamentoAlugados com o CódigoEquipamento igual ao código fornecido e que
	--aconteçem no periodo fornecido
		--Obtém NumeroSerie dos Alugueres que começam e ou acabam no periodo fornecido
	SELECT @count = COUNT(*) FROM EquipamentoAlugado WHERE CódigoEquipamento = @codigo AND NumeroSerieAluguer IN
		(SELECT NumeroSerie FROM Aluguer WHERE (Inicio<@inicioPeriodo AND FimComExtra>@inicioPeriodo)
			OR (Inicio<@fimPeriodo AND FimComExtra>@fimPeriodo))
	RETURN @count;
GO

GO
--Obtém o Valor do Preço para um Equipamento que ocorre num certo periodo fornecido
CREATE PROC Equipamento_Alugado_Preço
@codigo INT, @tipoDuração VARCHAR(2), @inicio DATETIME, @fim DATETIME, @preço DECIMAL(10,2) OUTPUT
AS
	--Obtém o Valor do Preço para um Equipamento que ocorre num certo periodo fornecido
	SELECT @preço = Valor FROM dbo.Preço WHERE Inicio<=@inicio AND Fim>=@inicio AND TipoDuração = @tipoDuração AND 
		CódigoEquipamento = @codigo;

	--Caso não hover um Preço para o Equipamento desejado no period desejado então devolve-se -1
	IF(@preço IS NULL)
		RETURN -1;

	DECLARE @blocoTemporal DECIMAL(10,2), @factor DECIMAL(10,2);
	
	--Cria @blocoTemporal que é igual ao numero de vezes que o periodo do Aluguer pode ser dividio num bloco do 
	--TipoDuração do mesmo
	EXEC Factor_Tipo_Duração @tipoDuração, @factor OUTPUT;
	SELECT @blocoTemporal = CEILING(DATEDIFF(MI,@inicio,@fim) / @factor)

	--Multiplica @preço por @blocoTemporal para obtér o preço completo do Equipamento no Aluguer
	SET @preço = (@preço*@blocoTemporal);
GO

GO
--Obtém a Soma dos Descontos que afetam um Equipamento no periodo do Aluguer
CREATE PROC Equipamento_Alugado_Desconto
@codigo INT, @inicio DATETIME, @decontoTotal DECIMAL(10,2) OUTPUT
AS
	--Obtém a Soma dos Descontos que afetam um Equipamento no periodo do Aluguer
		--Obétem NumeroIdentificador de qualquer Desconto que afeta o Aluguer e o Equipamento a verificar
			--Obtém NumeroIdentificador de qualquer Promoção que exista no inicio do Aluguer, Promoção que afeta tal Aluguer
		--Junta em função de NumeroIdentificador = NumeroIdentificadorDesconto
			--Obtém NumeroIdentificadorDesconto do Tipo_Descontos que afetam o Tipo do Equipamento a verificar
				--Obtém NomeTipo do Equipamento a verificar
	SELECT @decontoTotal = COALESCE(SUM(Valor),0) FROM dbo.Desconto WHERE 
	NumeroIdentificadorPromoção IN
		(SELECT PromoçãoNoPeriodo.NumeroIdentificador FROM (
			(SELECT NumeroIdentificador FROM dbo.Promoção WHERE Inicio<=@inicio AND Fim>=@inicio) 
		AS PromoçãoNoPeriodo
		INNER JOIN
			(SELECT NumeroIdentificadorDesconto FROM dbo.Tipo_Desconto WHERE NomeTipo = 
				(SELECT NomeTipo FROM Equipamento WHERE Código = @codigo))
		AS Tipo_DescontoDoTipo
		ON PromoçãoNoPeriodo.NumeroIdentificador = Tipo_DescontoDoTipo.NumeroIdentificadorDesconto))
	
	RETURN 0;
GO

GO
--Calcula o preço total de um Equipamento para um Aluguer, contando com o Desconto
CREATE PROC Calcular_Preço_De_Aluguer
@códigoEquipamento INT, @tipoDuração VARCHAR(2), @inicio DATETIME, @fim DATETIME, @preço DECIMAL(10,2) OUTPUT, @desconto DECIMAL(10,2) OUTPUT, @preçoAluguer DECIMAL(10,2) OUTPUT
AS
	DECLARE @ret INT;
	--Obtém o preço do Equipamento a verificar
	EXEC @ret = Equipamento_Alugado_Preço @códigoEquipamento, @tipoDuração, @inicio, @fim, @preço OUTPUT;
	
	IF(@ret=-1)
		--Caso o preço não existe envia um -1, que sinaliza erro
		RETURN -1;
	
	--Obtém o desconto que afeta o Equipamento no Aluguer
	EXEC Equipamento_Alugado_Desconto @códigoEquipamento, @inicio, @desconto OUTPUT;

	--Calcula o preço total com o preço e desconto obtidos nos procedimentos anteriores
	SET @preçoAluguer = @preço - (@preço*@desconto);
GO

GO
--Calcula o preço total de um Equipamento para um Aluguer, contando com o Desconto, mas recebendo este
CREATE PROC Calcular_Preço_De_Aluguer_Sem_Desconto
@códigoEquipamento INT, @tipoDuração VARCHAR(2), @inicio DATETIME, @fim DATETIME,  @desconto DECIMAL(10,2), @preço DECIMAL(10,2) OUTPUT, @preçoAluguer DECIMAL(10,2) OUTPUT
AS
	--Obtém o preço do Equipamento a verificar
	EXEC Equipamento_Alugado_Preço @códigoEquipamento, @tipoDuração, @inicio, @fim, @preço OUTPUT;

	--Calcula o preço total com o preço obtido no procedimento anteriore e desconto fornecido 
	SET @preçoAluguer = @preço - (@preço*@desconto);
GO

GO
--Introduz uma Promoção e utiliza esta para introduzir um Desconto
CREATE PROC Inserir_Desconto
@descrição VARCHAR(50), @inicio DATETIME, @fim DATETIME, @valor DECIMAL(2,2)
AS
	DECLARE @id INT;
	--Introduz uma Promoção
	INSERT INTO dbo.Promoção (Descrição, Inicio, Fim) VALUES ( @descrição, @inicio, @fim);

	--Obtém a chave principal da Promoção introduzida
	SET @id = @@IDENTITY

	--Introduz um Desconto com a chave principal obtida no ponto anterior
	INSERT INTO dbo.Desconto(NumeroIdentificadorPromoção,Valor) VALUES (@id, @valor)
	RETURN @id;
GO

GO
--Introduz uma Promoção e utiliza esta para introduzir um TempoExtra
CREATE PROC Inserir_TempoExtra
@descrição VARCHAR(50), @inicio DATETIME, @fim DATETIME, @fracçãoExtra INTEGER, @tipoDuração VARCHAR(2)
AS
	DECLARE @id INT;
	--Introduz uma Promoção
	INSERT INTO dbo.Promoção (Descrição, Inicio, Fim) VALUES ( @descrição, @inicio, @fim);

	--Obtém a chave principal da Promoção introduzida
	SET @id = @@IDENTITY

	--Introduz um TempoExtra com a chave principal obtida no ponto anterior
	INSERT INTO  dbo.TempoExtra (NumeroIdentificadorPromoção, FracçãoExtra, TipoDuração) VALUES (@id, @fracçãoExtra, @tipoDuração)
	RETURN @id;
GO

GO
CREATE PROC Alterar_Desconto
@descrição VARCHAR(50), @inicio DATETIME = NULL, @fim DATETIME = NULL, @valor DECIMAL(2,2), @numero INT
AS
	UPDATE dbo.Desconto SET Valor = @valor WHERE NumeroIdentificadorPromoção = @numero;
	UPDATE dbo.Promoção SET Descrição = @descrição, Inicio = @inicio, Fim = @fim WHERE NumeroIdentificador = @numero;
GO

GO
CREATE PROC Alterar_TempoExtra
@descrição VARCHAR(50), @inicio DATETIME = NULL, @fim DATETIME = NULL, @extra INTEGER, @tipoDuracao VARCHAR(2), @numero INT
AS
	UPDATE dbo.TempoExtra SET TipoDuração = @tipoDuracao, FracçãoExtra = @extra WHERE NumeroIdentificadorPromoção = @numero;
	UPDATE dbo.Promoção SET Descrição = @descrição, Inicio = @inicio, Fim = @fim WHERE NumeroIdentificador = @numero;
GO

GO
CREATE PROC Obter_Aluguers_Datas
@inicioPeriodo DATETIME, @fimPeriodo DATETIME
AS
	SELECT NumeroSerie, TipoDuração, CódigoCliente,CódigoEquipamento FROM 
	EquipamentoAlugado
	INNER JOIN
	(SELECT NumeroSerie, TipoDuração, CódigoCliente FROM Aluguer WHERE 
		(@inicioPeriodo<=Inicio AND Inicio<=@fimPeriodo)
		OR (Inicio<=@inicioPeriodo AND FimComExtra>=@fimPeriodo)
		OR (@inicioPeriodo<=Fim AND FimComExtra<=@fimPeriodo)) AS A
	ON A.NumeroSerie = EquipamentoAlugado.NumeroSerieAluguer
GO

