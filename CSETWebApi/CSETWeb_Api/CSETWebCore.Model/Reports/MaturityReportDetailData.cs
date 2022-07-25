﻿//////////////////////////////// 
// 
//   Copyright 2022 Battelle Energy Alliance, LLC  
// 
// 
//////////////////////////////// 
using System.Collections.Generic;
using CSETWebCore.DataLayer.Manual;

namespace CSETWebCore.Business.Reports
{
    public class MaturityReportDetailData
    {
        public List<usp_getRRASummaryOverall> RRASummaryOverall { get; set; }
        public List<usp_getRRASummary> RRASummary { get; set; }
        public List<usp_getRRASummaryByGoal> RRASummaryByGoal { get; set; }
        public List<usp_getRRASummaryByGoalOverall> RRASummaryByGoalOverall { get; set; }
        
        public List<CrmpStoredProcModels.usp_getCrmpSummary> CrmpSummary { get; set; }
        
        public List<VbosStoredProcModels.usp_getVbosSummaryOverall> VbosSummary { get; set; }
    }
}