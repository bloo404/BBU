<html>
<body>

Welcome <?php echo $_POST["author"]; ?><br>
Your title of recipe is: <?php echo $_POST["title"]; ?> <br>
Description: <?php echo $_POST["description"]; ?><br>
The ingredients are: <?php echo $_POST["ingredients"]; ?>
  
  
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

                $sql = "INSERT INTO recipes (title, description, ingredients, author,type) VALUES ( '$title', '$description', '$ingredients','$author','$type')";
                
               if (!mysqli_query($con, $sql)) {
					printf("%d Row inserted.\n", mysqli_affected_rows($con));
				}
                mysqli_close($con);
            }
        ?>
  </body>
</html>