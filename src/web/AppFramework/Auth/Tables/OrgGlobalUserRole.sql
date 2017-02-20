CREATE TABLE [Auth].[OrgGlobalUserRole] (
    [Id]              INT          IDENTITY (1, 1) NOT NULL,
    [OrgUserId]       INT          NOT NULL,
    [OrgGlobalRoleId] INT          NOT NULL,
    [IsActive]        BIT          CONSTRAINT [df_OrgGlobalUserRole_IsActive] DEFAULT ((1)) NOT NULL,
    [IsDeleted]       BIT          CONSTRAINT [df_OrgGlobalUserRole_IsDeleted] DEFAULT ((0)) NOT NULL,
    [created_by]      VARCHAR (50) CONSTRAINT [df_OrgGlobalUserRole_created_by] DEFAULT (user_name()) NOT NULL,
    [created_dt]      DATETIME     CONSTRAINT [df_OrgGlobalUserRole_created_dt] DEFAULT (getutcdate()) NOT NULL,
    [modified_by]     VARCHAR (50) CONSTRAINT [df_OrgGlobalUserRole_modified_by] DEFAULT (user_name()) NOT NULL,
    [modified_dt]     DATETIME     CONSTRAINT [df_OrgGlobalUserRole_modified_dt] DEFAULT (getutcdate()) NOT NULL,
    CONSTRAINT [cpk_OrgGlobalUserRole_OrgUserId_OrgGlobalRoleId] PRIMARY KEY CLUSTERED ([OrgUserId] ASC, [OrgGlobalRoleId] ASC),
    CONSTRAINT [fk_OrgGlobalUserRole_OrgGlobalRole_Id] FOREIGN KEY ([OrgGlobalRoleId]) REFERENCES [Auth].[OrgGlobalRole] ([Id]),
    CONSTRAINT [fk_OrgGlobalUserRole_OrgUser_Id] FOREIGN KEY ([OrgUserId]) REFERENCES [Auth].[OrgUser] ([Id])
);


GO
CREATE NONCLUSTERED INDEX [IX_fk_OrgGlobalUserRole_OrgUser_Id]
    ON [Auth].[OrgGlobalUserRole]([OrgUserId] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_fk_OrgGlobalUserRole_OrgGlobalRole_Id]
    ON [Auth].[OrgGlobalUserRole]([OrgGlobalRoleId] ASC);

