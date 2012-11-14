<?php
	$content = $_POST['content'];
	$file = $_POST['fileName'];
	$filePath = '../xml/'.$file ;
	
	$content = stripslashes($content);
	
	$writeFile = fopen($filePath, "w");
	
	if(fwrite($writeFile, $content))
	{
		echo $content;
	}
	else
	{
		echo "Error writing to file";
	}
	
	fclose($writeFile);
	
?>