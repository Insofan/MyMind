import {Component, HostBinding, Input, OnInit} from '@angular/core';
import {Article} from './article.model';

@Component({
  selector: 'app-article',
  templateUrl: './article.component.html',
  styleUrls: ['./article.component.css'],
  host: {
    // 对宿主传递, 在宿主元素上设置class属性为row
    class: 'row'
  }
})
export class ArticleComponent implements OnInit {
  @Input() article: Article;
  // article: Article;
  constructor() {
    this.article = new Article(
      'Angular 2',
      'http://angular.io',
      10);
  }

  voteUp(): boolean {
    this.article.voteUp();
    // 高速浏览器不要向上冒泡
    return false;
  }

  voteDown(): boolean {
    this.article.voteDown();
    // 高速浏览器不要向上冒泡
    return false;
  }

  ngOnInit() {
  }

}
