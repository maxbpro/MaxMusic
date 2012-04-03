<?php
require_once('pclzip.lib.php');
if($_POST['password'] == "COY7RZRDZB")
{
    mysql_connect("mysql52.hoster.ru","m59752","EU5DzsQg");
    mysql_select_db("db59752m");
	$uid = $_POST['uid'];
	//$uid = "123";

    // ѕроверка на наличие в базе и чтение при наличии
    $result = mysql_query("SELECT * FROM people WHERE uid='$uid'");

    if(mysql_num_rows($result) == 1)
    {
          $row = mysql_fetch_array($result);          echo "response=success&tack=" .  $row['tack'] . "&opened=" . $row['opened'] .
                             "&hits=" . $row['hits'] . "&fanat=" . $row['fanat'] .
                             "&creater=" . $row['creater'] . "&painter=" . $row['painter'] .
                             "&columb=" . $row['columb'] . "&achive=" . $row['achive'];    }
    else
    {           $list = glob("./Projects/*.zip");
           if(count($list) != 0 )
           {                $archive = new PclZip($list[count($list)-1]);
                $properties = $archive->properties();
                if ($properties['nb']>1000)
                {                	 $nameAchive = baseName($list[count($list)-1]);
                	 $n = $nameAchive+1;
                	 if($n>=100)
                	     $nameAchive = "0" . $n;
                	 else
                	   if($n>=10)
                	        $nameAchive = "00" . $n;
                	   else
                	       if($n>=0)
                	        $nameAchive = "000" . $n;

                     $archive = new PclZip("./Projects/$nameAchive" . ".zip");                     $result = $archive->create($uid);                }
                else
                {                	$nameAchive = baseName($list[count($list)-1]);
                }

           }
           else
           {
                mkdir($uid);                $archive = new PclZip("./Projects/0001.zip");
                $archive->create($uid);
                $nameAchive  = '0001';
                rmdir($uid);           }

           $result = mysql_query("INSERT INTO people (achive ,uid, tack , opened , hits ,  time , fanat ,
              creater,painter,columb) VALUES ('$nameAchive' ,'$uid','100','empty','empty', " . time() . ",0,0,0,0) ");

	       if($result != false)
              echo "response=success&tack=100&opened=empty&hits=empty&fanat=0&creater=0&painter=0&columb=0&achive=$nameAchive";
           else
              echo "response=error";    }
}
else
  echo "response=PasswordIsWrong";
?>