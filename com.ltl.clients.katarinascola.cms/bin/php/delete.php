<?php
	$file = $_POST['fileName'];
	$filePath = '.'.$file ;
	
	$delete = unlink($filePath);
	
	if ( $delete )
	{
		echo 'success' ;
	}
	else if ( !$delete )
	{
		echo 'fail' ;
	}
?>