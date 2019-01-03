import { TestBed } from '@angular/core/testing';

import { LargeService } from './large.service';

describe('LargeService', () => {
  beforeEach(() => TestBed.configureTestingModule({}));

  it('should be created', () => {
    const service: LargeService = TestBed.get(LargeService);
    expect(service).toBeTruthy();
  });
});
