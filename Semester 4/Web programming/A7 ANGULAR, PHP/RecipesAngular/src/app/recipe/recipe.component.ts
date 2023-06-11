import { Component, OnInit } from '@angular/core';
import { Recipe } from '../recipe';
import { GenericService } from '../generic.service';

@Component({
  selector: 'app-recipe',
  templateUrl: './recipe.component.html',
  styleUrls: ['./recipe.component.css'],
})
export class RecipeComponent implements OnInit {
  recipes: Recipe[] = [];

  selectedRecipe?: Recipe;
  errorMessage: string = "";

  type: string = "";

  constructor(private genericService: GenericService) {}
  
  ngOnInit(): void {
    // console.log('ngOnInit called for RecipeComponent');
    this.getRecipes();
  }

  getRecipes(): void {
    //console.log("GET RECIPES: before");
    this.genericService
      .fetchRecipes()
      .subscribe(recipes => this.recipes = recipes);
    //console.log("GET RECIPES: after");
  }

  onSelect(rec: Recipe): void {
    console.log(rec.title + ' by ' + rec.author + ' is selected.');
    this.selectedRecipe = rec;
  }

  UpdateRecipe(recipe: Recipe): void {
    this.errorMessage = "";
    this.genericService.UpdateRecipe(recipe)
      .subscribe(response => {
          let r: any = response;
          this.errorMessage = r.result;
      })
  }

  DeleteRecipe(recipe: Recipe): void {
    this.errorMessage = "";
    this.genericService.DeleteRecipe(recipe)
      .subscribe(response => {
          let r: any = response;
          this.errorMessage = r.result;
      })
  }

  AddRecipe(recipe: Recipe): void {
    this.errorMessage = "";
    let newRecipe : Recipe = {id: recipe.id , title: recipe.title, author: recipe.author, type: recipe.type, description: recipe.description, ingredients: recipe.ingredients};
    this.genericService.AddRecipe(recipe)
      .subscribe(response => {
          let r: any = response;
          this.errorMessage = r.result;
      })
    // his.getRecipes()
  }
  
  filterRecipes(type: string): void {
    this.genericService
      .filterRecipes(type)
      .subscribe(recipes => this.recipes = recipes);
    }

}
