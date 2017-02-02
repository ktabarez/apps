using Common.Logging;
using Common.Repository;
using System.Collections.Generic;
using System.Data.Common;
using System.Data.Entity;
using System.Data.Entity.Infrastructure;
using System.Linq;
using System.Threading.Tasks;
using System;

namespace IdentityProviders.SqlServerProvider
{
    public class SystemUserRepo : RepoBase<OrgUser>
    {
        public SystemUserRepo(DbContext context)
            : base(context)
        {

        }

        public Task<OrgUser> GetByUserNameAsync(string userName)
        {
            
            return Entities.FirstOrDefaultAsync(i => i.UserName.Equals(userName));
        }

        public new async Task CreateAsync(OrgUser entity)
        {
            await base.CreateAsync(entity);
        }

        public Task<OrgUser> GetByEmailAsync(string email)
        {
            
            return Entities.FirstOrDefaultAsync(i => i.Email.Equals(email));
        }

        public Task<List<OrgUser>> GetSearchResults(string searchTerm, int page = 0, int limit = 0)
        {
            

            var skipTotal = limit * (page - 1);

            return Entities.Where(i => i.UserName.ToLower().Contains(searchTerm))
                           .OrderBy(i => i.Id)
                           .Skip(limit * page)
                           .Take(limit)
                           .ToListAsync<OrgUser>();
            //Take(pages * limit).ToList();
        }

        public async Task<bool> AnyMoreSearchItems(string searchTerm, int page = 0, int limit = 0)
        {
            var totalItems = await Entities.Where(i => i.UserName.ToLower().Contains(searchTerm)).CountAsync();

            if(limit > totalItems)
                return false;

            return limit * page < totalItems;
        }
    }

    public class OrgUserRepo : RepoBase<OrgUser>
    {
        public OrgUserRepo(DbContext context)
            : base(context)
            
        {

        }

        public Task<List<OrgUser>> GetByUserNameAsync(string userName)
        {
            return Entities.Where(i => i.UserName.Equals(userName)).ToListAsync();
        }

        public Task<List<OrgUser>> GetAsync(string orgName, int page = 0, int limit = 0)
        {
            
            if (page == 0)
                return Entities.Where(i => i.Org.OrgName.Equals(orgName))
                    .OrderBy(i => i.Id)
                    .ToListAsync();

            return Entities.Where(i => i.Org.OrgName.Equals(orgName))
                    .OrderBy(i => i.Id)
                    .Skip(limit * (page - 1))
                    .Take(limit)
                    .ToListAsync();
        }

        public Task<OrgUser> GetAsync(string organization, string username)
        {
            
            return Entities.FirstOrDefaultAsync(i => i.Org.OrgName.Equals(organization) &&
                                                     i.Org.OrgUsers.Any(x => i.UserName.Equals(username)));
        }

        internal Task<List<OrgUser>> GetAsync(int userId)
        {
            return Entities.Where(i => i.Id == userId).ToListAsync();
        }

        public async Task<OrgUser> FindByOrgIdUserName(int orgId, string username)
        {
            return await Entities.FirstOrDefaultAsync(i => i.OrgId == orgId && i.UserName.Equals(username));
        }

        public async Task<OrgUser> FindByOrgIdUsernamePassword(int orgId, string username, string passwordHash)
        {
            return await Entities.FirstOrDefaultAsync(i => i.OrgId == orgId && i.UserName.Equals(username) && i.PasswordHash.Equals(passwordHash));
        }
    }

    public class OrgUserRoleRepo : RepoBase<OrgUserRole>
    {
        public OrgUserRoleRepo(DbContext context)
            : base(context)
            
        {

        }

        public Task<List<OrgUserRole>> GetAsync(int userId)
        {
            
            return Entities.Where(i => i.OrgUser.Id == userId).ToListAsync();
        }

        public Task<OrgUserRole> GetAsync(int orgRoleId, int orgUserId)
        {
            return Entities.FirstOrDefaultAsync(i => i.OrgRoleId == orgRoleId && i.OrgUserId == orgUserId);
        }
    }

    public class OrgAppUserRepo : RepoBase<OrgAppUser>
    {
        public OrgAppUserRepo(DbContext context)
            : base(context)
            
        {

        }

        public Task<List<OrgAppUser>> GetAsync(string organization)
        {
            
            return Entities.Where(i => i.OrgApp.Org.OrgName.Equals(organization)).ToListAsync();
        }

        public Task<List<OrgAppUser>> GetAsync(string organization, string application)
        {
            
            return Entities.Where(i => i.OrgApp.AppName.Equals(application) && i.OrgApp.Org.OrgName.Equals(organization)).ToListAsync();
        }

