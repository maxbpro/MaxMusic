<?php
 if($_POST['password'] == "COY7RZRDZB")
 {
    require_once('pclzip.lib.php');
    $uid = $_POST['uid'];
    $achive = $_POST['achive'];
    $name = $_POST['name'];
    $info = $_POST['info'];


    mkdir($uid);
    $fp = fopen("$uid/$name" ,'w');  
    if($fp)
    {
        $info = str_replace("\\","",$info);
	$result = fwrite($fp, $info);
	fclose($fp);
	if($result)
	{ 
             $zip = new PclZip("./Projects/$achive.zip");
             $v_list = $zip->add("$uid/$name");
             if ($v_list != 0) 
             {
                unlink("$uid/$name");
                rmdir($uid);
                echo "response=success";
             }
             else
             { 
                unlink("$uid/$name");
                rmdir($uid);
                echo "response=error";
             }
      
        }
	else
        {
          unlink("$uid/$name");
          rmdir($uid);
	  echo "response=error";
        }
         
    }
    else
    {
       echo "response=fopenError";	
    }
 }
 else 
   echo "response=PasswordIsWrong";

?>