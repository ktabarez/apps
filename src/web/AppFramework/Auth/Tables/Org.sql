CREATE TABLE [Auth].[Org] (
    [Id]          INT           IDENTITY (1, 1) NOT NULL,
    [OrgName]     VARCHAR (250) NOT NULL,
    [IsActive]    BIT           CONSTRAINT [df_Org_IsActive] DEFAULT ((1)) NOT NULL,
    [IsDeleted]   BIT           CONSTRAINT [df_Org_IsDeleted] DEFAULT ((0)) NOT NULL,
    [created_by]  VARCHAR (50)  CONSTRAINT [df_Org_created_by] DEFAULT (user_name()) NOT NULL,
    [created_dt]  DATETIME      CONSTRAINT [df_Org_created_dt] DEFAULT (getutcdate()) NOT NULL,
    [modified_by] VARCHAR (50)  CONSTRAINT [df_Org_modified_by] DEFAULT (user_name()) NOT NULL,
    [modified_dt] DATETIME      CONSTRAINT [df_Org_modified_dt] DEFAULT (getutcdate()) NOT NULL,
    CONSTRAINT [pk_Org_Id] PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT [uqc_Org_OrgName] UNIQUE NONCLUSTERED ([OrgName] ASC)
);

