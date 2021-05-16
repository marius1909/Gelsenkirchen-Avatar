<?php

require_once("dbconfig.php");

// $id = mysqli_real_escape_string($con, $_POST['id']);
$lernortID = mysqli_real_escape_string($con, $_POST['lernortID']);
$aufgabe = mysqli_real_escape_string($con, $_POST['aufgabe']);
$erfahrungspunkte = mysqli_real_escape_string($con, $_POST['erfahrungspunkte']);
    
$query = "INSERT INTO Memoryspiel (lernortID, aufgabe, erfahrungspunkte) VALUES ('$lernortID', '$aufgabe', '$erfahrungspunkte')";
    
$results = mysqli_query($con, $query);

// if($results>0) {
//     echo "Memoryspiel added successfully";
// }

$con->close();

?>