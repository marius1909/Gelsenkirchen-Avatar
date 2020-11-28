<?php

require_once("dbconfig.php");


// $quizID = $_POST['quizID'];
// $frage = $_POST['frage'];
// $antwort1 = $_POST['antwort1'];
// $antwort2 = $_POST['antwort2'];
// $antwort3 = $_POST['antwort3'];
// $antwort4 = $_POST['antwort4'];
// $position = $_POST['position'];
// $loesungsText = $_POST['loesungsText'];

$quizID = mysqli_real_escape_string($con, $_POST['quizID']);
$frage = mysqli_real_escape_string($con, $_POST['frage']);
$antwort1 = mysqli_real_escape_string($con, $_POST['antwort1']);
$antwort2 = mysqli_real_escape_string($con, $_POST['antwort2']);
$antwort3 = mysqli_real_escape_string($con, $_POST['antwort3']);
$antwort4 = mysqli_real_escape_string($con, $_POST['antwort4']);
$position = mysqli_real_escape_string($con, $_POST['position']);
$loesungsText = mysqli_real_escape_string($con, $_POST['loesungsText']);

// Überprüfen ob die Frage für das Quiz bereits existiert
$query = "SELECT * FROM QuizFragen Where frage == '$frage' and quizID == '$quizID'";
$res = mysqli_query($con,$query);
$data = mysqli_fetch_array($res);

if($data[0] >= 1){
    //Datensatz existiert
    echo json_encode('Frage existiert bereits');
}else{
    //Frage anlegen
    $query = "INSERT INTO QuizFragen(quizID, frage, antwort1, antwort2, antwort3, antwort4, position, loesungsText) VALUES ('$quizID', '$frage', '$antwort1', '$antwort2', '$antwort3', '$antwort4', '$position', '$loesungsText')";
    $results = mysqli_query($con, $query);
}
// if($results>0) {
//     echo "QuizFrage added successfully";
// } else {
//     echo "Couldn't add QuizFrage"
// }
$con->close();

?>