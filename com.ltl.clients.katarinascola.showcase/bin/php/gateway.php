<?php

	$xml_path 	= '../xml/';
	
	switch ($_GET['action'])
	{
		case 'get_images':
					
				$xml_file 	= $xml_path.$_GET['fileName'];
					
				if (file_exists($xml_file)) 
				{
				    $xml = simplexml_load_file($xml_file);
				    print $xml->asXML();
				} 
				else if ( !file_exists($xml_file) ) { exit('**ak: Error** '.$_GET['fileName'].' not found'); } 
				break;
		
		case 'get_books':

				$xml_file 	= $xml_path.'xmlLocator.xml';
				 					
				if (file_exists($xml_file)) 
				{
				    $xml = simplexml_load_file($xml_file);
				    print $xml->asXML();
				} 
				else if ( !file_exists($xml_file) ) { exit('**ak: Error** '.$_GET['fileName'].' not found'); } 
				break;
				
		case 'get_backgrounds':

				$xml_file 	= $xml_path.'backgrounds.xml';
				 					
				if (file_exists($xml_file)) 
				{
				    $xml = simplexml_load_file($xml_file);
				    print $xml->asXML();
				} 
				else if ( !file_exists($xml_file) ) { exit('**ak: Error** '.$_GET['fileName'].' not found'); } 
				break;		
	}