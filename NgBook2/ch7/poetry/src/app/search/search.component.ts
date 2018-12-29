import {Component, ElementRef, EventEmitter, OnInit, Output} from '@angular/core';
import {Poetry} from "../../api/poetry.model";
import {PoetryService} from "../../api/poetry.service";
import {fromEvent} from "rxjs";
import {debounceTime, filter, map, switchAll, tap} from "rxjs/operators";
import {SearchResult} from "../../../../../ch6/http/src/app/you-tube-search/search-result/search-result.model";

@Component({
    selector: 'app-search',
    templateUrl: './search.component.html',
    styleUrls: ['./search.component.css']
})
export class SearchComponent implements OnInit {
    @Output() loading: EventEmitter<boolean> = new EventEmitter<boolean>();
    @Output() Poetries: EventEmitter<Poetry[]> = new EventEmitter<Poetry[]>();

    constructor(private apiService: PoetryService, private el: ElementRef) {
        // private el: ElementRef
    }
    /*
        fromEvent(this.el.nativeElement, 'keyup')
      .pipe(
        map((e: any) => e.target.value), // extract the value of the input
        filter((text: string) => text.length > 1), // filter out if empty
        debounceTime(250), // only search after 250 ms
        tap(() => this.loading.emit(true)), // Enable loading
        // search, call the search service
        // discard old events if new input comes in
        switchAll(),
        // act on the return of the search
      ).subscribe(
      (results: SearchResult[]) => {
        this.loading.emit(false);
        this.results.emit(results);
      },
      (err: any) => { // on error
        console.log(err);
        this.loading.emit(false);
      },
      () => { // on completion
        this.loading.emit(false);
      }
    );

       console.log('home load');

        const res = this.poeServ.getPoetry(queStr, para);
        res.subscribe((response: Poetry[]) => {
                this.poetries = response;
            }
        );
     */

    ngOnInit() {
        const queUrl = 'searchPoetry?name=';
        // fromEvent(this.el.nativeElement, 'keyup')
        fromEvent(this.el.nativeElement, 'keyup')
            .pipe(
                map((e: any) => e.target.value),
                filter((text: string) => text.length > 1),
                debounceTime(300), // only search after 250 ms
                tap(() => this.loading.emit(true)),
                map((text: string) => this.apiService.getPoetry(queUrl, text)),
                switchAll(),
            ).subscribe(
                (results: Poetry[]) => {
                    this.loading.emit(false);
                    this.Poetries.emit(results);
                },
                (err: any) => { // on error
                    console.log(err);
                    this.loading.emit(false);
                },
                () => { // on completion
                    this.loading.emit(false);
                }
            );

    }
}
