/*
Post-Deployment Script Template							
--------------------------------------------------------------------------------------
 This file contains SQL statements that will be appended to the build script.		
 Use SQLCMD syntax to include a file in the post-deployment script.			
 Example:      :r .\myfile.sql								
 Use SQLCMD syntax to reference a variable in the post-deployment script.		
 Example:      :setvar TableName MyTable							
               SELECT * FROM [$(TableName)]					
--------------------------------------------------------------------------------------
*/
USE [AppFramework]
GO
SET IDENTITY_INSERT [Auth].[Org] ON 

GO
INSERT [Auth].[Org] ([Id], [OrgName], [IsActive], [IsDeleted], [created_by], [created_dt], [modified_by], [modified_dt]) VALUES (1, N'mfcu', 1, 0, N'someone', CAST(N'2017-01-19T01:43:37.127' AS DateTime), N'someone', CAST(N'2017-01-19T01:43:37.127' AS DateTime))
GO
SET IDENTITY_INSERT [Auth].[Org] OFF
GO
SET IDENTITY_INSERT [Auth].[OrgUser] ON 

GO
INSERT [Auth].[OrgUser] ([Id], [UserName], [Email], [PhoneNumber], [PasswordHash], [SecurityStamp], [IsLockoutEnabled], [IsTwoFactorEnabled], [AccessFailedCount], [LockoutEndDateUtc], [Claims], [Logins], [FirstName], [LastName], [Suffix], [OrgId], [IsActive], [IsDeleted], [created_by], [created_dt], [modified_by], [modified_dt]) VALUES (1, N'FIRSTAGAIN\kain.tabarez', N'kain.tabarez@domainname.com', NULL, NULL, NULL, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, 1, 1, 0, N'FIRSTAGAIN\kain.tabarez', CAST(N'2017-01-19T01:44:50.457' AS DateTime), N'FIRSTAGAIN\kain.tabarez', CAST(N'2017-01-19T01:44:50.457' AS DateTime))
GO
INSERT [Auth].[OrgUser] ([Id], [UserName], [Email], [PhoneNumber], [PasswordHash], [SecurityStamp], [IsLockoutEnabled], [IsTwoFactorEnabled], [AccessFailedCount], [LockoutEndDateUtc], [Claims], [Logins], [FirstName], [LastName], [Suffix], [OrgId], [IsActive], [IsDeleted], [created_by], [created_dt], [modified_by], [modified_dt]) VALUES (2, N'FIRSTAGAIN\AdamC', N'adamc@domainname.com', NULL, NULL, NULL, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, 1, 1, 0, N'FIRSTAGAIN\kain.tabarez', CAST(N'2017-01-19T01:44:50.800' AS DateTime), N'FIRSTAGAIN\kain.tabarez', CAST(N'2017-01-19T01:44:50.800' AS DateTime))
GO
INSERT [Auth].[OrgUser] ([Id], [UserName], [Email], [PhoneNumber], [PasswordHash], [SecurityStamp], [IsLockoutEnabled], [IsTwoFactorEnabled], [AccessFailedCount], [LockoutEndDateUtc], [Claims], [Logins], [FirstName], [LastName], [Suffix], [OrgId], [IsActive], [IsDeleted], [created_by], [created_dt], [modified_by], [modified_dt]) VALUES (3, N'FIRSTAGAIN\AngieL', N'angiel@domainname.com', NULL, NULL, NULL, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, 1, 1, 0, N'FIRSTAGAIN\kain.tabarez', CAST(N'2017-01-19T01:44:50.887' AS DateTime), N'FIRSTAGAIN\kain.tabarez', CAST(N'2017-01-19T01:44:50.887' AS DateTime))
GO
INSERT [Auth].[OrgUser] ([Id], [UserName], [Email], [PhoneNumber], [PasswordHash], [SecurityStamp], [IsLockoutEnabled], [IsTwoFactorEnabled], [AccessFailedCount], [LockoutEndDateUtc], [Claims], [Logins], [FirstName], [LastName], [Suffix], [OrgId], [IsActive], [IsDeleted], [created_by], [created_dt], [modified_by], [modified_dt]) VALUES (4, N'FIRSTAGAIN\BrendaL', N'brendal@domainname.com', NULL, NULL, NULL, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, 1, 1, 0, N'FIRSTAGAIN\kain.tabarez', CAST(N'2017-01-19T01:44:51.000' AS DateTime), N'FIRSTAGAIN\kain.tabarez', CAST(N'2017-01-19T01:44:51.000' AS DateTime))
GO
INSERT [Auth].[OrgUser] ([Id], [UserName], [Email], [PhoneNumber], [PasswordHash], [SecurityStamp], [IsLockoutEnabled], [IsTwoFactorEnabled], [AccessFailedCount], [LockoutEndDateUtc], [Claims], [Logins], [FirstName], [LastName], [Suffix], [OrgId], [IsActive], [IsDeleted], [created_by], [created_dt], [modified_by], [modified_dt]) VALUES (5, N'FIRSTAGAIN\CorinneG', N'corinneg@domainname.com', NULL, NULL, NULL, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, 1, 1, 0, N'FIRSTAGAIN\kain.tabarez', CAST(N'2017-01-19T01:44:51.077' AS DateTime), N'FIRSTAGAIN\kain.tabarez', CAST(N'2017-01-19T01:44:51.077' AS DateTime))
GO
INSERT [Auth].[OrgUser] ([Id], [UserName], [Email], [PhoneNumber], [PasswordHash], [SecurityStamp], [IsLockoutEnabled], [IsTwoFactorEnabled], [AccessFailedCount], [LockoutEndDateUtc], [Claims], [Logins], [FirstName], [LastName], [Suffix], [OrgId], [IsActive], [IsDeleted], [created_by], [created_dt], [modified_by], [modified_dt]) VALUES (6, N'FIRSTAGAIN\DanC', N'danc@domainname.com', NULL, NULL, NULL, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, 1, 1, 0, N'FIRSTAGAIN\kain.tabarez', CAST(N'2017-01-19T01:44:51.153' AS DateTime), N'FIRSTAGAIN\kain.tabarez', CAST(N'2017-01-19T01:44:51.153' AS DateTime))
GO
INSERT [Auth].[OrgUser] ([Id], [UserName], [Email], [PhoneNumber], [PasswordHash], [SecurityStamp], [IsLockoutEnabled], [IsTwoFactorEnabled], [AccessFailedCount], [LockoutEndDateUtc], [Claims], [Logins], [FirstName], [LastName], [Suffix], [OrgId], [IsActive], [IsDeleted], [created_by], [created_dt], [modified_by], [modified_dt]) VALUES (7, N'FIRSTAGAIN\DawnV', N'dawnv@domainname.com', NULL, NULL, NULL, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, 1, 1, 0, N'FIRSTAGAIN\kain.tabarez', CAST(N'2017-01-19T01:44:51.270' AS DateTime), N'FIRSTAGAIN\kain.tabarez', CAST(N'2017-01-19T01:44:51.270' AS DateTime))
GO
INSERT [Auth].[OrgUser] ([Id], [UserName], [Email], [PhoneNumber], [PasswordHash], [SecurityStamp], [IsLockoutEnabled], [IsTwoFactorEnabled], [AccessFailedCount], [LockoutEndDateUtc], [Claims], [Logins], [FirstName], [LastName], [Suffix], [OrgId], [IsActive], [IsDeleted], [created_by], [created_dt], [modified_by], [modified_dt]) VALUES (8, N'FIRSTAGAIN\DebraS', N'debras@domainname.com', NULL, NULL, NULL, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, 1, 1, 0, N'FIRSTAGAIN\kain.tabarez', CAST(N'2017-01-19T01:44:51.397' AS DateTime), N'FIRSTAGAIN\kain.tabarez', CAST(N'2017-01-19T01:44:51.397' AS DateTime))
GO
INSERT [Auth].[OrgUser] ([Id], [UserName], [Email], [PhoneNumber], [PasswordHash], [SecurityStamp], [IsLockoutEnabled], [IsTwoFactorEnabled], [AccessFailedCount], [LockoutEndDateUtc], [Claims], [Logins], [FirstName], [LastName], [Suffix], [OrgId], [IsActive], [IsDeleted], [created_by], [created_dt], [modified_by], [modified_dt]) VALUES (9, N'FIRSTAGAIN\DeclanC', N'declanc@domainname.com', NULL, NULL, NULL, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, 1, 1, 0, N'FIRSTAGAIN\kain.tabarez', CAST(N'2017-01-19T01:44:51.487' AS DateTime), N'FIRSTAGAIN\kain.tabarez', CAST(N'2017-01-19T01:44:51.487' AS DateTime))
GO
INSERT [Auth].[OrgUser] ([Id], [UserName], [Email], [PhoneNumber], [PasswordHash], [SecurityStamp], [IsLockoutEnabled], [IsTwoFactorEnabled], [AccessFailedCount], [LockoutEndDateUtc], [Claims], [Logins], [FirstName], [LastName], [Suffix], [OrgId], [IsActive], [IsDeleted], [created_by], [created_dt], [modified_by], [modified_dt]) VALUES (10, N'FIRSTAGAIN\DianaCL', N'dianacl@domainname.com', NULL, NULL, NULL, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, 1, 1, 0, N'FIRSTAGAIN\kain.tabarez', CAST(N'2017-01-19T01:44:51.583' AS DateTime), N'FIRSTAGAIN\kain.tabarez', CAST(N'2017-01-19T01:44:51.583' AS DateTime))
GO
INSERT [Auth].[OrgUser] ([Id], [UserName], [Email], [PhoneNumber], [PasswordHash], [SecurityStamp], [IsLockoutEnabled], [IsTwoFactorEnabled], [AccessFailedCount], [LockoutEndDateUtc], [Claims], [Logins], [FirstName], [LastName], [Suffix], [OrgId], [IsActive], [IsDeleted], [created_by], [created_dt], [modified_by], [modified_dt]) VALUES (11, N'FIRSTAGAIN\DonnaH', N'donnah@domainname.com', NULL, NULL, NULL, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, 1, 1, 0, N'FIRSTAGAIN\kain.tabarez', CAST(N'2017-01-19T01:44:51.700' AS DateTime), N'FIRSTAGAIN\kain.tabarez', CAST(N'2017-01-19T01:44:51.700' AS DateTime))
GO
INSERT [Auth].[OrgUser] ([Id], [UserName], [Email], [PhoneNumber], [PasswordHash], [SecurityStamp], [IsLockoutEnabled], [IsTwoFactorEnabled], [AccessFailedCount], [LockoutEndDateUtc], [Claims], [Logins], [FirstName], [LastName], [Suffix], [OrgId], [IsActive], [IsDeleted], [created_by], [created_dt], [modified_by], [modified_dt]) VALUES (12, N'FIRSTAGAIN\DougL', N'dougl@domainname.com', NULL, NULL, NULL, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, 1, 1, 0, N'FIRSTAGAIN\kain.tabarez', CAST(N'2017-01-19T01:44:51.790' AS DateTime), N'FIRSTAGAIN\kain.tabarez', CAST(N'2017-01-19T01:44:51.790' AS DateTime))
GO
INSERT [Auth].[OrgUser] ([Id], [UserName], [Email], [PhoneNumber], [PasswordHash], [SecurityStamp], [IsLockoutEnabled], [IsTwoFactorEnabled], [AccessFailedCount], [LockoutEndDateUtc], [Claims], [Logins], [FirstName], [LastName], [Suffix], [OrgId], [IsActive], [IsDeleted], [created_by], [created_dt], [modified_by], [modified_dt]) VALUES (13, N'FIRSTAGAIN\DougW', N'dougw@domainname.com', NULL, NULL, NULL, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, 1, 1, 0, N'FIRSTAGAIN\kain.tabarez', CAST(N'2017-01-19T01:44:51.880' AS DateTime), N'FIRSTAGAIN\kain.tabarez', CAST(N'2017-01-19T01:44:51.880' AS DateTime))
GO
INSERT [Auth].[OrgUser] ([Id], [UserName], [Email], [PhoneNumber], [PasswordHash], [SecurityStamp], [IsLockoutEnabled], [IsTwoFactorEnabled], [AccessFailedCount], [LockoutEndDateUtc], [Claims], [Logins], [FirstName], [LastName], [Suffix], [OrgId], [IsActive], [IsDeleted], [created_by], [created_dt], [modified_by], [modified_dt]) VALUES (14, N'FIRSTAGAIN\ErikaG', N'erikag@domainname.com', NULL, NULL, NULL, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, 1, 1, 0, N'FIRSTAGAIN\kain.tabarez', CAST(N'2017-01-19T01:44:51.977' AS DateTime), N'FIRSTAGAIN\kain.tabarez', CAST(N'2017-01-19T01:44:51.977' AS DateTime))
GO
INSERT [Auth].[OrgUser] ([Id], [UserName], [Email], [PhoneNumber], [PasswordHash], [SecurityStamp], [IsLockoutEnabled], [IsTwoFactorEnabled], [AccessFailedCount], [LockoutEndDateUtc], [Claims], [Logins], [FirstName], [LastName], [Suffix], [OrgId], [IsActive], [IsDeleted], [created_by], [created_dt], [modified_by], [modified_dt]) VALUES (15, N'FIRSTAGAIN\EveB', N'eveb@domainname.com', NULL, NULL, NULL, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, 1, 1, 0, N'FIRSTAGAIN\kain.tabarez', CAST(N'2017-01-19T01:44:52.137' AS DateTime), N'FIRSTAGAIN\kain.tabarez', CAST(N'2017-01-19T01:44:52.137' AS DateTime))
GO
INSERT [Auth].[OrgUser] ([Id], [UserName], [Email], [PhoneNumber], [PasswordHash], [SecurityStamp], [IsLockoutEnabled], [IsTwoFactorEnabled], [AccessFailedCount], [LockoutEndDateUtc], [Claims], [Logins], [FirstName], [LastName], [Suffix], [OrgId], [IsActive], [IsDeleted], [created_by], [created_dt], [modified_by], [modified_dt]) VALUES (16, N'FIRSTAGAIN\GaryD', N'garyd@domainname.com', NULL, NULL, NULL, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, 1, 1, 0, N'FIRSTAGAIN\kain.tabarez', CAST(N'2017-01-19T01:44:52.263' AS DateTime), N'FIRSTAGAIN\kain.tabarez', CAST(N'2017-01-19T01:44:52.263' AS DateTime))
GO
INSERT [Auth].[OrgUser] ([Id], [UserName], [Email], [PhoneNumber], [PasswordHash], [SecurityStamp], [IsLockoutEnabled], [IsTwoFactorEnabled], [AccessFailedCount], [LockoutEndDateUtc], [Claims], [Logins], [FirstName], [LastName], [Suffix], [OrgId], [IsActive], [IsDeleted], [created_by], [created_dt], [modified_by], [modified_dt]) VALUES (17, N'FIRSTAGAIN\HerlindaS', N'herlindas@domainname.com', NULL, NULL, NULL, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, 1, 1, 0, N'FIRSTAGAIN\kain.tabarez', CAST(N'2017-01-19T01:44:52.363' AS DateTime), N'FIRSTAGAIN\kain.tabarez', CAST(N'2017-01-19T01:44:52.363' AS DateTime))
GO
INSERT [Auth].[OrgUser] ([Id], [UserName], [Email], [PhoneNumber], [PasswordHash], [SecurityStamp], [IsLockoutEnabled], [IsTwoFactorEnabled], [AccessFailedCount], [LockoutEndDateUtc], [Claims], [Logins], [FirstName], [LastName], [Suffix], [OrgId], [IsActive], [IsDeleted], [created_by], [created_dt], [modified_by], [modified_dt]) VALUES (18, N'FIRSTAGAIN\JacindaK', N'jacindak@domainname.com', NULL, NULL, NULL, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, 1, 1, 0, N'FIRSTAGAIN\kain.tabarez', CAST(N'2017-01-19T01:44:52.460' AS DateTime), N'FIRSTAGAIN\kain.tabarez', CAST(N'2017-01-19T01:44:52.460' AS DateTime))
GO
INSERT [Auth].[OrgUser] ([Id], [UserName], [Email], [PhoneNumber], [PasswordHash], [SecurityStamp], [IsLockoutEnabled], [IsTwoFactorEnabled], [AccessFailedCount], [LockoutEndDateUtc], [Claims], [Logins], [FirstName], [LastName], [Suffix], [OrgId], [IsActive], [IsDeleted], [created_by], [created_dt], [modified_by], [modified_dt]) VALUES (19, N'FIRSTAGAIN\JeanineD', N'jeanined@domainname.com', NULL, NULL, NULL, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, 1, 1, 0, N'FIRSTAGAIN\kain.tabarez', CAST(N'2017-01-19T01:44:52.573' AS DateTime), N'FIRSTAGAIN\kain.tabarez', CAST(N'2017-01-19T01:44:52.573' AS DateTime))
GO
INSERT [Auth].[OrgUser] ([Id], [UserName], [Email], [PhoneNumber], [PasswordHash], [SecurityStamp], [IsLockoutEnabled], [IsTwoFactorEnabled], [AccessFailedCount], [LockoutEndDateUtc], [Claims], [Logins], [FirstName], [LastName], [Suffix], [OrgId], [IsActive], [IsDeleted], [created_by], [created_dt], [modified_by], [modified_dt]) VALUES (20, N'FIRSTAGAIN\JessicaS', N'jessicas@domainname.com', NULL, NULL, NULL, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, 1, 1, 0, N'FIRSTAGAIN\kain.tabarez', CAST(N'2017-01-19T01:44:52.653' AS DateTime), N'FIRSTAGAIN\kain.tabarez', CAST(N'2017-01-19T01:44:52.653' AS DateTime))
GO
INSERT [Auth].[OrgUser] ([Id], [UserName], [Email], [PhoneNumber], [PasswordHash], [SecurityStamp], [IsLockoutEnabled], [IsTwoFactorEnabled], [AccessFailedCount], [LockoutEndDateUtc], [Claims], [Logins], [FirstName], [LastName], [Suffix], [OrgId], [IsActive], [IsDeleted], [created_by], [created_dt], [modified_by], [modified_dt]) VALUES (21, N'FIRSTAGAIN\JohnC', N'johnc@domainname.com', NULL, NULL, NULL, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, 1, 1, 0, N'FIRSTAGAIN\kain.tabarez', CAST(N'2017-01-19T01:44:52.753' AS DateTime), N'FIRSTAGAIN\kain.tabarez', CAST(N'2017-01-19T01:44:52.753' AS DateTime))
GO
INSERT [Auth].[OrgUser] ([Id], [UserName], [Email], [PhoneNumber], [PasswordHash], [SecurityStamp], [IsLockoutEnabled], [IsTwoFactorEnabled], [AccessFailedCount], [LockoutEndDateUtc], [Claims], [Logins], [FirstName], [LastName], [Suffix], [OrgId], [IsActive], [IsDeleted], [created_by], [created_dt], [modified_by], [modified_dt]) VALUES (22, N'FIRSTAGAIN\JohnJ', N'johnj@domainname.com', NULL, NULL, NULL, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, 1, 1, 0, N'FIRSTAGAIN\kain.tabarez', CAST(N'2017-01-19T01:44:52.880' AS DateTime), N'FIRSTAGAIN\kain.tabarez', CAST(N'2017-01-19T01:44:52.880' AS DateTime))
GO
INSERT [Auth].[OrgUser] ([Id], [UserName], [Email], [PhoneNumber], [PasswordHash], [SecurityStamp], [IsLockoutEnabled], [IsTwoFactorEnabled], [AccessFailedCount], [LockoutEndDateUtc], [Claims], [Logins], [FirstName], [LastName], [Suffix], [OrgId], [IsActive], [IsDeleted], [created_by], [created_dt], [modified_by], [modified_dt]) VALUES (23, N'FIRSTAGAIN\KarenP', N'karenp@domainname.com', NULL, NULL, NULL, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, 1, 1, 0, N'FIRSTAGAIN\kain.tabarez', CAST(N'2017-01-19T01:44:52.980' AS DateTime), N'FIRSTAGAIN\kain.tabarez', CAST(N'2017-01-19T01:44:52.980' AS DateTime))
GO
INSERT [Auth].[OrgUser] ([Id], [UserName], [Email], [PhoneNumber], [PasswordHash], [SecurityStamp], [IsLockoutEnabled], [IsTwoFactorEnabled], [AccessFailedCount], [LockoutEndDateUtc], [Claims], [Logins], [FirstName], [LastName], [Suffix], [OrgId], [IsActive], [IsDeleted], [created_by], [created_dt], [modified_by], [modified_dt]) VALUES (24, N'FIRSTAGAIN\Lesleya', N'lesleya@domainname.com', NULL, NULL, NULL, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, 1, 1, 0, N'FIRSTAGAIN\kain.tabarez', CAST(N'2017-01-19T01:44:53.077' AS DateTime), N'FIRSTAGAIN\kain.tabarez', CAST(N'2017-01-19T01:44:53.077' AS DateTime))
GO
INSERT [Auth].[OrgUser] ([Id], [UserName], [Email], [PhoneNumber], [PasswordHash], [SecurityStamp], [IsLockoutEnabled], [IsTwoFactorEnabled], [AccessFailedCount], [LockoutEndDateUtc], [Claims], [Logins], [FirstName], [LastName], [Suffix], [OrgId], [IsActive], [IsDeleted], [created_by], [created_dt], [modified_by], [modified_dt]) VALUES (25, N'FIRSTAGAIN\LindaB', N'lindab@domainname.com', NULL, NULL, NULL, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, 1, 1, 0, N'FIRSTAGAIN\kain.tabarez', CAST(N'2017-01-19T01:44:53.183' AS DateTime), N'FIRSTAGAIN\kain.tabarez', CAST(N'2017-01-19T01:44:53.183' AS DateTime))
GO
INSERT [Auth].[OrgUser] ([Id], [UserName], [Email], [PhoneNumber], [PasswordHash], [SecurityStamp], [IsLockoutEnabled], [IsTwoFactorEnabled], [AccessFailedCount], [LockoutEndDateUtc], [Claims], [Logins], [FirstName], [LastName], [Suffix], [OrgId], [IsActive], [IsDeleted], [created_by], [created_dt], [modified_by], [modified_dt]) VALUES (26, N'FIRSTAGAIN\LisaC', N'lisac@domainname.com', NULL, NULL, NULL, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, 1, 1, 0, N'FIRSTAGAIN\kain.tabarez', CAST(N'2017-01-19T01:44:53.293' AS DateTime), N'FIRSTAGAIN\kain.tabarez', CAST(N'2017-01-19T01:44:53.293' AS DateTime))
GO
INSERT [Auth].[OrgUser] ([Id], [UserName], [Email], [PhoneNumber], [PasswordHash], [SecurityStamp], [IsLockoutEnabled], [IsTwoFactorEnabled], [AccessFailedCount], [LockoutEndDateUtc], [Claims], [Logins], [FirstName], [LastName], [Suffix], [OrgId], [IsActive], [IsDeleted], [created_by], [created_dt], [modified_by], [modified_dt]) VALUES (27, N'FIRSTAGAIN\LisaT', N'lisat@domainname.com', NULL, NULL, NULL, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, 1, 1, 0, N'FIRSTAGAIN\kain.tabarez', CAST(N'2017-01-19T01:44:53.373' AS DateTime), N'FIRSTAGAIN\kain.tabarez', CAST(N'2017-01-19T01:44:53.373' AS DateTime))
GO
INSERT [Auth].[OrgUser] ([Id], [UserName], [Email], [PhoneNumber], [PasswordHash], [SecurityStamp], [IsLockoutEnabled], [IsTwoFactorEnabled], [AccessFailedCount], [LockoutEndDateUtc], [Claims], [Logins], [FirstName], [LastName], [Suffix], [OrgId], [IsActive], [IsDeleted], [created_by], [created_dt], [modified_by], [modified_dt]) VALUES (28, N'FIRSTAGAIN\LizS', N'lizs@domainname.com', NULL, NULL, NULL, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, 1, 1, 0, N'FIRSTAGAIN\kain.tabarez', CAST(N'2017-01-19T01:44:53.490' AS DateTime), N'FIRSTAGAIN\kain.tabarez', CAST(N'2017-01-19T01:44:53.490' AS DateTime))
GO
INSERT [Auth].[OrgUser] ([Id], [UserName], [Email], [PhoneNumber], [PasswordHash], [SecurityStamp], [IsLockoutEnabled], [IsTwoFactorEnabled], [AccessFailedCount], [LockoutEndDateUtc], [Claims], [Logins], [FirstName], [LastName], [Suffix], [OrgId], [IsActive], [IsDeleted], [created_by], [created_dt], [modified_by], [modified_dt]) VALUES (29, N'FIRSTAGAIN\MariaN', N'marian@domainname.com', NULL, NULL, NULL, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, 1, 1, 0, N'FIRSTAGAIN\kain.tabarez', CAST(N'2017-01-19T01:44:53.607' AS DateTime), N'FIRSTAGAIN\kain.tabarez', CAST(N'2017-01-19T01:44:53.607' AS DateTime))
GO
INSERT [Auth].[OrgUser] ([Id], [UserName], [Email], [PhoneNumber], [PasswordHash], [SecurityStamp], [IsLockoutEnabled], [IsTwoFactorEnabled], [AccessFailedCount], [LockoutEndDateUtc], [Claims], [Logins], [FirstName], [LastName], [Suffix], [OrgId], [IsActive], [IsDeleted], [created_by], [created_dt], [modified_by], [modified_dt]) VALUES (30, N'FIRSTAGAIN\MaryW', N'maryw@domainname.com', NULL, NULL, NULL, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, 1, 1, 0, N'FIRSTAGAIN\kain.tabarez', CAST(N'2017-01-19T01:44:53.687' AS DateTime), N'FIRSTAGAIN\kain.tabarez', CAST(N'2017-01-19T01:44:53.687' AS DateTime))
GO
INSERT [Auth].[OrgUser] ([Id], [UserName], [Email], [PhoneNumber], [PasswordHash], [SecurityStamp], [IsLockoutEnabled], [IsTwoFactorEnabled], [AccessFailedCount], [LockoutEndDateUtc], [Claims], [Logins], [FirstName], [LastName], [Suffix], [OrgId], [IsActive], [IsDeleted], [created_by], [created_dt], [modified_by], [modified_dt]) VALUES (31, N'FIRSTAGAIN\MikeM', N'mikem@domainname.com', NULL, NULL, NULL, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, 1, 1, 0, N'FIRSTAGAIN\kain.tabarez', CAST(N'2017-01-19T01:44:53.803' AS DateTime), N'FIRSTAGAIN\kain.tabarez', CAST(N'2017-01-19T01:44:53.803' AS DateTime))
GO
INSERT [Auth].[OrgUser] ([Id], [UserName], [Email], [PhoneNumber], [PasswordHash], [SecurityStamp], [IsLockoutEnabled], [IsTwoFactorEnabled], [AccessFailedCount], [LockoutEndDateUtc], [Claims], [Logins], [FirstName], [LastName], [Suffix], [OrgId], [IsActive], [IsDeleted], [created_by], [created_dt], [modified_by], [modified_dt]) VALUES (32, N'FIRSTAGAIN\MillieG', N'millieg@domainname.com', NULL, NULL, NULL, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, 1, 1, 0, N'FIRSTAGAIN\kain.tabarez', CAST(N'2017-01-19T01:44:53.903' AS DateTime), N'FIRSTAGAIN\kain.tabarez', CAST(N'2017-01-19T01:44:53.903' AS DateTime))
GO
INSERT [Auth].[OrgUser] ([Id], [UserName], [Email], [PhoneNumber], [PasswordHash], [SecurityStamp], [IsLockoutEnabled], [IsTwoFactorEnabled], [AccessFailedCount], [LockoutEndDateUtc], [Claims], [Logins], [FirstName], [LastName], [Suffix], [OrgId], [IsActive], [IsDeleted], [created_by], [created_dt], [modified_by], [modified_dt]) VALUES (33, N'FIRSTAGAIN\NathanM', N'nathanm@domainname.com', NULL, NULL, NULL, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, 1, 1, 0, N'FIRSTAGAIN\kain.tabarez', CAST(N'2017-01-19T01:44:54.037' AS DateTime), N'FIRSTAGAIN\kain.tabarez', CAST(N'2017-01-19T01:44:54.037' AS DateTime))
GO
INSERT [Auth].[OrgUser] ([Id], [UserName], [Email], [PhoneNumber], [PasswordHash], [SecurityStamp], [IsLockoutEnabled], [IsTwoFactorEnabled], [AccessFailedCount], [LockoutEndDateUtc], [Claims], [Logins], [FirstName], [LastName], [Suffix], [OrgId], [IsActive], [IsDeleted], [created_by], [created_dt], [modified_by], [modified_dt]) VALUES (34, N'FIRSTAGAIN\NevilleB', N'nevilleb@domainname.com', NULL, NULL, NULL, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, 1, 1, 0, N'FIRSTAGAIN\kain.tabarez', CAST(N'2017-01-19T01:44:54.147' AS DateTime), N'FIRSTAGAIN\kain.tabarez', CAST(N'2017-01-19T01:44:54.147' AS DateTime))
GO
INSERT [Auth].[OrgUser] ([Id], [UserName], [Email], [PhoneNumber], [PasswordHash], [SecurityStamp], [IsLockoutEnabled], [IsTwoFactorEnabled], [AccessFailedCount], [LockoutEndDateUtc], [Claims], [Logins], [FirstName], [LastName], [Suffix], [OrgId], [IsActive], [IsDeleted], [created_by], [created_dt], [modified_by], [modified_dt]) VALUES (35, N'FIRSTAGAIN\PaulaM', N'paulam@domainname.com', NULL, NULL, NULL, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, 1, 1, 0, N'FIRSTAGAIN\kain.tabarez', CAST(N'2017-01-19T01:44:54.250' AS DateTime), N'FIRSTAGAIN\kain.tabarez', CAST(N'2017-01-19T01:44:54.250' AS DateTime))
GO
INSERT [Auth].[OrgUser] ([Id], [UserName], [Email], [PhoneNumber], [PasswordHash], [SecurityStamp], [IsLockoutEnabled], [IsTwoFactorEnabled], [AccessFailedCount], [LockoutEndDateUtc], [Claims], [Logins], [FirstName], [LastName], [Suffix], [OrgId], [IsActive], [IsDeleted], [created_by], [created_dt], [modified_by], [modified_dt]) VALUES (36, N'FIRSTAGAIN\PaulM', N'paulm@domainname.com', NULL, NULL, NULL, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, 1, 1, 0, N'FIRSTAGAIN\kain.tabarez', CAST(N'2017-01-19T01:44:54.333' AS DateTime), N'FIRSTAGAIN\kain.tabarez', CAST(N'2017-01-19T01:44:54.333' AS DateTime))
GO
INSERT [Auth].[OrgUser] ([Id], [UserName], [Email], [PhoneNumber], [PasswordHash], [SecurityStamp], [IsLockoutEnabled], [IsTwoFactorEnabled], [AccessFailedCount], [LockoutEndDateUtc], [Claims], [Logins], [FirstName], [LastName], [Suffix], [OrgId], [IsActive], [IsDeleted], [created_by], [created_dt], [modified_by], [modified_dt]) VALUES (37, N'FIRSTAGAIN\RobM', N'robm@domainname.com', NULL, NULL, NULL, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, 1, 1, 0, N'FIRSTAGAIN\kain.tabarez', CAST(N'2017-01-19T01:44:54.480' AS DateTime), N'FIRSTAGAIN\kain.tabarez', CAST(N'2017-01-19T01:44:54.480' AS DateTime))
GO
INSERT [Auth].[OrgUser] ([Id], [UserName], [Email], [PhoneNumber], [PasswordHash], [SecurityStamp], [IsLockoutEnabled], [IsTwoFactorEnabled], [AccessFailedCount], [LockoutEndDateUtc], [Claims], [Logins], [FirstName], [LastName], [Suffix], [OrgId], [IsActive], [IsDeleted], [created_by], [created_dt], [modified_by], [modified_dt]) VALUES (38, N'FIRSTAGAIN\SamuelM', N'samuelm@domainname.com', NULL, NULL, NULL, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, 1, 1, 0, N'FIRSTAGAIN\kain.tabarez', CAST(N'2017-01-19T01:44:54.560' AS DateTime), N'FIRSTAGAIN\kain.tabarez', CAST(N'2017-01-19T01:44:54.560' AS DateTime))
GO
INSERT [Auth].[OrgUser] ([Id], [UserName], [Email], [PhoneNumber], [PasswordHash], [SecurityStamp], [IsLockoutEnabled], [IsTwoFactorEnabled], [AccessFailedCount], [LockoutEndDateUtc], [Claims], [Logins], [FirstName], [LastName], [Suffix], [OrgId], [IsActive], [IsDeleted], [created_by], [created_dt], [modified_by], [modified_dt]) VALUES (39, N'FIRSTAGAIN\SaraH', N'sarah@domainname.com', NULL, NULL, NULL, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, 1, 1, 0, N'FIRSTAGAIN\kain.tabarez', CAST(N'2017-01-19T01:44:54.680' AS DateTime), N'FIRSTAGAIN\kain.tabarez', CAST(N'2017-01-19T01:44:54.680' AS DateTime))
GO
INSERT [Auth].[OrgUser] ([Id], [UserName], [Email], [PhoneNumber], [PasswordHash], [SecurityStamp], [IsLockoutEnabled], [IsTwoFactorEnabled], [AccessFailedCount], [LockoutEndDateUtc], [Claims], [Logins], [FirstName], [LastName], [Suffix], [OrgId], [IsActive], [IsDeleted], [created_by], [created_dt], [modified_by], [modified_dt]) VALUES (40, N'FIRSTAGAIN\SherryS', N'sherrys@domainname.com', NULL, NULL, NULL, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, 1, 1, 0, N'FIRSTAGAIN\kain.tabarez', CAST(N'2017-01-19T01:44:54.800' AS DateTime), N'FIRSTAGAIN\kain.tabarez', CAST(N'2017-01-19T01:44:54.800' AS DateTime))
GO
INSERT [Auth].[OrgUser] ([Id], [UserName], [Email], [PhoneNumber], [PasswordHash], [SecurityStamp], [IsLockoutEnabled], [IsTwoFactorEnabled], [AccessFailedCount], [LockoutEndDateUtc], [Claims], [Logins], [FirstName], [LastName], [Suffix], [OrgId], [IsActive], [IsDeleted], [created_by], [created_dt], [modified_by], [modified_dt]) VALUES (41, N'FIRSTAGAIN\SreeniR', N'sreenir@domainname.com', NULL, NULL, NULL, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, 1, 1, 0, N'FIRSTAGAIN\kain.tabarez', CAST(N'2017-01-19T01:44:54.920' AS DateTime), N'FIRSTAGAIN\kain.tabarez', CAST(N'2017-01-19T01:44:54.920' AS DateTime))
GO
INSERT [Auth].[OrgUser] ([Id], [UserName], [Email], [PhoneNumber], [PasswordHash], [SecurityStamp], [IsLockoutEnabled], [IsTwoFactorEnabled], [AccessFailedCount], [LockoutEndDateUtc], [Claims], [Logins], [FirstName], [LastName], [Suffix], [OrgId], [IsActive], [IsDeleted], [created_by], [created_dt], [modified_by], [modified_dt]) VALUES (42, N'FIRSTAGAIN\SteveH', N'steveh@domainname.com', NULL, NULL, NULL, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, 1, 1, 0, N'FIRSTAGAIN\kain.tabarez', CAST(N'2017-01-19T01:44:55.057' AS DateTime), N'FIRSTAGAIN\kain.tabarez', CAST(N'2017-01-19T01:44:55.057' AS DateTime))
GO
INSERT [Auth].[OrgUser] ([Id], [UserName], [Email], [PhoneNumber], [PasswordHash], [SecurityStamp], [IsLockoutEnabled], [IsTwoFactorEnabled], [AccessFailedCount], [LockoutEndDateUtc], [Claims], [Logins], [FirstName], [LastName], [Suffix], [OrgId], [IsActive], [IsDeleted], [created_by], [created_dt], [modified_by], [modified_dt]) VALUES (43, N'FIRSTAGAIN\StevenH', N'stevenh@domainname.com', NULL, NULL, NULL, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, 1, 1, 0, N'FIRSTAGAIN\kain.tabarez', CAST(N'2017-01-19T01:44:55.160' AS DateTime), N'FIRSTAGAIN\kain.tabarez', CAST(N'2017-01-19T01:44:55.160' AS DateTime))
GO
INSERT [Auth].[OrgUser] ([Id], [UserName], [Email], [PhoneNumber], [PasswordHash], [SecurityStamp], [IsLockoutEnabled], [IsTwoFactorEnabled], [AccessFailedCount], [LockoutEndDateUtc], [Claims], [Logins], [FirstName], [LastName], [Suffix], [OrgId], [IsActive], [IsDeleted], [created_by], [created_dt], [modified_by], [modified_dt]) VALUES (44, N'FIRSTAGAIN\SusanB', N'susanb@domainname.com', NULL, NULL, NULL, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, 1, 1, 0, N'FIRSTAGAIN\kain.tabarez', CAST(N'2017-01-19T01:44:55.300' AS DateTime), N'FIRSTAGAIN\kain.tabarez', CAST(N'2017-01-19T01:44:55.300' AS DateTime))
GO
INSERT [Auth].[OrgUser] ([Id], [UserName], [Email], [PhoneNumber], [PasswordHash], [SecurityStamp], [IsLockoutEnabled], [IsTwoFactorEnabled], [AccessFailedCount], [LockoutEndDateUtc], [Claims], [Logins], [FirstName], [LastName], [Suffix], [OrgId], [IsActive], [IsDeleted], [created_by], [created_dt], [modified_by], [modified_dt]) VALUES (45, N'FIRSTAGAIN\TerriM', N'terrim@domainname.com', NULL, NULL, NULL, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, 1, 1, 0, N'FIRSTAGAIN\kain.tabarez', CAST(N'2017-01-19T01:44:55.403' AS DateTime), N'FIRSTAGAIN\kain.tabarez', CAST(N'2017-01-19T01:44:55.403' AS DateTime))
GO
INSERT [Auth].[OrgUser] ([Id], [UserName], [Email], [PhoneNumber], [PasswordHash], [SecurityStamp], [IsLockoutEnabled], [IsTwoFactorEnabled], [AccessFailedCount], [LockoutEndDateUtc], [Claims], [Logins], [FirstName], [LastName], [Suffix], [OrgId], [IsActive], [IsDeleted], [created_by], [created_dt], [modified_by], [modified_dt]) VALUES (46, N'FIRSTAGAIN\VinceN', N'vincen@domainname.com', NULL, NULL, NULL, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, 1, 1, 0, N'FIRSTAGAIN\kain.tabarez', CAST(N'2017-01-19T01:44:55.503' AS DateTime), N'FIRSTAGAIN\kain.tabarez', CAST(N'2017-01-19T01:44:55.503' AS DateTime))
GO
INSERT [Auth].[OrgUser] ([Id], [UserName], [Email], [PhoneNumber], [PasswordHash], [SecurityStamp], [IsLockoutEnabled], [IsTwoFactorEnabled], [AccessFailedCount], [LockoutEndDateUtc], [Claims], [Logins], [FirstName], [LastName], [Suffix], [OrgId], [IsActive], [IsDeleted], [created_by], [created_dt], [modified_by], [modified_dt]) VALUES (47, N'FIRSTAGAIN\WilliamP', N'williamp@domainname.com', NULL, NULL, NULL, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, 1, 1, 0, N'FIRSTAGAIN\kain.tabarez', CAST(N'2017-01-19T01:44:55.647' AS DateTime), N'FIRSTAGAIN\kain.tabarez', CAST(N'2017-01-19T01:44:55.647' AS DateTime))
GO
SET IDENTITY_INSERT [Auth].[OrgUser] OFF
GO
SET IDENTITY_INSERT [Auth].[OrgClientType] ON 

