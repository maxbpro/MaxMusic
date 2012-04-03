<?php
 if($_POST['password'] == "COY7RZRDZB")
 {
    require_once('pclzip.lib.php');
    $uid = $_POST['uid'];
    $achive = $_POST['achive'];
    $name = $_POST['name'];
    
    $zip = new PclZip("./Projects/$achive.zip");

    $project = $zip->extract(PCLZIP_OPT_BY_NAME, "$uid/$name",
                              PCLZIP_OPT_EXTRACT_AS_STRING);
    if ($project > 0) 
      echo "response=" . $project[0]['content'];
    else
      echo "response=error";

 }
 else 
   echo "response=PasswordIsWrong";

?>