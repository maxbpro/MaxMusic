<?php


if($_POST['password'] == "COY7RZRDZB")
{

        mysql_connect("mysql52.hoster.ru","m59752","EU5DzsQg");
        mysql_select_db("db59752m");
      
	$uid = $_POST['uid'];
	$tack= $_POST['tack'];   
        $opened = $_POST['opened'];
        $columb = $_POST['columb'];
        $result = mysql_query("UPDATE people SET tack = '$tack', opened = '$opened', columb = '$columb' WHERE uid=$uid" );
        if($result)
           echo "response=success";
        else
           echo "response=error";
	
        
}
else
   echo "response=PasswordIsWrong";
 

?>