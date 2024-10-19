import { NgModule } from '@angular/core';
import { RouterModule } from '@angular/router';
import { BrowserModule } from '@angular/platform-browser';
import { BrowserAnimationsModule } from '@angular/platform-browser/animations';
import { routes } from './app.routes';
import { AppComponent } from './app.component';


@NgModule({
  declarations: [AppComponent],
  imports: [
    RouterModule.forRoot(routes), 
    BrowserAnimationsModule, 
    BrowserModule
  ], 
  bootstrap: [AppComponent]
})
export class AppRoutingModule { }