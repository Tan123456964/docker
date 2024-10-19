import { Routes } from '@angular/router';

export const routes: Routes = [
    {
        path: 'personal',
        loadChildren: () => import('./personal/personal.module').then(m => m.PersonalModule)
      },
      { path: '', redirectTo: 'personal/user/profile', pathMatch: 'full' } // Default route to 'profile' inside 'personal
];

