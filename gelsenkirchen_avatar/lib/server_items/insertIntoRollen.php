<?php

require_once("dbconfig.php");

$id = mysqli_real_escape_string($con, $_POST['id']);
$name = mysqli_real_escape_string($con, $_POST['name']);
$beschreibung = mysqli_real_escape_string($con, $_POST['beschreibung']);
    
$query = "INSERT INTO Rollen (id, name, beschreibung) VALUES ('$id', '$name', '$beschreibung')";
    
$results = mysqli_query($con, $query);

if($results){
    echo "Records inserted successfully.";
} else {
    echo "ERROR: Could not be able to execute $query.";
}

$con->close();

?>
