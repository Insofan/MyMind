import {Component, Input, OnInit} from '@angular/core';
import {Example} from "../home/example";

@Component({
  selector: 'app-sidebar',
  templateUrl: './sidebar.component.html',
  styleUrls: ['./sidebar.component.css']
})
export class SidebarComponent implements OnInit {
  // @Input() items;
  @Input('items') items: Example[];
  constructor() {
  }

  ngOnInit() {
    console.log("传值 " + this.items[0].label);
  }

}
