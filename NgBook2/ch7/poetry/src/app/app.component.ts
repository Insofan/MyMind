import {Component} from '@angular/core';
import {PoetryService} from '../api/poetry.service';


@Component({
    selector: 'app-root',
    templateUrl: './app.component.html',
    styleUrls: ['./app.component.css']
})
export class AppComponent {
    title = 'poetry';

    constructor(private poeServ: PoetryService) {
    }
}
