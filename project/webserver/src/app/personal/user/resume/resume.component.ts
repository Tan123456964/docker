import { Component, OnInit } from '@angular/core';
import { UserdataService } from '../../service/userdata.service';

@Component({
  selector: 'app-resume',
  templateUrl: './resume.component.html',
  styleUrls: ['./resume.component.css']
})
export class ResumeComponent implements OnInit {
  public resumes = undefined;

  constructor(private data:UserdataService){}

  ngOnInit(): void {
    this.data.resume.subscribe({
      next: (val)=> {
        this.resumes = val;
      }
    })
  }

}
