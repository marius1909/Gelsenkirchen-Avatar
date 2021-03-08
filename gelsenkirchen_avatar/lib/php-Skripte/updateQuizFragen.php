<?php

require_once("dbconfig.php");


$attribut = mysqli_real_escape_string($con, $_POST['attribut']);
$neuerWert = mysqli_real_escape_string($con, $_POST['neuerWert']);
$id = mysqli_real_escape_string($con, $_POST['id']);

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

$query = "UPDATE QuizFragen SET $attribut = '$neuerWert' WHERE id = '$id'";

$results = mysqli_query($con, $query);

$con->close();

?>