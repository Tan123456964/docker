import { Component, OnInit } from '@angular/core';
import { Router, ActivatedRoute } from '@angular/router';


@Component({
  selector: 'app-user',
  templateUrl: './user.component.html',
  styleUrls:[ './user.component.css']
})
export class UserComponent implements OnInit {

  selectedTab: number = 0;
  tabs = ['profile', 'resume', 'cat', 'achievement'];

  constructor(private router: Router, private route: ActivatedRoute) { }


  ngOnInit(): void {
    //TODO: page refrech should load content of the current tab, not default tab (profile)
  }

  
  onTabChange(index: number): void {
    this.selectedTab = index;
    const route = this.tabs[this.selectedTab];

    if (route) {
      this.router.navigate([route], { relativeTo: this.route });
    }
  }
}