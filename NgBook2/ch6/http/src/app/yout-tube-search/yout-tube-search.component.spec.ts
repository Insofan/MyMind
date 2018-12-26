import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { YoutTubeSearchComponent } from './yout-tube-search.component';

describe('YoutTubeSearchComponent', () => {
  let component: YoutTubeSearchComponent;
  let fixture: ComponentFixture<YoutTubeSearchComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ YoutTubeSearchComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(YoutTubeSearchComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
