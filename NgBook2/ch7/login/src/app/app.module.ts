import { BrowserModule } from '@angular/platform-browser';
import { NgModule } from '@angular/core';

import { AppRoutingModule } from './app-routing.module';
import { AppComponent } from './app.component';
import { NgZorroAntdModule, NZ_I18N, en_US } from 'ng-zorro-antd';
import { FormsModule } from '@angular/forms';
import { HttpClientModule } from '@angular/common/http';
import { NoopAnimationsModule } from '@angular/platform-browser/animations';
import {HashLocationStrategy, registerLocaleData} from '@angular/common';
import en from '@angular/common/locales/en';
import { LoginComponent } from './login/login.component';
import {AUTH_PROVIDERS, AuthService} from './service/auth.service';
import {LoggedInGuard} from './guards/loggedIn.guard';
import {ProtectedComponent} from './protected/protected.component';
import {HomeComponent} from './home/home.component';
import {AboutComponent} from './about/about.component';
import {ContactComponent} from './contact/contact.component';
import { ProductsComponent } from './products/products.component';
import { MainComponent } from './main/main.component';
import { ByIdComponent } from './by-id/by-id.component';

registerLocaleData(en);

@NgModule({
  declarations: [
    AppComponent,
    LoginComponent,
    ProtectedComponent,
    HomeComponent,
    AboutComponent,
    ContactComponent,
    ProductsComponent,
    MainComponent,
    ByIdComponent
  ],
  imports: [
    BrowserModule,
    AppRoutingModule,
    NgZorroAntdModule,
    FormsModule,
    HttpClientModule,
    NoopAnimationsModule
  ],
  providers: [{ provide: NZ_I18N, useValue: en_US }, AUTH_PROVIDERS,  {provide: localStorage, useClass: HashLocationStrategy}, LoggedInGuard, AuthService],
  bootstrap: [AppComponent]
})
export class AppModule { }
