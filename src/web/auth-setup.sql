
use AppFramework
go

IF NOT EXISTS (SELECT 1 FROM sys.schemas WHERE name = 'Auth')
BEGIN
    -- The schema must be run in its own batch!
    EXEC( 'CREATE SCHEMA Auth' );
END

IF NOT EXISTS (SELECT 1 FROM sys.schemas WHERE name = 'Config')
BEGIN
    -- The schema must be run in its own batch!
    EXEC( 'CREATE SCHEMA Config' );
END

IF NOT EXISTS (SELECT 1 FROM sys.schemas WHERE name = 'Logging')
BEGIN
    -- The schema must be run in its own batch!
    EXEC( 'CREATE SCHEMA Logging' );
END

if object_id('Auth.[OrgAppUserMetadata]', 'U') is not null
	drop table [auth].OrgAppUserMetadata
if object_id('Auth.[UserRefreshToken]', 'U') is not null
	drop table [auth].UserRefreshToken
if object_id('Auth.OrgGlobalUserRole', 'U') is not null
	drop table [auth].[OrgGlobalUserRole]
if object_id('Auth.OrgGlobalRole', 'U') is not null
	drop table [auth].[OrgGlobalRole]
if object_id('Auth.OrgUserRole', 'U') is not null
	drop table [auth].[OrgUserRole]
if object_id('Auth.OrgRole', 'U') is not null
	drop table [auth].[OrgRole]
if object_id('Auth.OrgAppUserAuthIp', 'U') is not null
	drop table [auth].[OrgAppUserAuthIp]
if object_id('Auth.OrgAppUserRole', 'U') is not null
	drop table [auth].[OrgAppUserRole]
if object_id('Auth.OrgAppUser', 'U') is not null
	drop table [auth].[OrgAppUser]
if object_id('Auth.OrgAppRole', 'U') is not null
	drop table [auth].[OrgAppRole]
if object_id('Auth.OrgApp', 'U') is not null
	drop table [auth].[OrgApp]
if object_id('Auth.[OrgUserRefreshToken]', 'U') is not null
	drop table [auth].OrgUserRefreshToken
if object_id('Auth.[OrgClient]', 'U') is not null
	drop table [auth].OrgClient
if object_id('Auth.[OrgClientType]', 'U') is not null
	drop table [auth].OrgClientType
if object_id('Auth.OrgUser', 'U') is not null
	drop table [auth].[OrgUser]
if object_id('Auth.Org', 'U') is not null
	drop table [auth].[Org]

create table [auth].Org
(
	Id int not null identity(1,1)
	,OrgName varchar(250) not null constraint uqc_Org_OrgName unique
	,IsActive bit not null
	,IsDeleted bit not null
	,created_by varchar(50) not null
	,created_dt datetime not null
	,modified_by varchar(50) not null
	,modified_dt datetime not null

	constraint pk_Org_Id primary key (Id asc)
)
alter table [auth].[Org] add constraint [df_Org_IsActive] default (0) for [IsActive]
alter table [auth].[Org] add constraint [df_Org_IsDeleted] default (0) for [IsDeleted]
alter table [auth].[Org] add constraint [df_Org_created_by] default (user_name()) for [created_by]
alter table [auth].[Org] add constraint [df_Org_created_dt] default (getdate()) for [created_dt]
alter table [auth].[Org] add constraint [df_Org_modified_by] default (user_name()) for [modified_by]
alter table [auth].[Org] add constraint [df_Org_modified_dt] default (getdate()) for [modified_dt]

create table [auth].[OrgUser]
(
	Id int not null identity(1,1)
	,UserName varchar(250) not null
	,Email varchar(250)
	,PhoneNumber varchar(250) null
	,PasswordHash varchar(max) null
	,SecurityStamp varchar(max) null
	,IsLockoutEnabled bit  not null
	,IsTwoFactorEnabled bit not null
	,AccessFailedCount int not null
	,LockoutEndDateUtc datetime null
	,Claims varchar(max) null
	,Logins varchar(max) null
	,FirstName varchar(250) null
	,LastName varchar(250) null
	,Suffix varchar(250) null
	,OrgId int not null
		constraint fk_OrgUser_Org_Id references [auth].[Org](Id)
	,IsActive bit not null
	,IsDeleted bit not null
	,created_by varchar(50) not null
	,created_dt datetime not null
	,modified_by varchar(50) not null
	,modified_dt datetime not null

	constraint pk_OrgUser_Id_OrgId primary key (Id)	
)

