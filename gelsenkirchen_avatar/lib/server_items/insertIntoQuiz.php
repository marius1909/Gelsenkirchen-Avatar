<?php

require_once("dbconfig.php");

$id = mysqli_real_escape_string($con, $_POST['id']);
$lernortID = mysqli_real_escape_string($con, $_POST['lernortID']);
$fragenAnzahl = mysqli_real_escape_string($con, $_POST['fragenAnzahl']);
$punkteProFrage = mysqli_real_escape_string($con, $_POST['punkteProFrage']);
    
$query = "INSERT INTO Quiz (id, lernortID, fragenAnzahl, punkteProFrage) VALUES ('$id', '$lernortID', '$fragenAnzahl', '$punkteProFrage')";
    
$results = mysqli_query($con, $query);

if($results){
    echo "Records inserted successfully.";
} else {
    echo "ERROR: Could not be able to execute $query.";
}

$con->close();

?>
