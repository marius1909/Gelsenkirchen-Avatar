<?php
require_once("dbconfig.php");
$benutzerID = $_GET['benutzerID'];
$lernKategorieID = $_GET['lernKategorieID'];
$erfahrungspunkte = $_GET['erfahrungspunkte'];
$lernortID = $_GET['lernortID'];
$quizID = $_GET['quizID'];
$query = "select SUM(erfahrungspunkte) as erfahrungspunkte from BenutzerKategorie where benutzerID = $benutzerID";
$res = mysqli_query($con,$query);
$pointOld = 0;
while ($row = mysqli_fetch_assoc($res)) {
    $pointOld = $row['erfahrungspunkte'] != null ? intval($row['erfahrungspunkte']) : 0;
}

$query = "delete from BenutzerKategorie where lernKategorieID = $lernKategorieID and benutzerID = $benutzerID and lernortID = $lernortID and quizID = $quizID ";
mysqli_query($con,$query);
$query ="insert into BenutzerKategorie (benutzerID,lernKategorieID,erfahrungspunkte,lernortID,quizID,created_at) VALUES ($benutzerID,$lernKategorieID,$erfahrungspunkte,$lernortID,$quizID,'".date("Y-m-d H:i:s")."');";
mysqli_query($con, $query);
$query = "select SUM(erfahrungspunkte) as erfahrungspunkte from BenutzerKategorie where benutzerID = $benutzerID AND lernKategorieID = $lernKategorieID;";
$res = mysqli_query($con,$query);
$point = 0;
while ($row = mysqli_fetch_assoc($res)) {
    $point = $row['erfahrungspunkte'] != null ? intval($row['erfahrungspunkte']) : 0;
}
$query = "select SUM(erfahrungspunkte) as erfahrungspunkte from BenutzerKategorie where benutzerID = $benutzerID";
$res = mysqli_query($con,$query);
$pointNew = 0;
while ($row = mysqli_fetch_assoc($res)) {
    $pointNew = $row['erfahrungspunkte'] != null ? intval($row['erfahrungspunkte']) : 0;
}
mysqli_free_result($res);
$query = "delete from RankKategorie where lernKategorieID = $lernKategorieID and benutzerID = $benutzerID";
mysqli_query($con,$query);
$query ="insert into RankKategorie (benutzerID,lernKategorieID,sum_erfahrungspunkte,created_at) VALUES ($benutzerID,$lernKategorieID,$point,'".date("Y-m-d H:i:s")."');";
mysqli_query($con, $query);

$data = [];
$data['total_point_new'] = $pointNew;
$data['total_point_old'] = $pointOld;
$data['status'] = true;
echo json_encode($data);
?>