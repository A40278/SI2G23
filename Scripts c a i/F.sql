USE Base_Dados_SI2_1617SI_23;

BEGIN TRAN
	SET NOCOUNT ON;
	
	DECLARE @empregado INT;

	--Instrudução
	INSERT INTO Empregado(Nome) VALUES ('Catia Onas');
	SET @empregado = @@IDENTITY;

	EXEC Inserir_Aluguer_e_Cliente 'mh', '2016-12-20 11:30:00',  '2016-12-20 15:00:00', @empregado, 'Alves Albano',
	77777777, 'Rua Olho Vivo 88';
	SELECT * FROM dbo.Cliente WHERE  Código = (SELECT MAX(Código) FROM dbo.Cliente); 
	SELECT * FROM dbo.Aluguer WHERE  NumeroSerie = (SELECT MAX(NumeroSerie) FROM dbo.Aluguer); 
ROLLBACK TRAN