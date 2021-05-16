<?php
//Gibt alle BenutzerSpiel der Tabelle BenutzerSpiel im body zurück

require_once("dbconfig.php");

/*Gibt alle BenutzerSpiel komlett zurück*/
$query = "SELECT * FROM BenutzerSpiel";


$res = mysqli_query($con, $query);

$data = array();

while ($row = mysqli_fetch_array($res, MYSQLI_ASSOC)) {
    $data[] = $row;
}

mysqli_free_result($res);
header('Content-Type: application/json');

echo json_encode($data);

?>