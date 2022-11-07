import { Injectable } from '@angular/core';
import { ConfigService } from './config.service';
import { HttpClient, HttpHeaders, HttpParams } from '@angular/common/http';
import { AssessmentService } from './assessment.service';
import { MaturityModel } from "../models/assessment-info.model";
import { MaturityDomainRemarks, QuestionGrouping } from '../models/questions.model';
const headers = {
  headers: new HttpHeaders().set("Content-Type", "application/json"),
  params: new HttpParams()
};

@Injectable({
  providedIn: 'root'
})
export class MaturityService {



  static currentMaturityModelName: string;

  domains: any[];

  // Array of Options for Consideration
  ofc: any[];


  cmmcData = null;

  /**
   * 
   * @param http 
   * @param configSvc 
   */
  constructor(
    // private assessSvc: AssessmentService,
    private http: HttpClient,
    private configSvc: ConfigService,
    private assessSvc: AssessmentService
  ) {

  }


  maturityModelIsEDM(): boolean {
    if (!MaturityService.currentMaturityModelName && !!this.assessSvc.assessment?.maturityModel) {
      MaturityService.currentMaturityModelName = this.assessSvc.assessment.maturityModel?.modelName;
    };
    return MaturityService.currentMaturityModelName == "EDM";
  }

  maturityModelIsCMMC(): boolean {
    if (!MaturityService.currentMaturityModelName && !!this.assessSvc.assessment?.maturityModel) {
      MaturityService.currentMaturityModelName = this.assessSvc.assessment.maturityModel?.modelName;
    };
    return MaturityService.currentMaturityModelName == "CMMC";
  }

  /**
   * Posts the current selections to the server.
   */
  postSelection(modelName: string) {
    MaturityService.currentMaturityModelName = modelName;
    return this.http.post(
      this.configSvc.apiUrl + "MaturityModel?modelName=" + modelName,
      null,
      headers
    );
  }

  getLevelScoresByGroup() {
    return this.http.get(this.configSvc.apiUrl + "MaturityModel/GetLevelScoresByGroup",
      headers)
  }

  getDomainObservations() {
    return this.http.get(this.configSvc.apiUrl + "MaturityModel/DomainRemarks",
      headers)
  }

  postDomainObservation(group: MaturityDomainRemarks) {
    return this.http.post(
      this.configSvc.apiUrl + "MaturityModel/DomainRemarks",
      group,
      headers
    );
  }

  /**
   * Gets the saved maturity level from the API.
   * If we store this in the assessment service 'assessment' object,
   * there is no need to go to the API for this.
   */
  getLevel() {
    return this.http.get(
      this.configSvc.apiUrl + "MaturityLevel",
      headers
    )
  }

  /**
   * Returns the name of the current target level.
   */
  targetLevelName() {
    const model = this.assessSvc.assessment.maturityModel;
    if (!!this.assessSvc.assessment && !!model.maturityTargetLevel) {
      const l = model.levels.find(x => x.level == this.assessSvc.assessment.maturityModel.maturityTargetLevel);
      if (!!l) {
        return l.label;
      }
      return '???';
    }
    else {
      return '???';
    }
  }

  /**
   * 
   * @param reportId 
   */
  public getResultsData(reportId: string) {
    if (!this.cmmcData) {
      this.cmmcData = this.http.get(this.configSvc.apiUrl + 'reports/' + reportId);
    }
    return this.cmmcData;
  }

  /**
   * 
   */
  public getTargetLevel() {
    return this.http.get(this.configSvc.apiUrl + 'maturity/targetlevel');
  }
  /**
   * 
   */
  public getComplianceByLevel() {
    return this.http.get(this.configSvc.apiUrl + 'results/compliancebylevel');
  }

  /**
   * 
   */
  public getComplianceByDomain() {
    return this.http.get(this.configSvc.apiUrl + 'results/compliancebydomain');
  }

  /**
   * Posts the selected maturity level to the API. 
   * @param level 
   */
  saveLevel(level: number) {
    if (this.assessSvc.assessment) {
      this.assessSvc.assessment.maturityModel.maturityTargetLevel = level;
    }
    return this.http.post(
      this.configSvc.apiUrl + "MaturityLevel",
      level,
      headers
    )
  }


  /**
   * 
   */
  getQuestionsList(installationMode: string, fillEmpty: boolean) {
    return this.http.get(
      this.configSvc.apiUrl
      + "MaturityQuestions?installationMode=" + installationMode + '&fill=' + fillEmpty,
      headers
    );
  }

  /**
   * Calls the MaturityStructure endpoint.  Specifying a domain abbreviation will limit
   * the response to a specific domain.
   */
  getStructure(domainAbbrev: string) {
    var url = this.configSvc.apiUrl + 'MaturityStructure'
    if (domainAbbrev != '') {
      url = url + '?domainAbbrev=' + domainAbbrev;
    }

    return this.http.get(url, headers);
  }

  /**
   * 
   * @param modelName 
   */
  getModel(modelName: string): MaturityModel {
    for (let m of AssessmentService.allMaturityModels) {
      if (m.modelName == modelName)
        return m;
    }
  }

  /**
   * 
   * @param maturityModel 
   */
  getMaturityDeficiency(maturityModel) {
    return this.http.get(this.configSvc.apiUrl + 'getMaturityDeficiencyList?maturity=' + maturityModel);
  }

  /**
   * 
   * @param maturity 
   */
  getCommentsMarked() {
    return this.http.get(this.configSvc.apiUrl + 'getCommentsMarked', headers);
  }

  /**
   * 
   * @param section
   */
  getEdmScores(section) {
    return this.http.get(this.configSvc.apiUrl + 'getEdmScores?section=' + section, headers);
  }

  /**
   * 
   */
  getMatDetailEDMAppendixList() {
    return this.http.get(this.configSvc.apiUrl + 'getEdmNistCsfResults');
  }

  getEdmPercentScores() {
    return this.http.get(this.configSvc.apiUrl + 'getEdmPercentScores')
  }

  getSPRSScore() {
    return this.http.get(this.configSvc.apiUrl + 'SPRSScore');
  }
  /**
   * 
   * @param modelName 
   */
  getReferenceText(modelName) {
    return this.http.get(this.configSvc.apiUrl + 'referencetext?model=' + modelName, headers);
  }

  /**
   * @param maturityModel 
   */
  getGlossary(maturityModel: string) {
    return this.http.get(this.configSvc.apiUrl + 'getGlossary?model=' + maturityModel);
  }


  /**
   * Returns SVG markup for the the specified 
   *    domain abbreviation (AM, SCM, etc)
   *    and MIL (MIL-1, MIL-2) etc.
   * Scaling the SVG to 1.5 gives a nice readable chart.
   */
  getMilHeatmapWidget(domain: string, mil: string) {
    return this.http.get(this.configSvc.reportsUrl + 'api/report/widget/milheatmap?domain=' + domain + '&mil=' + mil + '&scale=1.7',
      { responseType: 'text' }
    );
  }
}
