import { TestBed } from '@angular/core/testing';

import { ViePortService } from './vie-port.service';

describe('ViePortService', () => {
  beforeEach(() => TestBed.configureTestingModule({}));

  it('should be created', () => {
    const service: ViePortService = TestBed.get(ViePortService);
    expect(service).toBeTruthy();
  });
});
