export class Poetry {
  title: string;
  content: string;
  authors: string;

  constructor(obj?: any) {
    this.title = obj && obj.title || null;
    this.content = obj && obj.content || null;
    this.authors = obj && obj.authors || null;
  }
}
