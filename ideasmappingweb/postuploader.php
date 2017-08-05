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
    
<form role="form" class="form-horizontal" enctype="multipart/form-data" method="POST" action="post.php" name="form1" id="fileupload">
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
	
  
    <!-- The file upload form used as target for the file upload widget -->
    <!--<form id="fileupload" action="./post_files.php" method="POST" enctype="multipart/form-data"> -->
        <!-- Redirect browsers with JavaScript disabled to the origin page -->
        <noscript><input type="hidden" name="redirect" value="./postit.php"></noscript>
        <!-- The fileupload-buttonbar contains buttons to add/delete files and start/cancel the upload -->
        <div class="row fileupload-buttonbar">
            <div class="col-lg-7">
                <!-- The fileinput-button span is used to style the file input field as button -->
                <span class="btn btn-success fileinput-button">
                    <i class="glyphicon glyphicon-plus"></i>
                    <span>Add files...</span>
                    <input type="file" name="files[]" multiple>
                </span>
                <button type="submit" class="btn btn-primary start">
                    <i class="glyphicon glyphicon-upload"></i>
                    <span>Submit/Upload </span>
                </button>
                <button type="reset" class="btn btn-warning cancel">
                    <i class="glyphicon glyphicon-ban-circle"></i>
                    <span>Cancel upload</span>
                </button>
                <!-- The global file processing state -->
                <span class="fileupload-process"></span>
            </div>
            <!-- The global progress state -->
            <div class="col-lg-5 fileupload-progress fade">
                <!-- The global progress bar -->
                <div class="progress progress-striped active" role="progressbar" aria-valuemin="0" aria-valuemax="100">
                    <div class="progress-bar progress-bar-success" style="width:0%;"></div>
                </div>
                <!-- The extended global progress state -->
                <div class="progress-extended">&nbsp;</div>
            </div>
        </div>
        <!-- The table listing the files available for upload/download -->
        <table role="presentation" class="table table-striped"><tbody class="files"></tbody></table>
    </form>
    <br>
    <div class="panel panel-default">
        <div class="panel-heading">
            <h3 class="panel-title">Notes</h3>
        </div>
        <div class="panel-body">
            <ul>
                <li>The maximum file size for uploads is <strong>5 MB</strong>.</li>
                <li>Only sound (<strong>MP3</strong>) and image files (<strong>JPG, JPEG, PNG, BMP</strong>) are allowed.</li>
                <li>You can <strong>drag &amp; drop</strong> files from your desktop on this webpage (see <a href="https://github.com/blueimp/jQuery-File-Upload/wiki/Browser-support">Browser support</a>).</li>
                </ul>
        </div>
    </div>
</div>
<!-- The blueimp Gallery widget -->
<div id="blueimp-gallery" class="blueimp-gallery blueimp-gallery-controls" data-filter=":even">
    <div class="slides"></div>
    <h3 class="title"></h3>
    <a class="prev">‹</a>
    <a class="next">›</a>
    <a class="close">×</a>
    <a class="play-pause"></a>
    <ol class="indicator"></ol>
</div>
<!-- The template to display files available for upload -->
<script id="template-upload" type="text/x-tmpl">
{% for (var i=0, file; file=o.files[i]; i++) { %}
    <tr class="template-upload fade">
        <td>
            <span class="preview"></span>
        </td>
        <td>
            <p class="name">{%=file.name%}</p>
            <strong class="error text-danger"></strong>
        </td>
        <td>
            <p class="size">Processing...</p>
            <div class="progress progress-striped active" role="progressbar" aria-valuemin="0" aria-valuemax="100" aria-valuenow="0"><div class="progress-bar progress-bar-success" style="width:0%;"></div></div>
        </td>
        <td>
            {% if (!i && !o.options.autoUpload) { %}
                <button class="btn btn-primary start" disabled>
                    <i class="glyphicon glyphicon-upload"></i>
                    <span>Start</span>
                </button>
            {% } %}
            {% if (!i) { %}
                <button class="btn btn-warning cancel">
                    <i class="glyphicon glyphicon-ban-circle"></i>
                    <span>Cancel</span>
                </button>
            {% } %}
        </td>
    </tr>
{% } %}
</script>
<!-- The template to display files available for download -->
<script id="template-download" type="text/x-tmpl">
{% for (var i=0, file; file=o.files[i]; i++) { %}
    <tr class="template-download fade">
        <td>
            <span class="preview">
                {% if (file.thumbnailUrl) { %}
                    <a href="{%=file.url%}" title="{%=file.name%}" download="{%=file.name%}" data-gallery><img src="{%=file.thumbnailUrl%}"></a>
                {% } %}
            </span>
        </td>
        <td>
            <p class="name">
                {% if (file.url) { %}
                    <a href="{%=file.url%}" title="{%=file.name%}" download="{%=file.name%}" {%=file.thumbnailUrl?'data-gallery':''%}>{%=file.name%}</a>
                {% } else { %}
                    <span>{%=file.name%}</span>
                {% } %}
            </p>
            {% if (file.error) { %}
                <div><span class="label label-danger">Error</span> {%=file.error%}</div>
            {% } %}
        </td>
        <td>
            <span class="size">{%=o.formatFileSize(file.size)%}</span>
        </td>
        <td>
            {% if (file.deleteUrl) { %}
                <button class="btn btn-danger delete" data-type="{%=file.deleteType%}" data-url="{%=file.deleteUrl%}"{% if (file.deleteWithCredentials) { %} data-xhr-fields='{"withCredentials":true}'{% } %}>
                    <i class="glyphicon glyphicon-trash"></i>
                    <span>Delete</span>
                </button>
                <input type="checkbox" name="delete" value="1" class="toggle">
            {% } else { %}
                <button class="btn btn-warning cancel">
                    <i class="glyphicon glyphicon-ban-circle"></i>
                    <span>Cancel</span>
                </button>
            {% } %}
        </td>
    </tr>
{% } %}
</script>
</div>
 
 <div class="col-md-6"> 
<img class="img-rounded center" src="images/SUR40.jpg" width="400" height="400" alt="SUR40 taabletop" />
</div>
</div>





<!-- DO NOT EDIT AFTER THIS LINE -->


</div> <!-- container -->

<?php require_once "footer.php";?>

