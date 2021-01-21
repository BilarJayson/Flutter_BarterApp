<?php

require "connect.php";

if($_SERVER['REQUEST_METHOD']=="POST"){
  
    $response = array();
    $itemname = $_POST['itemname'];
    $number = $_POST['number'];
    $tradedesc = $_POST['tradedesc'];
    $idUser = $_POST['idUser'];

    $image = date('dmYHis').str_replace(" "," ", basename($_FILES['image']['name']));
    $imagePath = "uploads/".$image;
    move_uploaded_file($_FILES['image']['tmp_name'],$imagePath);



    $insert ="INSERT INTO item VALUE(NULL,'$itemname','$number','$tradedesc','$image',NOW(),'$idUser')";
    if (mysqli_query($con,$insert))
    {
        $response['value'] = 1;
        $response['message'] = "Record Successfully Added";
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