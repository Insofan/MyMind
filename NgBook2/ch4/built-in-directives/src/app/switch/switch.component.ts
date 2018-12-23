import { Component, OnInit } from '@angular/core';

@Component({
  selector: 'app-switch',
  templateUrl: './switch.component.html',
  styleUrls: ['./switch.component.css']
})
export class SwitchComponent implements OnInit {
  choice: number;
  constructor() {
    this.choice = 1;
  }

  ngOnInit() {
  }

  nextChoice() {
    this.choice++;
    console.log(this.choice);
    if (this.choice > 5) {
      this.choice = 1;
    }
  }

}
