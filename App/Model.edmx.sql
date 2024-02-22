
-- --------------------------------------------------
-- Entity Designer DDL Script for SQL Server 2005, 2008, 2012 and Azure
-- --------------------------------------------------
-- Date Created: 02/01/2024 14:35:33
-- Generated from EDMX file: C:\Users\Luka\Desktop\App\App\Model.edmx
-- --------------------------------------------------

SET QUOTED_IDENTIFIER OFF;
GO
USE [pppk];
GO
IF SCHEMA_ID(N'dbo') IS NULL EXECUTE(N'CREATE SCHEMA [dbo]');
GO

-- --------------------------------------------------
-- Dropping existing FOREIGN KEY constraints
-- --------------------------------------------------

IF OBJECT_ID(N'[dbo].[FK_ApartmentUploadedFile]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[UploadedFiles] DROP CONSTRAINT [FK_ApartmentUploadedFile];
GO

-- --------------------------------------------------
-- Dropping existing tables
-- --------------------------------------------------

IF OBJECT_ID(N'[dbo].[Apartments]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Apartments];
GO
IF OBJECT_ID(N'[dbo].[UploadedFiles]', 'U') IS NOT NULL
    DROP TABLE [dbo].[UploadedFiles];
GO

-- --------------------------------------------------
-- Creating all tables
-- --------------------------------------------------

-- Creating table 'Apartments'
CREATE TABLE [dbo].[Apartments] (
    [IDApartment] int IDENTITY(1,1) NOT NULL,
    [Address] nvarchar(50)  NOT NULL,
    [City] nvarchar(20)  NOT NULL,
    [Contact] nvarchar(50)  NOT NULL,
    [OwnerIdOwner] int  NOT NULL
);
GO

-- Creating table 'UploadedFiles'
CREATE TABLE [dbo].[UploadedFiles] (
    [IDUploadedFile] int IDENTITY(1,1) NOT NULL,
    [Name] nvarchar(50)  NOT NULL,
    [ContentType] nvarchar(20)  NOT NULL,
    [Content] varbinary(max)  NOT NULL,
    [ApartmentIDApartment] int  NOT NULL
);
GO

-- Creating table 'Owners'
CREATE TABLE [dbo].[Owners] (
    [IdOwner] int IDENTITY(1,1) NOT NULL,
    [FirstName] nvarchar(50)  NOT NULL,
    [LastName] nvarchar(50)  NOT NULL,
    [Email] nvarchar(100)  NOT NULL
);
GO

-- --------------------------------------------------
-- Creating all PRIMARY KEY constraints
-- --------------------------------------------------

-- Creating primary key on [IDApartment] in table 'Apartments'
ALTER TABLE [dbo].[Apartments]
ADD CONSTRAINT [PK_Apartments]
    PRIMARY KEY CLUSTERED ([IDApartment] ASC);
GO

-- Creating primary key on [IDUploadedFile] in table 'UploadedFiles'
ALTER TABLE [dbo].[UploadedFiles]
ADD CONSTRAINT [PK_UploadedFiles]
    PRIMARY KEY CLUSTERED ([IDUploadedFile] ASC);
GO

-- Creating primary key on [IdOwner] in table 'Owners'
ALTER TABLE [dbo].[Owners]
ADD CONSTRAINT [PK_Owners]
    PRIMARY KEY CLUSTERED ([IdOwner] ASC);
GO

-- --------------------------------------------------
-- Creating all FOREIGN KEY constraints
-- --------------------------------------------------

-- Creating foreign key on [ApartmentIDApartment] in table 'UploadedFiles'
ALTER TABLE [dbo].[UploadedFiles]
ADD CONSTRAINT [FK_ApartmentUploadedFile]
    FOREIGN KEY ([ApartmentIDApartment])
    REFERENCES [dbo].[Apartments]
        ([IDApartment])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_ApartmentUploadedFile'
CREATE INDEX [IX_FK_ApartmentUploadedFile]
ON [dbo].[UploadedFiles]
    ([ApartmentIDApartment]);
GO

-- Creating foreign key on [OwnerIdOwner] in table 'Apartments'
ALTER TABLE [dbo].[Apartments]
ADD CONSTRAINT [FK_OwnerApartment]
    FOREIGN KEY ([OwnerIdOwner])
    REFERENCES [dbo].[Owners]
        ([IdOwner])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_OwnerApartment'
CREATE INDEX [IX_FK_OwnerApartment]
ON [dbo].[Apartments]
    ([OwnerIdOwner]);
GO

-- --------------------------------------------------
-- Script has ended
-- --------------------------------------------------