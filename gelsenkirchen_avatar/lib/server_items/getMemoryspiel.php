<?php
//Gibt alle Memoryspiel der Tabelle Memoryspiel im body zurück

require_once("dbconfig.php");

$suche = 0;

$attribut = mysqli_real_escape_string($con, $_POST['attribut']);
$wert = mysqli_real_escape_string($con, $_POST['wert']);
$suche = mysqli_real_escape_string($con, $_POST['suche']);
$query = '';

/*Gibt nur das gesuchte Objekt Memoryspiel komlett zurück*/
if($suche == '1'){
    $query = "SELECT * FROM Memoryspiel Where $attribut = '$wert'";


/*Gibt alle Memoryspiel komlett zurück*/
} else {
$query = "SELECT * FROM Memoryspiel";
}

$res = mysqli_query($con, $query);

$data = array();

while ($row = mysqli_fetch_array($res, MYSQLI_ASSOC)) {
    $data[] = $row;
}

mysqli_free_result($res);
header('Content-Type: application/json');

echo json_encode($data);

?>