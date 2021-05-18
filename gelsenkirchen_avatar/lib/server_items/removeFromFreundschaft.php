<?php

require_once("dbconfig.php");

$benutzerID_1 = mysqli_real_escape_string($con, $_POST['benutzerID_1']);
$benutzerID_2 = mysqli_real_escape_string($con, $_POST['benutzerID_2']);

// sql to delete a record
$sql = "DELETE FROM Freundschaft WHERE (benutzerID_1 = '$benutzerID_1' AND benutzerID_2 = '$benutzerID_2') OR (benutzerID_1 = '$benutzerID_2' AND benutzerID_2 = '$benutzerID_1')";

if ($con->query($sql) === TRUE) {
  echo "Record deleted successfully";
} else {
  echo "Error deleting record: " . $con->error;
}

$con->close();
?>