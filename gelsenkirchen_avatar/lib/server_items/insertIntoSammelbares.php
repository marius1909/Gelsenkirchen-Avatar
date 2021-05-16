<?php

require_once("dbconfig.php");

$id = mysqli_real_escape_string($con, $_POST['id']);
$kategorieID = mysqli_real_escape_string($con, $_POST['kategorieID']);
$name = mysqli_real_escape_string($con, $_POST['name']);
$beschreibung = mysqli_real_escape_string($con, $_POST['beschreibung']);
$bild = mysqli_real_escape_string($con, $_POST['bild']);
$pfadID = mysqli_real_escape_string($con, $_POST['pfadID']);
    
$query = "INSERT INTO Sammelbares (id, kategorieID, name, beschreibung, bild, pfadID) VALUES ('$id', '$kategorieID', '$name', '$beschreibung', '$bild', '$pfadID')";
    
$results = mysqli_query($con, $query);

if($results){
    echo "Records inserted successfully.";
} else {
    echo "ERROR: Could not be able to execute $query.";
}

$con->close();

?>
