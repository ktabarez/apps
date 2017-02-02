using Common.ApiControllers;
using Common.ApiCors;
using IdentityProviders.SqlServerProvider;
using Microsoft.AspNet.Identity;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Threading.Tasks;
using System.Web.Http;
using Web.Api.Models;
using Microsoft.AspNet.Identity.Owin;
using System.Net.Http.Formatting;
using Microsoft.Owin;

namespace Web.Api.Controllers
{
    [Authorize]
    [CustomCorsPolicy]
    public class UserController : BaseApiController
    {
        private ApplicationUserManager _userManager;
        public ApplicationUserManager UserManager
        {
            get
            {
                return _userManager ?? Request.GetOwinContext().GetUserManager<ApplicationUserManager>();
            }
            private set
            {
                _userManager = value;
            }
        }
        private string _endpoint
        {
            get
            {
                return Request.RequestUri.AbsoluteUri.Replace(Request.RequestUri.PathAndQuery, String.Empty);
            }
        }

        private IOwinContext _owinContext
        {
            get { return Request.GetOwinContext(); }
        }

        public UserController()
        {
            
        }

        [Route("api/auth/{org}/users")]
        public async Task<IHttpActionResult> Post(string org, List<RegisterBindingModel> models)
        {
            if (!ModelState.IsValid)
                return BadRequest(ModelState);

            var response = new List<dynamic>();
             
            foreach (var model in models)
            {
                var result = await CreateUserAsync(model);
                var responseMessage = GetErrorResult(result.Item1);

                response.Add(new
                {
                    url = String.Format("{0}/{1}", Request.RequestUri, model.Username),
                    user = result.Item2 == null || result.Item2.OrgId == 0 ? (dynamic)model : new
                    {
                        result.Item2.Id,
                        result.Item2.UserName,
                        result.Item2.Email,
                        result.Item2.PhoneNumber,
                        result.Item2.IsLockoutEnabled,
                        result.Item2.IsTwoFactorEnabled,
                        result.Item2.AccessFailedCount,
                        result.Item2.LockoutEndDateUtc,
                        result.Item2.FirstName,
                        result.Item2.LastName,
                        result.Item2.Suffix,
                    },
                    satusCode = result.Item2 == null || result.Item2.OrgId == 0 ? HttpStatusCode.InternalServerError : HttpStatusCode.OK,
                });
            }

            return Ok(response);
        }

        /// <summary>
        /// Get currently authenticated user
        /// </summary>
        /// <returns></returns>
        [Route("api/auth/{org}/user")]
        public async Task<HttpResponseMessage> Get()
        {
            var username = ControllerContext.RequestContext.Principal.Identity.Name.Split('\\')[1];

            return await Task.FromResult<HttpResponseMessage>(Request.CreateResponse(HttpStatusCode.OK, new
            {
                UserName = username,
                AvatarUrl = "",
                Url = String.Format("/users/{0}", username),
                Name = "",
                Company = "",
                CreatedAt = DateTime.UtcNow,
                UpdatedAt = DateTime.UtcNow,
                TotalApps = 3,
                TotalRoles = 23,
            }));
        }

        //only allow site admin to call this
        [Route("api/auth/{org}/user/{username}")]
        public async Task<HttpResponseMessage> Update(UserModel model)
        {
            //update logic
            return await Task.FromResult<HttpResponseMessage>(Request.CreateResponse(HttpStatusCode.NoContent));
        }

        [Route("api/auth/{org}/user/{username}")]
        public async Task<HttpResponseMessage> Delete()
        {
            //update logic

            return await Task.FromResult<HttpResponseMessage>(Request.CreateResponse(HttpStatusCode.NoContent));
        }


        [Route("api/auth/{org}/users")]
        public async Task<HttpResponseMessage> Get(string[] username)
        {

            //create new user
            return await Task.FromResult<HttpResponseMessage>(Request.CreateResponse(HttpStatusCode.OK, new
            {
                Username,
                UserDomainName,
                UserFullDomainName,
                AvatarUrl = "",
                Url = String.Format("/users/{0}", UserDomainName == null ? Username : String.Format("{0}.{1}", UserDomainName, Username)),
                Name = "",
                Company = "",
                CreatedAt = DateTime.UtcNow,
                UpdatedAt = DateTime.UtcNow,
                TotalApps = 3,
                TotalRoles = 23,
            }));
        }

        private IHttpActionResult GetAsyncErrorResult(IdentityResult result)
        {
            if (result == null)
            {
                return InternalServerError();
            }

            if (!result.Succeeded)
            {
                if (result.Errors != null)
                {
                    foreach (string error in result.Errors)
                    {
                        ModelState.AddModelError("", error);
                    }
                }

                if (ModelState.IsValid)
                {
                    // No ModelState errors are available to send, so just return an empty BadRequest.
                    return BadRequest();
                }

                return BadRequest(ModelState);
            }

            return null;
        }

        private HttpResponseMessage GetErrorResult(IdentityResult result)
        {
            if (result == null)
            {
                return new HttpResponseMessage(HttpStatusCode.InternalServerError);
            }

            if (!result.Succeeded)
            {
                if (result.Errors != null)
                {
                    foreach (string error in result.Errors)
                    {
                        ModelState.AddModelError("", error);
                    }
                }

                if (ModelState.IsValid)
                {
                    // No ModelState errors are available to send, so just return an empty BadRequest.
                    return Request.CreateResponse<IdentityResult>(HttpStatusCode.BadRequest, result);
                }

                return Request.CreateResponse(HttpStatusCode.BadRequest, result);
            }

            return null;
        }

        private async Task<Tuple<IdentityResult, OrgUser>> CreateUserAsync(RegisterBindingModel model)
        {
            if (model.Username == null || model.Username.Trim().Equals(string.Empty) ||
                (model.Password != null && !model.Password.Trim().Equals(string.Empty) && model.Username.Contains(@"\")))
                return new Tuple<IdentityResult, OrgUser>(IdentityResult.Failed("invalid username"), null);

            OrgUser user = user = new OrgUser()
            {
                UserName = model.Username,
                Email = model.Email,
                IsActive = true,
                created_by = _owinContext.Authentication.User.Identity.Name,
                created_dt = DateTime.UtcNow,
                modified_by = _owinContext.Authentication.User.Identity.Name,
                modified_dt = DateTime.UtcNow,
                OrgId = model.OrgId,
            };

            IdentityResult result = null;

            if (model.Username.Contains(@"\"))
                result = await UserManager.CreateAsync(user);
            else
                result = await UserManager.CreateAsync(user, model.Password);

            return new Tuple<IdentityResult, OrgUser>(IdentityResult.Failed("invalid username"), user);
        }
    }
}