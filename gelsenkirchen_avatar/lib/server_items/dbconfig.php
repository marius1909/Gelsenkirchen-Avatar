<?php

$db_name = "DB4266205";
$db_user = "U4266205";
$db_pass = "Zukunftsstadt2030";
$db_host = "rdbms.strato.de";

$con = mysqli_connect($db_host, $db_user, $db_pass, $db_name);

if(!$con){
    // echo "connection error";
}
else{
    // echo "connection successfull";
}

?>