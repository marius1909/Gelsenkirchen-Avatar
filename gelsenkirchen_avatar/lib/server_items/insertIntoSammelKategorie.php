<?php

require_once("dbconfig.php");

$id = mysqli_real_escape_string($con, $_POST['id']);
$beschreibung = mysqli_real_escape_string($con, $_POST['beschreibung']);
$ortDesTragens = mysqli_real_escape_string($con, $_POST['ortDesTragens']);
    
$query = "INSERT INTO SammelKategorie (id, beschreibung, ortDesTragens) VALUES ('$id', '$beschreibung', '$ortDesTragens')";
    
$results = mysqli_query($con, $query);

if($results){
    echo "Records inserted successfully.";
} else {
    echo "ERROR: Could not be able to execute $query.";
}

$con->close();

?>
