using Common.Repository;
using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Threading.Tasks;
using System.Web;


namespace Web.Api.DataAccess.MemberFeedback
{
    public class MemberFeedbackRepo : RepoBase<MemberFeedback>
    {
        public MemberFeedbackRepo(DbContext context)
            : base(context)
        {

        }

        public async Task<List<MemberFeedback>> GetAsync(List<int> notInStatus, int page = 0, int limit = 0)
        {
            IQueryable<MemberFeedback> query = Entities;

            query = query.Where(i => !notInStatus.Contains(i.StatusID));

            if (page != 0)
                query = query.OrderBy(i => i.MemberFeedbackID).Skip((page -1) * limit).Take(limit);

            return await query.ToListAsync();
        }

        public async Task<Tuple<IEnumerable<MemberFeedback>, int>> GetPaginatedTableAsync(string searchValue = null, string sortColumn = "0", string orderByDir = "asc", int page = 0, int limit = 0)
        {
            Tuple<IEnumerable<MemberFeedback>, int> items = null;

            if(!String.IsNullOrEmpty(searchValue))
                items = await base.GetAsync(filter: (i) => i.MemberFeedbackCode.Contains(searchValue) ||
                                                            i.AccountNumber.Contains(searchValue) ||
                                                            i.CNFG_FeedbackType.FeedbackTypeDescr.Contains(searchValue) ||
                                                            i.CNFG_Status.StatusDescr.Contains(searchValue) ||
                                                            i.Comment.Contains(searchValue) ||
                                                            (i.AssignedToSystemUserID != null && i.CNFG_SystemUser.UserName.Contains(searchValue)),
                                            orderBy: i =>
                                            {
                                                if (orderByDir.Equals("asc"))
                                                    switch (sortColumn)
                                                    {
                                                        case "1":
                                                            return i.OrderBy(k => k.AccountNumber);
                                                        case "2":
                                                            return i.OrderBy(k => k.CNFG_FeedbackType.FeedbackTypeDescr);
                                                        case "3":
                                                            return i.OrderBy(k => k.CNFG_Status.StatusDescr);
                                                        case "4":
                                                            return i.OrderBy(k => k.Comment);
                                                        default:
                                                            return i.OrderBy(k => k.MemberFeedbackCode);
                                                    }

                                                switch (sortColumn)
                                                {
                                                    case "1":
                                                        return i.OrderByDescending(k => k.AccountNumber);
                                                    case "2":
                                                        return i.OrderByDescending(k => k.CNFG_FeedbackType.FeedbackTypeDescr);
                                                    case "3":
                                                        return i.OrderByDescending(k => k.CNFG_Status.StatusDescr);
                                                    case "4":
                                                        return i.OrderByDescending(k => k.Comment);
                                                    default:
                                                        return i.OrderByDescending(k => k.MemberFeedbackCode);
                                                }
                                            },
                                            page: page,
                                            limit: limit);
            else
                items = await base.GetAsync(orderBy: i =>
                            {
                                if (orderByDir.Equals("asc"))
                                    switch (sortColumn)
                                    {
                                        case "1":
                                            return i.OrderBy(k => k.AccountNumber);
                                        case "2":
                                            return i.OrderBy(k => k.CNFG_FeedbackType.FeedbackTypeDescr);
                                        case "3":
                                            return i.OrderBy(k => k.CNFG_Status.StatusDescr);
                                        case "4":
                                            return i.OrderBy(k => k.Comment);
                                        default:
                                            return i.OrderBy(k => k.MemberFeedbackCode);
                                    }

                                switch (sortColumn)
                                {
                                    case "1":
                                        return i.OrderByDescending(k => k.AccountNumber);
                                    case "2":
                                        return i.OrderByDescending(k => k.CNFG_FeedbackType.FeedbackTypeDescr);
                                    case "3":
                                        return i.OrderByDescending(k => k.CNFG_Status.StatusDescr);
                                    case "4":
                                        return i.OrderByDescending(k => k.Comment);
                                    default:
                                        return i.OrderByDescending(k => k.MemberFeedbackCode);
                                }
                            },
                            page: page,
                            limit: limit);

            return items;
        }

        public async Task<MemberFeedback> GetByFeedbackCode(string feedbackCode)
        {
            return await Entities.FirstOrDefaultAsync(i => i.MemberFeedbackCode.Equals(feedbackCode));
        }
    }

    public class MemberFeedbackUserRepo : RepoBase<CNFG_SystemUser>
    {
        public MemberFeedbackUserRepo(DbContext context)
            : base(context)
        {

        }

        public async Task<List<CNFG_SystemUser>> Get(int page = 0, int limit = 0)
        {
            IQueryable<CNFG_SystemUser> query = Entities;

            if (page != 0)
                query = query.OrderBy(i => i.SystemUserId).Skip((page - 1) * limit).Take(limit);

            return await query.ToListAsync();
        }
    }
}