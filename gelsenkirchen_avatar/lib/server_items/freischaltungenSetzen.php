<?php
require_once("dbconfig.php");
$benutzerID = $_GET['benutzerID'];
$sammelID = $_GET['sammelID'];


//Neues Objetk Freischalten
$query = "insert into Freigeschaltet (benutzerID, sammelID, ausgeruestet) values ($benutzerID,$sammelID,0)";
$res = mysqli_query($con,$query);

//Objekte die evt übersprungen wurden

for($i = 7; $i < $sammelID; $i++){
	$query = "insert into Freigeschaltet (benutzerID, sammelID, ausgeruestet) values ($benutzerID,$i,0)";
	$res = mysqli_query($con,$query);
}