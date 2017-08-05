<?php


//Login to Database
require_once 'login.php';

$expid=(isset($_GET['eid']))? $_GET['eid'] : $_SESSION['eid'];

// find experiment and check if it is not locked
$query = "SELECT * FROM experiment ORDER BY exp_date DESC";
	
$exp = mysql_query($query);

if(!mysql_num_rows($exp)) 
	die('Invalid experiment id!');

//Export all posts

$output = "<?xml version=\"1.0\" ?>\n";
$output .= "<experiments>\n"; 
for($i=0; $i<mysql_num_rows($exp); $i++)
{
	$title =  mysql_result($exp,$i,'exp_title');	
	$date =  mysql_result($exp,$i,'exp_date');
	$id =   mysql_result($exp,$i,'exp_id');
	$output .= "<experiment title=\"$title\" id=\"$id\" date=\"$date\" />\n";
}

$output .= "</experiments>";

$outFile = "experiments.xml";

$fh = fopen($outFile, 'w') or die("Can't open file");

fwrite($fh, $output);

fclose($fh);

if(isset($_GET['loc']))
	header("Location: ".$_GET['loc']."?status=success");
else
	echo $output; 





// close the connection 

//mysql_close($dbhandle); 
?>