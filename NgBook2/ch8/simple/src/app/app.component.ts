import {Component, Inject} from '@angular/core';
import {MyService} from './my.service';
import {ParamService} from './param.service';
import {ApiService} from './api.service';
import {ReflectiveInjector} from '@angular/core';
// 为了useInjectors不刷新导入的
import {ViePortService} from './vie-port.service';

@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.css']
})
export class AppComponent {
    title = 'simple';
    myService: MyService;
    // private apiService: ApiService;

    constructor(private paramService: ParamService,
                private  apiService: ApiService,
                @Inject('ApiServiceAlias') private aliasService: ApiService,
                @Inject('SizeService') private sizeService: any) {
        this.myService = new MyService();
        this.apiService = apiService;
    }

    invokeMyService(): void {
        console.log('MyService returned', this.myService.getValue());
    }

    invokeParamService(): void {
        console.log('ParamService returned', this.paramService.getValue());
    }
    invokeInjectService(): void {
        // console.log('Inject returned', this.apiService.get());
        this.apiService.get();
    }

    invokeApi(): void {
        this.apiService.get();
        this.aliasService.get();
        this.sizeService.run();
    }

    useInjectors(): void {
        // 自己创建注入器
        const injector: any = ReflectiveInjector.resolveAndCreate([
            ViePortService,
            {
                provide: 'OtherSizeService',
                useFactory: (viewport: any) => {
                    return viewport.determineService();
                },
                deps: [ViePortService]
            }
        ]);
        const sizeService: any = injector.get('OtherSizeService');
        sizeService.run();
    }
}