        public Task<OrgAppUser> GetAsync(string organization, string application, string username)
        {
            
            return Entities.FirstOrDefaultAsync(i => i.OrgApp.AppName.Equals(application) &&
                                i.OrgApp.Org.OrgName.Equals(organization) &&
                                i.OrgUser.UserName.Equals(username));
        }
    }

    public class OrgAppRepo : RepoBase<OrgApp>
    {
        public OrgAppRepo(DbContext context)
            : base(context)
            
        {

        }

        public Task<OrgApp> GetAsync(string organization, string appname)
        {
            
            return Entities.FirstOrDefaultAsync(i => i.Org.OrgName.Equals(organization) &&
                                         i.AppName.Equals(appname));
                                         
        }

        public Task<List<OrgApp>> GetAsync(string organization)
        {
            
            return Entities.Where(i => i.Org.OrgName.Equals(organization)).ToListAsync();
        }

        public Task<List<OrgApp>> GetSearchResults(string org, string searchTerm, int page = 0, int limit = 0)
        {
            

            var skipTotal = limit * (page - 1);

            return Entities.Where(i => i.Org.OrgName.ToLower().Equals(org.ToLower()) &&
                                       i.AppName.ToLower().Contains(searchTerm.ToLower()))
                           .OrderBy(i => i.Id)
                           .Skip(limit * page)
                           .Take(limit)
                           .ToListAsync<OrgApp>();
            //Take(pages * limit).ToList();
        }

        public async Task<bool> AnyMoreSearchItems(string org, string searchTerm, int page = 0, int limit = 0)
        {
            var totalItems = await Entities.Where(i => i.Org.OrgName.ToLower().Equals(org.ToLower()) &&
                                                       i.AppName.ToLower().Contains(searchTerm))
                                       .CountAsync();

            if (limit > totalItems)
                return false;

            return limit * page < totalItems;
        }
    }

    public class OrgAppUserAuthIpRepo : RepoBase<OrgAppUserAuthIp>
    {
        public OrgAppUserAuthIpRepo(DbContext context)
            : base(context)
            
        {

        }

        public Task<List<OrgAppUserAuthIp>> GetAsync(int userId)
        {
            
            return Entities.Where(oauai => oauai.OrgAppUser.UserId == userId).ToListAsync();
        }

        public Task<List<OrgAppUserAuthIp>> GetAsync(string organization)
        {
            
            return Entities.Where(i => i.OrgAppUser.OrgApp.Org.OrgName.Equals(organization)).ToListAsync();
        }

        public Task<List<OrgAppUserAuthIp>> GetAllAsync(string organization, string appname, string username)
        {
            
            return Entities.Where(i => i.OrgAppUser.OrgApp.AppName.Equals(appname) &&
                                       i.OrgAppUser.OrgApp.Org.OrgName.Equals(organization) &&
                                       i.OrgAppUser.OrgUser.UserName.Equals(username))
                           .ToListAsync();
        }

        public Task<OrgAppUserAuthIp> GetAsync(string organization, string appname, string username, string ipaddress)
        {
            
            return Entities.FirstOrDefaultAsync(i => i.OrgAppUser.OrgApp.AppName.Equals(appname) &&
                                       i.OrgAppUser.OrgApp.Org.OrgName.Equals(organization) &&
                                       i.OrgAppUser.OrgUser.UserName.Equals(username) &&
                                       i.Ip.Equals(ipaddress));
        }

        public async Task<bool> AnyMoreSearchItems(string org, string username, string searchTerm, int page = 0, int limit = 0)
        {
            var totalItems = await Entities.Where(i => i.OrgAppUser.OrgUser.UserName.ToLower().Equals(username.ToLower()) &&
                                                       i.OrgAppUser.OrgApp.Org.OrgName.ToLower().Equals(org.ToLower()))
                                           .Select(i => new
                                           {
                                               text = i.OrgAppUser.OrgApp.AppName.ToLower() + "\\" + i.Ip.ToLower(),
                                               item = i,
                                           })
                                           .Where(i => i.text.Contains(searchTerm.ToLower()))
                                           .CountAsync();

            if (limit > totalItems)
                return false;

            return limit * page < totalItems;
        }

        public async Task<List<OrgAppUserAuthIp>> GetSearchResults(string org, string username, string searchTerm, int page = 0, int limit = 0)
        {
            

            var skipTotal = limit * (page - 1);

            return await Entities.Where(i => i.OrgAppUser.OrgUser.UserName.ToLower().Equals(username.ToLower()) &&
                                                       i.OrgAppUser.OrgApp.Org.OrgName.ToLower().Equals(org.ToLower()))
                                           .Select(i => new
                                           {
                                               text = i.OrgAppUser.OrgApp.AppName.ToLower() + "\\" + i.Ip.ToLower(),
                                               item = i,
                                           })
                                           .Where(i => i.text.Contains(searchTerm.ToLower()))
                           .OrderBy(i => i.text)
                           .Select(i => i.item)
                           .Skip(limit * page)
                           .Take(limit)
                           .ToListAsync<OrgAppUserAuthIp>();
            //Take(pages * limit).ToList();
        }
    }

