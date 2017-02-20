CREATE TABLE [Auth].[OrgGlobalRole] (
    [Id]          INT           IDENTITY (1, 1) NOT NULL,
    [OrgId]       INT           NOT NULL,
    [Name]        VARCHAR (250) NOT NULL,
    [IsActive]    BIT           CONSTRAINT [df_OrgGlobalRole_IsActive] DEFAULT ((1)) NOT NULL,
    [IsDeleted]   BIT           CONSTRAINT [df_OrgGlobalRole_IsDeleted] DEFAULT ((0)) NOT NULL,
    [created_by]  VARCHAR (50)  CONSTRAINT [df_OrgGlobalRole_created_by] DEFAULT (user_name()) NOT NULL,
    [created_dt]  DATETIME      CONSTRAINT [df_OrgGlobalRole_created_dt] DEFAULT (getutcdate()) NOT NULL,
    [modified_by] VARCHAR (50)  CONSTRAINT [df_OrgGlobalRole_modified_by] DEFAULT (user_name()) NOT NULL,
    [modified_dt] DATETIME      CONSTRAINT [df_OrgGlobalRole_modified_dt] DEFAULT (getutcdate()) NOT NULL,
    CONSTRAINT [pk_OrgGlobalRole_Id] PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT [fk_OrgGlobalRole_Org_Id] FOREIGN KEY ([OrgId]) REFERENCES [Auth].[Org] ([Id])
);


GO
CREATE NONCLUSTERED INDEX [IX_fk_OrgGlobalRole_Org_Id]
    ON [Auth].[OrgGlobalRole]([OrgId] ASC);

