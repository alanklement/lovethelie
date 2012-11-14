<?php

    $file_temp 	= $_FILES['Filedata']['tmp_name'];

	$imagePath 	= '../images/'; 

	$randomizer = rand(000000, 999999);
 	$new_image_name = $randomizer.'.jpg';
 	$uploadedImg = $imagePath.$new_image_name;

	$upload = move_uploaded_file($file_temp, $uploadedImg);
	
	if($upload)
	{		
		chmod($uploadedImg, 0644);
		exit($new_image_name);
	}
	else
	{
		exit('fail');
	}

	
	
