<?php
error_reporting(0);
include_once ("dbconnect.php");
$email = $_POST['email'];

//$sql = "SELECT * FROM FLOWERORDER WHERE EMAIL = '$email'"; 

$sql = "SELECT FLOWERORDER.FLOWERID,FLOWERORDER.FLOWERQTY,FLOWERORDER.REMARKS,FLOWERORDER.SHOPID, FLOWER.FLOWERNAME, FLOWER.IMAGE, FLOWER.FLOWERPRICE ,SHOP.NAME FROM FLOWERORDER 
INNER JOIN FLOWER ON FLOWERORDER.FLOWERID = FLOWER.FLOWERID
INNER JOIN SHOP ON FLOWERORDER.SHOPID = SHOP.ID
WHERE FLOWERORDER.EMAIL= '$email'";  


$result = $conn->query($sql);

if ($result->num_rows > 0)
{
    $response["cart"] = array();
    while ($row = $result->fetch_assoc())
    { 
        $cartlist = array();
        $cartlist["flowerid"] = $row["FLOWERID"]; 
        $cartlist["flowerqty"] = $row["FLOWERQTY"];
        $cartlist["remarks"] = $row["REMARKS"];
        $cartlist["shopid"] = $row["SHOPID"];
        $cartlist["flowername"] = $row["FLOWERNAME"];
        $cartlist["flowerimg"] = $row["IMAGE"];
        $cartlist["flowerprice"] = $row["FLOWERPRICE"];
         $cartlist["shopname"] = $row["NAME"];
        


        
        array_push($response["cart"], $cartlist);
    }
    echo json_encode($response);
}
else
{
    echo "nodata";
}
?>