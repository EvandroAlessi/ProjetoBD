CREATE DATABASE BANCOSANGUE;
USE BANCOSANGUE;

CREATE TABLE Doador (
	IDDoador INTEGER NOT NULL AUTO_INCREMENT,
	Nome VARCHAR(150),
	Sexo CHAR(1),
	RG VARCHAR(20),
	NomeMae VARCHAR(150),
	NomePai VARCHAR(150),
	DataNascimento DATETIME,
    PRIMARY KEY(IDDoador)
);

CREATE TABLE Endereco (
	IDEndereco INTEGER NOT NULL AUTO_INCREMENT,
	Numero INTEGER,
	Cidade VARCHAR(150),
	UF CHAR(2),
	Bairro VARCHAR(150),
	Rua VARCHAR(150),
    IDDoador INTEGER NOT NULL,
	PRIMARY KEY(IDEndereco),
    FOREIGN KEY(IDDoador) REFERENCES Doador (IDDoador)
		ON UPDATE CASCADE 
        ON DELETE CASCADE
);

CREATE TABLE TesteAnemia (
	IDTesteAnemia INTEGER NOT NULL AUTO_INCREMENT,
	Data DATETIME,
	NivelHemoglobina VARCHAR(150),
	IDDoador INTEGER NOT NULL,
    PRIMARY KEY(IDTesteAnemia),
    FOREIGN KEY(IDDoador) REFERENCES Doador (IDDoador)
		ON UPDATE CASCADE 
        ON DELETE CASCADE
);

CREATE TABLE Entrevista (
	IDEntrevista INTEGER NOT NULL AUTO_INCREMENT,
	Data DATETIME,
	Apto TINYINT,
	IDTesteAnemia INTEGER NOT NULL,
    PRIMARY KEY(IDEntrevista),
	FOREIGN KEY(IDTesteAnemia) REFERENCES TesteAnemia(IDTesteAnemia)
		ON UPDATE RESTRICT
        ON DELETE RESTRICT
);

CREATE TABLE Doacao (
	IDDoacao INTEGER NOT NULL AUTO_INCREMENT,
	Data DATETIME,
	QtdSangue NUMERIC(5,2),
	IDEntrevista INTEGER NOT NULL,
    PRIMARY KEY(IDDoacao),
	FOREIGN KEY(IDEntrevista) REFERENCES Entrevista(IDEntrevista)
		ON UPDATE RESTRICT
        ON DELETE RESTRICT
);

CREATE TABLE TriagemSorologica (
	IDTriagemSorologica INTEGER NOT NULL AUTO_INCREMENT,
	AIDS TINYINT,
	Sifilis TINYINT,
	HepatiteB TINYINT,
	HepatiteC TINYINT,
	DoencaChagas TINYINT,
	HTLV TINYINT,
	Data DATETIME,
	IDDoacao INTEGER NOT NULL,
    PRIMARY KEY(IDTriagemSorologica),
    FOREIGN KEY(IDDoacao) REFERENCES Doacao (IDDoacao)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

CREATE TABLE TipoSangue (
	IDTipoSangue INTEGER NOT NULL AUTO_INCREMENT,
	RH CHAR(1),
	ABO VARCHAR(2),
    PRIMARY KEY(IDTipoSangue)
);

CREATE TABLE Imunohematologia (
	IDImunohematologia INTEGER NOT NULL AUTO_INCREMENT,
	Data DATETIME,
	TemCorpoIrregular VARCHAR(300),
	IDDoacao INTEGER NOT NULL,
	IDTipoSangue INTEGER NOT NULL,
    PRIMARY KEY(IDImunohematologia),
	FOREIGN KEY(IDTipoSangue) REFERENCES TipoSangue(IDTipoSangue)
		ON UPDATE RESTRICT 
        ON DELETE RESTRICT,
    FOREIGN KEY(IDDoacao) REFERENCES Doacao (IDDoacao)
        ON UPDATE CASCADE 
        ON DELETE CASCADE
);

CREATE TABLE SangueApto (
	IDSangueApto INTEGER NOT NULL AUTO_INCREMENT,
	DataVencimento DATETIME,
	IDDoacao INTEGER NOT NULL,
	IDTipoSangue INTEGER NOT NULL,
    PRIMARY KEY(IDSangueApto),
	FOREIGN KEY(IDTipoSangue) REFERENCES TipoSangue(IDTipoSangue)
		ON UPDATE RESTRICT 
        ON DELETE RESTRICT,
    FOREIGN KEY(IDDoacao) REFERENCES Doacao (IDDoacao)
        ON UPDATE CASCADE 
        ON DELETE CASCADE
);

CREATE TABLE Medico (
	IDMedico INTEGER NOT NULL AUTO_INCREMENT,
	Registro VARCHAR(10),
	Nome VARCHAR(150),
    PRIMARY KEY(IDMedico)
);

CREATE TABLE Consulta (
	IDConsulta INTEGER NOT NULL AUTO_INCREMENT,
	Data DATETIME,
	Descricao VARCHAR(300),
	IDMedico INTEGER NOT NULL,
	IDDoador INTEGER NOT NULL,
	IDDoacao INTEGER NOT NULL,
    PRIMARY KEY(IDConsulta),
	FOREIGN KEY(IDMedico) REFERENCES Medico(IDMedico)
		ON UPDATE RESTRICT 
        ON DELETE RESTRICT,
	FOREIGN KEY(IDDoador) REFERENCES Doador(IDDoador)
		ON UPDATE RESTRICT 
        ON DELETE RESTRICT,
    FOREIGN KEY(IDDoacao) REFERENCES Doacao (IDDoacao)
        ON UPDATE RESTRICT 
        ON DELETE RESTRICT
);

CREATE TABLE ColetaAmostra (
	IDColetaAmostra INTEGER NOT NULL AUTO_INCREMENT,
	Data DATETIME,
	IDTriagemSorologica INTEGER,
	IDImunohematologia INTEGER,
	IDConsulta INTEGER NOT NULL,
    PRIMARY KEY(IDColetaAmostra),
	FOREIGN KEY(IDImunohematologia) REFERENCES Imunohematologia(IDImunohematologia)
		ON UPDATE RESTRICT 
        ON DELETE RESTRICT,
    FOREIGN KEY(IDTriagemSorologica) REFERENCES TriagemSorologica (IDTriagemSorologica)
        ON UPDATE RESTRICT 
        ON DELETE RESTRICT,
    FOREIGN KEY(IDConsulta) REFERENCES Consulta (IDConsulta)
        ON UPDATE CASCADE 
        ON DELETE CASCADE
);


CREATE INDEX Index_DoadorNome ON Doador(Nome);
CREATE INDEX Index_DoadorRG ON Doador(RG);
CREATE INDEX Index_SangueAptoDataVencimento ON SangueApto(DataVencimento);
CREATE INDEX Index_EntrevistaApto ON Entrevista(Apto);
CREATE INDEX Index_TesteAnemiaData ON TesteAnemia(Data);
CREATE INDEX Index_EnderecoBairro ON Endereco(Bairro);
CREATE INDEX Index_EnderecoRua ON Endereco(Rua);
CREATE INDEX Index_TriagemSorologica ON TriagemSorologica(Data);
CREATE INDEX Index_MedicoRegistro ON Medico(Registro);
CREATE INDEX Index_ColetaAmostraData ON ColetaAmostra(Data);
CREATE INDEX Index_ImunohematologiaData ON Imunohematologia(Data);
CREATE INDEX Index_TipoSangueABO ON TipoSangue(ABO);
