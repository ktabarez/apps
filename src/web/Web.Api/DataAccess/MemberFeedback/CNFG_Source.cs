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
    
    public partial class CNFG_Source
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public CNFG_Source()
        {
            this.MemberFeedbacks = new HashSet<MemberFeedback>();
        }
    
        public short SourceID { get; set; }
        public string SourceDescr { get; set; }
        public System.DateTime RecordBeginDate { get; set; }
        public Nullable<System.DateTime> RecordEndDate { get; set; }
        public bool boolIsActive { get; set; }
        public string created_by { get; set; }
        public System.DateTime created_dt { get; set; }
        public string modified_by { get; set; }
        public System.DateTime modified_dt { get; set; }
    
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<MemberFeedback> MemberFeedbacks { get; set; }
    }
}
