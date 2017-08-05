<?php



require_once 'login.php';

$db_server = mysql_connect($db_hostname, $db_username, $db_password);



if (!$db_server)

{

	echo "error1";

	die("Unable to connect to MySQL: " . mysql_error());

}

mysql_select_db($db_database) or die("Unable to select database: " . mysql_error());

$output = "";


//$query = "TRUNCATE TABLE posts";
//$Records = mysql_query($query);
//echo $output; 


$myFile = "posts.xml";

$i=0;

//make a backup of the xml
$bakFile = date('Y_m_d')."-".$myFile.".bak".$i;

while(is_file($bakFile)){
	$i++;
	$bakFile = date('Y_m_d')."-".$myFile.".bak".$i;
}


echo "Backing up file in: ".$bakFile."<br>";

copy($myFile,$bakFile);

$fh = fopen($myFile, 'w') or die("can't open file");

//fwrite($fh, $output);

fclose($fh);

echo "Cleared file: ".$myFile."<br>";

// close the connection 

mysql_close($db_server); 

?> 