<?php

require_once("dbconfig.php");


$attribut = mysqli_real_escape_string($con, $_POST['attribut']);
$neuerWert = mysqli_real_escape_string($con, $_POST['neuerWert']);
$id = mysqli_real_escape_string($con, $_POST['id']);

$query = "UPDATE Benutzer SET $attribut = '$neuerWert' WHERE id = '$id'";

$results = mysqli_query($con, $query);

$con->close();

?>