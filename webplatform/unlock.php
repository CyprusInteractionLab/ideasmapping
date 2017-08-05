<?php
$act = $_GET['action'];
$eid = $_GET['eid'];

$val = ($act == 'unlock')? 0 : 1; 

require_once 'login.php';

$query = "UPDATE experiment SET exp_locked='".$val."' WHERE exp_id='".$eid."'";

if(mysql_query($query, $db_server)){
	//redirect to the main page
	header('Location:./index.php?status=success');
}
else
{
	//redirect to the main page
	header('Location:./index.php?status=fail');
}