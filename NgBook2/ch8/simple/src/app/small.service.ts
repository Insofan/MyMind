import { Injectable } from '@angular/core';

@Injectable({
  providedIn: 'root'
})
export class SmallService {
    run(): void {
        console.log('Small service...');
    }
  constructor() { }
}
