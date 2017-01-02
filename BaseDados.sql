GO
IF DB_ID ('Base_Dados_SI2_1617SI_23') IS NULL
	CREATE DATABASE Base_Dados_SI2_1617SI_23;
GO

IF (NOT EXISTS (SELECT * FROM sys.schemas WHERE name = 'Version01')) 
BEGIN
    EXEC ('CREATE SCHEMA Version01')
END

USE Base_Dados_SI2_1617SI_23

CREATE TABLE Version01.Tipo(
	Nome VARCHAR(50) CONSTRAINT PK_Tipo PRIMARY KEY,
	Descri��o VARCHAR(150) 
)

CREATE TABLE Version01.Equipamento(
	C�digo INT IDENTITY(1,1) CONSTRAINT PK_Equipamento PRIMARY KEY,
	NomeTipo VARCHAR(50) NOT NULL,
	Descri��o VARCHAR(150),
	CONSTRAINT FK_Equipamento_Tipo FOREIGN KEY(NomeTipo) REFERENCES Version01.Tipo(Nome) ON DELETE CASCADE
)

CREATE TABLE Version01.Pre�o(
	C�digoEquipamento INT NOT NULL,
	Valor DECIMAL(10,2) NOT NULL,
	TipoDura��o VARCHAR(2),
	Inicio DATETIME NOT NULL,
	Fim DATETIME NOT NULL,
	NumeroSerie INT IDENTITY(1,1) CONSTRAINT PK_Pre�o PRIMARY KEY,
	CONSTRAINT Preco_Valor CHECK (Valor>0),
	CONSTRAINT Tipo_Dura��o_Valores_Pre�o CHECK (TipoDura��o in ('mh','h','d','s','m')),
	CONSTRAINT Tempo_Correctos_Pre�o CHECK (Fim > Inicio),
	CONSTRAINT FK_Pre�o_Equipamento FOREIGN KEY (C�digoEquipamento) REFERENCES Version01.Equipamento(C�digo) ON DELETE CASCADE,
	CONSTRAINT UN_Pre�o UNIQUE (Inicio, TipoDura��o, C�digoEquipamento)
)

CREATE TABLE Version01.Cliente(
	C�digo INT IDENTITY(1,1) CONSTRAINT PK_Cliente PRIMARY KEY,
	Nome VARCHAR(100) NULL,
	NumeroFiscal INTEGER NULL,
	Morada VARCHAR(200) NULL,
	CONSTRAINT NumeroFiscal_Positivo CHECK (NumeroFiscal>0)
)

CREATE UNIQUE NONCLUSTERED INDEX NumeroFiscal_Unique
ON Version01.Cliente(NumeroFiscal)
WHERE NumeroFiscal IS NOT NULL;

CREATE TABLE Version01.Empregado(
	Nome VARCHAR(100) NOT NULL,
	Numero INT IDENTITY(1,1) CONSTRAINT PK_Empregado PRIMARY KEY
)

CREATE TABLE Version01.Aluguer(
	NumeroSerie INT IDENTITY(1,1) CONSTRAINT PK_Aluguer PRIMARY KEY,
	C�digoCliente INT,
	NumeroEmpregado INTEGER,
	TipoDura��o VARCHAR(2),
	Inicio DATETIME NOT NULL,
	Fim DATETIME NOT NULL,
	FimComExtra DATETIME NULL,
	Pre�o DECIMAL(10,2) DEFAULT 0.0,
	CONSTRAINT Tempo_Correctos_Aluguer CHECK (Fim > Inicio),
	CONSTRAINT Tipo_Dura��o_Valores_Aluguer CHECK (TipoDura��o in ('mh','h','d','s','m')),
	CONSTRAINT FK_Aluguer_Cliente FOREIGN KEY (C�digoCliente) REFERENCES Version01.Cliente(C�digo) ON DELETE CASCADE,
	CONSTRAINT FK_Aluguer_Empregado FOREIGN KEY (NumeroEmpregado) REFERENCES Version01.Empregado(Numero) ON DELETE CASCADE
)

CREATE TABLE Version01.Promo��o(
	NumeroIdentificador INT IDENTITY(1,1) CONSTRAINT PK_Promo��o PRIMARY KEY,
	Descri��o VARCHAR(150),
	Inicio DATETIME NOT NULL,
	Fim DATETIME NOT NULL,
	CONSTRAINT Tempo_Correctos_Promo��o CHECK (Fim > Inicio)
)

