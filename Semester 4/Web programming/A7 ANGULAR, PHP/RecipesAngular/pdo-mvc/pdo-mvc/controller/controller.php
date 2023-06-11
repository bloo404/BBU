<?php
// enable CORS - required for Angular UI
header("Access-Control-Allow-Origin: *");

require_once '../model/model.php';
require_once '../view/view.php';

class Controller
{
    private $view;
    private $model;	

    public function __construct(){
    	$this->model = new Model ();
        $this->view = new View();
    }

    public function service() {
	   if (isset($_GET['action']) && !empty($_GET['action'])) {
            if ($_GET['action'] == "getRecipe") {
   	            $this->{$_GET['action']}($_GET['recipe']);
            } else if ($_GET['action'] == "getAllRecipes") {
                $this->{$_GET['action']}();
            } else if ($_GET['action'] == "addRecipe") {
                $this->{$_GET['action']}($_GET['title'], $_GET['author'], $_GET['type'], $_GET['description'], $_GET['ingredients']);
            } else if ($_GET['action'] == "updateRecipe") {
                $this->{$_GET['action']}($_GET['title'], $_GET['author'], $_GET['type'], $_GET['description'], $_GET['ingredients']);
            } else if ($_GET['action'] == "removeRecipe") {
                $this->{$_GET['action']}($_GET['title']);
            }else if ($_GET['action'] == "getFilteredRecipes") {
                $this->{$_GET['action']}($_GET['type']);
            } 
	   }
    }

    private function getRecipe($recipe) {
	   $recipe = $this->model->getRecipe($recipe);
	   return $this->view->output($recipe);
    }

    private function getAllRecipes() {
       $recipes = $this->model->getAllRecipes();
       return $this->view->output($recipes);
    }

    private function addRecipe($title, $author, $type, $description, $ingredients) {
        $result = $this->model->addRecipe($title, $author, $type, $description, $ingredients);
        if ($result>0) { $r = "Success"; } 
        else { $r = "Failure"; }
        $this->view->returnResult($r);
    }

    private function updateRecipe($title, $author, $type, $description, $ingredients) {
        $result = $this->model->updateRecipe($title, $author, $type, $description, $ingredients);
        if ($result>0) { $r = "Success"; }
        else { $r = "Failure"; }
        $this->view->returnResult($r);
    }

    private function removeRecipe($title) {
        $result = $this->model->removeRecipe($title);
        if ($result>0) { $r = "Success"; }
        else { $r = "Failure"; }
        $this->view->returnResult($r);
    }

    private function getFilteredRecipes($type){
        $recipes = $this->model->getFilteredRecipes($type);
       return $this->view->output($recipes);
    }
}

$controller = new Controller();
$controller->service();

?>
