CREATE TABLE [Auth].[OrgAppUser] (
    [Id]          INT          IDENTITY (1, 1) NOT NULL,
    [UserId]      INT          NOT NULL,
    [OrgAppId]    INT          NOT NULL,
    [IsActive]    BIT          CONSTRAINT [df_OrgAppUser_IsActive] DEFAULT ((1)) NOT NULL,
    [IsDeleted]   BIT          CONSTRAINT [df_OrgAppUser_IsDeleted] DEFAULT ((0)) NOT NULL,
    [created_by]  VARCHAR (50) CONSTRAINT [df_OrgAppUser_created_by] DEFAULT (user_name()) NOT NULL,
    [created_dt]  DATETIME     CONSTRAINT [df_OrgAppUser_created_dt] DEFAULT (getutcdate()) NOT NULL,
    [modified_by] VARCHAR (50) CONSTRAINT [df_OrgAppUser_modified_by] DEFAULT (user_name()) NOT NULL,
    [modified_dt] DATETIME     CONSTRAINT [df_OrgAppUser_modified_dt] DEFAULT (getutcdate()) NOT NULL,
    CONSTRAINT [pk_OrgAppUser_Id] PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT [fk_OrgAppUser_OrgApp_Id] FOREIGN KEY ([OrgAppId]) REFERENCES [Auth].[OrgApp] ([Id]),
    CONSTRAINT [fk_OrgAppUser_User_Id] FOREIGN KEY ([UserId]) REFERENCES [Auth].[OrgUser] ([Id])
);


GO
CREATE NONCLUSTERED INDEX [IX_fk_OrgAppUser_User_Id]
    ON [Auth].[OrgAppUser]([UserId] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_fk_OrgAppUser_OrgApp_Id]
    ON [Auth].[OrgAppUser]([OrgAppId] ASC);

