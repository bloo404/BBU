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
            <a href="updateRecipe.php"> Update Recipe</a>
            <a href="#"> Delete Recipe</a>
        </nav>

        <div id="bu">
            <form method = "post" action="<?php echo $_SERVER['PHP_SELF'];?>">
                <div ng-app="myApp" ng-controller="myCtrl">
                <label for="idDel"> Title of recipe to delete: </label>
                <input type="text" name="idDel" ng-model="title">
                <br>

                <label for="authorDel"> Author of recipe to delete: </label>
                <input type="text" name="authorDel" ng-model="author">
                <br>

                This is what you are deleting:
                <br>
                <pre> {{"Title:" + title + "\n" + "Author:" + author + "\n"}}</pre>
                </div>
                <input type="submit" value="Delete">

            </form>
        </div>

        <?php

            $con = new mysqli("localhost", "root", "", "a6");

            if (!$con){
                die('Could not connect: ' . mysqli_error());
            }

            if ($_SERVER["REQUEST_METHOD"] == "POST"){
                 $nameToDelete = mysqli_real_escape_string($con, $_POST["idDel"]);
                 $authorToDelete = mysqli_real_escape_string($con, $_POST["authorDel"]);

            
                if ($nameToDelete){
                    $sql = "DELETE FROM recipes WHERE (title = '$nameToDelete' AND author = '$authorToDelete')";
                    $con -> query($sql);
                }

                if (mysqli_affected_rows($con) > 0) {
                    echo "Recipe deleted successfully";
                } else {
                    echo "Error deleting recipe: " . mysqli_error($con);
                }
    
                mysqli_close($con);
            } 
        ?>

         <script>
            var app = angular.module('myApp', []);
            app.controller('myCtrl', function($scope) {
                $scope.title = "what";
                $scope.author = "who";
            });
        </script>

    </body>
</html>