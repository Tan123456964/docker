import { ComponentFixture, TestBed } from '@angular/core/testing';

import { CatPictureComponent } from './cat-picture.component';

describe('CatPictureComponent', () => {
  let component: CatPictureComponent;
  let fixture: ComponentFixture<CatPictureComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [CatPictureComponent]
    })
    .compileComponents();

    fixture = TestBed.createComponent(CatPictureComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
