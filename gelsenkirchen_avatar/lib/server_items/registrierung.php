<?php

require_once("dbconfig.php");

$email = mysqli_real_escape_string($con, $_POST['email']);
$benutzer = mysqli_real_escape_string($con, $_POST['benutzer']);
$passwort = mysqli_real_escape_string($con, $_POST['passwort']);
$rolleID = mysqli_real_escape_string($con, $_POST['rolleID']);
$erfahrung = mysqli_real_escape_string($con, $_POST['erfahrung']);

// überprüfen ob Benutzer bereits angelegt

$query = "SELECT * FROM Benutzer Where email = '$email' or benutzer = '$benutzer'";
$res = mysqli_query($con,$query);
$data = mysqli_fetch_array($res);

if($data[0] >= 1){
    //Account existiert
    echo json_encode('Account existiert bereits');
}else{
    //Account anlegen

    $query = "INSERT INTO Benutzer(email, benutzer, passwort, rolleID, erfahrung) VALUES ('$email', '$benutzer', '$passwort', '$rolleID', '$erfahrung')";
    $res = mysqli_query($con,$query);

    if($res){
        echo json_encode('true');
    }else{
        echo json_encode('false');
    }
}

?>
