import { Component, Input, OnInit, Output, EventEmitter } from '@angular/core';
import { Content } from '../app/personal/service/userdata.service';
import { BehaviorSubject } from 'rxjs';
import { CommonModule } from '@angular/common';


// Import external libraries
import { MatCardModule } from '@angular/material/card';
import {MatDividerModule} from '@angular/material/divider';

@Component({
  selector: 'app-template',
  standalone: true,
  imports:[
    MatCardModule,
    MatDividerModule,
    CommonModule
  ],
  templateUrl: './template.component.html',
  styleUrls: ['./template.component.css']
})
export class TemplateComponent implements OnInit {


  @Input() data: BehaviorSubject<Content[]> = new BehaviorSubject<Content[]>([]); 
  @Input() contentType: string | undefined = undefined

  @Output() content_data = new EventEmitter<Content>()


  public userData:Content[] = []


  ngOnInit(): void {

    this.data.subscribe(c=>
      this.userData = c
    );
    
  }

  public addItem = (item: Content): void => {
    this.content_data.emit(item);
  };

  
  

}
