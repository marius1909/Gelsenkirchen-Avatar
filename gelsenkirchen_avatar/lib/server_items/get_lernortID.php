<?php
require_once("dbconfig.php");
$id = $_GET['id'];
$query = "select Lernort.*,Quiz.id as quizID from Lernort,Quiz where Quiz.lernortID = Lernort.id and Lernort.id = $id";
$res = mysqli_query($con,$query);
$data = mysqli_fetch_assoc($res);
mysqli_free_result($res);
header('Content-Type: application/json');
if(isset($data)){ 
    echo json_encode($data); 
}
else
    echo json_encode('Datensatz existiert nicht');
?>