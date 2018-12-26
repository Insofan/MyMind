import { BrowserModule } from '@angular/platform-browser';
import { NgModule } from '@angular/core';

import { AppRoutingModule } from './app-routing.module';
import { AppComponent } from './app.component';
import { HttpClientModule} from '@angular/common/http';
import {HomeComponent} from './home/home.component';
import { SimpleHttpComponent } from './simple-http/simple-http.component';
import {BrowserAnimationsModule} from '@angular/platform-browser/animations';
import {MatCardModule} from '@angular/material';
import {MatButtonModule} from '@angular/material';
import { YoutTubeSearchComponent } from './yout-tube-search/yout-tube-search.component';
import {youTubeSearchInjectables} from "./yout-tube-search/you-tube-search.injectables";

@NgModule({
  declarations: [
    AppComponent,
    HomeComponent,
    SimpleHttpComponent,
    YoutTubeSearchComponent
  ],
  imports: [
    BrowserModule,
    AppRoutingModule,
    HttpClientModule,
    BrowserAnimationsModule,
    MatCardModule,
    MatButtonModule
  ],
  providers: [],
  bootstrap: [AppComponent]
})
export class AppModule { }
