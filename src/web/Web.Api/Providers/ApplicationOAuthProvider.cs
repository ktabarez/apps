using Common.ApiClaims;
using Common.Logging;
using Common.Repository;
using Extensions.ClaimExtensions;
using Extensions.WebApiDependencyResolverExtension;
using IdentityProviders.SqlServerProvider;
using Microsoft.AspNet.Identity;
using Microsoft.AspNet.Identity.Owin;
using Microsoft.Owin.Security;
using Microsoft.Owin.Security.Cookies;
using Microsoft.Owin.Security.OAuth;
using System;
using System.Collections.Generic;
using System.Security.Claims;
using System.Threading.Tasks;
using System.Web.Http;

namespace Web.Api
{
    public class ApplicationOAuthProvider : OAuthAuthorizationServerProvider
    {
        private readonly string _publicClientId;

        private ILogServiceAsync<ILogServiceSettings> _logService;

        public ApplicationOAuthProvider(string publicClientId)
        {
            if (publicClientId == null)
            {
                throw new ArgumentNullException("publicClientId");
            }

            _publicClientId = publicClientId;

            _logService = GlobalConfiguration.Configuration.DependencyResolver.GetService<ILogServiceAsync<ILogServiceSettings>>();
        }

        public static AuthenticationProperties CreateProperties(OrgUser user, OAuthGrantResourceOwnerCredentialsContext context)
        {
            return new AuthenticationProperties(new Dictionary<string, string>
                {
                    {
                        "as:client_id", (context.ClientId == null) ? string.Empty : context.ClientId
                    },
                    {
                        "userName", context.UserName
                    },
                { "as:domainLogin", user.UserName },
                { "as:userName", user.UserName },
                { "as:fullName", user.Email },
                //{ "emailAddress", user.EmailAddress },
                //{ "departmentDescr", user.DepartmentDescr },
                //{ "isActive", user.boolIsActive.ToString() },
                //{ "systemUserId", user.SystemUserID.ToString() },
                //{ "departmentID", user.DepartmentID.ToString() },
                //{ "role", user.AppRole }
                });
        }

        //http://discoveringdotnet.alexeyev.org/2014/08/simple-explanation-of-bearer-authentication-for-web-api-2.html

        public override async Task GrantRefreshToken(OAuthGrantRefreshTokenContext context)
        {
            /*validate access token and user*/

            if (context.Ticket == null || context.Ticket.Identity == null || !context.Ticket.Identity.IsAuthenticated)
            {
                context.SetError("invalid_grant", "invalid refresh token");

                _logService.LogMessage(new
                {
                    type = "grantRefreshToken",
                    endpoint = context.Request.Uri,
                    msg = "Ticket or Identity is null or user is not authenticated"
                });

                return;
            }

            /*validate cilent*/

            var originalClient = context.Ticket.Properties.Dictionary["as:client_id"];
            var currentClient = context.ClientId;

            if (originalClient != currentClient)
            {
                context.SetError("invalid_clientId", "invalid client");

                _logService.LogMessage(new
                {
                    type = "grantRefreshToken",
                    endpoint = context.Request.Uri,
                    msg = "Refresh token is issued to a different client. The client_id being passed in the request doesn't match the client_id in the access token as:clien_id"
                });

                return;
            }

            /*create new ticket and refresh claims*/

            var newClaimsIdentity = new ClaimsIdentity(context.Ticket.Identity);


            var orgUserId = Convert.ToInt32(context.Ticket.Identity.GetUserId());
            var orgUserRepo = context.OwinContext.Get<RepoBase<OrgUser>>();

            var user = orgUserRepo.Find(orgUserId);

            ClaimsGenerator claimsGenerator = new ClaimsGenerator(
                user,
                newClaimsIdentity,
                context.OwinContext.Get<RepoBase<OrgUser>>(),
                context.OwinContext.Get<RepoBase<OrgUserRole>>(),
                context.OwinContext.Get<RepoBase<OrgGlobalUserRole>>(),
                context.OwinContext.Get<RepoBase<OrgAppUserAuthIp>>(),
                context.OwinContext.Get<RepoBase<OrgAppUserRole>>(),
                context.OwinContext.Get<RepoBase<OrgAppUserMetadata>>());

            await claimsGenerator.GenerateClaims();

            var newAuthTicket = new AuthenticationTicket(newClaimsIdentity, context.Ticket.Properties);
            var currentUtc = new Microsoft.Owin.Infrastructure.SystemClock().UtcNow;

            newAuthTicket.Properties.IssuedUtc = currentUtc;
            newAuthTicket.Properties.ExpiresUtc = currentUtc.Add(TimeSpan.FromMinutes(Convert.ToInt32(context.OwinContext.Get<string>("as:clientRefreshTokenLifeTime"))));
            newAuthTicket.Properties.AllowRefresh = true;

            /*validate new ticket*/

            context.Validated(newAuthTicket);

            var principal = new ClaimsPrincipal(new[] { newClaimsIdentity });

            _logService.LogMessage(new
            {
                type = "claimsRefreshed",
                endpoint = context.Request.Uri,
                userName = newClaimsIdentity.Name,
            });

            return;
        }

