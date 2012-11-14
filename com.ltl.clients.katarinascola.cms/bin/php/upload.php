<?php

    $file_temp 	= $_FILES['Filedata']['tmp_name'];

	$imagePath 	= '../images/'; 
    $thumbPath 	= '../thumbs/'; 
    
    $randomizer = rand(000000, 999999);
 	$new_image_name = $randomizer.'.jpg';
 	$newImage = $imagePath.$new_image_name;
 	$newThumb = $thumbPath.$new_image_name;

	$upload = move_uploaded_file($file_temp, $newImage);
	
	chmod($newImage, 0644);

	// ak: create large iamge
		
	$width = 800;
	$height = 500;

	// destroy $thumb
	$thumb = imagecreatefromjpeg($newImage);
	$size = list($width_orig,$height_orig)=getimagesize($newImage);

	$ratio_orig = $width_orig/$height_orig;

	if ($width/$height > $ratio_orig) 
	{
		 $width = $height*$ratio_orig;
	} 
	else 
	{
		  $height = $width/$ratio_orig;
	} 

	$tmp=imagecreatetruecolor($width,$height);
	imagecopyresampled($tmp,$thumb,0,0,0,0,$width,$height,$width_orig,$height_orig);		

	
		
	imagejpeg($tmp,$newImage,80);
	
	imagedestroy($tmp);
	imagedestroy($thumb);
	
	// ak ; create thumb
	$width = 50;
	$height = 30;

	// destory $thumb
	$thumb = imagecreatefromjpeg($newImage);
	$size = list($width_orig,$height_orig)=getimagesize($newImage);

	$ratio_orig = $width_orig/$height_orig;

	if ($width/$height > $ratio_orig) 
	{
		 $width = $height*$ratio_orig;
	} 
	else 
	{
		  $height = $width/$ratio_orig;
	} 
		
	$tmp=imagecreatetruecolor($width,$height);
	imagecopyresampled($tmp,$thumb,0,0,0,0,$width,$height,$width_orig,$height_orig);		
		
		
	imagejpeg($tmp,$newThumb,80);
	imagedestroy($tmp);
	imagedestroy($thumb);	
	
	exit($new_image_name);
	
