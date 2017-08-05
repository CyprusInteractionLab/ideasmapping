<?php 
session_start();
require_once 'login.php';
//require 'export.php';
//require 'exportGroups.php';

$pname= $_POST['_playerName'];
$gname= $_POST['_groupName'];
$note=$_POST['_note'];
$expid=$_SESSION['eid']; 
$file=$_FILES["file"]["name"];

// find experiment and check if it is not locked
$query = "SELECT * FROM experiment WHERE exp_id='".$expid."' AND exp_locked=0";
	
$exp = mysql_query($query);
	
// escape immediately if experiment is not specified
if(!isset($expid) || !mysql_num_rows($exp)){
	header ("Location: ./postit.php?error=eid");
}

/*
echo 'Group name is: '.$pname;
echo 'Player name is: '.$gname;
echo 'Note is: '.$note;
*/
$URL="./postit.php?pname=$pname&gname=$gname"; 



//Insert results into the database

if(isset($pname) && isset($note) && isset($gname) && ($note != "") )
{
	

 $query="INSERT INTO posts (name, note,groupId,exp_id) VALUES ('$pname','$note' ,'$gname','$expid')";

  
    mysql_query($query);

}

//die(var_dump($_FILES['files']));

$file_count = count($_FILES['files']['name']);

$status = "successful";
//if ($files["error"] <= 0 && $file!="")
for($i=0; $i<$file_count; $i++)
{
	$filename =  $_FILES["files"]["name"][$i];
	if(move_uploaded_file($_FILES["files"]["tmp_name"][$i], "uploads/" .$filename)) {
		//die("http://" . $_SERVER['DOCUMENT_ROOT']."/uploads/".$file);
		$ext = strtolower(pathinfo($filename, PATHINFO_EXTENSION));
		if ($ext=="mp3")
		{
			$query="INSERT INTO sound (name, url ,groupId,exp_id) VALUES ('$pname','$filename','$gname','$expid')";
			mysql_query($query);
		}
		else if ($ext == "jpg" || $ext == "jpeg" || $ext == "png" || $ext == "bmp")
		{
			$query="INSERT INTO images (name, url ,groupId,exp_id) VALUES ('$pname','$filename','$gname','$expid')";
			mysql_query($query);
		}
		else
			$status = "unsupported";
	} else{
		$status = "failure";
	}
}

$URL="./postit.php?pname=$pname&gname=$gname&upload=".$status;
header ("Location: $URL");

function reArrayFiles(&$file_post) {

    $file_ary = array();
    $file_count = count($file_post['name']);
    $file_keys = array_keys($file_post);

    for ($i=0; $i<$file_count; $i++) {
        foreach ($file_keys as $key) {
            $file_ary[$i][$key] = $file_post[$key][$i];
        }
    }

    return $file_ary;
}

?>
