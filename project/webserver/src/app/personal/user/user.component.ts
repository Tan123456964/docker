import { Component } from '@angular/core';
import { Router, ActivatedRoute } from '@angular/router';


@Component({
  selector: 'app-user',
  templateUrl: './user.component.html',
  styleUrls:[ './user.component.css']
})
export class UserComponent {

  selectedTab: number = 0;

  constructor(private router: Router, private route: ActivatedRoute) { }

  onTabChange(index: number): void {
    this.selectedTab = index;

    const routes = ['profile', 'resume', 'cat-picture', 'achievement'];
    const route = routes[index];

    if (route) {
      this.router.navigate([route], { relativeTo: this.route });
    }
  }
}