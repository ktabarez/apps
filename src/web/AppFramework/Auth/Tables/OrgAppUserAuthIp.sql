CREATE TABLE [Auth].[OrgAppUserAuthIp] (
    [Id]           INT          IDENTITY (1, 1) NOT NULL,
    [OrgAppUserId] INT          NOT NULL,
    [Ip]           VARCHAR (15) NOT NULL,
    [IsActive]     BIT          CONSTRAINT [df_OrgAppUserAuthIp_IsActive] DEFAULT ((1)) NOT NULL,
    [IsDeleted]    BIT          CONSTRAINT [df_OrgAppUserAuthIp_IsDeleted] DEFAULT ((0)) NOT NULL,
    [created_by]   VARCHAR (50) CONSTRAINT [df_OrgAppUserAuthIp_created_by] DEFAULT (user_name()) NOT NULL,
    [created_dt]   DATETIME     CONSTRAINT [df_OrgAppUserAuthIp_created_dt] DEFAULT (getutcdate()) NOT NULL,
    [modified_by]  VARCHAR (50) CONSTRAINT [df_OrgAppUserAuthIp_modified_by] DEFAULT (user_name()) NOT NULL,
    [modified_dt]  DATETIME     CONSTRAINT [df_OrgAppUserAuthIp_modified_dt] DEFAULT (getutcdate()) NOT NULL,
    CONSTRAINT [pk_OrgAppUserAuthIp_OrgAppUserId_Ip] PRIMARY KEY CLUSTERED ([OrgAppUserId] ASC, [Ip] ASC),
    CONSTRAINT [fk_OrgAppUserAuthIp_OrgAppUser_Id] FOREIGN KEY ([OrgAppUserId]) REFERENCES [Auth].[OrgAppUser] ([Id])
);


GO
CREATE NONCLUSTERED INDEX [IX_fk_OrgAppUserAuthIp_OrgAppUser_Id]
    ON [Auth].[OrgAppUserAuthIp]([OrgAppUserId] ASC);

