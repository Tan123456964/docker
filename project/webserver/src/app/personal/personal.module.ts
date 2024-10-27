import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
// Import the components and services that are part of the personal module
import { UserComponent } from './user/user.component';
import { AchievementComponent } from './user/achievement/achievement.component';
import { ProfileComponent } from './user/profile/profile.component';
import { UserdataService } from './service/userdata.service';
import { ResumeComponent } from './user/resume/resume.component';
import { CatPictureComponent } from './user/cat-picture/cat-picture.component';

// Import external libraries
import {MatTabsModule} from '@angular/material/tabs';
import { MatCardModule } from '@angular/material/card';
import {MatDividerModule} from '@angular/material/divider';

import { RouterModule, Routes } from '@angular/router';

const routes: Routes = [
  {
    path: 'user',
    component: UserComponent , 
    children: [
      { path: 'profile', component: ProfileComponent },
      { path: 'resume', component: ResumeComponent },
      { path: 'cat', component: CatPictureComponent },
      { path: 'achievement', component: AchievementComponent },
      { path: '', redirectTo: 'profile', pathMatch: 'full' } // Redirect to 'profile' by default
    ]
  }
];

@NgModule({
  declarations: [
    UserComponent, 
    AchievementComponent, 
    ProfileComponent, 
    ResumeComponent, 
    CatPictureComponent
  ],
  imports: [
    MatTabsModule,
    RouterModule.forChild(routes),
    CommonModule,
    MatCardModule,
    MatDividerModule
  ],
  providers: [
    UserdataService
  ],
})
export class PersonalModule { }
