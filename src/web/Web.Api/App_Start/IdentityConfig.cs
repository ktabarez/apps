using Common.Repository;
using IdentityProviders.SqlServerProvider;
using Microsoft.AspNet.Identity;
using System;
using System.Security.Claims;
using System.Threading.Tasks;
using System.Linq;

namespace Web.Api
{
    // Configure the application user manager used in this application. UserManager is defined in ASP.NET Identity and is used by the application.
    public class ApplicationUserManager : UserManager<OrgUser, int>
    {
        //private bool _supportsUserClaims { get; set; }
        //public override bool SupportsUserClaim
        //{
        //    get
        //    {
        //        return _supportsUserClaims;
        //    }
        //}

        //private bool _supportsUserLockout { get; set; }
        //public override bool SupportsUserLockout
        //{
        //    get
        //    {
        //        return _supportsUserLockout;
        //    }
        //}

        private bool _supportsUserSecurityStamp { get; set; }
        public override bool SupportsUserSecurityStamp
        {
            get
            {
                return _supportsUserSecurityStamp;
            }
        }

        public UserStore UserStore
        {
            //get
            //{
            //    return GlobalConfiguration.Configuration.DependencyResolver.GetService<SqlServerUserStore>();
            //} 
            get;
            private set;
        }

        public ApplicationUserManager(UserStore userStore)
            : base(userStore)
        {
            UserStore = userStore;
            //_supportsUserClaims = true;
            //_supportsUserLockout = false;
            _supportsUserSecurityStamp = false;
        }

        public override Task<IdentityResult> CreateAsync(OrgUser user)
        {
            return base.CreateAsync(user);
        }

        public async override Task<OrgUser> FindAsync(string userName, string password)
        {
            var user = await FindByNameAsync(userName);

            if (user == null)
                return null;

            return (OrgUser)user;
        }

        public async Task<OrgUser> FindByOrgIdUsername(int orgId, string username)
        {
            return await UserStore.FindByOrgIdUsername(orgId, username);
        }

        public async Task<OrgUser> FindByOrgIdUsernamePassword(int orgId, string username, string password)
        {
            var hash = base.PasswordHasher.HashPassword(password);

            var user = await UserStore.FindByOrgIdUsername(orgId, username);

            if (user != null && base.PasswordHasher.VerifyHashedPassword(user.PasswordHash, password) == PasswordVerificationResult.Success)
                return user;

            return null;
        }

        public async override Task<ClaimsIdentity> CreateIdentityAsync(OrgUser user, string authenticationType)
        {
            //user.Id = user.SystemUserID;
            //return base.CreateIdentityAsync(user, authenticationType);

            if (user == null)
            {
                throw new ArgumentNullException(typeof(OrgUser).Name);
            }
            var userName = user.UserName;

            var id = new ClaimsIdentity(ClaimTypes.CookiePath, ClaimTypes.Name, ClaimTypes.Role);
            id.AddClaim(new Claim(ClaimTypes.NameIdentifier, String.Format("{0}", user.Id)));
            id.AddClaim(new Claim("AspNet.Identity.SecurityStamp", userName));

            if (this.SupportsUserClaim)
            {
                id.AddClaims(await this.GetClaimsAsync(user.Id));
            }

            return id;
        }
        /// <summary>
        /// Creates a <see cref="ClaimsPrincipal"/> from an user asynchronously.
        /// </summary>
        /// <param name="user">The user to create a <see cref="ClaimsPrincipal"/> from.</param>
        /// <returns>The <see cref="Task"/> that represents the asynchronous creation operation, containing the created <see cref="ClaimsPrincipal"/>.</returns>
        //public async override Task<ClaimsPrincipal> CreateAsync(SystemUser user)
        //{ 
        //    if (user == null)
        //    {
        //        throw new ArgumentNullException(typeof(SystemUser).Name);
        //    }
        //    var userName = user.DomainLogin;

