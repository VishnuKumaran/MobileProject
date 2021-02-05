<?php
error_reporting(0);
include_once("dbconnect.php");
$email = $_POST['email'];
$password = $_POST['password'];

$sqllogin = "SELECT * FROM USER WHERE EMAIL = '$email' AND PASSWORD = '$password'";
$result = $conn->query($sqllogin);

if ($result->num_rows > 0) {
    while ($row = $result ->fetch_assoc()){
       // echo "success";
        echo $data= "success,".$row["NAME"].",".$row["PHONE"].",".$row["DATEREG"];
    }
}else{
    echo "failed";
} 

?>