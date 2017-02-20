CREATE TABLE [Auth].[OrgUser] (
    [Id]                 INT           IDENTITY (1, 1) NOT NULL,
    [UserName]           VARCHAR (250) NOT NULL,
    [Email]              VARCHAR (250) NULL,
    [PhoneNumber]        VARCHAR (250) NULL,
    [PasswordHash]       VARCHAR (MAX) NULL,
    [SecurityStamp]      VARCHAR (MAX) NULL,
    [IsLockoutEnabled]   BIT           CONSTRAINT [df_OrgUser_IsLockoutEnabled] DEFAULT ((0)) NOT NULL,
    [IsTwoFactorEnabled] BIT           CONSTRAINT [df_OrgUser_IsTwoFactorEnabled] DEFAULT ((0)) NOT NULL,
    [AccessFailedCount]  INT           CONSTRAINT [df_OrgUser_AccessFailedCount] DEFAULT ((0)) NOT NULL,
    [LockoutEndDateUtc]  DATETIME      NULL,
    [Claims]             VARCHAR (MAX) NULL,
    [Logins]             VARCHAR (MAX) NULL,
    [FirstName]          VARCHAR (250) NULL,
    [LastName]           VARCHAR (250) NULL,
    [Suffix]             VARCHAR (250) NULL,
    [OrgId]              INT           NOT NULL,
    [IsActive]           BIT           CONSTRAINT [df_OrgUser_IsActive] DEFAULT ((1)) NOT NULL,
    [IsDeleted]          BIT           CONSTRAINT [df_OrgUser_IsDeleted] DEFAULT ((0)) NOT NULL,
    [created_by]         VARCHAR (50)  CONSTRAINT [df_OrgUser_created_by] DEFAULT (user_name()) NOT NULL,
    [created_dt]         DATETIME      CONSTRAINT [df_OrgUser_created_dt] DEFAULT (getutcdate()) NOT NULL,
    [modified_by]        VARCHAR (50)  CONSTRAINT [df_OrgUser_modified_by] DEFAULT (user_name()) NOT NULL,
    [modified_dt]        DATETIME      CONSTRAINT [df_OrgUser_modified_dt] DEFAULT (getutcdate()) NOT NULL,
    CONSTRAINT [pk_OrgUser_Id_OrgId] PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT [fk_OrgUser_Org_Id] FOREIGN KEY ([OrgId]) REFERENCES [Auth].[Org] ([Id])
);


GO
CREATE NONCLUSTERED INDEX [IX_fk_OrgUser_Org_Id]
    ON [Auth].[OrgUser]([OrgId] ASC);

