import { Injectable } from '@angular/core';
import { HttpClient, HttpHeaders } from '@angular/common/http';

import { Observable, of } from 'rxjs';
import { catchError, map, tap } from 'rxjs/operators';
import { Recipe } from './recipe';

@Injectable({
  providedIn: 'root',
})
export class GenericService {
  private backendUrl = 'http://localhost/A7/RecipesAngular/pdo-mvc/pdo-mvc/controller/controller.php';
  httpOptions = {
    headers: new HttpHeaders({
      'Content-Type': 'application/json',
    }),
  };

  constructor(private http: HttpClient) {}

  fetchRecipes(): Observable<Recipe[]> {
    return this.http
      .get<Recipe[]>(this.backendUrl + '?action=getAllRecipes')
      .pipe(catchError(this.handleError<Recipe[]>('getAllRecipes', [])));
  }

UpdateRecipe(recipe: Recipe): Observable<string> {
  return this.http.get<string>(this.backendUrl+'?action=updateRecipe&title='+
      recipe.title +'&type='+  recipe.type + '&author=' + recipe.author +'&description='+ recipe.description + '&ingredients=' + recipe.ingredients)
      .pipe(catchError(this.handleError<string>('updateRecipe', ""))
  );
}

DeleteRecipe(recipe: Recipe): Observable<string> {
  return this.http.get<string>(this.backendUrl+'?action=removeRecipe&title='+
      recipe.title)
      .pipe(catchError(this.handleError<string>('removeRecipe', ""))
  );
}

AddRecipe(recipe: Recipe): Observable<string> {
  return this.http.get<string>(this.backendUrl+'?action=addRecipe&title='+
      recipe.title + '&author=' + recipe.author + '&type=' + recipe.type + '&description=' + recipe.description + '&ingredients=' + recipe.ingredients)
      .pipe(catchError(this.handleError<string>('addRecipe', ""))
  );
}

  private handleError<T>(operation = 'operation', result?: T) {
    return (error: any): Observable<T> => {
      // TODO: send the error to remote logging infrastructure
      console.error(error); // log to console instead

      // Let the app keep running by returning an empty result.
      return of(result as T);
    };
  }

  filterRecipes(type: string): Observable<Recipe[]> {
    return this.http
      .get<Recipe[]>(this.backendUrl + '?action=getFilteredRecipes&type=' + type)
      .pipe(catchError(this.handleError<Recipe[]>('getFilteredRecipes', [])));
  }

  
}
