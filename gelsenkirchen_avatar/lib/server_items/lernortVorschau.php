<?php

require_once("dbconfig.php");

$id = $_POST['id'];


// Prüfe ob der Datensatz existiert

$query = "SELECT * FROM Lernort WHERE id = $id";
$res = mysqli_query($con,$query);
$data = mysqli_fetch_array($res);

//data[0] = id, data[1] = nord, data[2] = ost, data[3] = kategorieID, data[4] = name, data[5] = kurzbeschreibung, data[6] = beschreibung, data[7] = titelbild, data[8] = minispielArtID, data[9] = belohnungenID, data[10] = weiterBilder
if($data[0] >= 1){
    // Datensatz existiert



        $resarr = array("id"=>$data['0'],"kategorieID"=>$data['3'],"name"=>$data['4'],"beschreibung"=>$data['6'],"titelbild"=>$data['7']);
        echo json_encode($resarr);
        
        
  
}else{
    
    // Datensatz existiert nicht.

    echo json_encode('Datensatz existiert nicht');
}

?>