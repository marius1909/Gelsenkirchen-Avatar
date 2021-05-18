<?php

require_once("dbconfig.php");

$nord = mysqli_real_escape_string($con, $_POST['nord']);
$ost = mysqli_real_escape_string($con, $_POST['ost']);
$kategorieID = mysqli_real_escape_string($con, $_POST['kategorieID']);
$name = mysqli_real_escape_string($con, $_POST['name']);
$kurzbeschreibung = mysqli_real_escape_string($con, $_POST['kurzbeschreibung']);
$beschreibung = mysqli_real_escape_string($con, $_POST['beschreibung']);
$titelbild = mysqli_real_escape_string($con, $_POST['titelbild']);
$minispielArtID = mysqli_real_escape_string($con, $_POST['minispielArtID']);
$belohnungenID = mysqli_real_escape_string($con, $_POST['belohnungenID']);
$weitereBilder = mysqli_real_escape_string($con, $_POST['weitereBilder']);
    
$query = "INSERT INTO Lernort (nord, ost, kategorieID, name, kurzbeschreibung, beschreibung, titelbild, minispielArtID, belohnungenID, weitereBilder) VALUES ('$nord', '$ost', '$kategorieID', '$name', '$kurzbeschreibung', '$beschreibung', '$titelbild', '$minispielArtID', '$belohnungenID', '$weitereBilder')";
    
$results = mysqli_query($con, $query);

if($results){
    echo "Records inserted successfully.";
} else {
    echo "ERROR: Could not be able to execute $query.";
}

$con->close();

?>
