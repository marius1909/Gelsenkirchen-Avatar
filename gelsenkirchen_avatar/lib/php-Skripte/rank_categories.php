<?php
require_once("dbconfig.php");
$id_user = $_GET["id_user"];
$id_lern_category = $_GET["id_lern_category"];
$limit = $_GET["limit"];
//select SUM(erfahrungspunkte) as erfahrungspunkte from BenutzerKategorie where benutzerID = $id_user
$query = "SELECT @curRank := @curRank + 1 AS rank,sum_erfahrungspunkte,Benutzer.benutzer as username,Benutzer.email as email,Benutzer.id as id_user FROM RankKategorie,(SELECT @curRank := 0) r,Benutzer where RankKategorie.benutzerID = Benutzer.id and RankKategorie.lernKategorieID = $id_lern_category ORDER BY  sum_erfahrungspunkte DESC, created_at ASC limit $limit;";
$res = mysqli_query($con,$query);
$data = [];
while ($row = mysqli_fetch_assoc($res)) {
    $data['data'][] = $row;
}
$data['current_rank'] = 0;
$data['current_point'] = 0;
$query = "SELECT @curRank := @curRank + 1 AS rank,sum_erfahrungspunkte,Benutzer.benutzer as username,Benutzer.id as id_user FROM RankKategorie,(SELECT @curRank := 0) r,Benutzer where RankKategorie.benutzerID = Benutzer.id and RankKategorie.lernKategorieID = $id_lern_category ORDER BY  sum_erfahrungspunkte DESC, created_at ASC";
$res = mysqli_query($con,$query);
while ($row = mysqli_fetch_assoc($res)) {
    if($row['id_user'] == $id_user){
        $data['current_rank'] = $row['rank'] != null ? intval($row['rank']) : 0;
        $data['current_point'] = $row['sum_erfahrungspunkte'] != null ? intval($row['sum_erfahrungspunkte']) : 0;
    }
}
mysqli_free_result($res);
if(isset($data))
    echo json_encode($data); 
else
    echo json_encode('Datensatz existiert nicht');
