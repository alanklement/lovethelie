<?php

//	include 'categories.php';
//	include 'getPhotos.php';

//	header('Content-type: text/xml');

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

				 	$xml = '<stories>
								<story name="Advertising" 	url="./xml/advertising.xml"		fileName="advertising.xml" />
								<story name="Beauty" 		url="./xml/beauty.xml"			fileName="beauty.xml"/>
								<story name="Celebrity" 	url="./xml/celeb.xml"			fileName="celeb.xml"/>
								<story name="Fashion" 		url="./xml/fashion.xml"			fileName="fashion.xml"/>
								<story name="Fashion II" 	url="./xml/fashion2.xml"		fileName="fashion2.xml"/>
								<story name="Random" 		url="./xml/random.xml"			fileName="random.xml"/>
								<story name="Red Carpet" 	url="./xml/random.xml"			fileName="redcarpet.xml"/>
							</stories>';
				
				print $xml ;
				
			//	$xml_file 	= $xml_path.'xmlLocator.xml';
				
				// $xml_file 	= './xmlLocator.xml';
				// 	
				// if (file_exists($xml_file)) 
				// {
				//     $xml = simplexml_load_file($xml_file);
				//     echo $xml->asXML();
				// } 
				// else if ( !file_exists($xml_file) ) { exit('**ak: Error** '.$_GET['fileName'].' not found'); } 
				break;
	}