alter table [auth].[OrgUser] add constraint [df_OrgUser_IsLockoutEnabled] default (0) for [IsLockoutEnabled]
alter table [auth].[OrgUser] add constraint [df_OrgUser_IsTwoFactorEnabled] default (0) for [IsTwoFactorEnabled]
alter table [auth].[OrgUser] add constraint [df_OrgUser_AccessFailedCount] default (0) for [AccessFailedCount]
alter table [auth].[OrgUser] add constraint [df_OrgUser_IsActive] default (0) for [IsActive]
alter table [auth].[OrgUser] add constraint [df_OrgUser_IsDeleted] default (0) for [IsDeleted]
alter table [auth].[OrgUser] add constraint [df_OrgUser_created_by] default (user_name()) for [created_by]
alter table [auth].[OrgUser] add constraint [df_OrgUser_created_dt] default (getdate()) for [created_dt]
alter table [auth].[OrgUser] add constraint [df_OrgUser_modified_by] default (user_name()) for [modified_by]
alter table [auth].[OrgUser] add constraint [df_OrgUser_modified_dt] default (getdate()) for [modified_dt]

/*************************************
* Organization Client
*************************************/

create table [auth].[OrgClientType]
(
	Id int not null identity(1,1)
	,Name varchar(250) not null unique
	,OrgId int not null
		constraint fk_OrgClientType_Org_Id references [auth].[Org](Id)
	,IsActive bit not null
	,IsDeleted bit not null
	,created_by varchar(50) not null
	,created_dt datetime not null
	,modified_by varchar(50) not null
	,modified_dt datetime not null

	constraint pk_OrgClientType_Id primary key (Id)
)

create table [auth].[OrgClient]
(
	Id varchar(250) not null
	,Secret varchar(max) null
	,Name varchar(250) not null unique
	,ClientTypeId int not null
		constraint fk_OrgClient_OrgClientType_Id references [auth].[OrgClientType](Id)
	,OrgId int not null
		constraint fk_OrgClient_Org_Id references [auth].[Org](Id)
	,RefreshTokenLifeTime int not null
	,AllowedOrigin varchar(100) not null

	,IsActive bit not null
	,IsDeleted bit not null
	,created_by varchar(50) not null
	,created_dt datetime not null
	,modified_by varchar(50) not null
	,modified_dt datetime not null

	constraint pk_OrgClient_Id_OrgId primary key (Id asc)
)

create table auth.OrgUserRefreshToken
(
	Id varchar(250) not null
	,Subject varchar(250) not null
	,OrgClientId varchar(250) not null
		constraint fk_OrgUserRefreshToken_OrgClient_Id references [auth].[OrgClient](Id)
	,OrgUserId int not null
		constraint fk_OrgUserRefreshToken_OrgUser_Id references [auth].[OrgUser](Id)
	,IssuedUtc datetime not null
	,ExpiresUtc datetime not null
	,ProtectedTicket varchar(max) not null

	constraint pk_OrgUserRefreshToken_Id primary key (Id asc)
)

/*************************************
* Organization Roles and Users
*************************************/

create table [auth].OrgGlobalRole
(
	Id int not null identity(1,1)
	,OrgId int not null
		constraint fk_OrgGlobalRole_Org_Id references auth.Org(Id)
	,Name varchar(250) not null
	,IsActive bit not null
	,IsDeleted bit not null
	,created_by varchar(50) not null
	,created_dt datetime not null
	,modified_by varchar(50) not null
	,modified_dt datetime not null

	constraint pk_OrgGlobalRole_Id primary key (Id asc)
)

alter table [auth].[OrgGlobalRole] add constraint [df_OrgGlobalRole_IsActive] default (0) for [IsActive]
alter table [auth].[OrgGlobalRole] add constraint [df_OrgGlobalRole_IsDeleted] default (0) for [IsDeleted]
alter table [auth].[OrgGlobalRole] add constraint [df_OrgGlobalRole_created_by] default (user_name()) for [created_by]
alter table [auth].[OrgGlobalRole] add constraint [df_OrgGlobalRole_created_dt] default (getdate()) for [created_dt]
alter table [auth].[OrgGlobalRole] add constraint [df_OrgGlobalRole_modified_by] default (user_name()) for [modified_by]
alter table [auth].[OrgGlobalRole] add constraint [df_OrgGlobalRole_modified_dt] default (getdate()) for [modified_dt]

