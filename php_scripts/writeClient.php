<?php

mysql_connect("mysql52.hoster.ru","m59752","EU5DzsQg");
mysql_select_db("db59752m");

if($_POST['password'] == "COY7RZRDZB")
{
      
	$uid = $_POST['uid'];

	$result = mysql_query("INSERT IGNORE INTO `people` (`uid`,`tack`,`opened`) VALUES ('". $uid ."','100','empty') ");
		
	if($result != false)	
           echo "response=success";
        else
           echo "response=error";
}
else
  echo "response=PasswordIsWrong";
 

?>