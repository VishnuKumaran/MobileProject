<?php
$servername = "localhost";
$username   = "jarfpcom_dreampetalsadmin";
$password   = "e29W7ICXBx6a";
$dbname     = "jarfpcom_dreampetals";

$conn = new mysqli($servername, $username, $password, $dbname);

if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}
?>