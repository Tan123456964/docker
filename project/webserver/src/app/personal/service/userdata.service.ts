import { Injectable } from '@angular/core';
import { BehaviorSubject } from 'rxjs';
import { HttpClient } from '@angular/common/http';

@Injectable({
  providedIn: 'root'
})
export class UserdataService {

  public profile = new BehaviorSubject<any>({})
  public resume = new BehaviorSubject<any>({})
  public cat = new BehaviorSubject<any>({})
  public achievement = new BehaviorSubject<any>({})


  constructor( private http:HttpClient) {
    this.getCatPictures();
    this.getProfileInfo();
    this.getResumes();
    this.getAchievement();
   }

   private getCatPictures = () => {
    this.http.get<any>('/api/cat').subscribe({
      next: (val) => {
        this.cat.next(val);
      },
      error: (err) => {
        this.cat.next({});
        console.error('Error fetching data for cat API:', err);
      },
      complete: () => {
        console.log('Cat data fetching complete');
      }
    });
  };


  private getProfileInfo = () => {
    this.http.get<any>('/api/profile').subscribe({
      next: (val) => {
        this.profile.next(val);
      },
      error: (err) => {
        this.profile.next({});
        console.error('Error fetching data for profile API:', err);
      },
      complete: () => {
        console.log('Profile data fetching complete');
      }
    });
  };

  private getResumes = () => {
    this.http.get<any>('/api/resume').subscribe({
      next: (val) => {
        this.resume.next(val);
      },
      error: (err) => {
        this.resume.next({});
        console.error('Error fetching data for resume API:', err);
      },
      complete: () => {
        console.log('Resume data fetching complete');
      }
    });
  };

  private getAchievement = () =>{
    this.http.get<any>('/api/achievement').subscribe({
      next: (val)=>{
        this.achievement.next(val)
      },
      error: (err) =>{
        this.achievement.next({})
        console.error('Error fetching data for achievement API:', err);
      },
      complete: ()=>{
        console.log('Achievement data fetching complete');
      }
    })
  }

  
}
