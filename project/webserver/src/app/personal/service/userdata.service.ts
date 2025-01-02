import { Injectable } from '@angular/core';
import { BehaviorSubject } from 'rxjs';
import { HttpClient } from '@angular/common/http';

export class Content {
  id: number | undefined = undefined;
  name: string | undefined = undefined;
  picture: string | undefined = undefined;
  created_at: string | undefined = undefined;
  version: string | undefined = undefined;
  filename: string | undefined = undefined;

  constructor(
    id?: number,
    name?: string,
    picture?: string,
    created_at?: string,
    version?: string,
    filename?:string
  ) {
    this.id = id;
    this.name = name;
    this.picture = picture;
    this.created_at = created_at;
    this.version = version;
    this.filename = filename
  }
}



@Injectable({
  providedIn: 'root'
})

export class UserdataService {

  public profile = new BehaviorSubject<Content[]>([])
  public resume = new BehaviorSubject<Content[]>([])
  public cat = new BehaviorSubject<Content[]>([])
  public achievement = new BehaviorSubject<Content[]>([])


  constructor( private http:HttpClient) {
    this.getCatPictures();
    this.getProfileInfo();
    this.getResumes();
    this.getAchievement();
   }

   private getCatPictures = () => {
    this.http.get<Content[]>('/api/cat').subscribe({
      next: (val:Content[]) => {
        this.cat.next(val);
      },
      error: (err) => {
        this.cat.next([]);
        console.error('Error fetching data for cat API:', err);
      },
      complete: () => {
        console.log('Cat data fetching complete');
      }
    });
  };


  private getProfileInfo = () => {
    this.http.get<Content[]>('/api/profile').subscribe({
      next: (val:Content[]) => {
        this.profile.next(val);
      },
      error: (err) => {
        this.profile.next([]);
        console.error('Error fetching data for profile API:', err);
      },
      complete: () => {
        console.log('Profile data fetching complete');
      }
    });
  };

  private getResumes = () => {
    this.http.get<Content[]>('/api/resume').subscribe({
      next: (val:Content[]) => {
        this.resume.next(val);
      },
      error: (err) => {
        this.resume.next([]);
        console.error('Error fetching data for resume API:', err);
      },
      complete: () => {
        console.log('Resume data fetching complete');
      }
    });
  };

  private getAchievement = () =>{
    this.http.get<Content[]>('/api/achievement').subscribe({
      next: (val:Content[])=>{
        this.achievement.next(val)
      },
      error: (err) =>{
        this.achievement.next([])
        console.error('Error fetching data for achievement API:', err);
      },
      complete: ()=>{
        console.log('Achievement data fetching complete');
      }
    })
  }

  
}
