﻿// <auto-generated> This file has been auto generated by EF Core Power Tools. </auto-generated>
using System;
using System.Collections.Generic;

namespace SearchIndex2
{
    /// <summary>
    /// A collection of FILE_REF_KEYS records
    /// </summary>
    public partial class FILE_REF_KEYS
    {
        public FILE_REF_KEYS()
        {
            GEN_FILEs = new HashSet<GEN_FILE>();
        }

        /// <summary>
        /// The Doc Num is used to
        /// </summary>
        public string Doc_Num { get; set; }

        public virtual ICollection<GEN_FILE> GEN_FILEs { get; set; }
    }
}