<?php

require_once("dbconfig.php");


$ausgeruestet = mysqli_real_escape_string($con, $_POST['ausgeruestet']);
$basisID = mysqli_real_escape_string($con, $_POST['basisID']);
$collectable1 = mysqli_real_escape_string($con, $_POST['collectable1']);
$collectable2 = mysqli_real_escape_string($con, $_POST['collectable2']);
$collectable3 = mysqli_real_escape_string($con, $_POST['collectable3']);
$benutzerID = mysqli_real_escape_string($con, $_POST['benutzerID']);


$query = "UPDATE Freigeschaltet SET ausgeruestet = 0 WHERE benutzerID = '$benutzerID'";

$results = mysqli_query($con, $query);

$query = "UPDATE Freigeschaltet SET ausgeruestet = 1 WHERE benutzerID = '$benutzerID' and sammelID = '$basisID'";

$results = mysqli_query($con, $query);

$query = "UPDATE Freigeschaltet SET ausgeruestet = 1 WHERE benutzerID = '$benutzerID' and sammelID = '$collectable1'";

$results = mysqli_query($con, $query);

$query = "UPDATE Freigeschaltet SET ausgeruestet = 1 WHERE benutzerID = '$benutzerID' and sammelID = '$collectable2'";

$results = mysqli_query($con, $query);

$query = "UPDATE Freigeschaltet SET ausgeruestet = 1 WHERE benutzerID = '$benutzerID' and sammelID = '$collectable3'";

$results = mysqli_query($con, $query);

echo json_encode('Avatar erfolgreich geaendert');

$con->close();

?>