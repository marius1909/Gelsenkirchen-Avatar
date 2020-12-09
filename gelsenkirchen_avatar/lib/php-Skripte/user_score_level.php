<?php
require_once("dbconfig.php");
$id_user = $_GET["id"];
$query = "select * from LernKategorie";
$res = mysqli_query($con,$query);
$dataTmp = [];
while ($row = mysqli_fetch_assoc($res)) {
    $dataTmp[] = $row;
}
$data = [];
foreach ($dataTmp as $key => $item) {
    $query = "select SUM(erfahrungspunkte) as erfahrungspunkte from BenutzerKategorie where benutzerID = $id_user AND lernKategorieID = " . $item['id'];
    $res = mysqli_query($con,$query);
    while ($row = mysqli_fetch_assoc($res)) {
        $item['erfahrungspunkte'] = $row['erfahrungspunkte'] != null ? intval($row['erfahrungspunkte']) : 0;
    }
    $data['data'][] = $item;
}
$query = "select SUM(erfahrungspunkte) as erfahrungspunkte from BenutzerKategorie where benutzerID = $id_user";
$res = mysqli_query($con,$query);
while ($row = mysqli_fetch_assoc($res)) {
    $data['total_point'] = $row['erfahrungspunkte'] != null ? intval($row['erfahrungspunkte']) : 0;
}
if($data['total_point'] >= 0 && $data['total_point'] <= 29){
    $data['level'] = 1;
}else if($data['total_point'] >= 30 && $data['total_point'] <= 50){
    $data['level'] = 2;
}else if($data['total_point'] >= 51 && $data['total_point'] <= 85){
    $data['level'] = 3;
}else if($data['total_point'] >= 86 && $data['total_point'] <= 145){
    $data['level'] = 4;
}else if($data['total_point'] >= 146 && $data['total_point'] <= 247){
    $data['level'] = 5;
}else if($data['total_point'] >= 248 && $data['total_point'] <= 420){
    $data['level'] = 6;
}else if($data['total_point'] >= 421 && $data['total_point'] <= 714){
    $data['level'] = 7;
}else if($data['total_point'] >= 715 && $data['total_point'] <= 1214){
    $data['level'] = 8;
}else if($data['total_point'] >= 1215){
    $data['level'] = 9;
}
mysqli_free_result($res);
if(isset($data))
    echo json_encode($data); 
else
    echo json_encode('Datensatz existiert nicht');