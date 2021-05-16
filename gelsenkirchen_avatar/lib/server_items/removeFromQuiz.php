<?php

require_once("dbconfig.php");

$id = mysqli_real_escape_string($con, $_POST['id']);
$lernortID = mysqli_real_escape_string($con, $_POST['lernortID']);
    
// sql to delete a record
$sql = "DELETE FROM Quiz WHERE id = '$id' and lernortID = '$lernortID'";

if ($con->query($sql) === TRUE) {
  echo "Record deleted successfully";
} else {
  echo "Error deleting record: " . $con->error;
}

$con->close();
?>
