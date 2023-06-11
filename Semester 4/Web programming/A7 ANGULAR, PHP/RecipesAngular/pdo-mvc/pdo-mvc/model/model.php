<?php

require_once '../repo/DBUtils.php';
require_once 'entity/recipe.php';

class Model {
	private $db;

	public function __construct() {
		$this->db = new DBUtils ();
	}

	public function getRecipe($recipeTitle) {
		$resultset = $this->db->selectRecipe($recipeTitle);
		$recipe = new Recipe($resultset[0]['id'], $resultset[0]['title'], $resultset[0]['author'], $resultset[0]['type'], $resultset[0]['description'],$resultset[0]['ingredients']);
        return $recipe;
	}

	public function getAllRecipes() {
		$resultset = $this->db->selectAllRecipes();
		$recipes = array();
		foreach($resultset as $key=>$val) {
			
			$recipe = new Recipe(array(
                'id' => $val['id'],
                'title' => $val['title'],
                'author' => $val['author'],
                'type' => $val['type'],
                'description' => $val['description'],
                'ingredients' => $val['ingredients']
            ));
	    	array_push($recipes, $recipe);
		}
	    return $recipes;
	}

	public function addRecipe($title, $author, $type, $description, $ingredients){
		return $this->db->addRecipe($title, $author, $type, $description, $ingredients);
	}

	public function updateRecipe($title, $author, $type, $description, $ingredients) {
		return $this->db->updateRecipe($title, $author, $type, $description, $ingredients);
	}

	public function removeRecipe($title) {
		return $this->db->removeRecipe($title);
	}

	public function getFilteredRecipes($type){
		$resultset = $this->db->selectFilteredRecipes($type);
		$recipes = array();
		foreach($resultset as $key=>$val) {
			$recipe = new Recipe(array(
                'id' => $val['id'],
                'title' => $val['title'],
                'author' => $val['author'],
                'type' => $val['type'],
                'description' => $val['description'],
                'ingredients' => $val['ingredients']
            ));
	    	array_push($recipes, $recipe);
		}
		return $recipes;	
	}
}

?>
