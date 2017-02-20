CREATE TABLE [Auth].[OrgClientType] (
    [Id]          INT           IDENTITY (1, 1) NOT NULL,
    [Name]        VARCHAR (250) NOT NULL,
    [OrgId]       INT           NOT NULL,
    [IsActive]    BIT           NOT NULL,
    [IsDeleted]   BIT           NOT NULL,
    [created_by]  VARCHAR (50)  NOT NULL,
    [created_dt]  DATETIME      NOT NULL,
    [modified_by] VARCHAR (50)  NOT NULL,
    [modified_dt] DATETIME      NOT NULL,
    CONSTRAINT [pk_OrgClientType_Id] PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT [fk_OrgClientType_Org_Id] FOREIGN KEY ([OrgId]) REFERENCES [Auth].[Org] ([Id]),
    UNIQUE NONCLUSTERED ([Name] ASC)
);


GO
CREATE NONCLUSTERED INDEX [IX_fk_OrgClientType_Org_Id]
    ON [Auth].[OrgClientType]([OrgId] ASC);

