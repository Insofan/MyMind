import { NgModule } from '@angular/core';
import {CommonModule, NgSwitch} from '@angular/common';
import {Route, RouterModule, Routes} from "@angular/router";
import {IntroComponent} from "./intro/intro.component";
import {NgForComponent} from "./ng-for/ng-for.component";
import {HomeComponent} from "./home/home.component";
import {Example} from "./home/example";
import {SwitchComponent} from "./switch/switch.component";
import {NgStyleComponent} from "./ng-style/ng-style.component";
import {NgClassComponent} from "./ng-class/ng-class.component";
import {NgNonBindableComponent} from "./ng-non-bindable/ng-non-bindable.component";

const routes: Routes = [
  {path: "", component: IntroComponent},
  {path: "ng-for", component: NgForComponent},
  {path: "ng-switch", component: SwitchComponent},
  {path: "ng-style", component: NgStyleComponent},
  {path: "ng-class", component: NgClassComponent},
  {path: "ng-non", component: NgNonBindableComponent},
];

// const homeCom = new HomeComponent();
// const routes: Routes = homeCom.examples.map((example: Example) => ({
// path: example.path, component: example.component
// }));

@NgModule({
  declarations: [],
  imports: [
    // CommonModule
    RouterModule.forRoot(routes)
  ],
  exports: [RouterModule]
})
export class AppRoutingModule { }
