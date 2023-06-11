<?php

class Recipe implements JsonSerializable {
	private $recipe;

	public function __construct($recipe) {
		$this->recipe = $recipe;	
	}

	public function getRecipe(){
		return $this->recipe;
	}

	public function setRecipe($recipe){
		$this->recipe = $recipe;
	}

	public function jsonSerialize() {
		return $this->recipe;
    }
}

?>
