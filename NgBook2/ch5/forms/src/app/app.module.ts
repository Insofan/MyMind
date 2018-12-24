import { BrowserModule } from '@angular/platform-browser';
import { NgModule } from '@angular/core';

import { AppRoutingModule } from './app-routing.module';
import { AppComponent } from './app.component';
import { DemoFormNgModelComponent } from './demo-form-ng-model/demo-form-ng-model.component';
import { HomeComponent } from './home/home.component';
import { NgZorroAntdModule, NZ_I18N, zh_CN } from 'ng-zorro-antd';
import {FormsModule, ReactiveFormsModule} from '@angular/forms';
import { HttpClientModule } from '@angular/common/http';
import { BrowserAnimationsModule } from '@angular/platform-browser/animations';
import { registerLocaleData } from '@angular/common';
import zh from '@angular/common/locales/zh';
import { DemoFormSkuComponent } from './demo-form-sku/demo-form-sku.component';
import { FormBuilderComponent } from './form-builder/form-builder.component';
import { FormValidateComponent } from './form-validate/form-validate.component';
import { EventFormComponent } from './event-form/event-form.component';

registerLocaleData(zh);

@NgModule({
  declarations: [
    AppComponent,
    DemoFormNgModelComponent,
    HomeComponent,
    DemoFormSkuComponent,
    FormBuilderComponent,
    FormValidateComponent,
    EventFormComponent
  ],
  imports: [
    BrowserModule,
    AppRoutingModule,
    NgZorroAntdModule,
    FormsModule,
    HttpClientModule,
    BrowserAnimationsModule,
    ReactiveFormsModule
  ],
  providers: [{ provide: NZ_I18N, useValue: zh_CN }],
  bootstrap: [AppComponent]
})
export class AppModule { }
