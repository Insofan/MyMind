import { TestBed } from '@angular/core/testing';

import { PoetryService } from './poetry.service';

describe('PoetryService', () => {
  beforeEach(() => TestBed.configureTestingModule({}));

  it('should be created', () => {
    const service: PoetryService = TestBed.get(PoetryService);
    expect(service).toBeTruthy();
  });
});
