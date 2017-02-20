CREATE TABLE [Auth].[OrgUserRefreshToken] (
    [Id]              VARCHAR (250) NOT NULL,
    [Subject]         VARCHAR (250) NOT NULL,
    [OrgClientId]     VARCHAR (250) NOT NULL,
    [OrgUserId]       INT           NOT NULL,
    [IssuedUtc]       DATETIME      NOT NULL,
    [ExpiresUtc]      DATETIME      NOT NULL,
    [ProtectedTicket] VARCHAR (MAX) NOT NULL,
    CONSTRAINT [pk_OrgUserRefreshToken_Id] PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT [fk_OrgUserRefreshToken_OrgClient_Id] FOREIGN KEY ([OrgClientId]) REFERENCES [Auth].[OrgClient] ([Id]),
    CONSTRAINT [fk_OrgUserRefreshToken_OrgUser_Id] FOREIGN KEY ([OrgUserId]) REFERENCES [Auth].[OrgUser] ([Id])
);


GO
CREATE NONCLUSTERED INDEX [IX_fk_OrgUserRefreshToken_OrgUser_Id]
    ON [Auth].[OrgUserRefreshToken]([OrgUserId] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_fk_OrgUserRefreshToken_OrgClient_Id]
    ON [Auth].[OrgUserRefreshToken]([OrgClientId] ASC);

