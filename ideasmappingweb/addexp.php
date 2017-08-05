<?php
$act = $_GET['action'];
$eid = $_GET['eid'];

$val = ($act == 'unlock')? 0 : 1; 

require_once 'login.php';

$title = $_POST['exptitle'];
$org = $_POST['exporg'];
$date = ($_POST['expdate']!="")? $_POST['expdate'] : date("Y-m-d");
$groups = $_POST['expgrps'];

if(isset($title))
{
	$query="INSERT INTO experiment (exp_title, exp_organizer,exp_date,exp_groups) VALUES ('$title','$org' ,'$date','$groups')"; 

	if(mysql_query($query, $db_server)){
	//redirect to the main page
		header('Location:./index.php?status=success');
	}
	else
	{
		//redirect to the main page
		header('Location:./index.php?status=fail');
	}
}
else
{
		//redirect to the main page
		header('Location:./index.php?status=fail');
}