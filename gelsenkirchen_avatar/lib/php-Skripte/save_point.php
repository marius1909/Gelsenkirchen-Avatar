<?php
require_once("dbconfig.php");
$benutzerID = $_GET['benutzerID'];
$lernKategorieID = $_GET['lernKategorieID'];
$erfahrungspunkte = $_GET['erfahrungspunkte'];
$lernortID = $_GET['lernortID'];
$quizID = $_GET['quizID'];
$query_where = "where lernKategorieID = $lernKategorieID and benutzerID = $benutzerID";
$query_where_update = "where lernKategorieID = $lernKategorieID and benutzerID = $benutzerID and lernortID != $lernortID and quizID != $quizID";
$query = "select * from BenutzerKategorie $query_where;";
$res = mysqli_query($con,$query);
$data = array();
while ($row = mysqli_fetch_assoc($res)) {
    $data = $row;
}
mysqli_free_result($res);
if(count($data) > 0){
    if($data['lernortID'] == $lernortID && $data['quizID'] == $quizID){
        $query = "delete from BenutzerKategorie $query_where_insert ";
        mysqli_query($con,$query);
        $query ="insert into BenutzerKategorie (benutzerID,lernKategorieID,erfahrungspunkte,lernortID,quizID,created_at) VALUES ($benutzerID,$lernKategorieID,$erfahrungspunkte,$lernortID,$quizID,'".date("Y-m-d H:i:s")."');";
        if(mysqli_query($con, $query)){
            echo "true";
        }else{
            echo "false";
        }
    }
    else if($data['lernortID'] != $lernortID && $data['quizID'] != $quizID){
        $point_current = $data['erfahrungspunkte'] + $erfahrungspunkte;
        $query = "update BenutzerKategorie set erfahrungspunkte = $point_current, created_at = '".date("Y-m-d H:i:s")."' $query_where_update";
        if(mysqli_query($con, $query)){
            echo "true";
        }else{
            echo "false";
        }
    }
}else{
    $query ="insert into BenutzerKategorie (benutzerID,lernKategorieID,erfahrungspunkte,lernortID,quizID,created_at) VALUES ($benutzerID,$lernKategorieID,$erfahrungspunkte,$lernortID,$quizID,'".date("Y-m-d H:i:s")."');";
        if(mysqli_query($con, $query)){
            echo "true";
        }else{
            echo "false";
        }
}
// if(count($data) > 0){
//     
//     
//     
// }
// 

?>