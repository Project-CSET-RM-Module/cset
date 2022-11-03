import { Component, Input, OnInit, HostListener, ViewChild, ElementRef } from '@angular/core';
import { NavigationService } from '../../../services/navigation.service';
import { Title } from '@angular/platform-browser';
import { MaturityService } from '../../../services/maturity.service';
import { ChartService } from '../../../services/chart.service';
import { CrmpDataService } from '../../../services/crmp-data.service';
import { NgxChartsModule, ColorHelper } from '@swimlane/ngx-charts';
import { BehaviorSubject } from 'rxjs';
import { AssessmentService } from '../../../services/assessment.service';
import { data } from 'jquery';



@Component({
  selector: 'app-crmp-summary',
  templateUrl: './crmp-summary.component.html',
  styleUrls: ['./crmp-summary.component.scss']
})
export class CrmpSummaryComponent implements OnInit {
  @Input() title = "CRMP Performance Summary";
  @Input() showNav = true;

  initialized = false;
  dataError = false;

  achievedLevelList = [];
	statsByCategoryList = [];

  riskfwidthvariable;
  riskawidthvariable;
  riskrwidthvariable;
  riskmwidthvariable;

  finalscorevariable;

  riskfscore;
  riskascore;
  riskrscore;
  riskmscore;

  finalscore;
  
  crmpModel;

  createAnswerCountsByLevel;
  // response;
  // crmpSummary;
  // statsByLevel;
  // columnWidthPx = 25;

  // statsByDomain;
  // statsByDomainAtUnderTarget;
  // gridColumnCount = 10;
  // gridColumns = new Array(this.gridColumnCount);
  // @ViewChild("gridChartDataDiv") gridChartData: ElementRef;
  // @ViewChild("gridTiles") gridChartTiles: Array<any>;
  // columnWidthEmitter: BehaviorSubject<number>;

  // whiteText = "rgba(255,255,255,1)";
  // blueText = "rgba(31,82,132,1)";

  // sAxisTicks = [0, 5, 10, 15, 18];
  // maxLevel = 0;
  // answerCountsByLevel = [];
  // answerDistribColorScheme = { domain: ['#28A745', '#DC3545', '#c3c3c3'] };

  // complianceByGoal = [];
  // answerDistribByGoal = [];
  // answerDistribByLevel = [];

 constructor(
   public maturitySvc: MaturityService,
   public CrmpDataSvc: CrmpDataService,
   public navSvc: NavigationService,
   public assessmentSvc: AssessmentService
  ) { 
    //this.columnWidthEmitter = new BehaviorSubject<number>(25);
  }


  ngOnInit(): void {
    
    this.maturitySvc.getResultsData('crmpSiteSummary').subscribe((r:any) => {
      console.log(r)
      r.Grouping_Id;
      console.log(r.Grouping_Id);

      //capture data here
      this.riskfscore = 2;
      this.riskascore = 3;
      this.riskrscore = 4;
      this.riskmscore = 1;

      // final score

      this.finalscore = 1;

      // this.generateAchievedLevel(r);

      // this.finalscore = this.generateAchievedLevel(r);

      // table

      // this.createCountTable(r);

      // this.createAnswerCountsByLevel = [];

      // is this necessary?
      if (r.maturityModels) {
        r.maturityModels.forEach(model => {
          if (model.maturityModelName === 'CRMP') {
            //this.achievedLevel = achievedLevel;
            }
        });
      }
      // this.riskascore = data.arguments.element.achievedLevel.vbosSiteSummary.vbosSiteSummary;
      // let level = levelItem.find(x => x.name == element.level_Name);
      // levelItem.find(x => x.Grouping_Id == element.Grouping_Id);
      });

    // this.finalscorevariable = displayPercent(this.finalscore * 20);
    // this.riskfwidthvariable = displayPercent(this.riskfscore * 20);
    // this.riskawidthvariable = displayPercent(this.riskascore * 20);
    // this.riskrwidthvariable = displayPercent(this.riskrscore * 20);
    // this.riskmwidthvariable = displayPercent(this.riskmscore * 20);

    this.finalscorevariable = displayPercent(20);
    this.riskfwidthvariable = displayPercent(40);
    this.riskawidthvariable = displayPercent(60);
    this.riskrwidthvariable = displayPercent(80);
    this.riskmwidthvariable = displayPercent(20);

  }

