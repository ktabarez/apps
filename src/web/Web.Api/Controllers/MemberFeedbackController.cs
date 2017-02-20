using Common.ApiControllers;
using Common.Repository;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Threading.Tasks;
using System.Web.Http;
using Web.Api.DataAccess.MemberFeedback;

namespace Web.Api.Controllers
{
    [Authorize]
    public class MemberFeedbackController : BaseApiController
    {
        private MemberFeedbackRepo _feedbacksRepo;
        private MemberFeedbackUserRepo _userRepo;

        public MemberFeedbackController()
        {

        }

        public MemberFeedbackController(IRepository<MemberFeedback> memberFeedbackRepo, IRepository<CNFG_SystemUser> userRepo)
        {
            _feedbacksRepo = (MemberFeedbackRepo)memberFeedbackRepo;
            _userRepo = (MemberFeedbackUserRepo)userRepo;
        }

        [HttpGet]
        [Route("api/{org}/apps/memberfeedback/feedbacks")]
        public async Task<HttpResponseMessage> GetFeedbacks(string org, [FromUri] List<int> notInStatus, int page = 0, int limit = 0)
        {
            if (notInStatus == null)
                notInStatus = new List<int>();

            var items = await _feedbacksRepo.Get(notInStatus, page, limit);

            return await Task.FromResult<HttpResponseMessage>(Request.CreateResponse(HttpStatusCode.OK, items.Select(i => new
            {
                url = String.Format("api/{0}/apps/memberfeedback/feedbacks/{1}", org, i.MemberFeedbackCode),
                htmlUrl = String.Format("memberfeedback/{0}", i.MemberFeedbackCode),
                i.MemberFeedbackCode,
                Type = new
                {
                    i.CNFG_FeedbackType.FeedbackTypeID,
                    i.CNFG_FeedbackType.FeedbackTypeDescr,
                    url = "",
                },
                Category = new
                {
                    i.CNFG_Category.CategoryID,
                    i.CNFG_Category.CategoryDescr,
                    url = "",
                },
                Source = new
                {
                    i.CNFG_Source.SourceID,
                    i.CNFG_Source.SourceDescr,
                    url = "",
                },
                i.AccountNumber,
                i.MemberName,
                i.Comment,
                i.Resolution,
                i.created_by,
                i.created_dt,
                i.modified_by,
                i.modified_dt,
                i.Branch,
                Status = new
                {
                    i.CNFG_Status.StatusID,
                    i.CNFG_Status.StatusDescr,
                },
                AssignedTo = i.CNFG_SystemUser1 == null ? null : new
                {
                    i.CNFG_SystemUser1.SystemUserId,
                    i.CNFG_SystemUser1.UserName,
                },
                i.AssignedToCopy,
                i.AssignedDate,
            })));
        }

        [HttpGet]
        [Route("api/{org}/apps/memberfeedback/feedbacks/{feedbackCode}")]
        public async Task<HttpResponseMessage> GetFeedback(string org, string feedbackCode)
        {
            var item = await _feedbacksRepo.GetByFeedbackCode(feedbackCode);

            if (item == null)
                return await Task.FromResult<HttpResponseMessage>(Request.CreateResponse(HttpStatusCode.NotFound, String.Empty));

            var feedbackItem = new
            {
                url = String.Format("api/{0}/apps/memberfeedback/feedbacks/{1}", org, feedbackCode),
                htmlUrl = String.Format("memberfeedback/{0}", feedbackCode),
                item.MemberFeedbackCode,
                Type = new
                {
                    item.CNFG_FeedbackType.FeedbackTypeID,
                    item.CNFG_FeedbackType.FeedbackTypeDescr,
                    url = "",
                },
                Category = new
                {
                    item.CNFG_Category.CategoryID,
                    item.CNFG_Category.CategoryDescr,
                    url = "",
                },
                Source = new
                {
                    item.CNFG_Source.SourceID,
                    item.CNFG_Source.SourceDescr,
                    url = "",
                },
                item.AccountNumber,
                item.MemberName,
                item.Comment,
                item.Resolution,
                item.created_by,
                item.created_dt,
                item.modified_by,
                item.modified_dt,
                item.Branch,
                Status = new
                {
                    item.CNFG_Status.StatusID,
                    item.CNFG_Status.StatusDescr,
                },
                AssignedTo = item.CNFG_SystemUser1 == null ? null : new
                {
                    item.CNFG_SystemUser1.SystemUserId,
                    item.CNFG_SystemUser1.UserName,
                },
                item.AssignedToCopy,
                item.AssignedDate,
            };
            return await Task.FromResult<HttpResponseMessage>(Request.CreateResponse(HttpStatusCode.OK, feedbackItem));
        }

        [HttpGet]
        [Route("api/{org}/apps/memberfeedback/users")]
        public async Task<HttpResponseMessage> GetUsers(int page = 0, int limit = 0)
        {
            var items = await _userRepo.Get(page, limit);

            if (items == null || !items.Any())
                return await Task.FromResult<HttpResponseMessage>(Request.CreateResponse(HttpStatusCode.NotFound, String.Empty));

            return await Task.FromResult<HttpResponseMessage>(Request.CreateResponse(HttpStatusCode.OK, items.Select(i => new
            {
                i.SystemUserId,
                i.UserName,
                i.boolIsAdmin,
                i.boolIsAssignable,
                i.DomainLogin,
                i.EmailAddress,
                i.modified_by,
                i.modified_dt,
                i.created_by,
                i.created_dt,
            })));
        }
    }
}