<?php

require_once("dbconfig.php");

$id = mysqli_real_escape_string($con, $_POST['id']);
$name = mysqli_real_escape_string($con, $_POST['name']);
$logo = mysqli_real_escape_string($con, $_POST['logo']);
    
$query = "INSERT INTO LernKategorie (id, name, logo) VALUES ('$id', '$name', '$logo')";
    
$results = mysqli_query($con, $query);

if($results){
    echo "Records inserted successfully.";
} else {
    echo "ERROR: Could not be able to execute $query.";
}

$con->close();

?>