        public override async Task GrantResourceOwnerCredentials(OAuthGrantResourceOwnerCredentialsContext context)
        {
            var sqlUserManager = context.OwinContext.GetUserManager<ApplicationUserManager>();
            var allowedOrigin = context.OwinContext.Get<string>("as:clientAllowedOrigin");
            var orgId = context.OwinContext.Get<int>("as:orgId");

            OrgUser sqlUser = null;

            /*validate user*/

            if (context.UserName.Contains(@"\"))
                sqlUser = await sqlUserManager.FindByOrgIdUsername(orgId, context.UserName);
            else
                sqlUser = await sqlUserManager.FindByOrgIdUsernamePassword(orgId, context.UserName, context.Password);

            if (sqlUser == null || !sqlUser.IsActive || sqlUser.IsDeleted)
            {
                context.SetError("invalid_grant", "invalid grant");

                _logService.LogMessage(new
                {
                    type = "claimsGenerated",
                    endpoint = context.Request.Uri,
                    userName = context.UserName,
                    data = new
                    {
                        message = "invalid_grant The user name or password is incorrect",
                    }
                });

                return;
            }

            if (allowedOrigin == null)
                allowedOrigin = "*";

            context.OwinContext.Set<int>("as:orgUserId", sqlUser.Id);
            context.OwinContext.Response.Headers.Add("Access-Control-Allow-Origin", new[] { allowedOrigin });

            /*add claims*/

            ClaimsIdentity oAuthIdentity = await sqlUser.GenerateUserIdentityAsync(sqlUserManager, OAuthDefaults.AuthenticationType);
            ClaimsIdentity cookiesIdentity = await sqlUser.GenerateUserIdentityAsync(sqlUserManager, CookieAuthenticationDefaults.AuthenticationType);

            oAuthIdentity.AddClaim(new Claim(ClaimTypes.Name, context.UserName));
            oAuthIdentity.AddClaim(new Claim("orgUserId", sqlUser.Id.ToString()));

            ClaimsGenerator claimsGenerator = new ClaimsGenerator(
                sqlUser,
                oAuthIdentity,
                context.OwinContext.Get<RepoBase<OrgUser>>(),
                context.OwinContext.Get<RepoBase<OrgUserRole>>(),
                context.OwinContext.Get<RepoBase<OrgGlobalUserRole>>(),
                context.OwinContext.Get<RepoBase<OrgAppUserAuthIp>>(),
                context.OwinContext.Get<RepoBase<OrgAppUserRole>>(),
                context.OwinContext.Get<RepoBase<OrgAppUserMetadata>>());

            await claimsGenerator.GenerateClaims();

            /*create ticket*/

            AuthenticationProperties properties = CreateProperties(sqlUser, context);
            AuthenticationTicket ticket = new AuthenticationTicket(oAuthIdentity, properties);
            ticket.Properties.AllowRefresh = true;
            context.Request.Context.Authentication.SignIn(cookiesIdentity);
            context.Validated(ticket);

            var principal = new ClaimsPrincipal(new[] { oAuthIdentity });

            _logService.LogMessage(new
            {
                type = "claimsGenerated",
                endpoint = context.Request.Uri,
                userName = context.UserName,
                data = new
                {
                    orgUsers = principal.GetClaim<SimpleRoleClaim>("projectRequestRole"),
                }
            });
        }

        public override Task TokenEndpoint(OAuthTokenEndpointContext context)
        {
            foreach (KeyValuePair<string, string> property in context.Properties.Dictionary)
            {
                context.AdditionalResponseParameters.Add(property.Key, property.Value);
            }

            return Task.FromResult<object>(null);
        }

        public override async Task ValidateClientAuthentication(OAuthValidateClientAuthenticationContext context)
        {
            string clientId = string.Empty;
            string clientSecret = string.Empty;

            if (!context.TryGetBasicCredentials(out clientId, out clientSecret))
            {
                context.TryGetFormCredentials(out clientId, out clientSecret);
            }

            /*validate client*/

            if (context.Parameters["org_id"] == null)
            {
                context.SetError("invalid_client", "invalid client");
                _logService.LogMessage(new
                {
                    type = "claimsGenerated",
                    endpoint = context.Request.Uri,
                    data = new
                    {
                        message = "invalid_grant The user name or password is incorrect",
                    }
                });

                return;
            }

            var orgRepo = (OrgRepo) context.OwinContext.Get<RepoBase<Org>>();
            var clientRepo = (OrgClientRepo) context.OwinContext.Get<RepoBase<OrgClient>>();
            var org = await orgRepo.FindAsync(Convert.ToInt32(context.Parameters["org_id"]));

            if(org == null || !org.IsActive )
            {
                context.SetError("invalid_client", "invalid client");
                return;
            }

            if (context.ClientId == null)
            {
                //Remove the comments from the below line context.SetError, and invalidate context 
                //if you want to force sending clientId/secrects once obtain access tokens. 
                context.Validated();
                //context.SetError("invalid_clientId", "ClientId should be sent.");
                return;
            }

            var client = await clientRepo.FindByOrgAndClientName(org.Id, context.ClientId);

            if (client == null || !client.IsActive || client.IsDeleted)
            {
                context.SetError("invalid_client", "invalid client");
                return;
            }

            if (client.OrgClientType.Id == 1 )//Models.ApplicationTypes.NativeConfidential)
            {
                if (string.IsNullOrWhiteSpace(clientSecret))
                {
                    context.SetError("invalid_client", "invalid client");
                    return;
                }
                else
                {
                    if (client.Secret != clientSecret) //Helper.GetHash(clientSecret))
                    {
                        context.SetError("invalid_client", "invalid client");
                        return;
                    }
                }
            }

            /*add props to owincontext*/

            context.OwinContext.Set<string>("as:clientAllowedOrigin", client.AllowedOrigin);
            context.OwinContext.Set<string>("as:clientRefreshTokenLifeTime", client.RefreshTokenLifeTime.ToString());
            context.OwinContext.Set<int>("as:orgId", client.OrgId);
            context.OwinContext.Set<string>("as:orgName", client.Org.OrgName);
            context.OwinContext.Set<int>("as:clientType", client.ClientTypeId);

            /*validate request*/

            context.Validated();
        }

        public override Task ValidateClientRedirectUri(OAuthValidateClientRedirectUriContext context)
        {
            if (context.ClientId == _publicClientId)
            {
                Uri expectedRootUri = new Uri(context.Request.Uri, "/");

                if (expectedRootUri.AbsoluteUri == context.RedirectUri)
                {
                    context.Validated();
                }
            }

            return Task.FromResult<object>(null);
        }
    }
}