        //    var id = new ClaimsIdentity(ClaimTypes.CookiePath, ClaimTypes.Name, ClaimTypes.Role);
        //    id.AddClaim(new Claim(ClaimTypes.NameIdentifier, String.Format("{0}",user.SystemUserID)));
        //    id.AddClaim(new Claim("AspNet.Identity.SecurityStamp", userName));

        //    if (this.SupportsUserClaim)
        //    {
        //        id.AddClaims(await this.GetClaimsAsync(user.SystemUserID));
        //    }

        //    return new ClaimsPrincipal(id);
        //}

    }

    public class UserStore : //IUserRoleStore<SqlUser>,
    IUserStore<OrgUser, int>,
    //IUserLoginStore<User, int>,
    //IUserClaimStore<SqlUser, int>,
    IUserPasswordStore<OrgUser, int>,
    IUserSecurityStampStore<OrgUser, int>,
    IQueryableUserStore<OrgUser, int>,
    //IUserTwoFactorStore<SqlUser, int>,
    //IUserLockoutStore<User, int>,
    IUserEmailStore<OrgUser, int>,
    IDisposable
    {
        private OrgUserRepo _userRepo;

        public UserStore(RepoBase<OrgUser> userRepo)
        {
            _userRepo = (OrgUserRepo) userRepo;
        }

        /*IQueryableUserStore*/

        public IQueryable<OrgUser> Users
        {
            get
            {
                return (IQueryable<OrgUser>)_userRepo.Entities.AsQueryable<OrgUser>();
            }
        }

        /*IUserStore*/

        public async Task CreateAsync(OrgUser user)
        {
            if (user == null)
            {
                throw new ArgumentNullException("user");
            }

            if (user.UserName == null)
            {
                throw new InvalidOperationException("Cannot create user as the 'UserName' property is null on user parameter.");
            }

            //user.Id = userRepository.GetKey(user.Email);

            await _userRepo.CreateAsync(user);

            //user.Id = userRepository.GetKey(user.Email);

            //user.Id = userRepository.GetKey(user.Email);
            //await emailRepository.SaveAsync(new CouchbaseUserEmail
            //    {
            //        Email = user.Email,
            //        UserId = user.UserName,
            //        ConfirmationRecord = new ConfirmationRecord
            //        {
            //             ConfirmedOn = DateTime.UtcNow,
            //        },
            //        Id = user.Email
            //    });
            //await phoneNumberRepository.SaveAsync(new CouchbaseUserPhoneNumber
            //    {
            //        UserId = user.Id,
            //        PhoneNumber = user.PhoneNumber
            //    });
            //await _couchbaseClient.SaveChangesAsync().ConfigureAwait(false);
        }

        public async Task<OrgUser> FindByIdAsync(int userId)
        {
            return await _userRepo.FindAsync(userId);
        }

        public Task<OrgUser> FindByIdAsync(string userId)
        {
            throw new NotImplementedException();
        }

        public Task<OrgUser> FindByNameAsync(string userName)
        {
            _userRepo.Get(i => i.UserName == userName).FirstOrDefault();

            var item = _userRepo.Entities.FirstOrDefault(i => i.UserName == userName);

            return Task.FromResult<OrgUser>(_userRepo.Entities.FirstOrDefault(i => i.UserName.ToLower().Equals(userName.ToLower())));
        }

        public async Task<OrgUser> FindByOrgIdUsername(int orgId, string username)
        {
            return await _userRepo.FindByOrgIdUserName(orgId, username);
        }

        /// <remarks>
        /// This method assumes that incomming User parameter is tracked in the session. So, this method literally behaves as SaveChangeAsync
        /// </remarks>
        public async Task UpdateAsync(OrgUser user)
        {
            if (user == null)
            {
                throw new ArgumentNullException("user");
            }

            await _userRepo.UpdateAsync(user);
        }

        public Task DeleteAsync(OrgUser user)
        {
            if (user == null)
            {
                throw new ArgumentNullException("user");
            }

            return _userRepo.DeleteAsync(user);
        }

        /*IUserPasswordStore*/

        public Task<string> GetPasswordHashAsync(OrgUser user)
        {
            if (user == null)
            {
                throw new ArgumentNullException("user");
            }

            return Task.FromResult<string>(String.Empty);//(user.PasswordHash);
        }

        public Task<bool> HasPasswordAsync(OrgUser user)
        {
            if (user == null)
            {
                throw new ArgumentNullException("user");
            }

            return Task.FromResult<bool>(true);//(user.PasswordHash != null);
        }

        public Task SetPasswordHashAsync(OrgUser user, string passwordHash)
        {
            if (user == null)
            {
                throw new ArgumentNullException("user");
            }

            user.SetPasswordHash(passwordHash);
            return Task.FromResult(0);
        }

        /*IUserSecurityStampStore*/

        public Task<string> GetSecurityStampAsync(OrgUser user)
        {
            if (user == null) throw new ArgumentNullException("user");
            return Task.FromResult<string>(user.SecurityStamp.ToString());
        }

        public Task SetSecurityStampAsync(OrgUser user, string stamp)
        {
            if (user == null) throw new ArgumentNullException("user");
            user.SecurityStamp = stamp;
            return Task.FromResult(0);
        }

        /*IUserEmailStore*/

        public async Task<OrgUser> FindByEmailAsync(string email)
        {
            if (email == null)
            {
                throw new ArgumentNullException("email");
            }

            OrgUser user = _userRepo.Entities.FirstOrDefault(i => i.Email.ToLower().Equals(email));

            if (user == null)
                return default(OrgUser);

            return await Task.FromResult<OrgUser>(user);
        }

        public async Task<string> GetEmailAsync(OrgUser user)
        {
            if (user == null)
            {
                throw new ArgumentNullException("user");
            }

            return await Task.FromResult(user.Email);
        }

        public async Task<bool> GetEmailConfirmedAsync(OrgUser user)
        {
            if (user == null)
            {
                throw new ArgumentNullException("user");
            }

            if (user.Email == null)
            {
                throw new InvalidOperationException("Cannot get the confirmation status of the e-mail because user doesn't have an e-mail.");
            }

            //ConfirmationRecord confirmation = await GeUserEmailConfirmationAsync(user.Email)
            //    .ConfigureAwait(false);

            return await Task.FromResult<bool>(false);// confirmation != null;
        }

        public Task SetEmailAsync(OrgUser user, string email)
        {
            user.Email = email;

            return _userRepo.UpdateAsync(user);
        }

        public async Task SetEmailConfirmedAsync(OrgUser user, bool confirmed)
        {
            await Task.FromResult<int>(0);
            //if (user == null)
            //{
            //    throw new ArgumentNullException("user");
            //}

            //if (user.Email == null)
            //{
            //    throw new InvalidOperationException("Cannot set the confirmation status of the e-mail because user doesn't have an e-mail.");
            //}

            //UserEmail userEmail = await GeUserEmailAsync(user.Email).ConfigureAwait(false);
            //if (userEmail == null)
            //{
            //    throw new InvalidOperationException("Cannot set the confirmation status of the e-mail because user doesn't have an e-mail as RavenUserEmail document.");
            //}

            //if (confirmed)
            //{
            //    userEmail.SetConfirmed();
            //}
            //else
            //{
            //    userEmail.SetUnconfirmed();
            //}
        }

        protected void Dispose(bool disposing)
        {
            //if (_disposeDocumentSession && disposing && _couchbaseClient != null)
            //{
            //    _couchbaseClient.Dispose();
            //}
        }

        public void Dispose()
        {
            //Dispose(true);
            //GC.SuppressFinalize(this);
        }
    }
}