create table [auth].OrgRole
(
	Id int not null identity(1,1)
	,OrgId int not null
		constraint fk_OrgRole_Org_Id references auth.Org(Id)
	,Name varchar(250) not null
	,IsActive bit not null
	,IsDeleted bit not null
	,created_by varchar(50) not null
	,created_dt datetime not null
	,modified_by varchar(50) not null
	,modified_dt datetime not null

	constraint pk_OrgRole_Id primary key (Id asc)
)

alter table [auth].[OrgRole] add constraint [df_OrgRole_IsActive] default (0) for [IsActive]
alter table [auth].[OrgRole] add constraint [df_OrgRole_IsDeleted] default (0) for [IsDeleted]
alter table [auth].[OrgRole] add constraint [df_OrgRole_created_by] default (user_name()) for [created_by]
alter table [auth].[OrgRole] add constraint [df_OrgRole_created_dt] default (getdate()) for [created_dt]
alter table [auth].[OrgRole] add constraint [df_OrgRole_modified_by] default (user_name()) for [modified_by]
alter table [auth].[OrgRole] add constraint [df_OrgRole_modified_dt] default (getdate()) for [modified_dt]

create table [auth].OrgGlobalUserRole
(
	Id int not null identity(1,1)
	,OrgUserId int not null
		constraint fk_OrgGlobalUserRole_OrgUser_Id references auth.OrgUser(Id)
	,OrgGlobalRoleId int not null
		constraint fk_OrgGlobalUserRole_OrgGlobalRole_Id references auth.OrgGlobalRole(Id)
	,IsActive bit not null
	,IsDeleted bit not null
	,created_by varchar(50) not null
	,created_dt datetime not null
	,modified_by varchar(50) not null
	,modified_dt datetime not null

	constraint cpk_OrgGlobalUserRole_OrgUserId_OrgGlobalRoleId primary key clustered (OrgUserId, OrgGlobalRoleId)
)

alter table [auth].[OrgGlobalUserRole] add constraint [df_OrgGlobalUserRole_IsActive] default (0) for [IsActive]
alter table [auth].[OrgGlobalUserRole] add constraint [df_OrgGlobalUserRole_IsDeleted] default (0) for [IsDeleted]
alter table [auth].[OrgGlobalUserRole] add constraint [df_OrgGlobalUserRole_created_by] default (user_name()) for [created_by]
alter table [auth].[OrgGlobalUserRole] add constraint [df_OrgGlobalUserRole_created_dt] default (getdate()) for [created_dt]
alter table [auth].[OrgGlobalUserRole] add constraint [df_OrgGlobalUserRole_modified_by] default (user_name()) for [modified_by]
alter table [auth].[OrgGlobalUserRole] add constraint [df_OrgGlobalUserRole_modified_dt] default (getdate()) for [modified_dt]

create table [auth].OrgUserRole
(
	Id int not null identity(1,1)
	,OrgUserId int not null
		constraint fk_OrgUserRole_OrgUser_Id references auth.OrgUser(Id)
	,OrgRoleId int not null
		constraint fk_OrgUserRole_OrgRole_Id references auth.OrgRole(Id)
	,IsActive bit not null
	,IsDeleted bit not null
	,created_by varchar(50) not null
	,created_dt datetime not null
	,modified_by varchar(50) not null
	,modified_dt datetime not null

	constraint cpk_OrgUserRole_OrgUserId_OrgRoleId primary key (OrgUserId, OrgRoleId)
)

alter table [auth].[OrgUserRole] add constraint [df_OrgUserRole_IsActive] default (0) for [IsActive]
alter table [auth].[OrgUserRole] add constraint [df_OrgUserRole_IsDeleted] default (0) for [IsDeleted]
alter table [auth].[OrgUserRole] add constraint [df_OrgUserRole_created_by] default (user_name()) for [created_by]
alter table [auth].[OrgUserRole] add constraint [df_OrgUserRole_created_dt] default (getdate()) for [created_dt]
alter table [auth].[OrgUserRole] add constraint [df_OrgUserRole_modified_by] default (user_name()) for [modified_by]
alter table [auth].[OrgUserRole] add constraint [df_OrgUserRole_modified_dt] default (getdate()) for [modified_dt]

