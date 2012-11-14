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
	
	
	// Because echo is not a function, following code is invalid. 
//($some_var) ? echo 'true' : echo 'false';

// However, the following examples will work:
//($some_var) ? print('true'): print('false'); // print is a function
//echo $some_var ? 'true': 'false'; // changing the statement around
	
?>