<?php

//	print base64_decode($_POST["image"]);

		$imagePath 	= '../images/'; 
		$thumbPath 	= '../thumbs/'; 
		
		$randomizer = rand(00000, 99999);
 		$new_image_name = $randomizer.'.jpg';
 		$newImage = $imagePath.$new_image_name;
 		$newThumb = $thumbPath.$new_image_name;
		
		$fp = fopen( $newImage, 'wb' );
		fwrite( $fp, $GLOBALS[ 'HTTP_RAW_POST_DATA' ] ) ;
		chmod($newImage, 0644);
		fclose( $fp );
		
		// ak: create thumb
		
		$width = 200;
		$height = 30;
		
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
		exit ($new_image_name);