GO
INSERT [Auth].[OrgClientType] ([Id], [Name], [OrgId], [IsActive], [IsDeleted], [created_by], [created_dt], [modified_by], [modified_dt]) VALUES (1, N'Native - Confidential', 1, 1, 0, N'someone', CAST(N'2017-01-19T01:43:37.130' AS DateTime), N'someone', CAST(N'2017-01-19T01:43:37.130' AS DateTime))
GO
INSERT [Auth].[OrgClientType] ([Id], [Name], [OrgId], [IsActive], [IsDeleted], [created_by], [created_dt], [modified_by], [modified_dt]) VALUES (2, N'JavaScript - Nonconfidential', 1, 1, 0, N'someone', CAST(N'2017-01-19T01:43:37.130' AS DateTime), N'someone', CAST(N'2017-01-19T01:43:37.130' AS DateTime))
GO
SET IDENTITY_INSERT [Auth].[OrgClientType] OFF
GO
INSERT [Auth].[OrgClient] ([Id], [Secret], [Name], [ClientTypeId], [OrgId], [RefreshTokenLifeTime], [AllowedOrigin], [IsActive], [IsDeleted], [created_by], [created_dt], [modified_by], [modified_dt]) VALUES (N'ngDashboardApp', N'1234', N'angular app', 2, 1, 7200, N'*', 1, 0, N'someone', CAST(N'2017-01-19T01:43:37.137' AS DateTime), N'someone', CAST(N'2017-01-19T01:43:37.137' AS DateTime))
GO
INSERT [Auth].[OrgClient] ([Id], [Secret], [Name], [ClientTypeId], [OrgId], [RefreshTokenLifeTime], [AllowedOrigin], [IsActive], [IsDeleted], [created_by], [created_dt], [modified_by], [modified_dt]) VALUES (N'webApi', N'123@', N'backend api client', 1, 1, 7200, N'*', 1, 0, N'someone', CAST(N'2017-01-19T01:43:37.137' AS DateTime), N'someone', CAST(N'2017-01-19T01:43:37.137' AS DateTime))
GO
SET IDENTITY_INSERT [Auth].[OrgGlobalRole] ON 