    public class OrgAppRoleRepo : RepoBase<OrgAppRole>
    {
        public OrgAppRoleRepo(DbContext context)
            : base(context)
            
        {

        }

        public Task<List<OrgAppRole>> GetAsync(string organization)
        {
            return Entities.Where(i => i.OrgApp.Org.OrgName.Equals(organization)).ToListAsync();
        }

        public Task<OrgAppRole> GetAsync(string organization, string appname, string roleName)
        {
            
            return Entities.FirstOrDefaultAsync(i => i.OrgApp.Org.OrgName.Equals(organization) &&
                                         i.OrgApp.AppName.Equals(appname) &&
                                         i.Name.Equals(roleName));
        }

        public Task<List<OrgAppRole>> GetAsync(string organization, string appname)
        {
            
            return Entities.Where(i => i.OrgApp.Org.OrgName.Equals(organization) && i.OrgApp.AppName.Equals(appname)).ToListAsync();
        }

        public Task<List<OrgAppRole>> GetSearchResults(string org, string searchTerm, int page = 0, int limit = 0)
        {
            

            var skipTotal = limit * (page - 1);

            return Entities.Where(i => i.OrgApp.Org.OrgName.ToLower().Equals(org.ToLower()))
                                           .Select(i => new
                                           {
                                               text = i.OrgApp.AppName.ToLower() + "\\" + i.Name.ToLower(),
                                               item = i,
                                           })
                            .Where(i => i.text.Contains(searchTerm.ToLower()))
                            .OrderBy(i => i.text)
                            .Select(i => i.item)
                            .Skip(limit * page)
                            .Take(limit)
                            .ToListAsync<OrgAppRole>();
            //Take(pages * limit).ToList();
        }

        public async Task<bool> AnyMoreSearchItems(string org, string searchTerm, int page = 0, int limit = 0)
        {
            var totalItems = await Entities.Where(i => i.OrgApp.Org.OrgName.ToLower().Equals(org.ToLower()))
                                           .Select(i => new 
                                           {
                                               text = i.OrgApp.AppName.ToLower() + "\\" + i.Name.ToLower(),
                                               item = i,
                                           })
                                           .Where(i => i.text.Contains(searchTerm.ToLower()))
                                           .CountAsync();

            if (limit > totalItems)
                return false;

            return limit * page < totalItems;
        }
    }

    public class OrgAppUserRoleRepo : RepoBase<OrgAppUserRole>
    {
        public OrgAppUserRoleRepo(DbContext context)
            : base(context)
            
        {

        }

        public Task<List<OrgAppUserRole>> GetAsync(int userId)
        {
            
            return Entities.Where(oaur => oaur.OrgAppUser.OrgUser.Id == userId).ToListAsync();
        }

        public Task<List<OrgAppUserRole>> GetAsync(string organization)
        {
            
            return Entities.Where(i => i.OrgAppUser.OrgApp.Org.OrgName.Equals(organization)).ToListAsync();
        }

        public Task<List<OrgAppUserRole>> GetAsync(string organization, string appname, string username)
        {
            
            return Entities.Where(i => i.OrgAppUser.OrgApp.AppName.Equals(appname) &&
                                                i.OrgAppUser.OrgApp.Org.OrgName.Equals(organization) &&
                                                i.OrgAppUser.OrgUser.UserName.Equals(username)).ToListAsync();
        }

        public Task<OrgAppUserRole> GetAsync(string orgname, string appname, string username, string rolename)
        {
            
            return Entities.FirstOrDefaultAsync(i => i.OrgAppUser.OrgApp.Org.OrgName.Equals(orgname) &&
                                i.OrgAppUser.OrgApp.AppName.Equals(appname) &&
                                i.OrgAppUser.OrgUser.UserName.Equals(username) &&
                                i.OrgAppRole.Name.Equals(rolename));
        }
    }

    public class OrgGlobalRoleRepo : RepoBase<OrgGlobalRole>
    {
        public OrgGlobalRoleRepo(DbContext context)
            : base(context)
            
        {

        }

        public Task<List<OrgGlobalRole>> GetAsync(string organization)
        {
            
            return Entities.Where(i => i.Org.OrgName.Equals(organization)).ToListAsync();
        }

