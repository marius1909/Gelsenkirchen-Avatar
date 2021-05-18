<?php

require_once("dbconfig.php");

$benutzerID = mysqli_real_escape_string($con, $_POST['benutzerID']);
$sammelID = mysqli_real_escape_string($con, $_POST['sammelID']);
$ausgeruestet = mysqli_real_escape_string($con, $_POST['ausgeruestet']);

if($ausgeruestet == 'true'){
$ausgeruestet = 1;
} else {
$ausgeruestet = 0;
}
    
$query = "INSERT INTO Freigeschaltet (benutzerID, sammelID, ausgeruestet) VALUES ('$benutzerID', '$sammelID', '$ausgeruestet')";
    
$results = mysqli_query($con, $query);

if($results){
    echo "Records inserted successfully.";
} else {
    echo "ERROR: Could not be able to execute $query.";
}

$con->close();

?>
