using Autofac;
using Autofac.Integration.WebApi;
using Common.Repository;

using Microsoft.Owin;
using Microsoft.Owin.Security.Infrastructure;
using Microsoft.Owin.Security.OAuth;
using Owin;
using System;
using System.Configuration;
using System.Reflection;
using System.Threading.Tasks;
using System.Web.Http;
using Microsoft.AspNet.Identity.Owin;

[assembly: OwinStartup(typeof(Web.Api.Startup))]

namespace Web.Api
{
    public class Startup
    {
        public static OAuthAuthorizationServerOptions OAuthOptions { get; private set; }

        public static string PublicClientId { get; private set; }

        public void Configuration(IAppBuilder app)
        {
            var builder = new ContainerBuilder();

            // get HttpConfiguration
            var config = GlobalConfiguration.Configuration;

            // register Web API controllers
            builder.RegisterApiControllers(Assembly.GetExecutingAssembly());

            // OPTIONAL: Register the Autofac filter provider.
            builder.RegisterWebApiFilterProvider(config);

            Bootstrapper.RegisterAutofac(builder);

            // set the dependency resolver to be Autofac
            var container = builder.Build();
            app.UseAutofacMiddleware(container);
            app.UseAutofacWebApi(config);
            config.DependencyResolver = new AutofacWebApiDependencyResolver(container);

            app.UseCors(Microsoft.Owin.Cors.CorsOptions.AllowAll);
            app.UseWebApi(config);
        }
    }
}
