 <?php
require_once("dbconfig.php");
$query = "select Quiz.id, Lernort.name from Lernort,Quiz where Quiz.lernortID = Lernort.id";
$res = mysqli_query($con,$query);
$data = array();

while ($row = mysqli_fetch_assoc($res)) {
    $data[] = $row;
}
mysqli_free_result($res);
header('Content-Type: application/json');

echo json_encode($data); 
?>