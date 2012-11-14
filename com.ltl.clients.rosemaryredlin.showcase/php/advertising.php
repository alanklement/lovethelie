<?php
header("Content-type: text/xml");
$file = file_get_contents('./../xml/advertising.xml');
echo $file;
