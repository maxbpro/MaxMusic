<?php
 if($_POST['password'] == "COY7RZRDZB")
 {
    require_once('pclzip.lib.php');
    $uid = $_POST['uid'];
    $achive = $_POST['achive'];
    $name = $_POST['name'];
    
 

    $zip = new PclZip("./Projects/$achive.zip");
    $v_list = $zip->delete(PCLZIP_OPT_BY_NAME,"$uid/$name");
    if ($v_list > 0) 
         echo "response=success";
    else
        echo "response=error"; 
    	
 }
 else 
   echo "response=PasswordIsWrong";

?>