using Autofac;
using Autofac.Core.Lifetime;
using Common.Logging;
using Extensions.Owin;
using Owin;
using Common.Repository;
using Newtonsoft.Json;
using Common.Notification;
using System.Web;
using System.Threading;
using Microsoft.Owin;

using Microsoft.AspNet.Identity;
using Microsoft.AspNet.Identity.Owin;
using System;
using Web.Api.DataAccess.MemberFeedback;

namespace Web.Api
{

    public static class Bootstrapper
    {
        public static void RegisterAutofac(ContainerBuilder builder)
        {
            /*services*/
            builder.Register(c => LogServiceAsync<WebLogServiceOptions>.Instance)
                .As<ILogServiceAsync<ILogServiceSettings>>()
                .SingleInstance();

            /*settings*/
            builder.Register(c => new ApiSettings()).SingleInstance();

            /*memberfeedback*/
            builder.Register(c => new MemberFeedbackEntities()).As<MemberFeedbackEntities>();
            builder.Register(c => new MemberFeedbackRepo(c.Resolve<MemberFeedbackEntities>())).As<IRepository<MemberFeedback>>().OnActivated(i =>
            {
                i.Instance.OnDbError += HandleOnDbError;
                i.Instance.OnDbActivity += (k, d) =>
                {
                    LogServiceAsync<WebLogServiceOptions>.Instance.LogMessage(new
                    {
                        type = "dbActivity",
                        data = d
                    });
                };
            }).InstancePerRequest();
            builder.Register(c => new MemberFeedbackUserRepo(c.Resolve<MemberFeedbackEntities>())).As<IRepository<CNFG_SystemUser>>().OnActivated(i => i.Instance.OnDbError += HandleOnDbError).InstancePerRequest();
            builder.Register(c => new MemberFeedbackTypeRepo(c.Resolve<MemberFeedbackEntities>())).As<IRepository<CNFG_FeedbackType>>().OnActivated(i => i.Instance.OnDbError += HandleOnDbError).InstancePerRequest();
            builder.Register(c => new MemberFeedbackSourceRepo(c.Resolve<MemberFeedbackEntities>())).As<IRepository<CNFG_Source>>().OnActivated(i => i.Instance.OnDbError += HandleOnDbError).InstancePerRequest();
            builder.Register(c => new MemberFeedbackCategoryRepo(c.Resolve<MemberFeedbackEntities>())).As<IRepository<CNFG_Category>>().OnActivated(i => i.Instance.OnDbError += HandleOnDbError).InstancePerRequest();

        }

        public static void RegisterOwin(IAppBuilder app)
        {
            app.CreatePerOwinContext<MemberFeedbackEntities>((options, owinContext) =>
            {
                return new MemberFeedbackEntities();
            });

            app.CreatePerOwinContext<RepoBase<CNFG_SystemUser>>((options, owinContext) =>
            {

                var logService = owinContext.Get<ILogServiceAsync<ILogServiceSettings>>();
                var iocContainer = owinContext.ToLifetimeScope<LifetimeScope>("autofac:OwinLifetimeScope");

                var logSeddrvice = iocContainer.GetService(typeof(ILogServiceAsync<ILogServiceSettings>)) as ILogServiceAsync<ILogServiceSettings>;

                return new MemberFeedbackUserRepo(owinContext.Get<MemberFeedbackEntities>());
            });

            var context = new OwinContext(app.Properties);

            var token = context.Get<CancellationToken>("host.OnAppDisposing");

            if (token != CancellationToken.None)
            {
                token.Register(() =>
                {
                    var iocContainer = context.ToLifetimeScope<LifetimeScope>("autofac:OwinLifetimeScope");
                    var logService = iocContainer.GetService(typeof(ILogServiceAsync<ILogServiceSettings>)) as ILogServiceAsync<ILogServiceSettings>;

                    logService.LogMessage(new
                    {
                        msg = "owin cancellation logservice dispose",
                    });
                    logService.Dispose();
                });
            }
        }

        public static void HandleOnDbError(object source, string serializedArgs)
        {
            dynamic dbEx = JsonConvert.DeserializeObject(serializedArgs);
            try
            {
                LogServiceAsync<CustomLogServiceOptions>.Instance.LogMessage(serializedArgs);
                NotificationException notification = dbEx.notification.ToObject<NotificationException>();
                notification.Username = HttpContext.Current.User.Identity.Name;
                notification.RawMessage = serializedArgs;
                DefaultNotificationClient.Instance.Notify(notification);
            }
            catch { }
        }
        public static void HandleOnFailedToNotify(object source, string serializedArgs)
        {
            try
            {
                LogServiceAsync<CustomLogServiceOptions>.Instance.LogMessage(serializedArgs);
            }
            catch { }
        }
    }
}