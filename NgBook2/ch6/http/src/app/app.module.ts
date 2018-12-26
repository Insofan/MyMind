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
import {youTubeSearchInjectables} from './you-tube-search/vendor/you-tube-search.injectables';
import { YouTubeSearchComponent } from './you-tube-search/you-tube-search.component';
import { SearchBoxComponent } from './you-tube-search/search-box/search-box.component';
import { SearchResultComponent } from './you-tube-search/search-result/search-result.component';

@NgModule({
  declarations: [
    AppComponent,
    HomeComponent,
    SimpleHttpComponent,
    YouTubeSearchComponent,
    SearchBoxComponent,
    SearchResultComponent,
  ],
  imports: [
    BrowserModule,
    AppRoutingModule,
    HttpClientModule,
    BrowserAnimationsModule,
    MatCardModule,
    MatButtonModule
  ],
  providers: [youTubeSearchInjectables],
  // providers: [],
  bootstrap: [AppComponent]
})
export class AppModule { }
