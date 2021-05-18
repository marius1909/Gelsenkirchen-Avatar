<?php

require_once("dbconfig.php");

$id = mysqli_real_escape_string($con, $_POST['id']);
    
// sql to delete a record
$sql = "DELETE FROM Rollen WHERE id = '$id'";

if ($con->query($sql) === TRUE) {
  echo "Record deleted successfully";
} else {
  echo "Error deleting record: " . $con->error;
}

$con->close();
?>
