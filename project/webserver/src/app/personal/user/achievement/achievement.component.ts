import { Component, OnInit } from '@angular/core';
import { UserdataService } from '../../service/userdata.service';
import { Content } from '../../service/userdata.service';
import { BehaviorSubject } from 'rxjs';

@Component({
  selector: 'app-achievement',
  templateUrl: './achievement.component.html',
  styleUrls: ['./achievement.component.css']
})
export class AchievementComponent implements OnInit {

  public achivements: BehaviorSubject<Content[]> = new BehaviorSubject<Content[]>([]);
  public contentType = "Achivement"

  constructor(private data:UserdataService){}


  ngOnInit(): void {
    this.data.achievement.subscribe({
      next: (val)=>{
        this.achivements.next(val)
      }
    })
  }


}
