import { Component, OnInit } from '@angular/core';
import { UserdataService } from '../../service/userdata.service';
import { Content } from '../../service/userdata.service';
import { BehaviorSubject } from 'rxjs';

@Component({
  selector: 'app-resume',
  templateUrl: './resume.component.html',
  styleUrls: ['./resume.component.css']
})
export class ResumeComponent implements OnInit {
  public resumes: BehaviorSubject<Content[]> = new BehaviorSubject<Content[]>([]);
  public contentType = "Resume"

  constructor(private data:UserdataService){}

  ngOnInit(): void {
    this.data.resume.subscribe({
      next: (val)=> {
        this.resumes.next(val)
      }
    })
  }

}