        public Task<OrgGlobalRole> GetAsync(string organization, string globalrole)
        {
            
            return Entities.FirstOrDefaultAsync(i => i.Org.OrgName.Equals(organization) &&
                                                     i.Name.Equals(globalrole));
        }

        public Task<List<OrgGlobalRole>> GetSearchResults(string org, string searchTerm, int page = 0, int limit = 0)
        {
            

            var skipTotal = limit * (page - 1);

            return Entities.Where(i => i.Org.OrgName.ToLower().Equals(org.ToLower()) &&
                                       i.Name.ToLower().Contains(searchTerm))
                           .OrderBy(i => i.Id)
                           .Skip(limit * page)
                           .Take(limit)
                           .ToListAsync<OrgGlobalRole>();
            //Take(pages * limit).ToList();
        }

        public async Task<bool> AnyMoreSearchItems(string org, string searchTerm, int page = 0, int limit = 0)
        {
            var totalItems = await Entities.Where(i => i.Org.OrgName.ToLower().Equals(org.ToLower()) &&
                                                       i.Name.ToLower().Contains(searchTerm))
                                       .CountAsync();

            if (limit > totalItems)
                return false;

            return limit * page < totalItems;
        }
    }

    public class GlobalUserRoleRepo : RepoBase<OrgGlobalUserRole>
    {
        public GlobalUserRoleRepo(DbContext context)
            : base(context)
        {

        }

        public Task<List<OrgGlobalUserRole>> GetAsync(int userId)
        {
            
            return Entities.Where(gur => gur.OrgUser.Id == userId).ToListAsync();
        }

        public Task<List<OrgGlobalUserRole>> GetAsync(string organization)
        {
            
            return Entities.Where(i => i.OrgUser.Org.OrgName.Equals(organization)).ToListAsync();
        }

        public Task<OrgGlobalUserRole> GetAsync(string orgname, string username)
        {
            
            return Entities.FirstOrDefaultAsync(i => i.OrgUser.UserName.Equals(username) &&
                                         i.OrgUser.Org.OrgName.Equals(orgname));
        }

        public Task<OrgGlobalUserRole> GetAsync(string orgname, string globalrole, string username)
        {
            return Entities.FirstOrDefaultAsync(i => i.OrgUser.Org.OrgName.Equals(orgname) &&
                                       i.OrgGlobalRole.Name.Equals(globalrole) &&
                                       i.OrgUser.UserName.Equals(username));
        }
    }

    public class OrgRepo : RepoBase<Org>
    {
        public OrgRepo(DbContext context)
            : base(context) { }

        public async Task<Org> FindByNameAsync(string organization)
        {
            return await Entities.FirstOrDefaultAsync(i => i.OrgName.Equals(organization));
        }
    }

    public class OrgRoleRepo : RepoBase<OrgRole>
    {
        public OrgRoleRepo(DbContext context)
            : base(context)
            
        {

        }

        public Task<List<OrgRole>> GetAsync(string orgName)
        {
            
            return Entities.Where(i => i.Org.OrgName.Equals(orgName)).ToListAsync();
        }

        public Task<OrgRole> GetAsync(string organization, string rolename)
        {
            

            return Entities.FirstOrDefaultAsync(i => i.Org.OrgName.Equals(organization) &&
                                         i.Name.Equals(rolename));
        }
    }

    public class UserRefreshTokenRepo : RepoBase<UserRefreshToken>
    {
        public UserRefreshTokenRepo(DbContext context)
            : base(context)
            
        {

        }

        public Task<UserRefreshToken> FindByUserName(string username)
        {
            return Entities.FirstOrDefaultAsync(i => i.Username.ToLower().Equals(username.ToLower()));
        }
    }

    public class OrgAppUserMetadataRepo : RepoBase<OrgAppUserMetadata>
    {
        public OrgAppUserMetadataRepo(DbContext context)
            : base(context)
        {

        }

        public Task<List<OrgAppUserMetadata>> FindAsync(int userId)
        {
            return Entities.Where(i => i.OrgAppUser.UserId == userId).ToListAsync();
        }
    }

    public class ClientTypeRepo : RepoBase<OrgClientType>
    {
        public ClientTypeRepo(DbContext context)
            : base(context)
        {

        }
    }

    public class OrgClientRepo : RepoBase<OrgClient>
    {
        public OrgClientRepo(DbContext context)
            : base(context)
        {

        }

        public async Task<OrgClient> FindByOrgAndClientName(int orgId, string clientId)
        {
            return await Entities.FirstOrDefaultAsync(i => i.OrgId == orgId && i.Id.Equals(clientId));
        }
    }

    public class RefreshTokenRepo : RepoBase<OrgUserRefreshToken>
    {
        public RefreshTokenRepo(DbContext context)
            :base(context)
        {

        }
    }
}
