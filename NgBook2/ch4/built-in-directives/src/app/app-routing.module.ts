import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import {Route, RouterModule} from "@angular/router";
import {IntroComponent} from "./intro/intro.component";
import {NgForComponent} from "./ng-for/ng-for.component";

const routes: Routes = [
  {path: "", component: IntroComponent},
  {path: "ng-for", component: NgForComponent}
];
@NgModule({
  declarations: [],
  imports: [
    // CommonModule
    RouterModule.forRoot(routes)
  ],
  exports: [RouterModule]
})
export class AppRoutingModule { }
