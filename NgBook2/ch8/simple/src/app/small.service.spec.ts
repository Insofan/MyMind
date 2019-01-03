import { TestBed } from '@angular/core/testing';

import { SmallService } from './small.service';

describe('SmallService', () => {
  beforeEach(() => TestBed.configureTestingModule({}));

  it('should be created', () => {
    const service: SmallService = TestBed.get(SmallService);
    expect(service).toBeTruthy();
  });
});
