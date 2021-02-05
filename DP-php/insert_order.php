<?php
error_reporting(0);
include_once("dbconnect.php");
$email= $_POST['email'];
$flowerid= $_POST['flowerid'];
$flowerqty= $_POST['quantity'];
$remarks= $_POST['remarks'];
$shopid= $_POST['shopid'];


$sqlcheck = "SELECT * FROM FLOWERORDER WHERE FLOWERID = '$flowerid' AND EMAIL = '$email'";
$result = $conn->query($sqlcheck);

if ($result->num_rows > 0){
    $sqlupdate = "UPDATE FLOWERORDER SET FLOWERQTY = '$flowerqty', REMARKS = '$remarks' WHERE FLOWERID = '$flowerid'AND EMAIL = '$email' ";
   if ($conn->query($sqlupdate) === TRUE){
    echo "success";
} 
}
else {
   $sqlinsert = "INSERT INTO FLOWERORDER (EMAIL,FLOWERID,FLOWERQTY,REMARKS,SHOPID) VALUES ('$email','$flowerid' ,'$flowerqty','$remarks','$shopid')";
if ($conn->query($sqlinsert) === TRUE){
    echo "success";
} 
}

?>