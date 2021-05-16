<?php

require_once("dbconfig.php");

// $id = mysqli_real_escape_string($con, $_POST['id']);
$memoryID = mysqli_real_escape_string($con, $_POST['memoryID']);
$paarID = mysqli_real_escape_string($con, $_POST['paarID']);
$kartentyp = mysqli_real_escape_string($con, $_POST['kartentyp']);
$kartenInhalt = mysqli_real_escape_string($con, $_POST['kartenInhalt']);
    
$query = "INSERT INTO Memorykarte (memoryID, paarID, kartentyp, kartenInhalt) VALUES ('$memoryID', '$paarID', '$kartentyp', '$kartenInhalt')";
    
$results = mysqli_query($con, $query);

if($results>0) {
    echo "Memorykarte added successfully";
}

$con->close();

?>