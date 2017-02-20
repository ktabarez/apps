CREATE TABLE [Auth].[OrgUserRole] (
    [Id]          INT          IDENTITY (1, 1) NOT NULL,
    [OrgUserId]   INT          NOT NULL,
    [OrgRoleId]   INT          NOT NULL,
    [IsActive]    BIT          CONSTRAINT [df_OrgUserRole_IsActive] DEFAULT ((1)) NOT NULL,
    [IsDeleted]   BIT          CONSTRAINT [df_OrgUserRole_IsDeleted] DEFAULT ((0)) NOT NULL,
    [created_by]  VARCHAR (50) CONSTRAINT [df_OrgUserRole_created_by] DEFAULT (user_name()) NOT NULL,
    [created_dt]  DATETIME     CONSTRAINT [df_OrgUserRole_created_dt] DEFAULT (getutcdate()) NOT NULL,
    [modified_by] VARCHAR (50) CONSTRAINT [df_OrgUserRole_modified_by] DEFAULT (user_name()) NOT NULL,
    [modified_dt] DATETIME     CONSTRAINT [df_OrgUserRole_modified_dt] DEFAULT (getutcdate()) NOT NULL,
    CONSTRAINT [cpk_OrgUserRole_OrgUserId_OrgRoleId] PRIMARY KEY CLUSTERED ([OrgUserId] ASC, [OrgRoleId] ASC),
    CONSTRAINT [fk_OrgUserRole_OrgRole_Id] FOREIGN KEY ([OrgRoleId]) REFERENCES [Auth].[OrgRole] ([Id]),
    CONSTRAINT [fk_OrgUserRole_OrgUser_Id] FOREIGN KEY ([OrgUserId]) REFERENCES [Auth].[OrgUser] ([Id])
);


GO
CREATE NONCLUSTERED INDEX [IX_fk_OrgUserRole_OrgUser_Id]
    ON [Auth].[OrgUserRole]([OrgUserId] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_fk_OrgUserRole_OrgRole_Id]
    ON [Auth].[OrgUserRole]([OrgRoleId] ASC);

