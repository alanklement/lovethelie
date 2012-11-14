<?php
header("Content-type: text/xml");
$file = file_get_contents('./../xml/celeb.xml');
echo $file;
