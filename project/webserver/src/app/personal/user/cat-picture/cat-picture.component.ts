import { Component, OnInit } from '@angular/core';
import { UserdataService } from '../../service/userdata.service';

@Component({
  selector: 'app-cat-picture',
  templateUrl: './cat-picture.component.html',
  styleUrls: ['./cat-picture.component.css']
})
export class CatPictureComponent implements OnInit  {

  constructor(private data:UserdataService){}

  public cats = undefined;

  ngOnInit(): void {
    this.data.cat.subscribe({
      next : (val)=>{
        this.cats = val
      }
    })
  }

}
