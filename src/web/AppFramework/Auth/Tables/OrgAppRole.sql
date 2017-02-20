CREATE TABLE [Auth].[OrgAppRole] (
    [Id]          INT           IDENTITY (1, 1) NOT NULL,
    [OrgAppId]    INT           NOT NULL,
    [Name]        VARCHAR (250) NOT NULL,
    [IsActive]    BIT           CONSTRAINT [df_OrgAppRole_IsActive] DEFAULT ((1)) NOT NULL,
    [IsDeleted]   BIT           CONSTRAINT [df_OrgAppRole_IsDeleted] DEFAULT ((0)) NOT NULL,
    [created_by]  VARCHAR (50)  CONSTRAINT [df_OrgAppRole_created_by] DEFAULT (user_name()) NOT NULL,
    [created_dt]  DATETIME      CONSTRAINT [df_OrgAppRole_created_dt] DEFAULT (getutcdate()) NOT NULL,
    [modified_by] VARCHAR (50)  CONSTRAINT [df_OrgAppRole_modified_by] DEFAULT (user_name()) NOT NULL,
    [modified_dt] DATETIME      CONSTRAINT [df_OrgAppRole_modified_dt] DEFAULT (getutcdate()) NOT NULL,
    CONSTRAINT [pk_OrgAppRole_Id] PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT [fk_OrgAppRole_OrgApp_Id] FOREIGN KEY ([OrgAppId]) REFERENCES [Auth].[OrgApp] ([Id])
);


GO
CREATE NONCLUSTERED INDEX [IX_fk_OrgAppRole_OrgApp_Id]
    ON [Auth].[OrgAppRole]([OrgAppId] ASC);

