<?php

require_once("dbconfig.php");

$benutzerID = mysqli_real_escape_string($con, $_POST['benutzerID']);
$spielbenutzerID = mysqli_real_escape_string($con, $_POST['spielID']);
$bewaeltigteAufgaben = mysqli_real_escape_string($con, $_POST['bewaeltigteAufgaben']);
    
$query = "INSERT INTO BenutzerSpiel (benutzerID, spielID, bewaeltigteAufgaben) VALUES ('$benutzerID', '$spielID', '$bewaeltigteAufgaben')";
    
$results = mysqli_query($con, $query);

if($results){
    echo "Records inserted successfully.";
} else {
    echo "ERROR: Could not be able to execute $query.";
}

$con->close();

?>
