<?php

 if($_POST['password'] == "COY7RZRDZB")
 {
    $id = $_POST['id'];
    $dir = './Projects/' . $id;
    if(!file_exists($dir))
    {
      $result = mkdir($dir, 0777);
      if($result)
         echo "response=success";
      else
         echo "response=error";	
    }
 }
 else 
   echo "response=PasswordIsWrong";

  
?>