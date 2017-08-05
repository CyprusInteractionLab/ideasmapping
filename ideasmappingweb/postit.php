<?php 
require_once "header.php";
require_once "login.php";

?>

<script type="text/javascript"> 
	function stopRKey(evt)
	{ 
  		var evt = (evt) ? evt : ((event) ? event : null); 
  		var node = (evt.target) ? evt.target : ((evt.srcElement) ? evt.srcElement : null); 
  		if ((evt.keyCode == 13) && (node.type=="text"))  return false; 
	} 
	document.onkeypress = stopRKey; 
</script>

<script type="text/javascript" src="charCount.js"></script>

<div class="container">
<?php
//Load experiment
$expid = ($_GET['eid']!='')? $_GET['eid'] : $_SESSION['eid'];

if($expid!='')
{
	// find experiment and check if it is not locked
	$query = "SELECT * FROM experiment WHERE exp_id='".$expid."' AND exp_locked=0";
	
	$exp = mysql_query($query);
	
	if(!mysql_num_rows($exp))
	{
		die("<div class='row'><div class='alert alert-danger'><b>Error:</b> Experiment does not exist or you do not have permissions to modify it. Make sure that the experiment exists and is UNLOCKED by the administrator.</div></div></div>");
	}
	else{
		// set the session to the current experiment
		$_SESSION['eid']=$expid;
	}
}
else
{
	//no experiment was given
	die("<div class='row'><div class='alert alert-warning'><b>Warning:</b> Experiment was not specified. Please contact the instructor.</div></div></div>");
}
?>
	<div class="row">
		<div class="col-md-12">
  <!-- Inform user about the upload -->
	<?php
		$upload = $_GET['upload'];
		if ($upload == 'successful')
			echo "<div class='alert alert-success'>File upload was successful!</div>";
		elseif ($upload == 'failure')
			echo "<div class='alert alert-danger'>File upload was not successful...</div>";
		elseif ($upload == "unsupported")
			echo "<div class='alert alert-warning'>File format is not supported. Please use .mp3 for sounds and .jpg, .jpeg, .png or .bmp for images.</div>";
	?>
    	<div class="page-header">
			<h1>Experiment: <?php echo mysql_result($exp,0,'exp_title').",".mysql_result($exp,0,'exp_date');?></h1>
			<p class="lead">Please submit your ideas in the form of text, sound or image.</p>
		</div>
    	</div>
    </div> <!-- row -->
    <!-- Get player number and group number -->
  	<?php
		require 'export.php';
		//require 'exportGroups.php';
		#require 'exportMultimedia.php';
	
		$name = $_GET['name']; 
		$pname = $_GET['pname'];
		$gname = $_GET['gname'];
		$groups = mysql_result($exp,0,'exp_groups');
		
		//$groupOptions = array(0=>'None',1 => 'Group 1', 2 => 'Group 2', 3 => 'Group 3', 4 => 'Group 4', 5 => 'Group 5', 6 => 'Group 6');
	
		//specify the group to preselect
		if(isset($gname))
		{
			//get the index of the group
			$grp_to_preselect = $gname[5];
		}
		else
		{
			$grp_to_preselect = 1;
		}	
		
		$playerOptions = array(1 => 'Player 1', 2 => 'Player 2', 3 => 'Player 3', 4 => 'Player 4');
		
		//specify the player to preselect
		if(isset($pname))
		{
			$plr_to_preselect = $pname[6];
		}
		else
		{
			$plr_to_preselect = 1;
		}
		
		//echo "Gr:".$gname." - ".$grp_to_preselect.", Pl:".$pname." - ".$plr_to_preselect;
	?>
    <div class="row">
    <div class="col-md-12">
    
<form role="form" class="form-horizontal" enctype="multipart/form-data" method="POST" action="post.php" name="form1">
	<div class="form-group">
    <label for="_groupName">Select Group</label>
    <?php
	
    	echo '<select name="_groupName" id="_groupName">';

			for($index=1; $index <= $groups; $index++)
			{
				print '    <option value="group' . $index . '"';
				if ($index == $grp_to_preselect)
					print ' selected="yes" ';
				print '>Group ' . $index . '</option>';
			}
			echo '</select><br/><br/>';
		?>
    </div>
    
    <div class="form-group">
    <label for="_playerName">Select Player</label>
    <?php
		echo '<select name="_playerName" id="_playerName">';
			foreach ($playerOptions as $index => $value)
			{
				print '    <option value="player' . $index . '"';
				if ($index == $plr_to_preselect)
					print ' selected="yes" ';
				print '>' . $value . '</option>';
			}
			echo '</select><br/><br/>';
	?>
    </div>

	<div class="form-group">
		<label for="_note">Note</label>
		<input class="form-control input-lg" type="text" name="_note" id="_note" size="100" maxlength="100"
onkeyup="CheckFieldLength(_note, 'charcount3', 'remaining3', 95);" onKeyDown="CheckFieldLength(_note, 'charcount3', 'remaining3', 95);" onMouseOut="CheckFieldLength(_note, 'charcount3', 'remaining3', 95);"/>
		<p class="help-block"><span id="charcount3">0</span> characters entered,   <span id="remaining3">95</span> characters remaining.</p>
    </div>
	
    <div class="form-group">
		<label for="files">File Upload</label>
		<input type="file" multiple='multiple' name="files[]"/>
    	<p class="help-block"> You can upload sound (.mp3) or image files (.jpg, .jpeg, .png, .bmp).</p>
     </div>

    <button class="btn btn-primary" type="submit"> Submit/Upload </button>
    </form>
    </div>
    </div> <!-- row -->
    
  	<hr>


    
    
    
 <div class="row">
 <div class="col-md-12">   
	<img class="img-rounded center" src="images/SUR40.jpg" width="400" height="400" alt="SUR40 taabletop" />
</div>
</div>





<!-- DO NOT EDIT AFTER THIS LINE -->


</div> <!-- container -->

<?php require_once "footer.php";?>

