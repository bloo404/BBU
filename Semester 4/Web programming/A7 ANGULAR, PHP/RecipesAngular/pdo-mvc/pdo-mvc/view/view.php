<?php

require_once '../model/entity/recipe.php';

class View
{
    public function __construct() {
    }

    public function outputRecipe($recipe) {
		echo json_encode($recipe);
    }

    public function output($param) {
    	echo json_encode($param);
    }

    public function returnResult($result) {
        echo "{\"result\" : \"$result\"}";
    }
}

?>
