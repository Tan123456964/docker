import { NgModule } from "@angular/core";
import { AppComponent } from "./app.component";
import { BrowserModule } from '@angular/platform-browser';
import { AppRoutingModule } from './app-routing.module';
import {BrowserAnimationsModule} from '@angular/platform-browser/animations';
import { provideAnimationsAsync } from '@angular/platform-browser/animations/async';
import { provideHttpClient } from "@angular/common/http";

@NgModule({ 
    declarations: [AppComponent],
    imports: [
      BrowserModule, 
      AppRoutingModule, 
      BrowserAnimationsModule,
    ],
    bootstrap: [AppComponent],
    providers: [
      provideHttpClient(),
      provideAnimationsAsync()
    ]
    
})
export class AppModule { }