<?php

include "connect.php";

if($_SERVER['REQUEST_METHOD']=="GET"){

 

	$queryResult = $con->query("SELECT * FROM item");
	
	
	$result = array ();
	while($fetchData = $queryResult->fetch_assoc()){
	    $result[] = $fetchData;
	}
	echo json_encode($result);
   
}


?>
