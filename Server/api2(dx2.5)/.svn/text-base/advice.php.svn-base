<?php
//提交建议
require_once './class/db.class.php';
require_once './class/json.class.php';
$db    = new DB();
$json  = new JSON();

//判断是否是GBK编码的数据库
if(strtoupper($dbcharset) == 'GBK'){
	if(!empty($_POST)){
		foreach ($_POST as $k=>$v){
			$_POST[$k] = mb_convert_encoding($v,'GBK','UTF-8');
		}
	}
}

$type = strtolower($_GET['type']);
$message = trim($_POST['message']);
$uid = intval($_POST['uid']);//可为空
$username = trim($_POST['username']);//可为空
$uip = getip();
$time = time();

if($type == 'submit' && !empty($message)){

	$sql = "INSERT INTO `".DB_PRE."advice_app` (`message`, `uid`, `username`, `uip`, `time`) VALUES ('".$message."', '".$uid."', '".$username."', '".$uip."', '".$time."');";
	$result = $db->query($sql);
	if($result){
		$code = 200;
		$end = 'send succ';
	}else{
		$code = 500;
		$end = 'send failed';
	}
}elseif($type == 'count' && trim($_POST['install']) == 'new' && !empty($_POST['hardtype'])){

	$hardtype = trim($_POST['hardtype']);
	if ($hardtype == 'iphone') {
		$hardtypein = 1;
	} elseif ($hardtype == 'android') {
		$hardtypein = 2;
	} else {
		$hardtypein = 0;
	}

	$sql = "INSERT INTO `".DB_PRE."count_install_app` (`uip`, `time`, `hardtype`) VALUES ('".$uip."', '".$time."', '".$hardtypein."');";
	$result = $db->query($sql);
	if ($result) {
		$code = 200;
		$end = 'count succ';
	}else{
		$code = 500;
		$end = 'count failed';
	}

}else{
	$code = 404;
	$end = 'unknown error';
}

if(!empty($code) && !empty($end)){
	$json_string = $json->ArrayGetjson(array(array('result'=>$end)), $code);
	echo $json_string;
}



//获取ip
function getip(){
	if(!empty($_SERVER["HTTP_CLIENT_IP"]))
	   $cip = $_SERVER["HTTP_CLIENT_IP"];
	else if(!empty($_SERVER["HTTP_X_FORWARDED_FOR"]))
	   $cip = $_SERVER["HTTP_X_FORWARDED_FOR"];
	else if(!empty($_SERVER["REMOTE_ADDR"]))
	   $cip = $_SERVER["REMOTE_ADDR"];
	else
	   $cip = "";
	return $cip;
}





