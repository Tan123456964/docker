import { Component, OnInit } from '@angular/core';
import { UserdataService } from '../../service/userdata.service';

@Component({
  selector: 'app-achievement',
  templateUrl: './achievement.component.html',
  styleUrls: ['./achievement.component.css']
})
export class AchievementComponent implements OnInit {

  public achivement = undefined

  constructor(private data:UserdataService){}


  ngOnInit(): void {
    this.data.achievement.subscribe({
      next: (val)=>{
        this.achivement = val
      }
    })
  }


}
