<?php

require_once("dbconfig.php");

$benutzerID_1 = mysqli_real_escape_string($con, $_POST['benutzerID_1']);
$benutzerID_2 = mysqli_real_escape_string($con, $_POST['benutzerID_2']);
    
$query = "INSERT INTO Freundschaft (benutzerID_1, benutzerID_2) VALUES ('$benutzerID_1', '$benutzerID_2')";
    
$results = mysqli_query($con, $query);

if($results>0) {
    echo "Freundschaft added successfully";
}

$con->close();

?>