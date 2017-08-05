<?php


//Login to Database
require_once 'login.php';

//Export all posts in groups
for ($j=1; $j<7 ; ++$j)
{

	$output = "<?xml version=\"1.0\" ?>\n"; 
	$output .= "<posts>\n";    
/*	
	$query = "SELECT * FROM posts WHERE groupId='group".$j."'";
	
	$Records = mysql_query($query);
	echo 'number of records: '.$Records;
	$rows = mysql_num_rows($Records);
*/	
	
	$query1 = "SELECT * FROM posts WHERE name='player1' AND groupId='group".$j."'";
	$Records1 = mysql_query($query1);
	$rows1 = mysql_num_rows($Records1);
	
	$query2 = "SELECT * FROM posts WHERE name='player2' AND groupId='group".$j."'";
	$Records2 = mysql_query($query2);
	$rows2 = mysql_num_rows($Records2);
	
	$query3 = "SELECT * FROM posts WHERE name='player3' AND groupId='group".$j."'";
	$Records3 = mysql_query($query3);
	$rows3 = mysql_num_rows($Records3);
	
	$query4 = "SELECT * FROM posts WHERE name='player4' AND groupId='group".$j."'";
	$Records4 = mysql_query($query4);
	$rows4 = mysql_num_rows($Records4);

	for ($i = 0 ; $i < max($rows1,$rows2,$rows3,$rows4) ; ++$i)
	{
		if ($i<$rows1)
		{
			$name =  mysql_result($Records1,$i,'name');	
			$note =  mysql_result($Records1,$i,'note');
			$output .= "<post name=\"$name\" note=\"$note\" />\n";
		}
		if ($i<$rows2)
		{
			$name =  mysql_result($Records2,$i,'name');	
			$note =  mysql_result($Records2,$i,'note');
			$output .= "<post name=\"$name\" note=\"$note\" />\n";
		}
		if ($i<$rows3)
		{
			$name =  mysql_result($Records3,$i,'name');	
			$note =  mysql_result($Records3,$i,'note');
			$output .= "<post name=\"$name\" note=\"$note\" />\n";
		}
		if ($i<$rows4)
		{
			$name =  mysql_result($Records4,$i,'name');	
			$note =  mysql_result($Records4,$i,'note');
			$output .= "<post name=\"$name\" note=\"$note\" />\n";
		}
	}

	$query1 = "SELECT * FROM sound WHERE name='player1' AND groupId='group".$j."'";
	$Records1 = mysql_query($query1);
	$rows1 = mysql_num_rows($Records1);
	
	$query2 = "SELECT * FROM sound WHERE name='player2' AND groupId='group".$j."'";
	$Records2 = mysql_query($query2);
	$rows2 = mysql_num_rows($Records2);
	
	$query3 = "SELECT * FROM sound WHERE name='player3' AND groupId='group".$j."'";
	$Records3 = mysql_query($query3);
	$rows3 = mysql_num_rows($Records3);
	
	$query4 = "SELECT * FROM sound WHERE name='player4' AND groupId='group".$j."'";
	$Records4 = mysql_query($query4);
	$rows4 = mysql_num_rows($Records4);

	
	for ($i = 0 ; $i < max($rows1,$rows2,$rows3,$rows4) ; ++$i)
{
	if ($i<$rows1)
	{
		$name =  mysql_result($Records1,$i,'name');	
		$sound =  mysql_result($Records1,$i,'url');
		$output .= "<sound name=\"$name\" url=\"$sound\" />\n";
	}
	if ($i<$rows2)
	{
		$name =  mysql_result($Records2,$i,'name');	
		$sound =  mysql_result($Records2,$i,'url');
		$output .= "<sound name=\"$name\" url=\"$sound\" />\n";
	}
	if ($i<$rows3)
	{
		$name =  mysql_result($Records3,$i,'name');	
		$sound =  mysql_result($Records3,$i,'url');
		$output .= "<sound name=\"$name\" url=\"$sound\" />\n";
	}
	if ($i<$rows4)
	{
		$name =  mysql_result($Records4,$i,'name');	
		$sound =  mysql_result($Records4,$i,'url');
		$output .= "<sound name=\"$name\" url=\"$sound\" />\n";
	}
}

	$query1 = "SELECT * FROM images WHERE name='player1' AND groupId='group".$j."'";
	$Records1 = mysql_query($query1);
	$rows1 = mysql_num_rows($Records1);
	
	$query2 = "SELECT * FROM images WHERE name='player2' AND groupId='group".$j."'";
	$Records2 = mysql_query($query2);
	$rows2 = mysql_num_rows($Records2);
	
	$query3 = "SELECT * FROM images WHERE name='player3' AND groupId='group".$j."'";
	$Records3 = mysql_query($query3);
	$rows3 = mysql_num_rows($Records3);
	
	$query4 = "SELECT * FROM images WHERE name='player4' AND groupId='group".$j."'";
	$Records4 = mysql_query($query4);
	$rows4 = mysql_num_rows($Records4);

	

for ($i = 0 ; $i < max($rows1,$rows2,$rows3,$rows4) ; ++$i)
{
	if ($i<$rows1)
	{
		$name =  mysql_result($Records1,$i,'name');	
		$image =  mysql_result($Records1,$i,'url');
		$output .= "<image name=\"$name\" url=\"$image\" />\n";
	}
	if ($i<$rows2)
	{
		$name =  mysql_result($Records2,$i,'name');	
		$image =  mysql_result($Records2,$i,'url');
		$output .= "<image name=\"$name\" url=\"$image\" />\n";
	}
	if ($i<$rows3)
	{
		$name =  mysql_result($Records3,$i,'name');	
		$image =  mysql_result($Records3,$i,'url');
		$output .= "<image name=\"$name\" url=\"$image\" />\n";
	}
	if ($i<$rows4)
	{
		$name =  mysql_result($Records4,$i,'name');	
		$image =  mysql_result($Records4,$i,'url');
		$output .= "<image name=\"$name\" url=\"$image\" />\n";
	}
}
	
	$output .= "</posts>";
	echo $output; 
	
	$myFile = "postsGroup".$j.".xml";
	
	$fh = fopen($myFile, 'w') or die("can't open file");
	
	fwrite($fh, $output);
	$output= "";
	fclose($fh);

}
