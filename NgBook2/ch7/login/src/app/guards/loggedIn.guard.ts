import {Injectable} from "@angular/core";
import {CanActivate} from "@angular/router";
import {AuthService} from "../service/auth.service";

// 实现CanActivate 接口, 用这个来控制守护路由
@Injectable()
export class LoggedInGuard implements CanActivate {
    constructor(private authService: AuthService) {}

    canActivate(): boolean {
        return this.authService.isLoggedIn();
    }
}