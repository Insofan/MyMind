import { Component, OnInit } from '@angular/core';
import {Example} from "./example";
import {IntroComponent} from "../intro/intro.component";

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
      {label: 'Intro',          name: 'Root',          path: '',                component: IntroComponent}
      // {label: 'NgFor',          name: 'NgFor',         path: 'ng_for',          component: NgForSampleApp },
      // {label: 'NgSwitch',       name: 'NgSwitch',      path: 'ng_switch',       component: NgSwitchSampleApp },
      // {label: 'NgStyle',        name: 'NgStyle',       path: 'ng_style',        component: NgStyleSampleApp },
      // {label: 'NgClass',        name: 'NgClass',       path: 'ng_class',        component: NgClassSampleApp },
      // {label: 'NgNonBindable',  name: 'NgNonBindable', path: 'ng_non_bindable', component: NgNonBindableSampleApp },
    ];

    this.testVal = "test test";

  }

  ngOnInit() {
  }

}
