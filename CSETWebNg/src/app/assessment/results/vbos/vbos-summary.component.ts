import { Component, OnInit, HostListener, ViewChild, ElementRef, Input } from '@angular/core';
import { NavigationService } from '../../../services/navigation.service';
import { MaturityService } from '../../../services/maturity.service';
import { AssessmentService } from '../../../services/assessment.service';
import { ReportAnalysisService } from '../../../services/report-analysis.service';
import { ReportService } from '../../../services/report.service';
import { VbosDataService } from '../../../services/vbos-data.service';
import * as $ from 'jquery';
import { formatPercent } from '@angular/common';



// New Custom TS to match SP
@Component({
	selector: 'app-vbos-summary',
	templateUrl: './vbos-summary.component.html',
	//styleUrls: 
	//host: {}
})
export class VbosSummaryComponent implements OnInit {
	
  initialized = false;
	dataError = false;

  achievedLevelList = [];
	statsByCategoryList = [];

  finalscorewidthvariable;
  assetmwidthvariable;
  configmanwidthvariable;
  accesscwidthvariable;
  flawremwidthvariable;
  malcodewidthvariable;
  sysintwidthvariable;
  continmonwidthvariable;
  indidrespwidthvariable;
  archdevwidthvariable;
  supplymanwidthvariable;

  finalscore;
  assetmscore;
  configmscore;
  accesscscore;
  flawrscore;
  malcodescore;
  systemiscore;
  continmscore;
  incresprecoscore;
  archdevscore;
  supplychscore;

  answerDistribByLevel = [];

  countTable = [];

constructor(
  public maturitySvc: MaturityService, 
  public assessmentSvc: AssessmentService,
  public navSvc: NavigationService
){}

ngOnInit(): void {
  this.maturitySvc.getResultsData('vbosSiteSummary').subscribe((r: any) => {
    console.log(r);

    this.assetmscore = 3;
    this.configmscore = 3;
    this.accesscscore = 3;
    this.flawrscore = 3;
    this.malcodescore = 3;
    this.systemiscore = 3;
    this.continmscore = 3;
    this.incresprecoscore = 3;
    this.archdevscore = 3;
    this.supplychscore = 3;

    this.finalscore = 3;

    // this.createAnswerDistribByLevel(r);

    // this.createCountTable(r);

    this.answerDistribByLevel = [];

    });

    this.finalscorewidthvariable = displayPercent(66);
    // = displayPercent(finalscore * 33)
    this.archdevwidthvariable = displayPercent(33);
    this.assetmwidthvariable = displayPercent(66);
    this.configmanwidthvariable = displayPercent(33);
    this.accesscwidthvariable = displayPercent(33);
    this.flawremwidthvariable = displayPercent(66);
    this.malcodewidthvariable = displayPercent(33);
    this.sysintwidthvariable = displayPercent(33);
    this.continmonwidthvariable = displayPercent(99);
    this.indidrespwidthvariable = displayPercent(33);
    this.archdevwidthvariable = displayPercent(33);
    this.supplymanwidthvariable = displayPercent(66);
    
  }

  //main data objective
  achievedLevel(data) {
	let outputData = data.filter(obj => obj.modelLevel != "Aggregate");
    // outputData.sort((a, b) => (a.modelLevel > b.modelLevel) ? 1 : -1);

    let levels: number[] = [];
    outputData.forEach(o => levels.push(o.level)); 
    // Minimum of Entire Data-Set Function
    // this.achievedLevelList = [];
    let achievedLevel = data.level;
    //Math.min(...levels);
    console.log(achievedLevel);
	return achievedLevel;
    // outputData.forEach(element => {
    //   achievedLevel += element assessmentLevel;
    //   element["achievedLevel"] = achievedLevel;
    // });
	// return outputData;
}

// createAnswerDistribByLevel(r: any) {
//   let levelList = [];
//   //r.rraSummary.forEach(element => {
//   r.MaturityService.forEach(element => {
//     let level = levelList.find(x => x.name == element.level_Name);
//     if (!level) {
//       level = {
//         name: element.level_Name, series: [
//           { name: 'Yes', value: 0 },
//           { name: 'No', value: 0 },
//           { name: 'Unanswered', value: 0 },
//         ]
//       };
//       levelList.push(level);
//     }

//     var p = level.series.find(x => x.name == element.answer_Full_Name);
//     p.value = element.percent;
//   });

//   this.answerDistribByLevel = levelList;
// }

// createCountTable(r: any) {
//   let countList = [];
//   //r.rraSummaryByGoal.forEach(element => {
//   r.MaturityService.forEach(element => {  
//     let count = countList.find(x => x.name == element.title);
//     if (!count) {
//       count = {
//         name: element.title,
//         yes: 0,
//         no: 0,
//         unanswered: 0
//       };
//       countList.push(count);
//     }

//     switch (element.answer_Text) {
//       case 'Y':
//         count.yes = element.qc;
//         break;
//       case 'N':
//         count.no = element.qc;
//         break;
//       case 'U':
//         count.unanswered = element.qc
//         break;
//     }
//   });

//   countList.forEach(r => {
//     r.total = r.yes + r.no + r.unanswered;
//     r.percent = ((r.yes / r.total) * 100).toFixed(1);
//   });

//   this.countTable = countList;
// }

// public setWidths(width: string) {
//   //const docStyle = document.documentElement.style;
//   //docStyle.setProperty('--achievedwidthvariable');
//   //etc
//   //docStyle not being recognized. JS?
// }

}

