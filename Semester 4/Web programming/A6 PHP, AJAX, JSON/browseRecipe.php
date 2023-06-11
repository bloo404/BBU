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
            <a href="#">Browse Recipe</a>
            <a href="addRecipe.html">Add Recipe</a>
            <a href="updateRecipe.php">Update Recipe</a>
            <a href="deleteRecipe.php">Delete Recipe</a>
        </nav>

        <form class="form" id="browse-car" method="post" action="<?php echo $_SERVER['PHP_SELF'];?>">
                <div ng-app="myApp" ng-controller="myCtrl">
                <label for="title"> Title of recipe: </label>
                <input type="text" name="title" ng-model="title">
                <br>

                <label for="author"> Author of recipe: </label>
                <input type="text" name="author" ng-model="author">
                <br>
                This is what you are searching for:
                <br>
                <pre> {{"Title:" + title + "\n" + "Author:" + author + "\n"}}</pre>
                </div>
               
            <input type="submit" value="Browse recipe">
        </form>

        <?php

            $con = new mysqli("localhost", "root", "", "a6");

            if (!$con){
                die('Could not connect: ' . mysqli_error());
            }

            if ($_SERVER["REQUEST_METHOD"] == "POST"){

            $title = mysqli_real_escape_string($con,$_POST["title"]);
            $author = mysqli_real_escape_string($con,$_POST["author"]);

            $result = mysqli_query($con,"SELECT * FROM recipes WHERE title = '$title' AND author = '$author' ");

            echo "<table border='1'>
            <tr>
            <th> ID </th>
            <th> Title </th>
            <th> Description </th>
            <th> Ingredients </th>
            <th> Author </th>
            <th> Type </th>
            </tr>";

            while($row = mysqli_fetch_array($result))
            {
            echo "<tr>";
            echo "<td>" . $row['ID'] . "</td>";
            echo "<td>" . $row['title'] . "</td>";
            echo "<td>" . $row['description'] . "</td>";
            echo "<td>" . $row['ingredients'] . "</td>";
            echo "<td>" . $row['author'] . "</td>";
            echo "<td>" . $row['type'] . "</td>";
            echo "</tr>";
            }
            echo "</table>";

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