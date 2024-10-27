import { Component, OnInit } from '@angular/core';
import { UserdataService } from '../../service/userdata.service';

@Component({
  selector: 'app-profile',
  templateUrl: './profile.component.html',
  styleUrls: ['./profile.component.css']
})
export class ProfileComponent implements OnInit {

  public profiles = undefined;

  constructor(private data:UserdataService){}

  ngOnInit(): void {
    this.data.profile.subscribe({
      next: (val)=>{
        this.profiles = val;
      }
    })
  }

}