/*************************************
* Organization App specific tables
*************************************/
create table [auth].OrgApp
(
	Id int not null Identity(1,1)
	,OrgId int not null
		constraint fk_OrgApp_Org_Id references auth.Org(Id)
	,AppName varchar(250) not null
	,IsActive bit not null
	,IsDeleted bit not null
	,created_by varchar(50) not null
	,created_dt datetime not null
	,modified_by varchar(50) not null
	,modified_dt datetime not null

	constraint pk_OrgApp_Id primary key (Id asc)
)

alter table [auth].[OrgApp] add constraint [df_OrgApp_IsActive] default (0) for [IsActive]
alter table [auth].[OrgApp] add constraint [df_OrgApp_IsDeleted] default (0) for [IsDeleted]
alter table [auth].[OrgApp] add constraint [df_OrgApp_created_by] default (user_name()) for [created_by]
alter table [auth].[OrgApp] add constraint [df_OrgApp_created_dt] default (getdate()) for [created_dt]
alter table [auth].[OrgApp] add constraint [df_OrgApp_modified_by] default (user_name()) for [modified_by]
alter table [auth].[OrgApp] add constraint [df_OrgApp_modified_dt] default (getdate()) for [modified_dt]

create table [auth].OrgAppRole
(
	Id int not null identity(1,1)
	,OrgAppId int not null
		constraint fk_OrgAppRole_OrgApp_Id references auth.OrgApp(Id)
	,Name varchar(250) not null
	,IsActive bit not null
	,IsDeleted bit not null
	,created_by varchar(50) not null
	,created_dt datetime not null
	,modified_by varchar(50) not null
	,modified_dt datetime not null

	constraint pk_OrgAppRole_Id primary key (Id asc)
)

alter table [auth].[OrgAppRole] add constraint [df_OrgAppRole_IsActive] default (0) for [IsActive]
alter table [auth].[OrgAppRole] add constraint [df_OrgAppRole_IsDeleted] default (0) for [IsDeleted]
alter table [auth].[OrgAppRole] add constraint [df_OrgAppRole_created_by] default (user_name()) for [created_by]
alter table [auth].[OrgAppRole] add constraint [df_OrgAppRole_created_dt] default (getdate()) for [created_dt]
alter table [auth].[OrgAppRole] add constraint [df_OrgAppRole_modified_by] default (user_name()) for [modified_by]
alter table [auth].[OrgAppRole] add constraint [df_OrgAppRole_modified_dt] default (getdate()) for [modified_dt]

create table [auth].OrgAppUser
(
	Id int not null identity(1,1)
	,UserId int not null
		constraint fk_OrgAppUser_User_Id references auth.[OrgUser](id)
	,OrgAppId int not null 
		constraint fk_OrgAppUser_OrgApp_Id references auth.OrgApp(Id)
	,IsActive bit not null
	,IsDeleted bit not null
	,created_by varchar(50) not null
	,created_dt datetime not null
	,modified_by varchar(50) not null
	,modified_dt datetime not null

	constraint pk_OrgAppUser_Id primary key (Id asc)
)

alter table [auth].[OrgAppUser] add constraint [df_OrgAppUser_IsActive] default (0) for [IsActive]
alter table [auth].[OrgAppUser] add constraint [df_OrgAppUser_IsDeleted] default (0) for [IsDeleted]
alter table [auth].[OrgAppUser] add constraint [df_OrgAppUser_created_by] default (user_name()) for [created_by]
alter table [auth].[OrgAppUser] add constraint [df_OrgAppUser_created_dt] default (getdate()) for [created_dt]
alter table [auth].[OrgAppUser] add constraint [df_OrgAppUser_modified_by] default (user_name()) for [modified_by]
alter table [auth].[OrgAppUser] add constraint [df_OrgAppUser_modified_dt] default (getdate()) for [modified_dt]

