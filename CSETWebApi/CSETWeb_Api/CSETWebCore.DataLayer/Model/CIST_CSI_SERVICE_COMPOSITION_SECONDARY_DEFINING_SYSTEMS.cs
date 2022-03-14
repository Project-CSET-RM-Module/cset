﻿// <auto-generated> This file has been auto generated by EF Core Power Tools. </auto-generated>
#nullable disable
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace CSETWebCore.DataLayer.Model
{
    public partial class CIST_CSI_SERVICE_COMPOSITION_SECONDARY_DEFINING_SYSTEMS
    {
        [Key]
        public int Assessment_Id { get; set; }
        [Key]
        public int Defining_System_Id { get; set; }

        [ForeignKey(nameof(Assessment_Id))]
        [InverseProperty(nameof(CIST_CSI_SERVICE_COMPOSITION.CIST_CSI_SERVICE_COMPOSITION_SECONDARY_DEFINING_SYSTEMS))]
        public virtual CIST_CSI_SERVICE_COMPOSITION Assessment { get; set; }
        [ForeignKey(nameof(Defining_System_Id))]
        [InverseProperty(nameof(CIST_CSI_DEFINING_SYSTEMS.CIST_CSI_SERVICE_COMPOSITION_SECONDARY_DEFINING_SYSTEMS))]
        public virtual CIST_CSI_DEFINING_SYSTEMS Defining_System { get; set; }
    }
}