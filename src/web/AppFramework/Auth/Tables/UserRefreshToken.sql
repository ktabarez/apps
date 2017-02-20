CREATE TABLE [Auth].[UserRefreshToken] (
    [Id]                UNIQUEIDENTIFIER   NOT NULL,
    [Username]          VARCHAR (250)      NOT NULL,
    [AccessToken]       VARCHAR (MAX)      NOT NULL,
    [ExpirationDateUtc] DATETIMEOFFSET (7) NOT NULL,
    [IssuedDateUtc]     DATETIMEOFFSET (7) NOT NULL,
    [created_by]        VARCHAR (50)       CONSTRAINT [df_UserRefreshToken_created_by] DEFAULT (user_name()) NOT NULL,
    [created_dt]        DATETIME           CONSTRAINT [df_UserRefreshToken_created_dt] DEFAULT (getutcdate()) NOT NULL,
    [modified_by]       VARCHAR (50)       CONSTRAINT [df_UserRefreshToken_modified_by] DEFAULT (user_name()) NOT NULL,
    [modified_dt]       DATETIME           CONSTRAINT [df_UserRefreshToken_modified_dt] DEFAULT (getutcdate()) NOT NULL,
    CONSTRAINT [pk_UserRefreshToken_Id] PRIMARY KEY CLUSTERED ([Id] ASC)
);

