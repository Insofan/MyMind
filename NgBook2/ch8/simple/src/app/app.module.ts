import { BrowserModule } from '@angular/platform-browser';
import { NgModule } from '@angular/core';

import { AppRoutingModule } from './app-routing.module';
import { AppComponent } from './app.component';
import {MyService} from './my.service';
import {ParamService} from './param.service';
import {ApiService} from './api.service';
import { ViePortService} from "./vie-port.service";

@NgModule({
  declarations: [
    AppComponent
  ],
  imports: [
    BrowserModule,
    AppRoutingModule
  ],
  providers: [MyService, {provide: ParamService, useFactory: (): ParamService => new ParamService('YoLo')},
      {
          provide: 'ApiServiceAlias',
          useExisting: ApiService
      },
      {
          provide: 'SizeService',
          useFactory: (viewport: any) => {
              return viewport.determineService();
          },
          deps: [ViePortService]
      }],
  bootstrap: [AppComponent]
})
export class AppModule { }