GO
INSERT [Auth].[OrgGlobalRole] ([Id], [OrgId], [Name], [IsActive], [IsDeleted], [created_by], [created_dt], [modified_by], [modified_dt]) VALUES (1, 1, N'godmode', 1, 0, N'me', CAST(N'2017-01-19T01:43:37.140' AS DateTime), N'me', CAST(N'2017-01-19T01:43:37.140' AS DateTime))
GO
SET IDENTITY_INSERT [Auth].[OrgGlobalRole] OFF
GO
SET IDENTITY_INSERT [Auth].[OrgApp] ON 

GO
INSERT [Auth].[OrgApp] ([Id], [OrgId], [AppName], [IsActive], [IsDeleted], [created_by], [created_dt], [modified_by], [modified_dt]) VALUES (1, 1, N'memberFeedback', 1, 0, N'me', CAST(N'2017-01-19T01:45:37.477' AS DateTime), N'me', CAST(N'2017-01-19T01:45:37.477' AS DateTime))
GO
SET IDENTITY_INSERT [Auth].[OrgApp] OFF
GO
INSERT [Auth].[OrgUserRefreshToken] ([Id], [Subject], [OrgClientId], [OrgUserId], [IssuedUtc], [ExpiresUtc], [ProtectedTicket]) VALUES (N'9e6b7fa02f6547379e8ee0f7a9042eb2', N'FIRSTAGAIN\kain.tabarez', N'ngDashboardApp', 1, CAST(N'2017-01-21T01:06:47.877' AS DateTime), CAST(N'2017-01-26T01:06:47.877' AS DateTime), N'VLwDt8m4iNKa4NAyzHyRFeSIaGkpa0kW8OuNBXiBjp_2yLqRYyXlDK5-1cocd3c-OvYpUxfwYP6GHEKs3y93n_z51UjDvvhJQBrn4AkY9XrOTbEo3NYvysTx4iwafyCMS5D7HoDV0tz-BFMs8yZYv3lwBrz7foBUoygjA7gw8sSQCu_z3LHYfD6VZVWL4Rn_yIuJ_ZegLWOVo-ev5aP6uTno_EKLbm0O2KP3i6MNv-wXECo3IitAkhApzP_0NSwUr1XSy-nzdfcId39p5gtQWZ_URIGBRgTBNpMHtp54BRe_71BCnmoyNKDIeI_ClalPOBMmp56fXX3Q4MtQK6cBaolh8fvzSs4OLEr5dou3Y42uRHO049cpLbJv2HiozqBKnFFPptoiJTHOO2PeaYvWmSBfMfjIPKeSy_HMpYfpUu5VD6qC2AByGrqQN7v3H2XSuk81jliZZd2fdIhfjvZi2tPgck7vWGjCF_omJ_MnZRwQ-HykV8v-eQymr6siOz1kiz-YsLNMYftf32FQCzCgP0slZ1PP-6H0pAVXcMZMu6UapxcdBmXETSlPmrkqWrLSdg-2DmAjXa2JdTVDAIs1nwNhFP_gbSkrRcWgOwGU05HB5sVoTcAxqmPKpZCc6mByZpg3r3-ExRRHwWICmK940NUi1q7AKfiTxrcWDzUnjIjPx7S1Ixoolf3PTNdU0UTvtBzGS6sZZfPmgJBnH_LGoHmoIod54Uq7G4EBTmLXbxo')
GO
INSERT [Auth].[OrgUserRefreshToken] ([Id], [Subject], [OrgClientId], [OrgUserId], [IssuedUtc], [ExpiresUtc], [ProtectedTicket]) VALUES (N'e63a646ceb414c9caf8769a64da7b717', N'FIRSTAGAIN\kain.tabarez', N'ngDashboardApp', 1, CAST(N'2017-01-19T02:43:35.280' AS DateTime), CAST(N'2017-01-24T02:43:35.280' AS DateTime), N'Chan6lkU1arrIV9OoEc6cHLmlPkeO0GPZF9x4bUQe3BEt9En1u5xuFbuJBVrDu4pFCnP4jcR6zBTGDig6octQ9ye6JjtXtyPDcU6dHhVskJloAObdAqP8Ajj9slrfXP2XBqILqavB4HYB9S0KxxvfCDgKYHGNc3GoXWWpmA7vi1W_c8DdOUiCcd35mUb5iQfttVr61pb98zXPMq4QAOjSz7JIGy6H0xu0YUVlOiJtmfm8XaN7levCVHciwN7EpLLT_jnppxJT6hBbL7VSMmH6KqElYpYVmYVSmgXEtSYbY2hev4Y3oP4Ddbn3cUeNk8Zv8I5qdLiandFVdv5K9pfYuuRQvjbK-A8RqUOXfrSvSZ-N59TpxngK0xSLvXPOx47KcuDFfDnUlkmMSvhdamibt772fmgwGZrPyPiQSwiMDDTasWPHwNIelHWTeFunXsWU2V1XRwgcUfRlT_aD5Aq5mLNWvv-iF0A0W0NlYKRxCkGTdPPJ3fYMgUQ5sTTq6owWDJh8uX3Ztxp2mbHOMcRFaZfZsZdJKrGdInn3LiGWiHsRQ9TYWrXLypi8KXR-uwmhoM_FtqUDcLIgG3LOf4qCsQ6vHkJua1WjY_375sMQiLnUDC-McZuFuHmc58LwDrZpn4UoXdoPwWkT68k0L-6KfuC8CdTW1KC6Bc2RcO2c-366JIzaFkxmCYsmmLtQlClE4lPt6jtOVhWzFUG7n9AxBjRFnWkOZPDvmDyK2mPGUk')
GO
SET IDENTITY_INSERT [Auth].[OrgGlobalUserRole] ON 