CREATE TABLE Version01.Desconto(
	NumeroIdentificadorPromo��o INTEGER CONSTRAINT PK_Desconto PRIMARY KEY,
	Valor DECIMAL(2,2) NOT NULL,
	CONSTRAINT Valor_Desconto_Factor CHECK(0<Valor and Valor<=1),
	CONSTRAINT FK_Desconto_Promo��o FOREIGN KEY (NumeroIdentificadorPromo��o) REFERENCES Version01.Promo��o(NumeroIdentificador) ON DELETE CASCADE
)
CREATE TABLE Version01.TempoExtra(
	NumeroIdentificadorPromo��o INTEGER CONSTRAINT PK_TempoExtra PRIMARY KEY,
	Frac��oExtra INTEGER NOT NULL,
	TipoDura��o VARCHAR(2),
	CONSTRAINT TempoExtra_Dura��o_Valores_Aluguer CHECK (TipoDura��o in ('mh','h','d','s','m')),
	CONSTRAINT FK_TempoExtra_Promo��o FOREIGN KEY (NumeroIdentificadorPromo��o) REFERENCES Version01.Promo��o(NumeroIdentificador) ON DELETE CASCADE
)

CREATE TABLE Version01.EquipamentoAlugado(
	NumeroSerieAluguer INTEGER NOT NULL,
	C�digoEquipamento INTEGER NOT NULL,
	Pre�oOriginal DECIMAL(10,2) DEFAULT 0,
	Desconto DECIMAL(10,2) DEFAULT 0,
	Pre�oFinal DECIMAL(10,2) DEFAULT 0,
	CONSTRAINT FK_EquipamentoAlugado_Equipamento FOREIGN KEY (C�digoEquipamento) REFERENCES Version01.Equipamento(C�digo) ON DELETE CASCADE,
	CONSTRAINT FK_EquipamentoAlugado_Aluguer FOREIGN KEY (NumeroSerieAluguer) REFERENCES Version01.Aluguer(NumeroSerie) ON DELETE CASCADE,
	CONSTRAINT PK_EquipamentoAlugado PRIMARY KEY (NumeroSerieAluguer, C�digoEquipamento)
)

CREATE TABLE Version01.Tipo_Desconto(
	NumeroIdentificadorDesconto INTEGER NOT NULL,
	NomeTipo VARCHAR(50) NOT NULL,
	CONSTRAINT FK_Tipo_Desconto_Tipo FOREIGN KEY(NomeTipo) REFERENCES Version01.Tipo(Nome) ON DELETE CASCADE,
	CONSTRAINT FK_Tipo_Desconto_Desconto FOREIGN KEY(NumeroIdentificadorDesconto) REFERENCES Version01.Desconto(NumeroIdentificadorPromo��o) ON DELETE CASCADE,
	CONSTRAINT PK_Tipo_Desconto PRIMARY KEY (NumeroIdentificadorDesconto, NomeTipo)
)

GO
CREATE VIEW dbo.Tipo AS 
SELECT * FROM Version01.Tipo
GO

GO
CREATE VIEW dbo.Equipamento AS
SELECT * FROM Version01.Equipamento
GO

GO
CREATE VIEW dbo.Pre�o AS
SELECT * FROM Version01.Pre�o
GO

GO
CREATE VIEW dbo.Cliente AS
SELECT * FROM Version01.Cliente
GO

GO
CREATE VIEW dbo.Empregado AS
SELECT * FROM Version01.Empregado
GO

GO
CREATE VIEW dbo.Aluguer AS
SELECT * FROM Version01.Aluguer
GO

GO
CREATE VIEW dbo.Promo��o AS
SELECT * FROM Version01.Promo��o
GO

GO
CREATE VIEW dbo.Desconto AS
SELECT * FROM Version01.Desconto
GO

GO
CREATE VIEW dbo.TempoExtra AS
SELECT * FROM Version01.TempoExtra
GO

GO
CREATE VIEW dbo.EquipamentoAlugado AS
SELECT * FROM Version01.EquipamentoAlugado
GO

GO
CREATE VIEW dbo.Tipo_Desconto AS
SELECT * FROM Version01.Tipo_Desconto
GO