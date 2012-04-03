<?php
if($_POST['password'] == "COY7RZRDZB")
{
   require_once('pclzip.lib.php');
   $uid = $_POST['uid'];
   $achive = $_POST['achive'];


   $zip = new PclZip("./Projects/$achive.zip");

   if (($list = $zip->listContent()) > 0)
   {
       $st = "";
       for($i=1; $i<count($list); $i++)
       {
          $st = $st . basename($list[$i][filename]) . ',';
       }
       echo "response=success&list=$st";
   }
   else
   { 
       echo "response=error";
       
   }
 


}
else
   echo "response=PasswordIsWrong";
?>