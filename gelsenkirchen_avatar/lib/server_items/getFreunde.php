<?php
//Gibt die befreundeten Benutzer der Tabelle Benutzer im body zurück

require_once("dbconfig.php");

$benutzerID_1 = mysqli_real_escape_string($con, $_POST['benutzerID_1']);

/*Gibt die befreundeten Benutzer zurück*/
$query = "SELECT * FROM Benutzer where id = any (SELECT benutzerID_2 FROM Freundschaft where benutzerID_1 = $benutzerID_1)"; 


$res = mysqli_query($con, $query);

$data = array();

while ($row = mysqli_fetch_array($res, MYSQLI_ASSOC)) {
    $data[] = $row;
}

/*Gibt die befreundeten Benutzer zurück*/
$query = "SELECT * FROM Benutzer where id = any (SELECT benutzerID_1 FROM Freundschaft where benutzerID_2 = $benutzerID_1)";

$res = mysqli_query($con, $query);

$data1 = array();

while ($row = mysqli_fetch_array($res, MYSQLI_ASSOC)) {
    $data1[] = $row;
}

$ergebnis = array_merge($data, $data1);

mysqli_free_result($res);
header('Content-Type: application/json');

echo json_encode($ergebnis);

?>