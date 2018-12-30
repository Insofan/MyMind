import { Component, OnInit } from '@angular/core';
import {AuthService} from '../service/auth.service';

@Component({
  selector: 'app-login',
  templateUrl: './login.component.html',
  styleUrls: ['./login.component.css']
})
export class LoginComponent implements OnInit {
    message: string;

    constructor(private authService: AuthService) {
        this.message = '';
    }

    login(username: string, password: string): boolean {
        this.message = '';
        if (!this.authService.login(username, password)) {
            this.message = 'Incoorect credentials.';
            setTimeout(function () {
                this.message = '';
            }.bind(this), 2500);
        }
        return false;
    }

    logout(): boolean {
        this.authService.logout();
        return false;
    }

    ngOnInit() {
    }

}
