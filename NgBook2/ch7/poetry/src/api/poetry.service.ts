import { Injectable } from '@angular/core';
import {HttpClient, HttpResponse} from '@angular/common/http';
import {Observable} from 'rxjs';
import {catchError, filter, map} from "rxjs/operators";
import {Poetry} from "./poetry.model";
import {SearchResult} from "../../../../ch6/http/src/app/you-tube-search/search-result/search-result.model";

const baseUrl = 'https://api.apiopen.top/';

@Injectable()

export class PoetryService {

  constructor(private http: HttpClient) {
  }

  public getPoetry(path: string, param: string): Observable<Poetry[]> {
    const getUrl = baseUrl + path + param;
    return this.http.get(getUrl)
      .pipe(
        map((response: HttpResponse<any>) => {
          return (<any>response).result.map((item) => {
            return new Poetry(item);
          });
        }),
      );
  }
}