create table [auth].OrgAppUserRole
(
	Id int not null identity(1,1)
	,OrgAppUserId int not null
		constraint fk_OrgAppUserRole_OrgAppUser_Id references auth.OrgAppUser(Id)
	,OrgAppRoleId int not null
		constraint fk_OrgAppUserRole_OrgAppRole_Id references auth.OrgAppRole(Id)
	,IsActive bit not null
	,IsDeleted bit not null
	,created_by varchar(50) not null
	,created_dt datetime not null
	,modified_by varchar(50) not null
	,modified_dt datetime not null

	constraint cpk_OrgAppUserRole_OrgAppUserId_OrgAppRoleId primary key (OrgAppUserId, OrgAppRoleId)
)

alter table [auth].[OrgAppUserRole] add constraint [df_OrgAppUserRole_IsActive] default (0) for [IsActive]
alter table [auth].[OrgAppUserRole] add constraint [df_OrgAppUserRole_IsDeleted] default (0) for [IsDeleted]
alter table [auth].[OrgAppUserRole] add constraint [df_OrgAppUserRole_created_by] default (user_name()) for [created_by]
alter table [auth].[OrgAppUserRole] add constraint [df_OrgAppUserRole_created_dt] default (getdate()) for [created_dt]
alter table [auth].[OrgAppUserRole] add constraint [df_OrgAppUserRole_modified_by] default (user_name()) for [modified_by]
alter table [auth].[OrgAppUserRole] add constraint [df_OrgAppUserRole_modified_dt] default (getdate()) for [modified_dt]

create table [auth].OrgAppUserAuthIp
(
	Id int not null identity(1,1)
	,OrgAppUserId int not null
		constraint fk_OrgAppUserAuthIp_OrgAppUser_Id references auth.OrgAppUser(Id)
	,Ip varchar(15) not null
	,IsActive bit not null
	,IsDeleted bit not null
	,created_by varchar(50) not null
	,created_dt datetime not null
	,modified_by varchar(50) not null
	,modified_dt datetime not null

	constraint pk_OrgAppUserAuthIp_OrgAppUserId_Ip primary key (OrgAppUserId, Ip)
)

alter table [auth].[OrgAppUserAuthIp] add constraint [df_OrgAppUserAuthIp_IsActive] default (0) for [IsActive]
alter table [auth].[OrgAppUserAuthIp] add constraint [df_OrgAppUserAuthIp_IsDeleted] default (0) for [IsDeleted]
alter table [auth].[OrgAppUserAuthIp] add constraint [df_OrgAppUserAuthIp_created_by] default (user_name()) for [created_by]
alter table [auth].[OrgAppUserAuthIp] add constraint [df_OrgAppUserAuthIp_created_dt] default (getdate()) for [created_dt]
alter table [auth].[OrgAppUserAuthIp] add constraint [df_OrgAppUserAuthIp_modified_by] default (user_name()) for [modified_by]
alter table [auth].[OrgAppUserAuthIp] add constraint [df_OrgAppUserAuthIp_modified_dt] default (getdate()) for [modified_dt]


create table [auth].OrgAppUserMetadata
(
	Id int not null identity(1,1)
	,OrgAppUserId int not null
		constraint fk_OrgAppUserMetadata_OrgAppUser_Id references auth.OrgAppUser(Id)
	,Metadata xml not null
	,created_by varchar(50) not null
	,created_dt datetime not null
	,modified_by varchar(50) not null
	,modified_dt datetime not null

	constraint pk_OrgAppUserMetadata_Id primary key (Id asc)
)

alter table [auth].[OrgAppUserMetadata] add constraint [df_OrgAppUserMetadata_created_by] default (user_name()) for [created_by]
alter table [auth].[OrgAppUserMetadata] add constraint [df_OrgAppUserMetadata_created_dt] default (getdate()) for [created_dt]
alter table [auth].[OrgAppUserMetadata] add constraint [df_OrgAppUserMetadata_modified_by] default (user_name()) for [modified_by]
alter table [auth].[OrgAppUserMetadata] add constraint [df_OrgAppUserMetadata_modified_dt] default (getdate()) for [modified_dt]

