<?php
header("Content-type: text/xml");
$file = file_get_contents('./../xml/hair_makeup.xml');
echo $file;
