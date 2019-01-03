import { Injectable } from '@angular/core';

@Injectable({
  providedIn: 'root'
})
export class ApiService {

    get(): void {
        console.log('Getting resource...');
    }

    constructor() {
    }
}
