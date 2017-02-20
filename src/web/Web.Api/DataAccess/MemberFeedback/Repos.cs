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

        public async Task<List<MemberFeedback>> Get(List<int> notInStatus, int page = 0, int limit = 0)
        {
            IQueryable<MemberFeedback> query = Entities;

            query = query.Where(i => !notInStatus.Contains(i.StatusID));

            if (page != 0)
                query = query.OrderBy(i => i.MemberFeedbackID).Skip((page -1) * limit).Take(limit);

            return await query.ToListAsync();
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