create table [auth].UserRefreshToken
(
	Id uniqueidentifier not null
	,Username varchar(250) not null
	,AccessToken varchar(max) not null
	,ExpirationDateUtc datetimeoffset not null
	,IssuedDateUtc datetimeoffset not null
	,created_by varchar(50) not null
	,created_dt datetime not null
	,modified_by varchar(50) not null
	,modified_dt datetime not null

	constraint pk_UserRefreshToken_Id primary key (Id asc)
)

alter table [auth].[UserRefreshToken] add constraint [df_UserRefreshToken_created_by] default (user_name()) for [created_by]
alter table [auth].[UserRefreshToken] add constraint [df_UserRefreshToken_created_dt] default (getdate()) for [created_dt]
alter table [auth].[UserRefreshToken] add constraint [df_UserRefreshToken_modified_by] default (user_name()) for [modified_by]
alter table [auth].[UserRefreshToken] add constraint [df_UserRefreshToken_modified_dt] default (getdate()) for [modified_dt]

--SELECT 'CREATE INDEX [IX_' + f.name + '] ON Auth.' + OBJECT_NAME(f.parent_object_id) + '(' + COL_NAME(fc.parent_object_id, fc.parent_column_id) +')'
--FROM sys.foreign_keys AS f 
--INNER JOIN sys.foreign_key_columns AS fc 
--ON f.OBJECT_ID = fc.constraint_object_id

CREATE INDEX [IX_fk_OrgUser_Org_Id] ON Auth.OrgUser(OrgId)
CREATE INDEX [IX_fk_OrgClientType_Org_Id] ON Auth.OrgClientType(OrgId)
CREATE INDEX [IX_fk_OrgClient_Org_Id] ON Auth.OrgClient(OrgId)
CREATE INDEX [IX_fk_OrgGlobalRole_Org_Id] ON Auth.OrgGlobalRole(OrgId)
CREATE INDEX [IX_fk_OrgRole_Org_Id] ON Auth.OrgRole(OrgId)
CREATE INDEX [IX_fk_OrgApp_Org_Id] ON Auth.OrgApp(OrgId)
CREATE INDEX [IX_fk_OrgUserRefreshToken_OrgUser_Id] ON Auth.OrgUserRefreshToken(OrgUserId)
CREATE INDEX [IX_fk_OrgGlobalUserRole_OrgUser_Id] ON Auth.OrgGlobalUserRole(OrgUserId)
CREATE INDEX [IX_fk_OrgUserRole_OrgUser_Id] ON Auth.OrgUserRole(OrgUserId)
CREATE INDEX [IX_fk_OrgAppUser_User_Id] ON Auth.OrgAppUser(UserId)
CREATE INDEX [IX_fk_OrgClient_OrgClientType_Id] ON Auth.OrgClient(ClientTypeId)
CREATE INDEX [IX_fk_OrgUserRefreshToken_OrgClient_Id] ON Auth.OrgUserRefreshToken(OrgClientId)
CREATE INDEX [IX_fk_OrgGlobalUserRole_OrgGlobalRole_Id] ON Auth.OrgGlobalUserRole(OrgGlobalRoleId)
CREATE INDEX [IX_fk_OrgUserRole_OrgRole_Id] ON Auth.OrgUserRole(OrgRoleId)
CREATE INDEX [IX_fk_OrgAppRole_OrgApp_Id] ON Auth.OrgAppRole(OrgAppId)
CREATE INDEX [IX_fk_OrgAppUser_OrgApp_Id] ON Auth.OrgAppUser(OrgAppId)
CREATE INDEX [IX_fk_OrgAppUserRole_OrgAppRole_Id] ON Auth.OrgAppUserRole(OrgAppRoleId)
CREATE INDEX [IX_fk_OrgAppUserRole_OrgAppUser_Id] ON Auth.OrgAppUserRole(OrgAppUserId)
CREATE INDEX [IX_fk_OrgAppUserAuthIp_OrgAppUser_Id] ON Auth.OrgAppUserAuthIp(OrgAppUserId)
CREATE INDEX [IX_fk_OrgAppUserMetadata_OrgAppUser_Id] ON Auth.OrgAppUserMetadata(OrgAppUserId)

insert into auth.org select 'mfcu', 1, 0, 'someone', GETUTCDATE(), 'someone', GETUTCDATE()

