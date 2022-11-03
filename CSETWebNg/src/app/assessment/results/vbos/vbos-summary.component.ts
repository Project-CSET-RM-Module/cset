import { Component, OnInit, HostListener, ViewChild, ElementRef, Input, } from '@angular/core';
import { NavigationService } from '../../../services/navigation.service';
import { MaturityService } from '../../../services/maturity.service';
import { AssessmentService } from '../../../services/assessment.service';
import { ReportAnalysisService } from '../../../services/report-analysis.service';
import { ReportService } from '../../../services/report.service';
import { VbosDataService } from '../../../services/vbos-data.service';
import * as $ from 'jquery';
import { formatPercent } from '@angular/common';
import { element } from 'protractor';



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
  countsTable = [];

  barscoreswidthvar;
  level;

constructor(
  public maturitySvc: MaturityService, 
  public assessmentSvc: AssessmentService,
  public navSvc: NavigationService
){}

ngOnInit(): void {
  this.maturitySvc.getResultsData('vbosSiteSummary').subscribe((r: any) => {
    console.log(r);
    r.Grouping_Id;
    r.level;
    console.log(r.Grouping_Id);
    console.log(this.level);

    //capture data here
    this.assetmscore = 2;
    this.configmscore = 3;
    this.accesscscore = 2;
    this.flawrscore = 3;
    this.malcodescore = 3;
    this.systemiscore = 1;
    this.continmscore = 3;
    this.incresprecoscore = 2;
    this.archdevscore = 2;
    this.supplychscore = 3;

    this.barscoreswidthvar = this.level;

    // final score

    this.finalscore = 1;
    // this.achievedLevel(r);
    // this.finalscore = this.achievedLevel(r);

    // table

    // this.createAnswerDistribByLevel(r);
    this.createCountTable(r);
    // this.answerDistribByLevel = [];

    });

    this.finalscorewidthvariable = "33%";
    //this.finalscorewidthvariable = displayPercent(this.finalscore * 33);
    // = displayPercent(this.finalscore * 33);

    //for the bars div loop
    // this.barscoreswidthvar = (this.level * 33) + "%";
    
    this.assetmwidthvariable = formatPercent(66, this.assetmwidthvariable);
    this.configmanwidthvariable = displayPercent(100);
    this.accesscwidthvariable = displayPercent(66);
    this.flawremwidthvariable = displayPercent(100);
    this.malcodewidthvariable = displayPercent(100);
    this.sysintwidthvariable = displayPercent(33);
    this.continmonwidthvariable = displayPercent(100);
    this.indidrespwidthvariable = displayPercent(66);
    this.archdevwidthvariable = displayPercent(66);
    this.supplymanwidthvariable = displayPercent(100);
    
    
    // this.assetmwidthvariable = displayPercent(this.assetmscore * 33);
    // this.configmanwidthvariable = displayPercent(this.configmscore * 33);
    // this.accesscwidthvariable = displayPercent(this.accesscscore * 33);
    // this.flawremwidthvariable = displayPercent(this.flawrscore * 33);
    // this.malcodewidthvariable = displayPercent(this.malcodescore * 33);
    // this.sysintwidthvariable = displayPercent(this.systemiscore * 33);
    // this.continmonwidthvariable = displayPercent(this.continmscore * 33);
    // this.indidrespwidthvariable = displayPercent(this.incresprecoscore * 33);
    // this.archdevwidthvariable = displayPercent(this.archdevscore * 33);
    // this.supplymanwidthvariable = displayPercent(this.supplychscore * 33);


  }

  
  achievedLevel(r: any) {
  //achievedLevel(data) {

    // this.achievedLevelList = [];
    // outputData.forEach(element => {
    //   achievedLevel += element assessmentLevel;

    // html accessible?
    //   element["achievedLevel"] = achievedLevel;
        // });
    // let achievedLevel = data.level;
    let achievedLevel = r.level;
    console.log(achievedLevel);
    console.log(r.level);
    // spot for current result: undefined
	return achievedLevel;
  }

// Preferred table data method

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
//       console.log(level);
//       levelList.push(level);
//     }
//     var p = level.series.find(x => x.name == element.answer_Full_Name);
//     p.value = element.percent;
//   });
//   this.answerDistribByLevel = levelList;
// }

// alternate table count data

createCountTable(r: any) {
  let countList = [];
  //r.rraSummaryByGoal.forEach(element => {
  r.MaturityService.forEach(element => {  
    let count = countList.find(x => x.name == element.title);
    if (!count) {
      count = {
        name: element.title,
        yes: 0,
        no: 0,
        unanswered: 0
      };
      countList.push(count);
    }
    switch (element.answer_Text) {
      case 'Y':
        count.yes = element.qc;
        break;
      case 'N':
        count.no = element.qc;
        break;
      case 'U':
        count.unanswered = element.qc
        break;
    }
  });
  countList.forEach(r => {
    r.total = r.yes + r.no + r.unanswered;
    r.percent = ((r.yes / r.total) * 100).toFixed(1);
  });
  this.countTable = countList;
}

makeCountTable(data) {
  let countsList = [];
  data.MaturityService.forEach(element => {
    let count = countsList.find(x => x.name == element.title);
      if (!count) {
        count = {
          name: element.title, series: [
            { name: 'Yes', value: 0 },
            { name: 'No', value: 0 },
            { name: 'Unanswered', value: 0 },
          ]
        };
        countsList.push(count);
        this.countsTable = countsList;
      }

      var p = count.series.find(x => x.name == element.answer_Full_Name);
      p.value = element.percent;
  })
}

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

// public setWidths(width: string) {
//   //const docStyle = document.documentElement.style;
//   //docStyle.setProperty('--achievedwidthvariable');
//   //etc
//   //docStyle not being recognized. JS?
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
