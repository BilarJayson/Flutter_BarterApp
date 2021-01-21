<?php

require "connect.php";

if($_SERVER['REQUEST_METHOD']=="POST"){
   
    $response = array();
    $itemname = $_POST['itemname'];
    $tradedesc = $_POST['tradedesc'];
    $idUser = $_POST['idUser'];
    


    $insert = "UPDATE item SET itemname ='$itemname', tradedesc = '$tradedesc' WHERE id='$idUser'";
    if (mysqli_query($con,$insert))
    {
        $response['value'] = 1;
        $response['message'] = "Record Successfully";
        echo json_encode($response);
    }
    else
    {
        $response['value'] = 0;
        $response['message'] = "Record Failed";
        echo json_encode($response);
    }
     
    
    

  
   
 
}

?>