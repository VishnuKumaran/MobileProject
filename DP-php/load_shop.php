<?php
error_reporting(0);
include_once ("dbconnect.php");
 
//$name = $_POST['name'];

$location = $_POST['location'];
$sql = "SELECT * FROM SHOP WHERE LOCATION = '$location'";    
$result = $conn->query($sql);

if ($result->num_rows > 0)
{
    $response["shop"] = array();
    while ($row = $result->fetch_assoc())
    { 
        $shoplist = array();
        $shoplist["shopid"] = $row["ID"];
        $shoplist["shopname"] = $row["NAME"];
        $shoplist["shopphone"] = $row["PHONE"];
        $shoplist["shoplocation"] = $row["LOCATION"];
        $shoplist["shopimage"] = $row["IMAGE"];
        
        array_push($response["shop"], $shoplist);
    }
    echo json_encode($response);
}
else
{
    echo "nodata";
}
?>