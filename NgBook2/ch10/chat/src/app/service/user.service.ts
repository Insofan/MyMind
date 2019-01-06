import {Injectable} from '@angular/core';
import {BehaviorSubject, Subject} from "rxjs";
import {User} from "../model/user.model";

@Injectable()
export class UserService {
    /**
     * 因为发送消息是即时的, 所以最新的订阅者中会有丢失流中最新值的风险, this is a side affect, but BehaviourSubject patch this issue.
     */
    currentUser: Subject<User> = new BehaviorSubject<User>(null);

    public setCurrentUser(newUser: User): void {
        this.currentUser.next(newUser);
    }

    constructor() {
    }
}

export var userServiceInjectables: Array<any> = [
    UserService
];
