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

// $id = $_POST['id'];
// $nord = $_POST['nord'];
// $ost = $_POST['ost'];
// $kategorieID = $_POST['kategorieID'];
// $name = $_POST['name'];
// $kurzbeschreibung = $_POST['kurzbeschreibung'];
// $beschreibung = $_POST['beschreibung'];
// $titelbild = $_POST['titelbild'];
// $minispielArtID = $_POST['minispielArtID'];
// $belohnungenID = $_POST['belohnungenID'];
// $weitereBilder = $_POST['weitereBilder'];

$query = "INSERT INTO Lernort (nord, ost, kategorieID, name, kurzbeschreibung, beschreibung, titelbild, minispielArtID, belohnungenID, weitereBilder) VALUES ('$nord', '$ost', '$kategorieID', '$name', '$kurzbeschreibung', '$beschreibung', '$titelbild', '$minispielArtID', '$belohnungenID', '$weitereBilder')";

$results = mysqli_query($con, $query);

if($results>0) {
    echo "Lernort added successfully";
}

$con->close();

?>