GO
INSERT [Auth].[OrgGlobalUserRole] ([Id], [OrgUserId], [OrgGlobalRoleId], [IsActive], [IsDeleted], [created_by], [created_dt], [modified_by], [modified_dt]) VALUES (1, 1, 1, 1, 0, N'me', CAST(N'2017-01-19T01:45:37.470' AS DateTime), N'me', CAST(N'2017-01-19T01:45:37.470' AS DateTime))
GO
SET IDENTITY_INSERT [Auth].[OrgGlobalUserRole] OFF
GO
SET IDENTITY_INSERT [Auth].[OrgAppUser] ON 

GO
INSERT [Auth].[OrgAppUser] ([Id], [UserId], [OrgAppId], [IsActive], [IsDeleted], [created_by], [created_dt], [modified_by], [modified_dt]) VALUES (1, 2, 1, 1, 0, N'me', CAST(N'2017-01-19T01:45:37.497' AS DateTime), N'me', CAST(N'2017-01-19T01:45:37.497' AS DateTime))
GO
INSERT [Auth].[OrgAppUser] ([Id], [UserId], [OrgAppId], [IsActive], [IsDeleted], [created_by], [created_dt], [modified_by], [modified_dt]) VALUES (2, 3, 1, 1, 0, N'me', CAST(N'2017-01-19T01:45:37.497' AS DateTime), N'me', CAST(N'2017-01-19T01:45:37.497' AS DateTime))
GO
INSERT [Auth].[OrgAppUser] ([Id], [UserId], [OrgAppId], [IsActive], [IsDeleted], [created_by], [created_dt], [modified_by], [modified_dt]) VALUES (3, 4, 1, 1, 0, N'me', CAST(N'2017-01-19T01:45:37.497' AS DateTime), N'me', CAST(N'2017-01-19T01:45:37.497' AS DateTime))
GO
INSERT [Auth].[OrgAppUser] ([Id], [UserId], [OrgAppId], [IsActive], [IsDeleted], [created_by], [created_dt], [modified_by], [modified_dt]) VALUES (4, 5, 1, 1, 0, N'me', CAST(N'2017-01-19T01:45:37.497' AS DateTime), N'me', CAST(N'2017-01-19T01:45:37.497' AS DateTime))
GO
INSERT [Auth].[OrgAppUser] ([Id], [UserId], [OrgAppId], [IsActive], [IsDeleted], [created_by], [created_dt], [modified_by], [modified_dt]) VALUES (5, 6, 1, 1, 0, N'me', CAST(N'2017-01-19T01:45:37.497' AS DateTime), N'me', CAST(N'2017-01-19T01:45:37.497' AS DateTime))
GO
INSERT [Auth].[OrgAppUser] ([Id], [UserId], [OrgAppId], [IsActive], [IsDeleted], [created_by], [created_dt], [modified_by], [modified_dt]) VALUES (6, 7, 1, 1, 0, N'me', CAST(N'2017-01-19T01:45:37.497' AS DateTime), N'me', CAST(N'2017-01-19T01:45:37.497' AS DateTime))
GO
INSERT [Auth].[OrgAppUser] ([Id], [UserId], [OrgAppId], [IsActive], [IsDeleted], [created_by], [created_dt], [modified_by], [modified_dt]) VALUES (7, 8, 1, 1, 0, N'me', CAST(N'2017-01-19T01:45:37.497' AS DateTime), N'me', CAST(N'2017-01-19T01:45:37.497' AS DateTime))
GO
INSERT [Auth].[OrgAppUser] ([Id], [UserId], [OrgAppId], [IsActive], [IsDeleted], [created_by], [created_dt], [modified_by], [modified_dt]) VALUES (8, 9, 1, 1, 0, N'me', CAST(N'2017-01-19T01:45:37.497' AS DateTime), N'me', CAST(N'2017-01-19T01:45:37.497' AS DateTime))
GO
INSERT [Auth].[OrgAppUser] ([Id], [UserId], [OrgAppId], [IsActive], [IsDeleted], [created_by], [created_dt], [modified_by], [modified_dt]) VALUES (9, 10, 1, 1, 0, N'me', CAST(N'2017-01-19T01:45:37.497' AS DateTime), N'me', CAST(N'2017-01-19T01:45:37.497' AS DateTime))
GO
INSERT [Auth].[OrgAppUser] ([Id], [UserId], [OrgAppId], [IsActive], [IsDeleted], [created_by], [created_dt], [modified_by], [modified_dt]) VALUES (10, 11, 1, 1, 0, N'me', CAST(N'2017-01-19T01:45:37.497' AS DateTime), N'me', CAST(N'2017-01-19T01:45:37.497' AS DateTime))
GO
INSERT [Auth].[OrgAppUser] ([Id], [UserId], [OrgAppId], [IsActive], [IsDeleted], [created_by], [created_dt], [modified_by], [modified_dt]) VALUES (11, 12, 1, 1, 0, N'me', CAST(N'2017-01-19T01:45:37.497' AS DateTime), N'me', CAST(N'2017-01-19T01:45:37.497' AS DateTime))
GO
INSERT [Auth].[OrgAppUser] ([Id], [UserId], [OrgAppId], [IsActive], [IsDeleted], [created_by], [created_dt], [modified_by], [modified_dt]) VALUES (12, 13, 1, 1, 0, N'me', CAST(N'2017-01-19T01:45:37.497' AS DateTime), N'me', CAST(N'2017-01-19T01:45:37.497' AS DateTime))
GO
INSERT [Auth].[OrgAppUser] ([Id], [UserId], [OrgAppId], [IsActive], [IsDeleted], [created_by], [created_dt], [modified_by], [modified_dt]) VALUES (13, 14, 1, 1, 0, N'me', CAST(N'2017-01-19T01:45:37.497' AS DateTime), N'me', CAST(N'2017-01-19T01:45:37.497' AS DateTime))
GO
INSERT [Auth].[OrgAppUser] ([Id], [UserId], [OrgAppId], [IsActive], [IsDeleted], [created_by], [created_dt], [modified_by], [modified_dt]) VALUES (14, 15, 1, 1, 0, N'me', CAST(N'2017-01-19T01:45:37.497' AS DateTime), N'me', CAST(N'2017-01-19T01:45:37.497' AS DateTime))
GO
INSERT [Auth].[OrgAppUser] ([Id], [UserId], [OrgAppId], [IsActive], [IsDeleted], [created_by], [created_dt], [modified_by], [modified_dt]) VALUES (15, 16, 1, 1, 0, N'me', CAST(N'2017-01-19T01:45:37.497' AS DateTime), N'me', CAST(N'2017-01-19T01:45:37.497' AS DateTime))
GO
INSERT [Auth].[OrgAppUser] ([Id], [UserId], [OrgAppId], [IsActive], [IsDeleted], [created_by], [created_dt], [modified_by], [modified_dt]) VALUES (16, 17, 1, 1, 0, N'me', CAST(N'2017-01-19T01:45:37.497' AS DateTime), N'me', CAST(N'2017-01-19T01:45:37.497' AS DateTime))
GO
INSERT [Auth].[OrgAppUser] ([Id], [UserId], [OrgAppId], [IsActive], [IsDeleted], [created_by], [created_dt], [modified_by], [modified_dt]) VALUES (17, 18, 1, 1, 0, N'me', CAST(N'2017-01-19T01:45:37.497' AS DateTime), N'me', CAST(N'2017-01-19T01:45:37.497' AS DateTime))
GO
INSERT [Auth].[OrgAppUser] ([Id], [UserId], [OrgAppId], [IsActive], [IsDeleted], [created_by], [created_dt], [modified_by], [modified_dt]) VALUES (18, 19, 1, 1, 0, N'me', CAST(N'2017-01-19T01:45:37.497' AS DateTime), N'me', CAST(N'2017-01-19T01:45:37.497' AS DateTime))
GO
INSERT [Auth].[OrgAppUser] ([Id], [UserId], [OrgAppId], [IsActive], [IsDeleted], [created_by], [created_dt], [modified_by], [modified_dt]) VALUES (19, 20, 1, 1, 0, N'me', CAST(N'2017-01-19T01:45:37.497' AS DateTime), N'me', CAST(N'2017-01-19T01:45:37.497' AS DateTime))
GO
INSERT [Auth].[OrgAppUser] ([Id], [UserId], [OrgAppId], [IsActive], [IsDeleted], [created_by], [created_dt], [modified_by], [modified_dt]) VALUES (20, 21, 1, 1, 0, N'me', CAST(N'2017-01-19T01:45:37.497' AS DateTime), N'me', CAST(N'2017-01-19T01:45:37.497' AS DateTime))
GO
INSERT [Auth].[OrgAppUser] ([Id], [UserId], [OrgAppId], [IsActive], [IsDeleted], [created_by], [created_dt], [modified_by], [modified_dt]) VALUES (21, 22, 1, 1, 0, N'me', CAST(N'2017-01-19T01:45:37.497' AS DateTime), N'me', CAST(N'2017-01-19T01:45:37.497' AS DateTime))
GO
INSERT [Auth].[OrgAppUser] ([Id], [UserId], [OrgAppId], [IsActive], [IsDeleted], [created_by], [created_dt], [modified_by], [modified_dt]) VALUES (22, 23, 1, 1, 0, N'me', CAST(N'2017-01-19T01:45:37.497' AS DateTime), N'me', CAST(N'2017-01-19T01:45:37.497' AS DateTime))
GO
INSERT [Auth].[OrgAppUser] ([Id], [UserId], [OrgAppId], [IsActive], [IsDeleted], [created_by], [created_dt], [modified_by], [modified_dt]) VALUES (23, 24, 1, 1, 0, N'me', CAST(N'2017-01-19T01:45:37.497' AS DateTime), N'me', CAST(N'2017-01-19T01:45:37.497' AS DateTime))
GO
INSERT [Auth].[OrgAppUser] ([Id], [UserId], [OrgAppId], [IsActive], [IsDeleted], [created_by], [created_dt], [modified_by], [modified_dt]) VALUES (24, 25, 1, 1, 0, N'me', CAST(N'2017-01-19T01:45:37.497' AS DateTime), N'me', CAST(N'2017-01-19T01:45:37.497' AS DateTime))
GO
INSERT [Auth].[OrgAppUser] ([Id], [UserId], [OrgAppId], [IsActive], [IsDeleted], [created_by], [created_dt], [modified_by], [modified_dt]) VALUES (25, 26, 1, 1, 0, N'me', CAST(N'2017-01-19T01:45:37.497' AS DateTime), N'me', CAST(N'2017-01-19T01:45:37.497' AS DateTime))
GO
INSERT [Auth].[OrgAppUser] ([Id], [UserId], [OrgAppId], [IsActive], [IsDeleted], [created_by], [created_dt], [modified_by], [modified_dt]) VALUES (26, 27, 1, 1, 0, N'me', CAST(N'2017-01-19T01:45:37.497' AS DateTime), N'me', CAST(N'2017-01-19T01:45:37.497' AS DateTime))
GO
INSERT [Auth].[OrgAppUser] ([Id], [UserId], [OrgAppId], [IsActive], [IsDeleted], [created_by], [created_dt], [modified_by], [modified_dt]) VALUES (27, 28, 1, 1, 0, N'me', CAST(N'2017-01-19T01:45:37.497' AS DateTime), N'me', CAST(N'2017-01-19T01:45:37.497' AS DateTime))
GO
INSERT [Auth].[OrgAppUser] ([Id], [UserId], [OrgAppId], [IsActive], [IsDeleted], [created_by], [created_dt], [modified_by], [modified_dt]) VALUES (28, 29, 1, 1, 0, N'me', CAST(N'2017-01-19T01:45:37.497' AS DateTime), N'me', CAST(N'2017-01-19T01:45:37.497' AS DateTime))
GO
INSERT [Auth].[OrgAppUser] ([Id], [UserId], [OrgAppId], [IsActive], [IsDeleted], [created_by], [created_dt], [modified_by], [modified_dt]) VALUES (29, 30, 1, 1, 0, N'me', CAST(N'2017-01-19T01:45:37.497' AS DateTime), N'me', CAST(N'2017-01-19T01:45:37.497' AS DateTime))
GO
INSERT [Auth].[OrgAppUser] ([Id], [UserId], [OrgAppId], [IsActive], [IsDeleted], [created_by], [created_dt], [modified_by], [modified_dt]) VALUES (30, 31, 1, 1, 0, N'me', CAST(N'2017-01-19T01:45:37.497' AS DateTime), N'me', CAST(N'2017-01-19T01:45:37.497' AS DateTime))
GO
INSERT [Auth].[OrgAppUser] ([Id], [UserId], [OrgAppId], [IsActive], [IsDeleted], [created_by], [created_dt], [modified_by], [modified_dt]) VALUES (31, 32, 1, 1, 0, N'me', CAST(N'2017-01-19T01:45:37.497' AS DateTime), N'me', CAST(N'2017-01-19T01:45:37.497' AS DateTime))
GO
INSERT [Auth].[OrgAppUser] ([Id], [UserId], [OrgAppId], [IsActive], [IsDeleted], [created_by], [created_dt], [modified_by], [modified_dt]) VALUES (32, 33, 1, 1, 0, N'me', CAST(N'2017-01-19T01:45:37.497' AS DateTime), N'me', CAST(N'2017-01-19T01:45:37.497' AS DateTime))
GO
INSERT [Auth].[OrgAppUser] ([Id], [UserId], [OrgAppId], [IsActive], [IsDeleted], [created_by], [created_dt], [modified_by], [modified_dt]) VALUES (33, 34, 1, 1, 0, N'me', CAST(N'2017-01-19T01:45:37.497' AS DateTime), N'me', CAST(N'2017-01-19T01:45:37.497' AS DateTime))
GO
INSERT [Auth].[OrgAppUser] ([Id], [UserId], [OrgAppId], [IsActive], [IsDeleted], [created_by], [created_dt], [modified_by], [modified_dt]) VALUES (34, 35, 1, 1, 0, N'me', CAST(N'2017-01-19T01:45:37.497' AS DateTime), N'me', CAST(N'2017-01-19T01:45:37.497' AS DateTime))
GO
INSERT [Auth].[OrgAppUser] ([Id], [UserId], [OrgAppId], [IsActive], [IsDeleted], [created_by], [created_dt], [modified_by], [modified_dt]) VALUES (35, 36, 1, 1, 0, N'me', CAST(N'2017-01-19T01:45:37.497' AS DateTime), N'me', CAST(N'2017-01-19T01:45:37.497' AS DateTime))
GO
INSERT [Auth].[OrgAppUser] ([Id], [UserId], [OrgAppId], [IsActive], [IsDeleted], [created_by], [created_dt], [modified_by], [modified_dt]) VALUES (36, 37, 1, 1, 0, N'me', CAST(N'2017-01-19T01:45:37.497' AS DateTime), N'me', CAST(N'2017-01-19T01:45:37.497' AS DateTime))
GO
INSERT [Auth].[OrgAppUser] ([Id], [UserId], [OrgAppId], [IsActive], [IsDeleted], [created_by], [created_dt], [modified_by], [modified_dt]) VALUES (37, 38, 1, 1, 0, N'me', CAST(N'2017-01-19T01:45:37.497' AS DateTime), N'me', CAST(N'2017-01-19T01:45:37.497' AS DateTime))
GO
INSERT [Auth].[OrgAppUser] ([Id], [UserId], [OrgAppId], [IsActive], [IsDeleted], [created_by], [created_dt], [modified_by], [modified_dt]) VALUES (38, 39, 1, 1, 0, N'me', CAST(N'2017-01-19T01:45:37.497' AS DateTime), N'me', CAST(N'2017-01-19T01:45:37.497' AS DateTime))
GO
INSERT [Auth].[OrgAppUser] ([Id], [UserId], [OrgAppId], [IsActive], [IsDeleted], [created_by], [created_dt], [modified_by], [modified_dt]) VALUES (39, 40, 1, 1, 0, N'me', CAST(N'2017-01-19T01:45:37.497' AS DateTime), N'me', CAST(N'2017-01-19T01:45:37.497' AS DateTime))
GO
INSERT [Auth].[OrgAppUser] ([Id], [UserId], [OrgAppId], [IsActive], [IsDeleted], [created_by], [created_dt], [modified_by], [modified_dt]) VALUES (40, 41, 1, 1, 0, N'me', CAST(N'2017-01-19T01:45:37.497' AS DateTime), N'me', CAST(N'2017-01-19T01:45:37.497' AS DateTime))
GO
INSERT [Auth].[OrgAppUser] ([Id], [UserId], [OrgAppId], [IsActive], [IsDeleted], [created_by], [created_dt], [modified_by], [modified_dt]) VALUES (41, 42, 1, 1, 0, N'me', CAST(N'2017-01-19T01:45:37.497' AS DateTime), N'me', CAST(N'2017-01-19T01:45:37.497' AS DateTime))
GO
INSERT [Auth].[OrgAppUser] ([Id], [UserId], [OrgAppId], [IsActive], [IsDeleted], [created_by], [created_dt], [modified_by], [modified_dt]) VALUES (42, 43, 1, 1, 0, N'me', CAST(N'2017-01-19T01:45:37.497' AS DateTime), N'me', CAST(N'2017-01-19T01:45:37.497' AS DateTime))
GO
INSERT [Auth].[OrgAppUser] ([Id], [UserId], [OrgAppId], [IsActive], [IsDeleted], [created_by], [created_dt], [modified_by], [modified_dt]) VALUES (43, 44, 1, 1, 0, N'me', CAST(N'2017-01-19T01:45:37.497' AS DateTime), N'me', CAST(N'2017-01-19T01:45:37.497' AS DateTime))
GO
INSERT [Auth].[OrgAppUser] ([Id], [UserId], [OrgAppId], [IsActive], [IsDeleted], [created_by], [created_dt], [modified_by], [modified_dt]) VALUES (44, 45, 1, 1, 0, N'me', CAST(N'2017-01-19T01:45:37.497' AS DateTime), N'me', CAST(N'2017-01-19T01:45:37.497' AS DateTime))
GO
INSERT [Auth].[OrgAppUser] ([Id], [UserId], [OrgAppId], [IsActive], [IsDeleted], [created_by], [created_dt], [modified_by], [modified_dt]) VALUES (45, 46, 1, 1, 0, N'me', CAST(N'2017-01-19T01:45:37.497' AS DateTime), N'me', CAST(N'2017-01-19T01:45:37.497' AS DateTime))
GO
INSERT [Auth].[OrgAppUser] ([Id], [UserId], [OrgAppId], [IsActive], [IsDeleted], [created_by], [created_dt], [modified_by], [modified_dt]) VALUES (46, 47, 1, 1, 0, N'me', CAST(N'2017-01-19T01:45:37.497' AS DateTime), N'me', CAST(N'2017-01-19T01:45:37.497' AS DateTime))
GO
SET IDENTITY_INSERT [Auth].[OrgAppUser] OFF
GO
SET IDENTITY_INSERT [Auth].[OrgAppRole] ON 

