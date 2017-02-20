CREATE TABLE [Auth].[OrgAppUserMetadata] (
    [Id]           INT          IDENTITY (1, 1) NOT NULL,
    [OrgAppUserId] INT          NOT NULL,
    [Metadata]     XML          NOT NULL,
    [created_by]   VARCHAR (50) CONSTRAINT [df_OrgAppUserMetadata_created_by] DEFAULT (user_name()) NOT NULL,
    [created_dt]   DATETIME     CONSTRAINT [df_OrgAppUserMetadata_created_dt] DEFAULT (getutcdate()) NOT NULL,
    [modified_by]  VARCHAR (50) CONSTRAINT [df_OrgAppUserMetadata_modified_by] DEFAULT (user_name()) NOT NULL,
    [modified_dt]  DATETIME     CONSTRAINT [df_OrgAppUserMetadata_modified_dt] DEFAULT (getutcdate()) NOT NULL,
    CONSTRAINT [pk_OrgAppUserMetadata_Id] PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT [fk_OrgAppUserMetadata_OrgAppUser_Id] FOREIGN KEY ([OrgAppUserId]) REFERENCES [Auth].[OrgAppUser] ([Id])
);


GO
CREATE NONCLUSTERED INDEX [IX_fk_OrgAppUserMetadata_OrgAppUser_Id]
    ON [Auth].[OrgAppUserMetadata]([OrgAppUserId] ASC);

