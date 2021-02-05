<?php
error_reporting(0);
include_once ("dbconnect.php");
 

$shopid = $_POST['shopid'];
$sql = "SELECT * FROM FLOWER WHERE SHOPID = '$shopid'";    
$result = $conn->query($sql);

if ($result->num_rows > 0)
{
    $response["flower"] = array();
    while ($row = $result->fetch_assoc())
    { 
        $flowerlist = array();
        $flowerlist["flowerid"] = $row["FLOWERID"];
        $flowerlist["flowername"] = $row["FLOWERNAME"];
        $flowerlist["flowerprice"] = $row["FLOWERPRICE"];
        $flowerlist["flowerqty"] = $row["QUANTITY"];
         $flowerlist["flowerimg"] = $row["IMAGE"];
        
        array_push($response["flower"], $flowerlist);
    }
    echo json_encode($response);
}
else
{
    echo "nodata";
}
?>