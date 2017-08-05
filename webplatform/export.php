<?php


//Login to Database
require_once 'login.php';

$expid=(isset($_GET['eid']))? $_GET['eid'] : $_SESSION['eid'];

// find experiment and check if it is not locked
$query = "SELECT * FROM experiment WHERE exp_id='".$expid."'";
	
$exp = mysql_query($query);

if(!mysql_num_rows($exp)) 
	die('Invalid experiment id!');

//Export all posts

$output = "<?xml version=\"1.0\" ?>\n"; 
/*   
$queryExp = "SELECT * FROM experiment WHERE exp_id=".$expid;
$exp = mysql_query($queryExp);

if(mysql_num_rows($exp)==0)
{
	die('No Experiment with the given ID='.$expid);
}

$title =  mysql_result($Records1,0,'exp_title');	
$date =  mysql_result($Records1,0,'exp_date');
$output .= "<experiment id='".$expid."' title='".$title."' date='".$date."' />\n";
*/

$tables = array("posts", "sound", "images");
$groupout = array();

for($p=1; $p<=4; $p++)
{
	//Export notes
	$query = "SELECT * FROM posts WHERE name='player".$p."' and exp_id='".$expid."'";
	$Records = mysql_query($query);
	$rows = mysql_num_rows($Records);

	for ($i = 0 ; $i < $rows; ++$i)
	{
		$name =  mysql_result($Records,$i,'name');	
		$note =  mysql_result($Records,$i,'note');
		$gid =   mysql_result($Records,$i,'groupId');
		$groupout[$gid] .= "<post name=\"$name\" group=\"$gid\" note=\"$note\" />\n";
		//$output .= "<post name=\"$name\" note=\"$note\" />\n";
	}
	
	//Export sounds
	$query = "SELECT * FROM sound WHERE name='player".$p."' and exp_id='".$expid."'";
	$Records = mysql_query($query);
	$rows = mysql_num_rows($Records);

	for ($i = 0 ; $i < $rows; ++$i)
	{
		$name =  mysql_result($Records,$i,'name');	
		$sound =  mysql_result($Records,$i,'url');
		$gid =   mysql_result($Records,$i,'groupId');
		$groupout[$gid] .= "<sound name=\"$name\" group=\"$gid\" url=\"$sound\" />\n";
		//$output .= "<sound name=\"$name\" url=\"$sound\" />\n";
	}
	
	//Export images
	$query = "SELECT * FROM images WHERE name='player".$p."' and exp_id='".$expid."'";
	$Records = mysql_query($query);
	$rows = mysql_num_rows($Records);

	for ($i = 0 ; $i < $rows; ++$i)
	{
		$name =  mysql_result($Records,$i,'name');	
		$image =  mysql_result($Records,$i,'url');
		$gid =   mysql_result($Records,$i,'groupId');
		$groupout[$gid] .= "<image name=\"$name\" group=\"$gid\" url=\"$image\" />\n";
		//$output .= "<image name=\"$name\" url=\"$image\" />\n";
	}
}

$output .= "<posts>\n";

$prefix = "[expid_".mysql_result($exp,0,'exp_id')."]";

foreach($groupout as $gids => $out)
{
	$output .= $out;
	$myFile = $prefix."-".$gids."-posts.xml";
	
	$fh = fopen($myFile, 'w') or die("can't open file");
	fwrite($fh, "<?xml version=\"1.0\" ?>\n<posts>\n".$out."</posts>");
	fclose($fh);
}

$output .= "</posts>";

$myFile = $prefix."-posts.xml";

$fh = fopen($myFile, 'w') or die("Can't open file");

fwrite($fh, $output);

fclose($fh);

if(isset($_GET['loc']))
	header("Location: ".$_GET['loc']."?status=success");
else
	echo $output; 





// close the connection 

//mysql_close($dbhandle); 
?>