import { Injectable, Inject } from '@angular/core';
import {HttpClient, HttpResponse} from '@angular/common/http';
import {Observable, pipe} from "rxjs";
import {SearchResult} from "./search-result.model";
import {catchError, map} from "rxjs/operators";

export const YOUTUBE_API_KEY = 'AIzaSyDOfT_BO81aEZScosfTYMruJobmpjqNeEk';
export const YOUTUBE_API_URL = 'https://www.googleapis.com/youtube/v3/search';

@Injectable()
export class YouTubeSearchService {

    constructor(private http: HttpClient,
                @Inject(YOUTUBE_API_KEY) private apiKey: string,
                @Inject(YOUTUBE_API_URL) private apiUrl: string) {
    }

  search(query: string): Observable<SearchResult[]> {
    const params: string = [
      `q=${query}`,
      `key=${this.apiKey}`,
      `part=snippet`,
      `type=video`,
      `maxResults=10`
    ].join('&');
    const queryUrl = `${this.apiUrl}?${params}`;

    return this.http.get(queryUrl)
      .pipe(
        map((response: HttpResponse<any>) => {
          return (<any>response).items
            .pipe(
              map( item => {
                console.log('search item: ', item);
                return new SearchResult({
                  // id: item.id.videoId,
                  // title: item.snippet.title,
                  // description: item.snippet.description,
                  // thumbnailUrl: item.snippet.thumbnails.high.url
                });
              })
            );
        })
      );
  }


}
