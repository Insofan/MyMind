import { Injectable } from '@angular/core';
import {HttpClient} from '@angular/common/http';

export const YOUTUBE_API_KEY = 'AIzaSyDOfT_BO81aEZScosfTYMruJobmpjqNeEk';
export const YOUTUBE_API_URL = 'https://www.googleapis.com/youtube/v3/search';

@Injectable({
    providedIn: 'root'
})
export class YouTubeSearchService {

    constructor(private http: HttpClient,
                @Injectable(YOUTUBE_API_KEY) private apiKey: string,
                @Injectable(YOUTUBE_API_URL) private apiUrl: string) {

    }
}
