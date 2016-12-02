USE Base_Dados_SI2_1617SI_23

BEGIN TRAN
	SET NOCOUNT ON;

	DECLARE @equipamento INT;
	
	--Introdu��o do Tipo necessario para o Equipamento--
	INSERT INTO Tipo(Nome, Descri��o) VALUES ('Canoa', 'canoa simples');
	INSERT INTO Tipo(Nome, Descri��o) VALUES ('Gaivota', 'gaivota simples');
	--Introdu��o do Tipo necessario para o Equipamento--

	--Introdu��o do Equipamento correcto--
	INSERT INTO dbo.Equipamento(Descri��o, NomeTipo) VALUES ('uma canoa para teste','Canoa');
	SET @equipamento = @@IDENTITY;
	--Introdu��o do Equipamento correcto--

	--Erro 1, n�o existe o Tipo Canoa Grande--
	PRINT('Erro 1, n�o existe o Tipo Canoa Grande');
	INSERT INTO dbo.Equipamento(Descri��o, NomeTipo) VALUES ('uma canoa preta','Canoa Grande');
	PRINT('Erro 1, n�o existe o Tipo Canoa Grande');
	--Erro 1, n�o existe o Tipo Canoa Grande--
	
	SELECT * FROM Equipamento WHERE C�digo = @equipamento;

	--Erro 2, n�o existe o Tipo Canoa Grande--
	PRINT('Erro 2, n�o existe o Tipo Canoa Grande');
	UPDATE dbo.Equipamento SET NomeTipo = 'Canoa Grande' WHERE C�digo = @equipamento
	PRINT('Erro 2, n�o existe o Tipo Canoa Grande');
	--Erro 2, n�o existe o Tipo Canoa Grande--

	--Alterar a Descri��o e NomeTipo do Equipamento--
	UPDATE dbo.Equipamento SET Descri��o = 'uma gaivota para testes', NomeTipo = 'Gaivota' WHERE C�digo = @equipamento
	--Alterar a Descri��o e NomeTipo do Equipamento--

	SELECT * FROM Equipamento WHERE C�digo = @equipamento;

	--Remover o Equipamento--
	DELETE FROM dbo.Equipamento WHERE C�digo = @equipamento
	--Remover o Equipamento--

	SELECT * FROM Equipamento WHERE C�digo = @equipamento;
ROLLBACK TRAN