const displayPercent = (percent: number) => 
'${(percent * 100).toFixed(2)}%';

//DOCUMENTATION and ATTEMPTS

//answer data distributed by sections
// statsByCategory(data) {
// 	let outputData = data.filter(obj => obj.modelLevel != "Aggregate");
//     outputData.sort((a, b) => (a.modelLevel > b.modelLevel) ? 1 : -1);
//     let categoryList = [];
    
//     // Check Hardcoded Array in vbos data service

// 	return outputData;	
// }

//secondary data objectives
// categoryCounts(data) {
// 	let outputData = [];	
// 	return outputData;
// }

// Previous TS attempt 

// @Component({
//   selector: 'app-vbos-summary',
//   templateUrl: './vbos-summary.component.html',
//   styleUrls: ['./rra-summary-all.component.scss']
//   host: { class: 'd-flex flex-column flex-11a' }
// })
// export class VbosSummaryComponent implements OnInit {
//   @Input() title = "VBOS Performance Summary";
//   @Input() showNav = true;

//   initialized = false;

//   sAxisTicks = [0, 5, 10, 15, 18];
//   maxLevel = 0;
//   answerCountsByLevel = [];
//   answerDistribColorScheme = { domain: ['#28A745', '#DC3545', '#c3c3c3'] };

//   complianceByGoal = [];
//   answerDistribByGoal = [];
//   answerDistribByLevel = [];

//   colorScheme1 = { domain: ['#007BFF'] };
//   xAxisTicks = [0, 25, 50, 75, 100];

//   constructor(
//     public VbosDataSvc: VbosDataService,
//     public navSvc: NavigationService,
//     public maturitySvc: MaturityService,
//     public assessmentSvc: AssessmentService
//   ) { }

//   ngOnInit(): void {
//     this.VbosDataSvc.getVBOSDetail().subscribe((r: any) => {
//       this.createAnswerCountsByLevel(r);
//       this.createAnswerDistribByLevel(r);
//     });
//   }

//   createAnswerCountsByLevel(r: any) {
//     let levelList = [];

//     r.vbosSummary.forEach(element => {
//       let level = levelList.find(x => x.name == element.level_Name);
//       if (!level) {
//         level = {
//           name: element.level_Name, series: [
//             { name: 'Yes', value: 0 },
//             { name: 'No', value: 0 },
//             { name: 'Unanswered', value: 0 },
//           ]
//         };
//         levelList.push(level);
//       }

//       var p = level.series.find(x => x.name == element.answer_Full_Name);
//       p.value = element.qc;
//     });
//     this.answerCountsByLevel = levelList;
//     this.findMaxLength();
//   }

//   findMaxLength(){
//     let mLength = 0;
//     this.answerCountsByLevel.forEach(x =>{
//       let length = 0;
//       x.series.forEach(y => {
//         length += y.value;
//       });
//       if(mLength < length){
//         mLength = length;
//       }
//     })
//     this.maxLevel = mLength;
//   }
//   createAnswerDistribByLevel(r: any) {
//     let levelList = [];
//     r.vbosSummary.forEach(element => {
//       let level = levelList.find(x => x.name == element.level_Name);
//       if (!level) {
//         level = {
//           name: element.level_Name, series: [
//             { name: 'Yes', value: 0 },
//             { name: 'No', value: 0 },
//             { name: 'Unanswered', value: 0 },
//           ]
//         };
//         levelList.push(level);
//       }

//       var p = level.series.find(x => x.name == element.answer_Full_Name);
//       p.value = element.percent;
//     });

//     this.answerDistribByLevel = levelList;
//   }

  // formatPercent(x: any) {
  //   return x + '.0';
  // }



// }
// }