insert into auth.OrgClientType select 'Native - Confidential', 1, 1, 0, 'someone', getutcdate(), 'someone', GETUTCDATE()
insert into auth.OrgClientType select 'JavaScript - Nonconfidential', 1,  1, 0, 'someone', getutcdate(), 'someone', GETUTCDATE()
insert into auth.OrgClient select 'webApi', '123@', 'backend api client', 1, 1, 7200, '*', 1, 0, 'someone', getutcdate(), 'someone', GETUTCDATE()
insert into auth.OrgClient select 'ngDashboardApp', '1234', 'angular app', 2, 1, 7200, '*', 1, 0, 'someone', getutcdate(), 'someone', GETUTCDATE()


insert into auth.OrgGlobalRole select 1, 'godmode', 1, 0, 'me', GETUTCDATE(), 'me', GETUTCDATE()

--create admin user by directly calling the api using postman or fiddler then uncomment code below

/*
insert into auth.OrgGlobalUserRole select 1, 1,  1, 0, 'me', GETUTCDATE(), 'me', GETUTCDATE()
insert into auth.OrgApp select 1, 'memberFeedback', 1, 0, 'me', GETUTCDATE(), 'me', GETUTCDATE()
insert into auth.OrgAppRole select 1, 'admin', 1, 0, 'me', GETUTCDATE(), 'me', GETUTCDATE()
insert into auth.OrgAppRole select 1, 'assignable', 1, 0, 'me', GETUTCDATE(), 'me', GETUTCDATE()
select '{ "username": "FIRST_AGAIN\\' + domainlogin + '","email": "' + emailaddress + '", "orgId": 1 },' from MemberFeedback.mbr.CNFG_SystemUser
insert into auth.OrgAppUser
select ou.Id, 1, 1, 0, 'me', GETUTCDATE(), 'me', GETUTCDATE()
from MemberFeedback.mbr.CNFG_SystemUser mu
	join AppFramework.auth.OrgUser ou
		on mu.EmailAddress = ou.Email
insert into auth.OrgAppUserRole
select oau.Id, 2, 1, 0, 'me', GETUTCDATE(), 'me', GETUTCDATE()
from MemberFeedback.mbr.CNFG_SystemUser mu
	join AppFramework.auth.OrgUser ou
		on mu.EmailAddress = ou.Email
		and mu.boolIsAssignable = 1
	join AppFramework.auth.OrgAppUser oau
		on ou.Id = oau.UserId
insert into auth.OrgAppUserRole
select oau.Id, 1, 1, 0, 'me', GETUTCDATE(), 'me', GETUTCDATE()
from MemberFeedback.mbr.CNFG_SystemUser mu
	join AppFramework.auth.OrgUser ou
		on mu.EmailAddress = ou.Email
		and mu.boolIsAdmin = 1
	join AppFramework.auth.OrgAppUser oau
		on ou.Id = oau.UserId
*/

--select * from auth.org
--select * from auth.OrgUser
--select * from auth.OrgClient
--select * from auth.OrgUserRefreshToken
--select * from auth.OrgGlobalRole
--select * from auth.OrgGlobalUserRole
--select * from auth.OrgApp
--select * from auth.OrgAppRole
--select * from auth.OrgAppUser
--select * from auth.OrgAppUserRole

select o.OrgName
	,'global role' 'RoleType'
	,null 'AppName'
	,ou.UserName
	,ogr.Name 'Role'
from auth.Org o
	left join auth.OrgUser ou	
		on o.Id = ou.Id
	left join auth.OrgGlobalUserRole gur
		on ou.Id = gur.OrgUserId
		left join auth.OrgGlobalRole ogr
			on gur.OrgGlobalRoleId = ogr.Id
union
select o.OrgName
	,'app role' 'RoleType'
	,oa.AppName
	,ou.UserName
	,oar.Name 'Role'
from auth.Org o
	join auth.OrgApp oa
		on o.Id = oa.OrgId
	join auth.OrgAppUser oau
		on oa.Id = oau.OrgAppId
	join auth.OrgUser ou
		on oau.UserId = ou.Id
	join auth.OrgAppUserRole oaur
		on oau.id = oaur.OrgAppUserId
	join auth.OrgAppRole oar
		on oaur.OrgAppRoleId = oar.Id
order by 3 asc