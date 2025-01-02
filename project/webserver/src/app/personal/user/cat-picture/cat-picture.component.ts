import { Component, OnInit } from '@angular/core';
import { UserdataService } from '../../service/userdata.service';
import { Content } from '../../service/userdata.service';
import { BehaviorSubject } from 'rxjs';

@Component({
  selector: 'app-cat-picture',
  templateUrl: './cat-picture.component.html',
  styleUrls: ['./cat-picture.component.css']
})
export class CatPictureComponent implements OnInit  {

  constructor(private data:UserdataService){}

  public cats: BehaviorSubject<Content[]> = new BehaviorSubject<Content[]>([]);
  public contentType = "Cats"

  ngOnInit(): void {
    this.data.cat.subscribe({
      next : (val)=>{
        this.cats.next(val)
      }
    })
  }

}
