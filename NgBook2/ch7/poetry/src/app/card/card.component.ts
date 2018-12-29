import {Component, Input, OnInit} from '@angular/core';
import {Poetry} from '../../api/poetry.model';
import {SearchResult} from "../../../../../ch6/http/src/app/you-tube-search/search-result/search-result.model";

@Component({
  selector: 'app-card',
  templateUrl: './card.component.html',
  styleUrls: ['./card.component.css']
})
export class CardComponent implements OnInit {
    @Input() poetry: Poetry;

    constructor() {
    }

    ngOnInit() {
        console.log('card: ' + this.poetry.title.toString());
    }

}
