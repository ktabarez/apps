CREATE TABLE [Auth].[OrgClient] (
    [Id]                   VARCHAR (250) NOT NULL,
    [Secret]               VARCHAR (MAX) NULL,
    [Name]                 VARCHAR (250) NOT NULL,
    [ClientTypeId]         INT           NOT NULL,
    [OrgId]                INT           NOT NULL,
    [RefreshTokenLifeTime] INT           NOT NULL,
    [AllowedOrigin]        VARCHAR (100) NOT NULL,
    [IsActive]             BIT           NOT NULL,
    [IsDeleted]            BIT           NOT NULL,
    [created_by]           VARCHAR (50)  NOT NULL,
    [created_dt]           DATETIME      NOT NULL,
    [modified_by]          VARCHAR (50)  NOT NULL,
    [modified_dt]          DATETIME      NOT NULL,
    CONSTRAINT [pk_OrgClient_Id_OrgId] PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT [fk_OrgClient_Org_Id] FOREIGN KEY ([OrgId]) REFERENCES [Auth].[Org] ([Id]),
    CONSTRAINT [fk_OrgClient_OrgClientType_Id] FOREIGN KEY ([ClientTypeId]) REFERENCES [Auth].[OrgClientType] ([Id]),
    UNIQUE NONCLUSTERED ([Name] ASC)
);


GO
CREATE NONCLUSTERED INDEX [IX_fk_OrgClient_Org_Id]
    ON [Auth].[OrgClient]([OrgId] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_fk_OrgClient_OrgClientType_Id]
    ON [Auth].[OrgClient]([ClientTypeId] ASC);

