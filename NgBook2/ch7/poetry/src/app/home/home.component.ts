import { Component, OnInit } from '@angular/core';
import {PoetryService} from '../../api/poetry.service';
import {Poetry} from '../../api/poetry.model';

@Component({
  selector: 'app-home',
  templateUrl: './home.component.html',
  styleUrls: ['./home.component.css']
})
export class HomeComponent implements OnInit {
    poetries: Poetry[];
  constructor(private poeServ: PoetryService) {
    console.log('home load');
  }

  ngOnInit() {
    console.log('home load');
      const queStr = 'searchPoetry?name=';
      const para = '将进酒';
      const res = this.poeServ.getPoetry(queStr, para);
      res.subscribe((response: Poetry[]) => {
              this.poetries = response;
          }
      );
  }
}
