<?php

class DBUtils {
	private $host = '127.0.0.1';
	private $db   = 'a6';
	private $user = 'root';
	private $pass = '';
	private $charset = 'utf8';	

	private $pdo;
	private $error;

	public function __construct () {
		$dsn = "mysql:host=$this->host;dbname=$this->db;charset=$this->charset";
		$opt = array(PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
			PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
			PDO::ATTR_EMULATE_PREPARES   => false);
		try {
			$this->pdo = new PDO($dsn, $this->user, $this->pass, $opt);		
		} // Catch any errors
		catch(PDOException $e){
			$this->error = $e->getMessage();
			echo "Error connecting to DB: " . $this->error;
		}
	}

	public function selectRecipe($title) {
        $stmt = $this->pdo->query("SELECT * FROM recipes where title ='" . $title ."'");
        return $stmt->fetchAll(PDO::FETCH_ASSOC);
    }

    public function selectAllRecipes() {
    	$stmt = $this->pdo->query("SELECT * FROM recipes");
        return $stmt->fetchAll(PDO::FETCH_ASSOC);
    }

	public function selectFilteredRecipes($type) {
    	$stmt = $this->pdo->query("SELECT * FROM recipes WHERE type='" . $type . "'");
        return $stmt->fetchAll(PDO::FETCH_ASSOC);
    }

	public function addRecipe($title, $author, $type, $description, $ingredients) {
		$affected_rows = $this->pdo->exec("INSERT into recipes(title, author, type, description, ingredients) values('" .
							$title . "', '" . $author . "','" . $type . "','" . $description . "','" . $ingredients . "')");
		return $affected_rows;
	}

	public function updateRecipe($title, $author, $type, $description, $ingredients)  {
		$affected_rows = $this->pdo->exec("UPDATE recipes set type='" . $type . "', description='" . $description . "', ingredients='" . $ingredients .
						    "' WHERE title='" . $title . "' and author='" . $author . "'");
		return $affected_rows;
	}

	public function removeRecipe($title) {
		$affected_rows = $this->pdo->exec("DELETE from recipes where title='" . $title . "'");
		return $affected_rows;
	}
	
	private function select($table) {
		$stmt = $this->pdo->query("SELECT * FROM " . $table);
		return $stmt->fetchAll(PDO::FETCH_ASSOC);
	}

	private function insert($id, $value) {
		$affected_rows = $this->pdo->exec("INSERT into table values(" . $id . ",'" . $value ."');");
		return $affected_rows;
	}

	private function delete ($id) {
		$affected_rows = $this->pdo->exec("DELETE from table where id=" . $id);
		return $affected_rows;
	}

	private function update ($id, $value) {
		$affected_rows = $this->pdo->exec("UPDATE table SET field='" . $value ."' where id=" . $id);

	}
}
 

?>

