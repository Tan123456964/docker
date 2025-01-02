import { Component, OnInit } from '@angular/core';
import { UserdataService } from '../../service/userdata.service';
import { Content } from '../../service/userdata.service';
import { BehaviorSubject } from 'rxjs';

@Component({
  selector: 'app-profile',
  templateUrl: './profile.component.html',
  styleUrls: ['./profile.component.css']
})
export class ProfileComponent implements OnInit {

  public profiles: BehaviorSubject<Content[]> = new BehaviorSubject<Content[]>([]);
  public contentType = "Profiles"

  constructor(private data:UserdataService){}

  ngOnInit(): void {
    this.data.profile.subscribe({
      next: (val)=>{
        this.profiles.next(val);
      }
    })
  }

}
