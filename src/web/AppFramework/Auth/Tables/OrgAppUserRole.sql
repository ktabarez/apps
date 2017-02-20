CREATE TABLE [Auth].[OrgAppUserRole] (
    [Id]           INT          IDENTITY (1, 1) NOT NULL,
    [OrgAppUserId] INT          NOT NULL,
    [OrgAppRoleId] INT          NOT NULL,
    [IsActive]     BIT          CONSTRAINT [df_OrgAppUserRole_IsActive] DEFAULT ((1)) NOT NULL,
    [IsDeleted]    BIT          CONSTRAINT [df_OrgAppUserRole_IsDeleted] DEFAULT ((0)) NOT NULL,
    [created_by]   VARCHAR (50) CONSTRAINT [df_OrgAppUserRole_created_by] DEFAULT (user_name()) NOT NULL,
    [created_dt]   DATETIME     CONSTRAINT [df_OrgAppUserRole_created_dt] DEFAULT (getutcdate()) NOT NULL,
    [modified_by]  VARCHAR (50) CONSTRAINT [df_OrgAppUserRole_modified_by] DEFAULT (user_name()) NOT NULL,
    [modified_dt]  DATETIME     CONSTRAINT [df_OrgAppUserRole_modified_dt] DEFAULT (getutcdate()) NOT NULL,
    CONSTRAINT [cpk_OrgAppUserRole_OrgAppUserId_OrgAppRoleId] PRIMARY KEY CLUSTERED ([OrgAppUserId] ASC, [OrgAppRoleId] ASC),
    CONSTRAINT [fk_OrgAppUserRole_OrgAppRole_Id] FOREIGN KEY ([OrgAppRoleId]) REFERENCES [Auth].[OrgAppRole] ([Id]),
    CONSTRAINT [fk_OrgAppUserRole_OrgAppUser_Id] FOREIGN KEY ([OrgAppUserId]) REFERENCES [Auth].[OrgAppUser] ([Id])
);


GO
CREATE NONCLUSTERED INDEX [IX_fk_OrgAppUserRole_OrgAppRole_Id]
    ON [Auth].[OrgAppUserRole]([OrgAppRoleId] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_fk_OrgAppUserRole_OrgAppUser_Id]
    ON [Auth].[OrgAppUserRole]([OrgAppUserId] ASC);

