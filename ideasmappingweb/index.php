<?php require_once 'header.php';?>

    <div class="container">
	<?php
	//display status alert
	$status = $_GET['status'];
	
	if($status == "success")
	{
		echo "<div class='alert alert-success'>Action completed successfully!</div>";
	}
	elseif($status == 'fail')
	{
		echo "<div class='alert alert-danger'>Problem completing action...</div>";
	}
	?>
    
	<div class="row">
    <div class="col-md-12">
      <div class="page-header">
        <h1>Experiment Setup Page</h1>
        <p class="lead">Use this page to choose and modify an existing experiment or to create a new one.</p>
        </div>
      </div>
	</div>
    <div class="row">
    	<div class="col-md-12">
        <h3> Setup New Experiment </h3>
		<hr />
			<form role="form" method="POST" action="addexp.php" name="form2">
      		<div class="form-group">
            	<label for="exptitle" class="col-sm-2 control-label">Experiment Title</label>
            	<div class="col-sm-10">
              		<input type="text" class="form-control" name="exptitle" id="exptitle" placeholder="Enter Descriptive Title for your Experiment" maxlength="50">
            	</div>
  			</div>
			
            <div class="form-group">
            	<label for="exporg" class="col-sm-2 control-label">Organizer</label>
            	<div class="col-sm-10">
              		<input type="text" class="form-control" name="exporg" id="exporg" placeholder="Organizer of the Experiment" maxlength="65" value="CUT Interaction Lab">
            	</div>
  			</div>
            
            <div class="form-group">
            	<label for="expdate" class="col-sm-2 control-label">Date</label>
            	<div class="col-sm-10">
              		<input type="date" class="form-control" name="expdate" id="expdate">
            	</div>
  			</div>
            
            <div class="form-group">
            	<label for="expgrps" class="col-sm-2 control-label">Groups</label>
            	<div class="col-sm-10">
              		<input type="text" class="form-control" name="expgrps" id="expgrps" placeholder="Enter Number of Groups">
            	</div>
  			</div>

			<button type="submit" class="btn btn-primary">Create New Experiment </button	>
			</form>
		</div>
	</div>
      <div class="row">
      	<?php

	require_once 'login.php';
	require_once 'exportExperiments.php';

	$query = "SELECT * FROM experiment ORDER BY exp_date DESC";
	$result = mysql_query($query, $db_server);

	if(mysql_num_rows($result)){
	?>
	<div class="col-md-12">
    <h3> Existing Experiments </h3>
		<hr />
    <!--
		<form class="form-inline" role="form" method="POST" action="post.php" name="form1">
 		<div class="form-group">
 			<label class="sr-only" for="expSelection">Select Experiment</label>
			<select class="form-control" name="experiments">
			<?php
				for($i=0; $i < mysql_num_rows($result); $i++){
					echo "<option value='".mysql_result($result,$i,'exp_id')."'>";
					echo mysql_result($result,$i,'exp_title')." [".mysql_result($result,$i,'exp_date')."]</option>";
				}
			?>
			</select>
    	</div>
		<button type="submit" class="btn btn-default"> Choose Experiment </button>
		</form>
        -->
        <table class="table table-hover table-condensed">
        <thead>
        <tr>
        	<th>#</th>
            <th>ID</th>
            <th>Experiment Title</th>
            <th>Date</th>
            <th>Groups</th>
            <th>Actions</th>
        </tr>
        </thead>
        <tbody>
        <?php
				for($i=0; $i < mysql_num_rows($result); $i++){
					echo "<tr><td>".($i+1)."</td>";
					echo "<td>".mysql_result($result,$i,'exp_id')."</td>";
					echo "<td>".mysql_result($result,$i,'exp_title')."</td>";
					echo "<td>".mysql_result($result,$i,'exp_date')."</td>";
					echo "<td>".mysql_result($result,$i,'exp_groups')."</td>";
					echo "<td><a class='btn btn-primary' href='./postit.php?eid=".mysql_result($result,$i,'exp_id')."'>Post</a>";
					if(mysql_result($result,$i,'exp_locked')){
						echo " <a class='btn btn-danger' href='./unlock.php?eid=".mysql_result($result,$i,'exp_id')."&action=unlock'>Unlock</a>";
					}
					else{
						echo " <a class='btn btn-success' href='./unlock.php?eid=".mysql_result($result,$i,'exp_id')."&action=lock'>Lock</a>";
					}
					echo " <a class='btn btn-default' href='./export.php?eid=".mysql_result($result,$i,'exp_id')."&loc=index.php'>Export Posts</a>";
					
					$filename = "[expid_".mysql_result($result,$i,'exp_id')."]-posts.xml";
					
					//show file link
					if(file_exists($filename))
					{
						echo " <a href='./".$filename."'>View Posts</a>";
					}
					
					echo "</td>";
				}
			?>
        </tbody>
        </table>
   </div> <!-- end col -->
  </div> <!-- end row -->
   
	<hr/>
<?php }?>
    </div><!-- /.container -->

<?php require_once 'footer.php';?>