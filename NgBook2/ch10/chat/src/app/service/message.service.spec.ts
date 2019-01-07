import { TestBed } from '@angular/core/testing';
import {Message} from "../model/message.model";
import {User} from "../model/user.model";
import {Thread} from "../model/thread.model";

import { MessageService } from './message.service';

describe('MessageService', () => {
  beforeEach(() => TestBed.configureTestingModule({}));

  it('should be created', () => {
    const service: MessageService = TestBed.get(MessageService);
    expect(service).toBeTruthy();
  });
});
