<?php

require_once("dbconfig.php");

$benutzerID = mysqli_real_escape_string($con, $_POST['benutzerID']);
$lernKategorieID = mysqli_real_escape_string($con, $_POST['lernKategorieID']);

// sql to delete a record
$sql = "DELETE FROM BenutzerKategorie WHERE benutzerID = '$benutzerID' and lernKategorieID = '$lernKategorieID'";

if ($con->query($sql) === TRUE) {
  echo "Record deleted successfully";
} else {
  echo "Error deleting record: " . $con->error;
}

$con->close();
?>
