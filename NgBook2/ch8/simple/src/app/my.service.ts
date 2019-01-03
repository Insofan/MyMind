import { Injectable } from '@angular/core';

@Injectable({
  providedIn: 'root'
})
export class MyService {
    public getValue(): string {
        return 'a value';
    }
  constructor() { }
}
