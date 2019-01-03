import { Injectable } from '@angular/core';

@Injectable({
  providedIn: 'root'
})
export class LargeService {
    run(): void {
        console.log('Large service...');
    }
  constructor() { }
}
