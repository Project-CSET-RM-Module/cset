////////////////////////////////
//
//   Copyright 2023 Battelle Energy Alliance, LLC
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.
//
////////////////////////////////
import { HttpClient, HttpHeaders, HttpParams } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { ConfigService } from './config.service';
import { Vendor } from '../models/diagram-vulnerabilities.model';

const headers = {
  headers: new HttpHeaders()
    .set('Content-Type', 'application/json'),
  params: new HttpParams()
};

@Injectable()
export class DiagramService {
  apiUrl: string;
  id: number;
  csafVendors: Vendor[] = [];

  constructor(private http: HttpClient, private configSvc: ConfigService) {
    this.apiUrl = this.configSvc.apiUrl + 'diagram/';
  }

  // calls to retrieve static data
  getSymbols() {
    return this.http.get(this.apiUrl + 'symbols/get');
  }

  saveComponent(component) {
    return this.http.post(this.apiUrl + 'saveComponent', component, headers)
  }

  getAllSymbols() {
    return this.http.get(this.apiUrl + 'symbols/getAll');
  }

  // get diagram components
  getDiagramComponents() {
    return this.http.get(this.apiUrl + 'getComponents');
  }

  getDiagramZones() {
    return this.http.get(this.apiUrl + 'getZones');
  }

  getDiagramShapes() {
    return this.http.get(this.apiUrl + 'getShapes');
  }

  getDiagramText() {
    return this.http.get(this.apiUrl + 'getTexts');
  }

  getDiagramLinks() {
    return this.http.get(this.apiUrl + 'getLinks');
  }

  getDiagramWarnings() {
    return this.http.get(this.configSvc.apiUrl + 'analysis/NetworkWarnings');
  }

  getExport(): any {
    return this.http.get(this.apiUrl + 'exportExcel', { responseType: 'blob' });
  }

  getVulnerabilities() {
    return this.http.get(this.apiUrl + 'vulnerabilities');
  }

  saveCsafVendor(vendor: Vendor) {
    return this.http.post(this.apiUrl + 'vulnerabilities/saveVendor', vendor, headers);
  }

  deleteCsafVendor(vendorName: string) {
    return this.http.post(this.apiUrl + 'vulnerabilities/deleteVendor?vendorName=' + vendorName, '');
  }

  deleteCsafProduct(vendorName: string, productName: string) {
    return this.http.post(this.apiUrl + 'vulnerabilities/deleteProduct?vendorName=' + vendorName + '&productName=' + productName, '');
  }
}
