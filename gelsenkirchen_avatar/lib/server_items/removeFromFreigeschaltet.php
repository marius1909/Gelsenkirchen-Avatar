<?php

require_once("dbconfig.php");

$benutzerID = mysqli_real_escape_string($con, $_POST['benutzerID']);
$sammelID = mysqli_real_escape_string($con, $_POST['sammelID']);
    
// sql to delete a record
$sql = "DELETE FROM Freigeschaltet WHERE benutzerID = '$benutzerID' and sammelID = '$sammelID'";

if ($con->query($sql) === TRUE) {
  echo "Record deleted successfully";
} else {
  echo "Error deleting record: " . $con->error;
}

$con->close();
?>
