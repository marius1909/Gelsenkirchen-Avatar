 <?php

require_once("dbconfig.php");

$quizID = $_POST['quizID'];
$position = 0;

// Prüfe ob der Datensatz existiert

$query = "SELECT * FROM QuizFragen WHERE quizID = $quizID AND position = $position";
$res = mysqli_query($con,$query);
$data = mysqli_fetch_array($res);

//data[0] = id, data[1] = quizID, data[2] = frage, data[3] = antwort1, data[4] = antwort2, data[5] = antwort3, data[6] = antwort4, data[7] = position, data[8] = loesungstext
if($data[0] >= 1){
    // Datensatz existiert



        $resarr = array();
        while($data[0] >= 1){
        array_push($resarr,array("frage"=>$data['2'],"antwort"=> array($data['3'],$data['4'],$data['5'],$data['6'],$data['8'])));
        $position = $position + 1;    
        $query = "SELECT * FROM QuizFragen WHERE quizID = $quizID AND position = $position";
        $res = mysqli_query($con,$query);
        $data = mysqli_fetch_array($res);
        }
        
        echo json_encode($resarr);
  
}else{
    
    // Datensatz existiert nicht.

    echo json_encode('Datensatz existiert nicht');
}

?>