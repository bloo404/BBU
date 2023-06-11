<!DOCTYPE html>
<html>
    <head>
        <title> RECIPES MANAGEMENT </title>
        <link rel="stylesheet" href="style.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
        <script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.6.9/angular.min.js"></script>
    </head>

    <body>
        <nav>
            <a href="browseRecipe.php"> Browse Recipe</a>
            <a href="addRecipe.html"> Add Recipe</a>
            <a href="#"> Update Recipe</a>
            <a href="deleteRecipe.php"> Delete Recipe</a>
        </nav>

        <form class="form" id="update-car" method="post" action="<?php echo $_SERVER['PHP_SELF'];?>">
        <div ng-app="myApp" ng-controller="myCtrl">
            <label for="title"> Title: </label>
            <input name="title" type="text" ng-model="title">
            
            <br>
            <br>
            
            <label for="description"> Description: </label>
            <input name="description" type="text" ng-model="description">
            
            <br>
            <br>
        
            <label for="ingredients"> Ingredients: </label>
            <input name="ingredients" type="text" ng-model="ingredients">
            
            <br>
            <br>

            <label for="author"> Author: </label>
            <input name="author" type="text" ng-model="author">
            
            <br>
            <br>

            <label for="type"> Type: </label>
            <input name="type" type="text" ng-model="type">
            
            <br>
            <br>
            <br>
            <br>
                Recipe: <br>
                <pre>{{"Title:" + title + "\n" + "Author:" + author + "\n" + "Type:" + type + "\n" + "Description:" + description + "\n" + "Ingredients:" + ingredients}}</pre>
            </div>
            <br> 

            <input type="submit" value="Update recipe">
        </form>

        <?php

            $con = new mysqli("localhost", "root", "", "a6");

            if (!$con){
                die('Could not connect: ' . mysqli_error());
            }

            if ($_SERVER["REQUEST_METHOD"] == "POST"){
                $description = mysqli_real_escape_string($con,$_POST["description"]);
                $ingredients = mysqli_real_escape_string($con,$_POST["ingredients"]);
                $author = mysqli_real_escape_string($con,$_POST["author"]);
                $title = mysqli_real_escape_string($con,$_POST["title"]);
                $type = mysqli_real_escape_string($con,$_POST["type"]);

                $sql = "UPDATE recipes SET description = '$description', ingredients ='$ingredients', author = '$author', 
                title = '$title', type = 'type' WHERE title = '$title'";

                $con -> query($sql);
            }

            if (mysqli_affected_rows($con) > 0) {
                echo "Recipe updated successfully";
            } else {
                echo "Error updating recipe: " . mysqli_error($con);
            }

            mysqli_close($con);
        ?>

        <script>
            var app = angular.module('myApp', []);
            app.controller('myCtrl', function($scope) {
                $scope.title = "some title...";
                $scope.author = "some author...";
                $scope.type = "some type...";
                $scope.description = "some description...";
                $scope.ingredients = "some ingredients...";
            });
        </script>

    </body>
</html>