<?php
/**
 * 验证码
 * @copyright  Copyright (c) 2007-2012 ShopNC Inc. (http://www.shopnc.net)
 * @license    http://www.shopnc.net
 * @link       http://www.shopnc.net
 * @since      File available since Release v1.1
 */
session_start();
error_reporting(0);
$_SESSION['ShopNC_app_seccode'] = "";
$width = 70;
$height = 21;
$len = "4";
$noise = true;
$noisenum = 30;
$image = imageCreate($width, $height);
$back = imagecolorallocate($image, mt_rand(150,255), mt_rand(150,255), mt_rand(150,255));
imageFilledRectangle($image, 0, 0, $width, $height, $back);
$size = $width / $len;
if($size > $height){
	$size = $height;
}
$left = ($width - $len * ($size + $size / 10)) / $size;

$textall=range('A','Z');
for($i = 0; $i < $len; $i++) {
	$tmptext = rand(0, 25);
	$randtext = $textall[$tmptext];
	$code .= $randtext;
}
if($noise == true){
	setnoise($image, $width, $height, $back, $noisenum);
}

for ($i = 0; $i < strlen($code); $i++){
	imageString($image,5,$i*$width/4+mt_rand(1,5),$height/4,$code[$i],imageColorAllocate($image,mt_rand(0,150),mt_rand(0,150),mt_rand(0,150)));
}
$_SESSION['ShopNC_app_seccode'] = $code;
@header("Content-type: image/png");
imagePng($image);
imagedestroy($image);
function setnoise($image, $width, $height, $back, $noisenum){
	for ($i=0; $i<$noisenum; $i++){
		$randColor = imageColorAllocate($image, rand(0, 255), rand(0, 255), rand(0, 255));
		imageSetPixel($image, rand(0, $width), rand(0, $height), $randColor);
	}

}