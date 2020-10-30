<?php
//Gibt alle Lernorte der Tabelle Lernort im body zurück

require_once("dbconfig.php");

//Zu Demonstrationszwecken des Lernortscreens wird hier nur ein Datensatz zurückgegeben
//$query = "SELECT 'Name', 'Kategorie' FROM Lernort";
$query = "SELECT Lernort.Name AS Lernort, LernKategorie.Name AS Kategorie FROM LernKategorie INNER JOIN Lernort ON LernKategorie.id=Lernort.KategorieID";

$res = mysqli_query($con, $query);

$data = array();

while ($row = mysqli_fetch_array($res, MYSQLI_ASSOC)) {
    $data[] = $row;
}

mysqli_free_result($res);
header('Content-Type: application/json');

echo json_encode($data);

?>