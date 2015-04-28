<?php
//验证登陆状态

require_once 'db.class.php';
require_once 'json.class.php';
if (UCDBON == 1) {
	require_once 'dbuc.class.php';
}



// d
class Login{
	//验证登陆状态
	function check($sid){
		$db = new DB();
		$json = new JSON();
		if(!empty($sid)){
			$sql = "SELECT uid,username FROM `".DB_PRE."common_session_app` WHERE sid = '".$sid."'";
			$sescheck = $db->fetch_all($sql);
			if(count($sescheck)=='1'){
				return true;
			}else{
				return false;
			}
		}else{
			return false;
		}
	}
	//登陆
	function doLogin($acc = '', $pw = ''){
		$dbl = new DB();
		$json = new JSON();
		if(strtoupper(DBCHARSET) == 'GBK'){
			$acc = mb_convert_encoding($acc, 'GBK', 'UTF-8');
		}
		//查用户名
		if (UCDBON == 1) {
			$db = new DBUC();
			$sql = "SELECT uid,username,password,salt FROM `".UC_PRE."members` WHERE username = '".$acc."'";
			$pwcheck = $db->fetch_all($sql);
		} else {
			$sql = "SELECT uid,username,password,salt FROM `".UC_PRE."members` WHERE username = '".$acc."'";
			$pwcheck = $dbl->fetch_all($sql);
		}
		//判断是否是GBK编码的数据库
		if(strtoupper($dbcharset) == 'GBK'){
			if(!empty($pwcheck[0])){
				foreach ($pwcheck[0] as $k=>$v){
					$pwcheck[0][$k] = mb_convert_encoding($v,'GBK','UTF-8');
				}
			}
		}
		if(!empty($pwcheck))//用户名正确
		{
			if(md5($pw.$pwcheck[0]['salt']) == $pwcheck[0]['password'])//密码正确
			{
				//查是否登陆过
				$sql = "SELECT sid FROM `".DB_PRE."common_session_app` WHERE uid = '".$pwcheck[0]['uid']."'";
				$sescheck = $dbl->fetch_all($sql);
	
				if(empty($sescheck))//初次登陆
				{
					//设置sid
					$sql = "INSERT INTO `".DB_PRE."common_session_app` (`sid`, `ip`, `uid`, `username`, `lastlogin`) VALUES ('".md5($pwcheck[0]['password'].time())."', '".$_SERVER['REMOTE_ADDR']."', '".$pwcheck[0]['uid']."', '".$pwcheck[0]['username']."', '".time()."');";
					$sesset = $dbl->query($sql);
	
					if($sesset)//设置成功
					{
						$sid = md5($pwcheck[0]['password'].time());
					}
					else//设置失败
					{
						$sid = 500;
					}
				}
				else//已登陆
				{
					//更新最近登陆时间
					$sql = "UPDATE `".DB_PRE."common_session_app` SET `lastlogin` = '".time()."' WHERE `sid` = '".$sescheck[0]['sid']."'";
					$upsid = $dbl->query($sql);
					if($upsid)//更新成功
					{
						$sid = $sescheck[0]['sid'];
					}
					else//更新失败
					{
						$sid = 500;
					}
				}
			}
			else//密码错误
			{
				$sid = 'aperror';
			}
		}
		else//用户名不存在
		{
			$sid = 'aperror';
		}
		
		//输出json
		if(empty($sid)){
			$code = '404';
			$data_array = array();
		}else{
			if(!empty($sid)){
				$code = '200';
				$data_array[0] = array('sessionid'=>$sid,'uid'=>$pwcheck[0]['uid'],'groupid'=>$pwcheck[0]['groupid']);
			}elseif($sid == 500){
				$code = '500';
				$data_array = array();
			}
		}
		$json_string = $json->ArrayGetjson($data_array, $code);
		echo $json_string;
	}
}