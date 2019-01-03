import {Injectable, ReflectiveInjector} from '@angular/core';
import {SmallService} from "./small.service";
import {LargeService} from "./large.service";

@Injectable({
  providedIn: 'root'
})
export class ViePortService {


    determineService(): any {
        const w: number = Math.max(document.documentElement.clientWidth, window.innerWidth || 0);

        if (w < 800) {
            return new SmallService();
        }

        return new LargeService();
    }

  constructor() { }
}
