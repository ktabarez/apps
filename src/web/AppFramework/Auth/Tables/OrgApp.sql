CREATE TABLE [Auth].[OrgApp] (
    [Id]          INT           IDENTITY (1, 1) NOT NULL,
    [OrgId]       INT           NOT NULL,
    [AppName]     VARCHAR (250) NOT NULL,
    [IsActive]    BIT           CONSTRAINT [df_OrgApp_IsActive] DEFAULT ((1)) NOT NULL,
    [IsDeleted]   BIT           CONSTRAINT [df_OrgApp_IsDeleted] DEFAULT ((0)) NOT NULL,
    [created_by]  VARCHAR (50)  CONSTRAINT [df_OrgApp_created_by] DEFAULT (user_name()) NOT NULL,
    [created_dt]  DATETIME      CONSTRAINT [df_OrgApp_created_dt] DEFAULT (getutcdate()) NOT NULL,
    [modified_by] VARCHAR (50)  CONSTRAINT [df_OrgApp_modified_by] DEFAULT (user_name()) NOT NULL,
    [modified_dt] DATETIME      CONSTRAINT [df_OrgApp_modified_dt] DEFAULT (getutcdate()) NOT NULL,
    CONSTRAINT [pk_OrgApp_Id] PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT [fk_OrgApp_Org_Id] FOREIGN KEY ([OrgId]) REFERENCES [Auth].[Org] ([Id])
);


GO
CREATE NONCLUSTERED INDEX [IX_fk_OrgApp_Org_Id]
    ON [Auth].[OrgApp]([OrgId] ASC);