GO
INSERT [Auth].[OrgAppRole] ([Id], [OrgAppId], [Name], [IsActive], [IsDeleted], [created_by], [created_dt], [modified_by], [modified_dt]) VALUES (1, 1, N'admin', 1, 0, N'me', CAST(N'2017-01-19T01:45:37.480' AS DateTime), N'me', CAST(N'2017-01-19T01:45:37.480' AS DateTime))
GO
INSERT [Auth].[OrgAppRole] ([Id], [OrgAppId], [Name], [IsActive], [IsDeleted], [created_by], [created_dt], [modified_by], [modified_dt]) VALUES (2, 1, N'assignable', 1, 0, N'me', CAST(N'2017-01-19T01:45:37.483' AS DateTime), N'me', CAST(N'2017-01-19T01:45:37.483' AS DateTime))
GO
SET IDENTITY_INSERT [Auth].[OrgAppRole] OFF
GO
SET IDENTITY_INSERT [Auth].[OrgAppUserRole] ON 

GO
INSERT [Auth].[OrgAppUserRole] ([Id], [OrgAppUserId], [OrgAppRoleId], [IsActive], [IsDeleted], [created_by], [created_dt], [modified_by], [modified_dt]) VALUES (1, 1, 2, 1, 0, N'me', CAST(N'2017-01-19T01:45:37.513' AS DateTime), N'me', CAST(N'2017-01-19T01:45:37.513' AS DateTime))
GO
INSERT [Auth].[OrgAppUserRole] ([Id], [OrgAppUserId], [OrgAppRoleId], [IsActive], [IsDeleted], [created_by], [created_dt], [modified_by], [modified_dt]) VALUES (2, 2, 2, 1, 0, N'me', CAST(N'2017-01-19T01:45:37.513' AS DateTime), N'me', CAST(N'2017-01-19T01:45:37.513' AS DateTime))
GO
INSERT [Auth].[OrgAppUserRole] ([Id], [OrgAppUserId], [OrgAppRoleId], [IsActive], [IsDeleted], [created_by], [created_dt], [modified_by], [modified_dt]) VALUES (3, 3, 2, 1, 0, N'me', CAST(N'2017-01-19T01:45:37.513' AS DateTime), N'me', CAST(N'2017-01-19T01:45:37.513' AS DateTime))
GO
INSERT [Auth].[OrgAppUserRole] ([Id], [OrgAppUserId], [OrgAppRoleId], [IsActive], [IsDeleted], [created_by], [created_dt], [modified_by], [modified_dt]) VALUES (4, 4, 2, 1, 0, N'me', CAST(N'2017-01-19T01:45:37.513' AS DateTime), N'me', CAST(N'2017-01-19T01:45:37.513' AS DateTime))
GO
INSERT [Auth].[OrgAppUserRole] ([Id], [OrgAppUserId], [OrgAppRoleId], [IsActive], [IsDeleted], [created_by], [created_dt], [modified_by], [modified_dt]) VALUES (5, 5, 2, 1, 0, N'me', CAST(N'2017-01-19T01:45:37.513' AS DateTime), N'me', CAST(N'2017-01-19T01:45:37.513' AS DateTime))
GO
INSERT [Auth].[OrgAppUserRole] ([Id], [OrgAppUserId], [OrgAppRoleId], [IsActive], [IsDeleted], [created_by], [created_dt], [modified_by], [modified_dt]) VALUES (6, 6, 2, 1, 0, N'me', CAST(N'2017-01-19T01:45:37.513' AS DateTime), N'me', CAST(N'2017-01-19T01:45:37.513' AS DateTime))
GO
INSERT [Auth].[OrgAppUserRole] ([Id], [OrgAppUserId], [OrgAppRoleId], [IsActive], [IsDeleted], [created_by], [created_dt], [modified_by], [modified_dt]) VALUES (7, 7, 2, 1, 0, N'me', CAST(N'2017-01-19T01:45:37.513' AS DateTime), N'me', CAST(N'2017-01-19T01:45:37.513' AS DateTime))
GO
INSERT [Auth].[OrgAppUserRole] ([Id], [OrgAppUserId], [OrgAppRoleId], [IsActive], [IsDeleted], [created_by], [created_dt], [modified_by], [modified_dt]) VALUES (8, 8, 2, 1, 0, N'me', CAST(N'2017-01-19T01:45:37.513' AS DateTime), N'me', CAST(N'2017-01-19T01:45:37.513' AS DateTime))
GO
INSERT [Auth].[OrgAppUserRole] ([Id], [OrgAppUserId], [OrgAppRoleId], [IsActive], [IsDeleted], [created_by], [created_dt], [modified_by], [modified_dt]) VALUES (9, 9, 2, 1, 0, N'me', CAST(N'2017-01-19T01:45:37.513' AS DateTime), N'me', CAST(N'2017-01-19T01:45:37.513' AS DateTime))
GO
INSERT [Auth].[OrgAppUserRole] ([Id], [OrgAppUserId], [OrgAppRoleId], [IsActive], [IsDeleted], [created_by], [created_dt], [modified_by], [modified_dt]) VALUES (10, 10, 2, 1, 0, N'me', CAST(N'2017-01-19T01:45:37.513' AS DateTime), N'me', CAST(N'2017-01-19T01:45:37.513' AS DateTime))
GO
INSERT [Auth].[OrgAppUserRole] ([Id], [OrgAppUserId], [OrgAppRoleId], [IsActive], [IsDeleted], [created_by], [created_dt], [modified_by], [modified_dt]) VALUES (11, 11, 2, 1, 0, N'me', CAST(N'2017-01-19T01:45:37.513' AS DateTime), N'me', CAST(N'2017-01-19T01:45:37.513' AS DateTime))
GO
INSERT [Auth].[OrgAppUserRole] ([Id], [OrgAppUserId], [OrgAppRoleId], [IsActive], [IsDeleted], [created_by], [created_dt], [modified_by], [modified_dt]) VALUES (12, 12, 2, 1, 0, N'me', CAST(N'2017-01-19T01:45:37.513' AS DateTime), N'me', CAST(N'2017-01-19T01:45:37.513' AS DateTime))
GO
INSERT [Auth].[OrgAppUserRole] ([Id], [OrgAppUserId], [OrgAppRoleId], [IsActive], [IsDeleted], [created_by], [created_dt], [modified_by], [modified_dt]) VALUES (13, 13, 2, 1, 0, N'me', CAST(N'2017-01-19T01:45:37.513' AS DateTime), N'me', CAST(N'2017-01-19T01:45:37.513' AS DateTime))
GO
INSERT [Auth].[OrgAppUserRole] ([Id], [OrgAppUserId], [OrgAppRoleId], [IsActive], [IsDeleted], [created_by], [created_dt], [modified_by], [modified_dt]) VALUES (14, 14, 2, 1, 0, N'me', CAST(N'2017-01-19T01:45:37.513' AS DateTime), N'me', CAST(N'2017-01-19T01:45:37.513' AS DateTime))
GO
INSERT [Auth].[OrgAppUserRole] ([Id], [OrgAppUserId], [OrgAppRoleId], [IsActive], [IsDeleted], [created_by], [created_dt], [modified_by], [modified_dt]) VALUES (15, 15, 2, 1, 0, N'me', CAST(N'2017-01-19T01:45:37.513' AS DateTime), N'me', CAST(N'2017-01-19T01:45:37.513' AS DateTime))
GO
INSERT [Auth].[OrgAppUserRole] ([Id], [OrgAppUserId], [OrgAppRoleId], [IsActive], [IsDeleted], [created_by], [created_dt], [modified_by], [modified_dt]) VALUES (16, 16, 2, 1, 0, N'me', CAST(N'2017-01-19T01:45:37.513' AS DateTime), N'me', CAST(N'2017-01-19T01:45:37.513' AS DateTime))
GO
INSERT [Auth].[OrgAppUserRole] ([Id], [OrgAppUserId], [OrgAppRoleId], [IsActive], [IsDeleted], [created_by], [created_dt], [modified_by], [modified_dt]) VALUES (17, 17, 2, 1, 0, N'me', CAST(N'2017-01-19T01:45:37.513' AS DateTime), N'me', CAST(N'2017-01-19T01:45:37.513' AS DateTime))
GO
INSERT [Auth].[OrgAppUserRole] ([Id], [OrgAppUserId], [OrgAppRoleId], [IsActive], [IsDeleted], [created_by], [created_dt], [modified_by], [modified_dt]) VALUES (18, 18, 2, 1, 0, N'me', CAST(N'2017-01-19T01:45:37.513' AS DateTime), N'me', CAST(N'2017-01-19T01:45:37.513' AS DateTime))
GO
INSERT [Auth].[OrgAppUserRole] ([Id], [OrgAppUserId], [OrgAppRoleId], [IsActive], [IsDeleted], [created_by], [created_dt], [modified_by], [modified_dt]) VALUES (44, 19, 1, 1, 0, N'me', CAST(N'2017-01-19T01:45:37.520' AS DateTime), N'me', CAST(N'2017-01-19T01:45:37.520' AS DateTime))
GO
INSERT [Auth].[OrgAppUserRole] ([Id], [OrgAppUserId], [OrgAppRoleId], [IsActive], [IsDeleted], [created_by], [created_dt], [modified_by], [modified_dt]) VALUES (19, 20, 2, 1, 0, N'me', CAST(N'2017-01-19T01:45:37.513' AS DateTime), N'me', CAST(N'2017-01-19T01:45:37.513' AS DateTime))
GO
INSERT [Auth].[OrgAppUserRole] ([Id], [OrgAppUserId], [OrgAppRoleId], [IsActive], [IsDeleted], [created_by], [created_dt], [modified_by], [modified_dt]) VALUES (20, 21, 2, 1, 0, N'me', CAST(N'2017-01-19T01:45:37.513' AS DateTime), N'me', CAST(N'2017-01-19T01:45:37.513' AS DateTime))
GO
INSERT [Auth].[OrgAppUserRole] ([Id], [OrgAppUserId], [OrgAppRoleId], [IsActive], [IsDeleted], [created_by], [created_dt], [modified_by], [modified_dt]) VALUES (21, 22, 2, 1, 0, N'me', CAST(N'2017-01-19T01:45:37.513' AS DateTime), N'me', CAST(N'2017-01-19T01:45:37.513' AS DateTime))
GO
INSERT [Auth].[OrgAppUserRole] ([Id], [OrgAppUserId], [OrgAppRoleId], [IsActive], [IsDeleted], [created_by], [created_dt], [modified_by], [modified_dt]) VALUES (45, 23, 1, 1, 0, N'me', CAST(N'2017-01-19T01:45:37.520' AS DateTime), N'me', CAST(N'2017-01-19T01:45:37.520' AS DateTime))
GO
INSERT [Auth].[OrgAppUserRole] ([Id], [OrgAppUserId], [OrgAppRoleId], [IsActive], [IsDeleted], [created_by], [created_dt], [modified_by], [modified_dt]) VALUES (22, 24, 2, 1, 0, N'me', CAST(N'2017-01-19T01:45:37.513' AS DateTime), N'me', CAST(N'2017-01-19T01:45:37.513' AS DateTime))
GO
INSERT [Auth].[OrgAppUserRole] ([Id], [OrgAppUserId], [OrgAppRoleId], [IsActive], [IsDeleted], [created_by], [created_dt], [modified_by], [modified_dt]) VALUES (23, 25, 2, 1, 0, N'me', CAST(N'2017-01-19T01:45:37.513' AS DateTime), N'me', CAST(N'2017-01-19T01:45:37.513' AS DateTime))
GO
INSERT [Auth].[OrgAppUserRole] ([Id], [OrgAppUserId], [OrgAppRoleId], [IsActive], [IsDeleted], [created_by], [created_dt], [modified_by], [modified_dt]) VALUES (24, 26, 2, 1, 0, N'me', CAST(N'2017-01-19T01:45:37.513' AS DateTime), N'me', CAST(N'2017-01-19T01:45:37.513' AS DateTime))
GO
INSERT [Auth].[OrgAppUserRole] ([Id], [OrgAppUserId], [OrgAppRoleId], [IsActive], [IsDeleted], [created_by], [created_dt], [modified_by], [modified_dt]) VALUES (25, 27, 2, 1, 0, N'me', CAST(N'2017-01-19T01:45:37.513' AS DateTime), N'me', CAST(N'2017-01-19T01:45:37.513' AS DateTime))
GO
INSERT [Auth].[OrgAppUserRole] ([Id], [OrgAppUserId], [OrgAppRoleId], [IsActive], [IsDeleted], [created_by], [created_dt], [modified_by], [modified_dt]) VALUES (26, 28, 2, 1, 0, N'me', CAST(N'2017-01-19T01:45:37.513' AS DateTime), N'me', CAST(N'2017-01-19T01:45:37.513' AS DateTime))
GO
INSERT [Auth].[OrgAppUserRole] ([Id], [OrgAppUserId], [OrgAppRoleId], [IsActive], [IsDeleted], [created_by], [created_dt], [modified_by], [modified_dt]) VALUES (27, 29, 2, 1, 0, N'me', CAST(N'2017-01-19T01:45:37.513' AS DateTime), N'me', CAST(N'2017-01-19T01:45:37.513' AS DateTime))
GO
INSERT [Auth].[OrgAppUserRole] ([Id], [OrgAppUserId], [OrgAppRoleId], [IsActive], [IsDeleted], [created_by], [created_dt], [modified_by], [modified_dt]) VALUES (28, 30, 2, 1, 0, N'me', CAST(N'2017-01-19T01:45:37.513' AS DateTime), N'me', CAST(N'2017-01-19T01:45:37.513' AS DateTime))
GO
INSERT [Auth].[OrgAppUserRole] ([Id], [OrgAppUserId], [OrgAppRoleId], [IsActive], [IsDeleted], [created_by], [created_dt], [modified_by], [modified_dt]) VALUES (46, 31, 1, 1, 0, N'me', CAST(N'2017-01-19T01:45:37.520' AS DateTime), N'me', CAST(N'2017-01-19T01:45:37.520' AS DateTime))
GO
INSERT [Auth].[OrgAppUserRole] ([Id], [OrgAppUserId], [OrgAppRoleId], [IsActive], [IsDeleted], [created_by], [created_dt], [modified_by], [modified_dt]) VALUES (29, 31, 2, 1, 0, N'me', CAST(N'2017-01-19T01:45:37.513' AS DateTime), N'me', CAST(N'2017-01-19T01:45:37.513' AS DateTime))
GO
INSERT [Auth].[OrgAppUserRole] ([Id], [OrgAppUserId], [OrgAppRoleId], [IsActive], [IsDeleted], [created_by], [created_dt], [modified_by], [modified_dt]) VALUES (30, 32, 2, 1, 0, N'me', CAST(N'2017-01-19T01:45:37.513' AS DateTime), N'me', CAST(N'2017-01-19T01:45:37.513' AS DateTime))
GO
INSERT [Auth].[OrgAppUserRole] ([Id], [OrgAppUserId], [OrgAppRoleId], [IsActive], [IsDeleted], [created_by], [created_dt], [modified_by], [modified_dt]) VALUES (31, 33, 2, 1, 0, N'me', CAST(N'2017-01-19T01:45:37.513' AS DateTime), N'me', CAST(N'2017-01-19T01:45:37.513' AS DateTime))
GO
INSERT [Auth].[OrgAppUserRole] ([Id], [OrgAppUserId], [OrgAppRoleId], [IsActive], [IsDeleted], [created_by], [created_dt], [modified_by], [modified_dt]) VALUES (32, 34, 2, 1, 0, N'me', CAST(N'2017-01-19T01:45:37.513' AS DateTime), N'me', CAST(N'2017-01-19T01:45:37.513' AS DateTime))
GO
INSERT [Auth].[OrgAppUserRole] ([Id], [OrgAppUserId], [OrgAppRoleId], [IsActive], [IsDeleted], [created_by], [created_dt], [modified_by], [modified_dt]) VALUES (47, 35, 1, 1, 0, N'me', CAST(N'2017-01-19T01:45:37.520' AS DateTime), N'me', CAST(N'2017-01-19T01:45:37.520' AS DateTime))
GO
INSERT [Auth].[OrgAppUserRole] ([Id], [OrgAppUserId], [OrgAppRoleId], [IsActive], [IsDeleted], [created_by], [created_dt], [modified_by], [modified_dt]) VALUES (48, 36, 1, 1, 0, N'me', CAST(N'2017-01-19T01:45:37.520' AS DateTime), N'me', CAST(N'2017-01-19T01:45:37.520' AS DateTime))
GO
INSERT [Auth].[OrgAppUserRole] ([Id], [OrgAppUserId], [OrgAppRoleId], [IsActive], [IsDeleted], [created_by], [created_dt], [modified_by], [modified_dt]) VALUES (33, 36, 2, 1, 0, N'me', CAST(N'2017-01-19T01:45:37.513' AS DateTime), N'me', CAST(N'2017-01-19T01:45:37.513' AS DateTime))
GO
INSERT [Auth].[OrgAppUserRole] ([Id], [OrgAppUserId], [OrgAppRoleId], [IsActive], [IsDeleted], [created_by], [created_dt], [modified_by], [modified_dt]) VALUES (34, 37, 2, 1, 0, N'me', CAST(N'2017-01-19T01:45:37.513' AS DateTime), N'me', CAST(N'2017-01-19T01:45:37.513' AS DateTime))
GO
INSERT [Auth].[OrgAppUserRole] ([Id], [OrgAppUserId], [OrgAppRoleId], [IsActive], [IsDeleted], [created_by], [created_dt], [modified_by], [modified_dt]) VALUES (35, 38, 2, 1, 0, N'me', CAST(N'2017-01-19T01:45:37.513' AS DateTime), N'me', CAST(N'2017-01-19T01:45:37.513' AS DateTime))
GO
INSERT [Auth].[OrgAppUserRole] ([Id], [OrgAppUserId], [OrgAppRoleId], [IsActive], [IsDeleted], [created_by], [created_dt], [modified_by], [modified_dt]) VALUES (36, 39, 2, 1, 0, N'me', CAST(N'2017-01-19T01:45:37.513' AS DateTime), N'me', CAST(N'2017-01-19T01:45:37.513' AS DateTime))
GO
INSERT [Auth].[OrgAppUserRole] ([Id], [OrgAppUserId], [OrgAppRoleId], [IsActive], [IsDeleted], [created_by], [created_dt], [modified_by], [modified_dt]) VALUES (37, 40, 2, 1, 0, N'me', CAST(N'2017-01-19T01:45:37.513' AS DateTime), N'me', CAST(N'2017-01-19T01:45:37.513' AS DateTime))
GO
INSERT [Auth].[OrgAppUserRole] ([Id], [OrgAppUserId], [OrgAppRoleId], [IsActive], [IsDeleted], [created_by], [created_dt], [modified_by], [modified_dt]) VALUES (38, 41, 2, 1, 0, N'me', CAST(N'2017-01-19T01:45:37.513' AS DateTime), N'me', CAST(N'2017-01-19T01:45:37.513' AS DateTime))
GO
INSERT [Auth].[OrgAppUserRole] ([Id], [OrgAppUserId], [OrgAppRoleId], [IsActive], [IsDeleted], [created_by], [created_dt], [modified_by], [modified_dt]) VALUES (39, 42, 2, 1, 0, N'me', CAST(N'2017-01-19T01:45:37.513' AS DateTime), N'me', CAST(N'2017-01-19T01:45:37.513' AS DateTime))
GO
INSERT [Auth].[OrgAppUserRole] ([Id], [OrgAppUserId], [OrgAppRoleId], [IsActive], [IsDeleted], [created_by], [created_dt], [modified_by], [modified_dt]) VALUES (40, 43, 2, 1, 0, N'me', CAST(N'2017-01-19T01:45:37.513' AS DateTime), N'me', CAST(N'2017-01-19T01:45:37.513' AS DateTime))
GO
INSERT [Auth].[OrgAppUserRole] ([Id], [OrgAppUserId], [OrgAppRoleId], [IsActive], [IsDeleted], [created_by], [created_dt], [modified_by], [modified_dt]) VALUES (41, 44, 2, 1, 0, N'me', CAST(N'2017-01-19T01:45:37.513' AS DateTime), N'me', CAST(N'2017-01-19T01:45:37.513' AS DateTime))
GO
INSERT [Auth].[OrgAppUserRole] ([Id], [OrgAppUserId], [OrgAppRoleId], [IsActive], [IsDeleted], [created_by], [created_dt], [modified_by], [modified_dt]) VALUES (42, 45, 2, 1, 0, N'me', CAST(N'2017-01-19T01:45:37.513' AS DateTime), N'me', CAST(N'2017-01-19T01:45:37.513' AS DateTime))
GO
INSERT [Auth].[OrgAppUserRole] ([Id], [OrgAppUserId], [OrgAppRoleId], [IsActive], [IsDeleted], [created_by], [created_dt], [modified_by], [modified_dt]) VALUES (43, 46, 2, 1, 0, N'me', CAST(N'2017-01-19T01:45:37.513' AS DateTime), N'me', CAST(N'2017-01-19T01:45:37.513' AS DateTime))
GO
SET IDENTITY_INSERT [Auth].[OrgAppUserRole] OFF
GO
