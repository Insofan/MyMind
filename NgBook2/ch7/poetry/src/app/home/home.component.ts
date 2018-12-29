import {Component, OnInit} from '@angular/core';
import {PoetryService} from '../../api/poetry.service';
import {Poetry} from '../../api/poetry.model';

@Component({
    selector: 'app-home',
    templateUrl: './home.component.html',
    styleUrls: ['./home.component.css']
})
export class HomeComponent implements OnInit {
    poetries: Poetry[];
    loading: boolean;

    constructor(private poeServ: PoetryService) {
        console.log('home load');
    }

    ngOnInit() {

    }
    updatePoetries(poetries: Poetry[]): void {
       this.poetries = poetries;
    }
}
