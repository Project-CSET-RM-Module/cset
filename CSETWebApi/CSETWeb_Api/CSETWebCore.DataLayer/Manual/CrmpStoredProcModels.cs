using System;

namespace CSETWebCore.DataLayer.Manual;


public class CrmpStoredProcModels
{
    public class usp_getCrmpSummary
    {
        public int Grouping_Id { get; set; }
        public String title { get; set; }
        public int level { get; set; }
        public int y { get; set; }
        public int n { get; set; }
        public int u { get; set; }
    }
}