﻿//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace Mfcu.Repositories.ITGov
{
    using System;
    using System.Data.Entity;
    using System.Data.Entity.Infrastructure;
    using System.Data.Entity.Core.Objects;
    using System.Linq;
    
    public partial class ITGovEntities : DbContext
    {
        public ITGovEntities()
            : base("name=ITGovEntities")
        {
        }
    
        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            throw new UnintentionalCodeFirstException();
        }
    
        public virtual DbSet<Area> Areas { get; set; }
        public virtual DbSet<Assignment> Assignments { get; set; }
        public virtual DbSet<AuditLog> AuditLogs { get; set; }
        public virtual DbSet<Domain> Domains { get; set; }
        public virtual DbSet<Practice> Practices { get; set; }
        public virtual DbSet<Priority> Priorities { get; set; }
        public virtual DbSet<Process> Processes { get; set; }
        public virtual DbSet<Status> Status { get; set; }
        public virtual DbSet<Attachment> Attachments { get; set; }
        public virtual DbSet<Comment> Comments { get; set; }
        public virtual DbSet<Department> Departments { get; set; }
        public virtual DbSet<Link> Links { get; set; }
        public virtual DbSet<CoreSystem> CoreSystems { get; set; }
        public virtual DbSet<SystemUser> SystemUsers { get; set; }
        public virtual DbSet<Vendor> Vendors { get; set; }
        public virtual DbSet<Tracking> Trackings { get; set; }
        public virtual DbSet<TrackingDepartment> TrackingDepartments { get; set; }
        public virtual DbSet<vwPractice> vwPractices { get; set; }
        public virtual DbSet<vwPracticeAssignment> vwPracticeAssignments { get; set; }
        public virtual DbSet<vwSystemUser> vwSystemUsers { get; set; }
        public virtual DbSet<vwTracking> vwTrackings { get; set; }
        public virtual DbSet<IncidentStatus> IncidentStatus { get; set; }
    
        [DbFunction("ITGovEntities", "udf_sel_ParseListGeneric")]
        public virtual IQueryable<udf_sel_ParseListGeneric_Result> udf_sel_ParseListGeneric(string strList, string strDelimiter)
        {
            var strListParameter = strList != null ?
                new ObjectParameter("strList", strList) :
                new ObjectParameter("strList", typeof(string));
    
            var strDelimiterParameter = strDelimiter != null ?
                new ObjectParameter("strDelimiter", strDelimiter) :
                new ObjectParameter("strDelimiter", typeof(string));
    
            return ((IObjectContextAdapter)this).ObjectContext.CreateQuery<udf_sel_ParseListGeneric_Result>("[ITGovEntities].[udf_sel_ParseListGeneric](@strList, @strDelimiter)", strListParameter, strDelimiterParameter);
        }
    
        public virtual ObjectResult<usp_get_AttachmentFileName_Result> usp_get_AttachmentFileName(Nullable<int> intSurrogateID, string strSystemType, string strSourceFile)
        {
            var intSurrogateIDParameter = intSurrogateID.HasValue ?
                new ObjectParameter("intSurrogateID", intSurrogateID) :
                new ObjectParameter("intSurrogateID", typeof(int));
    
            var strSystemTypeParameter = strSystemType != null ?
                new ObjectParameter("strSystemType", strSystemType) :
                new ObjectParameter("strSystemType", typeof(string));
    
            var strSourceFileParameter = strSourceFile != null ?
                new ObjectParameter("strSourceFile", strSourceFile) :
                new ObjectParameter("strSourceFile", typeof(string));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction<usp_get_AttachmentFileName_Result>("usp_get_AttachmentFileName", intSurrogateIDParameter, strSystemTypeParameter, strSourceFileParameter);
        }
    }
}
