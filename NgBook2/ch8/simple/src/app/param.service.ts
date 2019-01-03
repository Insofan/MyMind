import { Injectable } from '@angular/core';

@Injectable({
  providedIn: 'root'
})
export class ParamService {

  constructor(private phrase: string) {
      console.log('ParamService is being created with params', phrase);
  }
  getValue(): string {
      return this.phrase;
  }
}
