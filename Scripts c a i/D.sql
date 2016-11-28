USE Base_Dados_SI2_1617SI_23

BEGIN TRAN
	SET NOCOUNT ON;

	DECLARE @equipamento INT;
	
	--Introdução do Tipo necessario para o Equipamento--
	INSERT INTO Tipo(Nome, Descrição) VALUES ('Canoa', 'canoa simples');
	INSERT INTO Tipo(Nome, Descrição) VALUES ('Gaivota', 'gaivota simples');
	--Introdução do Tipo necessario para o Equipamento--

	--Introdução do Equipamento correcto--
	INSERT INTO dbo.Equipamento(Descrição, NomeTipo) VALUES ('uma canoa para teste','Canoa');
	SET @equipamento = @@IDENTITY;
	--Introdução do Equipamento correcto--

	--Erro 1, não existe o Tipo Canoa Grande--
	PRINT('Erro 1, não existe o Tipo Canoa Grande');
	INSERT INTO dbo.Equipamento(Descrição, NomeTipo) VALUES ('uma canoa preta','Canoa Grande');
	PRINT('Erro 1, não existe o Tipo Canoa Grande');
	--Erro 1, não existe o Tipo Canoa Grande--
	
	SELECT * FROM Equipamento WHERE Código = @equipamento;

	--Erro 2, não existe o Tipo Canoa Grande--
	PRINT('Erro 2, não existe o Tipo Canoa Grande');
	UPDATE dbo.Equipamento SET NomeTipo = 'Canoa Grande' WHERE Código = @equipamento
	PRINT('Erro 2, não existe o Tipo Canoa Grande');
	--Erro 2, não existe o Tipo Canoa Grande--

	--Alterar a Descrição e NomeTipo do Equipamento--
	UPDATE dbo.Equipamento SET Descrição = 'uma gaivota para testes', NomeTipo = 'Gaivota' WHERE Código = @equipamento
	--Alterar a Descrição e NomeTipo do Equipamento--

	SELECT * FROM Equipamento WHERE Código = @equipamento;

	--Remover o Equipamento--
	DELETE FROM dbo.Equipamento WHERE Código = @equipamento
	--Remover o Equipamento--

	SELECT * FROM Equipamento WHERE Código = @equipamento;
ROLLBACK TRAN