import { platformBrowserDynamic } from '@angular/platform-browser-dynamic';
import {AppRoutingModule} from './app/app-routing.module';

platformBrowserDynamic()
.bootstrapModule(AppRoutingModule)
.catch(err => console.error(err));

