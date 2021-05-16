<?php

require_once("dbconfig.php");

$benutzerID = mysqli_real_escape_string($con, $_POST['benutzerID']);
$spielID = mysqli_real_escape_string($con, $_POST['spielID']);

// sql to delete a record
$sql = "DELETE FROM BenutzerSpiel WHERE benutzerID = '$benutzerID' and spielID = '$spielID'";

if ($con->query($sql) === TRUE) {
  echo "Record deleted successfully";
} else {
  echo "Error deleting record: " . $con->error;
}

$con->close();
?>
