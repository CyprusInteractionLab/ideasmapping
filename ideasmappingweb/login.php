<?php // login.php

$db_hostname = 'ideasmappingdb.db.10088771.hostedresource.com';

$db_database = 'ideasmappingdb';

$db_username = 'ideasmappingdb';

$db_password = 'Inetuser1@cil';

/*
$db_con = new mysqli($db_hostname,$db_username,$db_password,$db_database);

if($db_con->connect_errno)
{
	die("Failed to connect to MySQL: (" . $db_con->connect_errno . ") " . $db_con->connect_error);	
}
$db_con->query("SET NAMES 'utf8'");
*/

$db_server = mysql_connect($db_hostname, $db_username, $db_password);

if (!$db_server)
{
	echo "error1";
	die("Unable to connect to MySQL: " . mysql_error());
}

mysql_select_db($db_database, $db_server);
mysql_query("SET NAMES 'utf8'");
mysql_query("SET CHARACTER SET 'utf8'");
