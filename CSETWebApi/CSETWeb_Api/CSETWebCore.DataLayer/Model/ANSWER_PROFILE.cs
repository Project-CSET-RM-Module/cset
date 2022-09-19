﻿// <auto-generated> This file has been auto generated by EF Core Power Tools. </auto-generated>
#nullable disable
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace CSETWebCore.DataLayer.Model
{
    public partial class ANSWER_PROFILE
    {
        public ANSWER_PROFILE()
        {
            ANSWER_CLONE = new HashSet<ANSWER_CLONE>();
        }

        public int Asessment_Id { get; set; }
        [Key]
        public int Profile_Id { get; set; }
        [StringLength(50)]
        public string ProfileName { get; set; }
        [Column(TypeName = "datetime")]
        public DateTime Profile_Date { get; set; }

        [ForeignKey("Asessment_Id")]
        [InverseProperty("ANSWER_PROFILE")]
        public virtual ASSESSMENTS Asessment { get; set; }
        [InverseProperty("Profile")]
        public virtual ICollection<ANSWER_CLONE> ANSWER_CLONE { get; set; }
    }
}