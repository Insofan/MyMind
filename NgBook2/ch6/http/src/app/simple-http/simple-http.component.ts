import { Component, OnInit} from '@angular/core';
import { HttpClient, HttpResponse, HttpHandler } from '@angular/common/http';

@Component({
  selector: 'app-simple-http',
  templateUrl: './simple-http.component.html',
  styleUrls: ['./simple-http.component.css']
})
export class SimpleHttpComponent implements OnInit {

  data: Object;
  loading: boolean;
  constructor(private  http: HttpClient) {
  }

  makeRequest(): void {
    this.loading = true;
    this.http.get('http://jsonplaceholder.typicode.com/posts/1').subscribe(
       (res) => {
        this.data = res;
        this.loading = false;
      }
    );
  }

  ngOnInit() {
  }

}
