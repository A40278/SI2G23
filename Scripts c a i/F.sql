USE Base_Dados_SI2_1617SI_23;

BEGIN TRAN
	SET NOCOUNT ON;
	
	DECLARE @empregado INT;
	DECLARE @now DATETIME = GETDATE();

	--Instrudução
	INSERT INTO Empregado(Nome) VALUES ('Catia Onas');
	SET @empregado = @@IDENTITY;

	DECLARE @inicio DATETIME = DATEADD(hh,-3,@now), @fim DATETIME = DATEADD(hh,3,@now);

	EXEC Inserir_Aluguer_e_Cliente 'mh', @inicio,  @fim, @empregado, 'Alves Albano', 77777777, 'Rua Olho Vivo 88';

	SELECT * FROM dbo.Cliente WHERE  Código = (SELECT MAX(Código) FROM dbo.Cliente); 
	SELECT * FROM dbo.Aluguer WHERE  NumeroSerie = (SELECT MAX(NumeroSerie) FROM dbo.Aluguer); 
ROLLBACK TRAN