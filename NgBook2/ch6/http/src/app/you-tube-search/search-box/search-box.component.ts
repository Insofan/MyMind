import {Component, ElementRef, EventEmitter, OnInit, Output} from '@angular/core';
import {SearchResult} from "../search-result/search-result.model";
import { fromEvent } from 'rxjs';
import {map, filter, debounceTime, tap, switchAll} from 'rxjs/operators';
import {YouTubeSearchService} from '../vendor/you-tube-search.service';

@Component({
  selector: 'app-search-box',
  templateUrl: './search-box.component.html',
  styleUrls: ['./search-box.component.css']
})
export class SearchBoxComponent implements OnInit {
  @Output() loading: EventEmitter<boolean> = new EventEmitter<boolean>();
  @Output() results: EventEmitter<SearchResult[]> = new EventEmitter<SearchResult[]>();

  constructor(private  youtube: YouTubeSearchService,
              private el: ElementRef) {
  }

  ngOnInit() {
    fromEvent(this.el.nativeElement, 'keyup')
      .pipe(
        map((e: any) => e.target.value), // extract the value of the input
        filter((text: string) => text.length > 1), // filter out if empty
        debounceTime(250), // only search after 250 ms
        tap(() => this.loading.emit(true)), // Enable loading
        // search, call the search service
        map((query: string) => this.youtube.search(query)),
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
  }
}