    generateAchievedLevel(data) {
      //let outputData = data.filter(obj => obj.modelLevel != "Aggregate");
        // outputData.sort((a, b) => (a.modelLevel > b.modelLevel) ? 1 : -1);
    
        //let levels: number[] = [];
        //outputData.forEach(o => levels.push(o.level)); 
        // Minimum of Entire Data-Set Function
        // this.achievedLevelList = [];
        // outputData.forEach(element => {
        //   achievedLevel += element assessmentLevel;
        //   element["achievedLevel"] = achievedLevel;
        // });  
        let achievedLevel = data.level;
        console.log(achievedLevel);
      return achievedLevel; 
      // return outputData;
    }

    displayPercent = (percent: number) => 
    '${(percent * 100).toFixed(2)}%';
  }

  const displayPercent = (percent: number) => 
'${(percent * 100).toFixed(2)}%';

  // createAnswerCountsByLevel(r: any) {
  //   let levelList = [];

  //   r.crmpSummary.forEach(element => {
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
  //     p.value = element.qc;
  //   });
  //   this.answerCountsByLevel = levelList;
  //   this.findMaxLength();
  // }


  // Past attempts for reference


      // // cmmc example
    // //*********Error here*********
    // this.CrmpDataSvc.getResultsData('crmpSiteSummary').subscribe(
    //   (r: any) => {
    //     this.response = r;

    //     if (r.maturityModels) {
    //       r.maturityModels.forEach(model => {
    //         if (model.maturityModelName === 'CRMP') {
    //           this.crmpModel = model
    //           this.statsByLevel = this.generateStatsByLevel(this.crmpModel.statsByLevel)
    //           this.statsByDomain = this.crmpModel.statsByDomain
    //           this.statsByDomainAtUnderTarget = this.crmpModel.statsByDomainAtUnderTarget;
    //         }
    //       });
    //       window.dispatchEvent(new Event('resize'));
    //     }
    //     this.initialized = true;
    //     window.dispatchEvent(new Event('resize'));
    //   },
    //   error => {
    //     this.dataError = true;
    //     this.initialized = true;
    //     console.log('Site Summary report load Error: ' + (<Error>error).message)
    //   }
    // ), (finish) => {
    // };

    // this.columnWidthEmitter.subscribe(item => {
    //   $(".gridCell").css("width", `${item}px`)
    // })

  // findMaxLength(){
  //   let mLength = 0;
  //   this.answerCountsByLevel.forEach(x =>{
  //     let length = 0;
  //     x.series.forEach(y => {
  //       length += y.value;
  //     });
  //     if(mLength < length){
  //       mLength = length;
  //     }
  //   })
  //   this.maxLevel = mLength;
  // }

  // createAnswerDistribByLevel(r: any) {
  //   let levelList = [];
  //   r.crmpSummary.forEach(element => {
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

  // createComplianceByGoal(r: any) {
  //   let goalList = [];
  //   this.answerDistribByGoal.forEach(element => {
  //     var yesPercent = element.series.find(x => x.name == 'Yes').value;

  //     var goal = { name: element.name, value: Math.round(yesPercent) };
  //     goalList.push(goal);
  //   });

  //   this.complianceByGoal = goalList;
  // }

  // //Horizontal bar chart - Blue from RRA Gaps
  // generateStatsByLevel(data) {
  //   let outputData = data.filter(obj => obj.modelLevel != "Aggregate");
  //   outputData.sort((a, b) => (a.modelLevel > b.modelLevel) ? 1 : -1);
  //   let totalAnsweredCount = 0;
  //   let totalUnansweredCount = 0;
  //   outputData.forEach(element => {
  //     totalUnansweredCount += element.questionUnAnswered;
  //     totalAnsweredCount += element.questionAnswered;
  //     element["totalUnansweredCount"] = totalUnansweredCount;
  //     element["totalAnsweredCount"] = totalAnsweredCount;
  //   });
  //   return outputData;
  // }

  // //
  // getcolumnWidth() {
  //   if (this.gridChartData?.nativeElement != null) {
  //     this.columnWidthPx = this.gridChartData.nativeElement.clientWidth / this.gridColumns.length;
  //     this.columnWidthEmitter.next(this.columnWidthPx);
  //   }
  // }

  // getBarWidth(data) {
  //   return {
  //     'flex-grow': data.questionAnswered / data.questionCount,
  //     //'background': this.getGradient("blue")
  //   };
  // }

  // formatPercent(x: any) {
  //   return x + '%';
  // }





// const displayPercent = (percent: number) => 
// '${(percent * 100).toFixed(2)}%';