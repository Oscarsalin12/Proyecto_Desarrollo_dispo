CREATE DATABASE MonitoreoArritmias;
GO

USE MonitoreoArritmias;
GO


CREATE TABLE Usuarios (
    IdUsuario INT IDENTITY(1,1) PRIMARY KEY,
    NombreCompleto VARCHAR(100) NOT NULL,
    Correo VARCHAR(100) NOT NULL UNIQUE,
    Telefono VARCHAR(15) NOT NULL,
    Contrasena VARCHAR(255) NOT NULL,
    TokenWeb VARCHAR(MAX) NULL
);


CREATE TABLE Licencias (
    IdLicencia INT IDENTITY(1,1) PRIMARY KEY,
    TipoLicencia VARCHAR(30) NOT NULL DEFAULT 'Grupal', 
    CodigoGrupo VARCHAR(20) NOT NULL UNIQUE,             
    FechaInicio DATE NOT NULL DEFAULT GETDATE(),
    FechaFin DATE NOT NULL,                              
);


CREATE TABLE Pacientes (
    IdPaciente INT IDENTITY(1,1) PRIMARY KEY,
    IdLicencia INT NOT NULL,                           
    NombreCompleto VARCHAR(100) NOT NULL,
    Edad INT NOT NULL,
    Sexo CHAR(1) NOT NULL,
    FechaNacimiento DATE NOT NULL,
    Peso DECIMAL(5,2) NOT NULL,
    Estatura DECIMAL(3,2) NOT NULL,
    TipoSangre VARCHAR(5) NOT NULL,
    Fotografia VARbinary(MAX) NULL,
    CURP varchar(18) NOT NULL UNIQUE,
    Direccion VARCHAR(200) NOT NULL,
    Telefono VARCHAR(15) NOT NULL,
    BitAdmin BIT NOT NULL DEFAULT 0,
    CONSTRAINT FK_Pacientes_Licencias FOREIGN KEY (IdLicencia) REFERENCES Licencias(IdLicencia)
);


CREATE TABLE GrupoCuidadores (
    IdGrupo INT IDENTITY(1,1) PRIMARY KEY,
    IdPaciente INT NOT NULL,
    IdCuidador INT NOT NULL,                             
    EsAdministrador BIT NOT NULL DEFAULT 0,             
    FechaVinculacion DATETIME NOT NULL DEFAULT GETDATE(),
    CONSTRAINT FK_Grupo_Pacientes FOREIGN KEY (IdPaciente) REFERENCES Pacientes(IdPaciente) ON DELETE CASCADE,
    CONSTRAINT FK_Grupo_Usuarios FOREIGN KEY (IdCuidador) REFERENCES Usuarios(IdUsuario) ON DELETE CASCADE,
    CONSTRAINT UQ_Paciente_Cuidador UNIQUE (IdPaciente, IdCuidador) 
);


CREATE TABLE Arritmias (
    IdArritmia INT IDENTITY(1,1) PRIMARY KEY,
    IdPaciente INT NOT NULL,
    Tipo VARCHAR(50) NOT NULL, 
    FrecuenciaCardiaca INT NOT NULL,
    DuracionEpisodioSeconds INT NOT NULL,
    FechaRegistro DATETIME NOT NULL DEFAULT GETDATE(),
    Mareo BIT NOT NULL DEFAULT 0,
    Palpitaciones BIT NOT NULL DEFAULT 0,
    DolorPecho BIT NOT NULL DEFAULT 0,
    Desmayo BIT NOT NULL DEFAULT 0,
    FaltaAire BIT NOT NULL DEFAULT 0,
    Fatiga BIT NOT NULL DEFAULT 0,
    CONSTRAINT FK_Arritmias_Pacientes FOREIGN KEY (IdPaciente) REFERENCES Pacientes(IdPaciente) ON DELETE CASCADE
);