<?php

require_once("dbconfig.php");

// $id = mysqli_real_escape_string($con, $_POST['id']);
$memoryID = mysqli_real_escape_string($con, $_POST['memoryID']);
$paarID = mysqli_real_escape_string($con, $_POST['paarID']);
$kartentyp = mysqli_real_escape_string($con, $_POST['kartentyp']);
$karteninhalt = mysqli_real_escape_string($con, $_POST['karteninhalt']);
    
$query = "INSERT INTO Memorykarte (memoryID, paarID, kartentyp, karteninhalt) VALUES ('$memoryID', '$paarID', '$kartentyp', '$karteninhalt')";
    
$results = mysqli_query($con, $query);

if($results>0) {
    echo "Memorykarte added successfully";
}

$con->close();

?>