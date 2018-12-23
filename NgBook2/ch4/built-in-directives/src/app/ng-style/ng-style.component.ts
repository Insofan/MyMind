import { Component, OnInit } from '@angular/core';

@Component({
  selector: 'app-ng-style',
  templateUrl: './ng-style.component.html',
  styleUrls: ['./ng-style.component.css']
})
export class NgStyleComponent implements OnInit {

  fontSize: number;
  style: {
    'background-color': string,
    'border-radius': string,
    border?: string,
    width?: string,
    height?: string
  };
  color: string;
  constructor() {
    this.fontSize = 26;
    this.style = {
      'background-color': '#ccc',
      'border-radius': '50px',
      'height': '30px',
      'width': '30px'
    };
    this.color = 'blue';
  }

  apply(color: string, input: number) {
    this.color = color;
    this.fontSize = input;
  }

  ngOnInit() {
  }

}
