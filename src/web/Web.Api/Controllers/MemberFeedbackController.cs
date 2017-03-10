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

            var items = await _feedbacksRepo.GetAsync(notInStatus, page, limit);

            return await Task.FromResult<HttpResponseMessage>(Request.CreateResponse(HttpStatusCode.OK, items.Select(i => new
            {
                i.MemberFeedbackID,
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
                AssignedTo = i.CNFG_SystemUser == null ? null : new
                {
                    i.CNFG_SystemUser.SystemUserId,
                    i.CNFG_SystemUser.UserName,
                },
                i.AssignedToCopy,
                i.AssignedDate,
            })));
        }

        [AllowAnonymous]
        [HttpPost]
        [Route("api/{org}/apps/memberfeedback/search/feedbacks")]
        public async Task<HttpResponseMessage> SearchFeedbacks()
        {
            var formData = await Request.Content.ReadAsFormDataAsync();

            var draw = formData["draw"];
            var start = Convert.ToInt32(formData["start"]);
            var length = Convert.ToInt32(formData["length"]);
            var sortColumn = formData["order[0][column]"];
            var sortColumnDir = formData["order[0][dir]"];
            var searchValue = formData["search[value]"];
            var totalRecords = _feedbacksRepo.Entities.Count();

            var items = await _feedbacksRepo.GetPaginatedTableAsync(searchValue: searchValue, sortColumn: sortColumn, orderByDir: sortColumnDir, page: (start / length) + 1,
                                                             limit: length);

            return await Task.FromResult<HttpResponseMessage>(Request.CreateResponse(HttpStatusCode.OK, new
            {
                Draw = draw,
                RecordsFiltered = items.Item2,
                RecordsTotal = totalRecords,
                data = items.Item1.Select( i => new
                {
                    url = String.Format("/api/{0}/apps/memberfeedback/feedbacks/{1}", "someorg", i.MemberFeedbackCode),
                    htmlUrl = String.Format("/memberfeedback/{0}", i.MemberFeedbackCode),
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
                    AssignedTo = i.CNFG_SystemUser == null ? null : new
                    {
                        i.CNFG_SystemUser.SystemUserId,
                        i.CNFG_SystemUser.UserName,
                    },
                    i.AssignedToCopy,
                    i.AssignedDate,
                })


            }));

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
                item.MemberFeedbackID,
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
                AssignedTo = item.CNFG_SystemUser == null ? null : new
                {
                    item.CNFG_SystemUser.SystemUserId,
                    item.CNFG_SystemUser.UserName,
                },
                item.AssignedToCopy,
                item.AssignedDate,
                resolvedBy = item.CNFG_SystemUser1 == null ? null : new
                {
                    item.CNFG_SystemUser1.SystemUserId,
                    item.CNFG_SystemUser1.UserName,
                }
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
                i.boolIsActive
            })));
        }

        [HttpPut]
        [Route("api/{org}/apps/memberfeedback/feedbacks")]
        public async Task<HttpResponseMessage> Put(List<FeedBackModel> models)
        {
            foreach (var model in models)
            {
                var item = await _feedbacksRepo.FindAsync(model.MemberFeedbackID);
                item.AssignedToSystemUserID = model.AssignedToId;
                item.AssignedDate = DateTime.Now;
                item.Resolution = model.Resolution;

                await _feedbacksRepo.UpdateAsync(item);
            }

            return await Task.FromResult<HttpResponseMessage>(Request.CreateResponse(HttpStatusCode.OK, String.Empty));
        }
    }

    public class FeedBackModel
    {
        public int MemberFeedbackID { get; set; }
        public int AssignedToId { get; set; }
        public string Resolution { get; set; }
    }
}
