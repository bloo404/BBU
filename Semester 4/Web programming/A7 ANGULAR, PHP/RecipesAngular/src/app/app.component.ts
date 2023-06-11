import { Component } from '@angular/core';

@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.scss']
})
export class AppComponent {
  author = 'Jaclina-Iana Bulat';
  title = 'Recipes';
  showRecipesPanel = false;
  showRecipesCaption = 'Show recipes';
  
  OnClickShowRecipes() : void {
  	  this.showRecipesPanel = !this.showRecipesPanel;
  	  if (this.showRecipesPanel) {
          //this.showRecipesPanel = false;
  	  	  this.showRecipesCaption = 'Hide recipes';
  	  } else {
  	  		this.showRecipesCaption = 'Show recipes';
  	  }
  }
}
