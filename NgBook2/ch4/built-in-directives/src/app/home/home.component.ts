import { Component, OnInit } from '@angular/core';
import {Example} from "./example";
import {IntroComponent} from "../intro/intro.component";
import {NgForComponent} from "../ng-for/ng-for.component";
import {SwitchComponent} from "../switch/switch.component";
import {NgStyleComponent} from "../ng-style/ng-style.component";
import {NgClassComponent} from "../ng-class/ng-class.component";
import {NgNonBindableComponent} from "../ng-non-bindable/ng-non-bindable.component";

@Component({
  selector: 'app-home',
  templateUrl: './home.component.html',
  styleUrls: ['./home.component.css']
})


export class HomeComponent implements OnInit {
  examples: Example[];
  testVal: string;

  constructor() {
    this.examples = [
      {label: 'Intro',          name: 'Root',          path: '',                component: IntroComponent},
      {label: 'Ng-For',          name: 'For',          path: 'ng-for',                component: NgForComponent},
      {label: 'NgSwitch',       name: 'NgSwitch',      path: 'ng-switch',       component:  SwitchComponent},
      {label: 'NgStyle',        name: 'NgStyle',       path: 'ng-style',        component:  NgStyleComponent},
      {label: 'NgClass',        name: 'NgClass',       path: 'ng-class',        component:  NgClassComponent},
      {label: 'NgNonBindable',  name: 'NgNonBindable', path: 'ng-non', component:  NgNonBindableComponent},
    ];

    this.testVal = "test test";

  }

  ngOnInit() {
  }

}
