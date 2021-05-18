<?php

require_once("dbconfig.php");

$email = $_POST['email'];
$passwort = $_POST['passwort'];

// Prüfe ob der Account existiert

$query = "SELECT * FROM Benutzer WHERE email = '$email'";
$res = mysqli_query($con,$query);
$data = mysqli_fetch_array($res);

//data[0] = id, data[1] = email, data[2] = benutzer, data[3] = passwort, data[4] = rolleID 
if($data[0] >= 1){
    // Account existiert

    $query = "SELECT * FROM Benutzer WHERE passwort = '$passwort' and email = '$email'";
    $res = mysqli_query($con,$query);
    $data = mysqli_fetch_array($res);

    if($data[3] == $passwort){
        // passwort korrekt

        $resarr = array("id"=>$data[0],"email"=>$data['1'],"benutzer"=>$data['2'],"passwort"=>$data['3'],"rolleID"=>$data['4'], "erfahrung"=>$data['5']);
        echo json_encode($resarr);
    }else{

        // passwort inkorrekt

        echo json_encode('Falsches Passwort');
    }


}else{
    
    // Account existiert noch nicht.

    echo json_encode('Account existiert nicht');
}

?>
