using Common.Repository;
using IdentityProviders.SqlServerProvider;
using Microsoft.Owin.Security.Infrastructure;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using System.Web;
using Microsoft.AspNet.Identity.Owin;
using Microsoft.AspNet.Identity;
using System.Web.Http;
using Extensions.WebApiDependencyResolverExtension;
using Common.Logging;

namespace Web.Api
{
    public class RefreshTokenProvider : IAuthenticationTokenProvider
    {
        //private IPasswordHashPovider _passwordHasher;
        private ILogServiceAsync<ILogServiceSettings> _logService;

        public RefreshTokenProvider()
        {
            //_passwordHasher = GlobalConfiguration.Configuration.DependencyResolver.GetService<IPasswordHashPovider>();
            _logService = GlobalConfiguration.Configuration.DependencyResolver.GetService<ILogServiceAsync<ILogServiceSettings>>();
        }

        public void Create(AuthenticationTokenCreateContext context)
        {
            throw new NotImplementedException();
        }

        public async Task CreateAsync(AuthenticationTokenCreateContext context)
        {
            var clientid = context.Ticket.Properties.Dictionary["as:client_id"];

            if (string.IsNullOrEmpty(clientid))
            {
                return;
            }

            var refreshTokenId = Guid.NewGuid().ToString("n");
            var refreshTokenRepo = context.OwinContext.Get<RepoBase<OrgUserRefreshToken>>();
            var refreshTokenLifeTime = context.OwinContext.Get<string>("as:clientRefreshTokenLifeTime");
            var orgUserId = context.OwinContext.Get<int>("as:orgUserId");

            var token = new OrgUserRefreshToken()
            {
                Id = refreshTokenId,//_passwordHasher.HashPassword(refreshTokenId),
                OrgClientId = clientid,
                OrgUserId = orgUserId,
                Subject = context.Ticket.Identity.Name,
                IssuedUtc = DateTime.UtcNow,
                ExpiresUtc = DateTime.UtcNow.AddMinutes(Convert.ToDouble(refreshTokenLifeTime)),
            };

            context.Ticket.Properties.IssuedUtc = token.IssuedUtc;
            context.Ticket.Properties.ExpiresUtc = token.ExpiresUtc;

            token.ProtectedTicket = context.SerializeTicket();

            await refreshTokenRepo.CreateAsync(token);

            context.SetToken(refreshTokenId);
        }

        public void Receive(AuthenticationTokenReceiveContext context)
        {
            throw new NotImplementedException();
        }

        public async Task ReceiveAsync(AuthenticationTokenReceiveContext context)
        {
            var allowedOrigin = context.OwinContext.Get<string>("as:clientAllowedOrigin");
            var refreshTokenRepo = context.OwinContext.Get<RepoBase<OrgUserRefreshToken>>();
            var hashedTokenId = context.Token;// _passwordHasher.HashPassword(context.Token);

            var refreshToken = await refreshTokenRepo.FindAsync(hashedTokenId);

            if (refreshToken != null)
            {
                var clientRepo = context.OwinContext.Get<RepoBase<OrgClient>>();

                //Get protectedTicket from refreshToken class
                var oldRefreshtoken = await refreshTokenRepo.FindAsync(hashedTokenId);

                var client = await clientRepo.FindAsync(oldRefreshtoken.OrgClientId);

                context.OwinContext.Response.Headers.Add("Access-Control-Allow-Origin", new[] { client.AllowedOrigin });

                context.OwinContext.Set<string>("as:clientAllowedOrigin", client.AllowedOrigin);
                context.OwinContext.Set<string>("as:client_id", client.Id);
                context.OwinContext.Set<int>("as:orgUserId", oldRefreshtoken.OrgUserId);
                context.OwinContext.Set<string>("as:clientRefreshTokenLifeTime", client.RefreshTokenLifeTime.ToString());

                context.DeserializeTicket(oldRefreshtoken.ProtectedTicket);
                await refreshTokenRepo.DeleteAsync(oldRefreshtoken);
            }
        }
    }
}