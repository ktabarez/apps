//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace Web.Api.DataAccess.MemberFeedback
{
    using System;
    using System.Collections.Generic;
    
    public partial class vw_MemberFeedbackDetails
    {
        public int MemberFeedbackID { get; set; }
        public string MemberFeedbackCode { get; set; }
        public short CategoryID { get; set; }
        public string CategoryDescr { get; set; }
        public short FeedbackTypeID { get; set; }
        public string FeedbackTypeDescr { get; set; }
        public short FeedbackSourceID { get; set; }
        public string SourceDescr { get; set; }
        public short StatusID { get; set; }
        public string StatusDescr { get; set; }
        public short FunctionalID { get; set; }
        public string FunctionalDescr { get; set; }
        public short Branch { get; set; }
        public string AccountNumber { get; set; }
        public string MemberName { get; set; }
        public string Comment { get; set; }
        public Nullable<int> AssignedtoSystemUserID { get; set; }
        public string AssignedToCopy { get; set; }
        public Nullable<System.DateTime> AssignedDate { get; set; }
        public string Resolution { get; set; }
        public Nullable<int> Resolution_byID { get; set; }
        public System.DateTime created_dt { get; set; }
        public string created_by { get; set; }
        public string modified_by { get; set; }
        public System.DateTime modified_dt { get; set; }
    }
}
