<?php

require_once("dbconfig.php");

$benutzerID = mysqli_real_escape_string($con, $_POST['benutzerID']);
$lernKategorieID = mysqli_real_escape_string($con, $_POST['lernKategorieID']);
$erfahrungspunkte = mysqli_real_escape_string($con, $_POST['erfahrungspunkte']);
    
$query = "INSERT INTO BenutzerKategorie (benutzerID, lernKategorieID, erfahrungspunkte) VALUES ('$benutzerID', '$lernKategorieID', '$erfahrungspunkte')";
    
$results = mysqli_query($con, $query);

if($results){
    echo "Records inserted successfully.";
} else {
    echo "ERROR: Could not be able to execute $query.";
}

$con->close();

?>
