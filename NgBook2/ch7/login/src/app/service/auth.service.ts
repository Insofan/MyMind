import {Injectable} from '@angular/core';


@Injectable()
export class AuthService {

    constructor() {
    }

    public login(user: string, password: string): boolean {
        if (user === 'user' && password === 'password') {
            localStorage.setItem('username', user);
            return true;
        }
        return false;
    }

    logout(): any {
        localStorage.removeItem('username');
    }

    getUser(): any {
        return localStorage.getItem('username');
    }

    public isLoggedIn(): boolean {
        return this.getUser() !== null;
    }
}
export let AUTH_PROVIDERS: Array<any> = [
    {provide: AuthService, userClass: AuthService}
];
