<?php
require_once './class/db.class.php';
require_once './class/json.class.php';
if (UCDBON == 1) {
	require_once 'dbuc.class.php';
}

$db = new DB();
$json = new JSON();
//存储ios设备device token的接口API
$len = strlen($_POST['token']);
if($len == 64){
	$sql = "INSERT INTO `".DB_PRE."common_devicetoken` (`token`) VALUES('".$_POST['token']."')";
	$result = $db->query($sql);
	if($result){
		$code = '200';
		$data_array[0] = array('result'=>'token save succ');
	}else{
		$code = '200';
		$data_array[0] = array('result'=>'token save failed');
	}
}else{
	$code = '200';
	$data_array[0] = array('result'=>'input token error');
}

$json_string = $json->ArrayGetjson($data_array, $code);
echo $json_string;