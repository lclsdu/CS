<?php
/**
 * 商圈controler
 * $_GET['type']为必须参数
 */
require_once './class/db.class.php';
require_once './class/json.class.php';
require_once './class/topic.class.php';
require_once './class/login.class.php';
define('SHOP_PIC', $shoplist_url);
define('DS', DIRECTORY_SEPARATOR);
//参数处理
$type = strtolower($_GET['type']);
//实例化类
$db    = new DB();
$json  = new JSON();
$topic = new Topic();
//limit参数
function getLimitParam($pageno,$pagesize){
	$limit_param = array();
	$limit_param[0] = ($pageno-1)*$pagesize;
	$limit_param[1] = $pagesize;
	return $limit_param;
}
switch ($type){
	case 'shop_list'://需要传一个r参数（半径范围，单位：米）,坐标经度参数lng，坐标纬度参数lat

		//添加对分类的验证
		if (trim($_GET['class']) == 'on' && trim($_GET['cid']) != '') {
			$sql = "SELECT * FROM `".DB_PRE."shop_class_app` WHERE `cid` = '".intval($_GET['cid'])."'";
			$result = $db->fetch_all($sql);
			if ($result) {
				//有数据
				if ($result[0]['pid'] != '0') {//说明是二级分类
					$cids = intval($_GET['cid']);
				} else {
					$sql = "SELECT cid FROM `".DB_PRE."shop_class_app` WHERE `pid` = '".intval($_GET['cid'])."'";
					$result2 = $db->fetch_all($sql);
					$cids = "";
					if (!empty($result2)) {
						foreach ($result2 as $val) {
							$cids .= $val['cid'].",";
						} 
						$cids .= intval($_GET['cid']);
					} else {
						$cids = intval($_GET['cid']);
					}
				}
			} else {
				//无数据
				$cids = '';
			}
		} else {
				//无数据
				$cids = '';
		}
		
		$limit_param = getLimitParam(intval($_GET['pageno']),intval($_GET['pagesize']));
		$range_array = getaround($_GET['lat'], $_GET['lng'], $_GET['r']);
		if (trim($_GET['limit']) == 'max') {
			if($cids != ''){
				$sql = "SELECT shop_id,shop_pic,shop_address,shop_name,shop_website,shop_lat,shop_lng,shop_phone,class,fuwu,huanjing FROM `".DB_PRE."common_shoplist` WHERE `class` IN (".$cids.") ORDER BY `shop_id` DESC LIMIT ".$limit_param[0].",".$limit_param[1];
			}else{
				$sql = "SELECT shop_id,shop_pic,shop_address,shop_name,shop_website,shop_lat,shop_lng,shop_phone,class,fuwu,huanjing FROM `".DB_PRE."common_shoplist` ORDER BY `shop_id` DESC LIMIT ".$limit_param[0].",".$limit_param[1];
			}
		}elseif ($cids != '') {
			$sql = "SELECT shop_id,shop_pic,shop_address,shop_name,shop_website,shop_lat,shop_lng,shop_phone,class,fuwu,huanjing FROM `".DB_PRE."common_shoplist` WHERE `shop_lat` > ".$range_array[0]." AND `shop_lat` < ".$range_array[1]." AND `shop_lng` > ".$range_array[2]." AND `shop_lng` < ".$range_array[3]." AND `class` IN (".$cids.") LIMIT ".$limit_param[0].",".$limit_param[1];
		} else {
			$sql = "SELECT shop_id,shop_pic,shop_address,shop_name,shop_website,shop_lat,shop_lng,shop_phone,class,fuwu,huanjing FROM `".DB_PRE."common_shoplist` WHERE `shop_lat` > ".$range_array[0]." AND `shop_lat` < ".$range_array[1]." AND `shop_lng` > ".$range_array[2]." AND `shop_lng` < ".$range_array[3]." LIMIT ".$limit_param[0].",".$limit_param[1];
		}
		$shop_list = $db->fetch_all($sql);
		if (trim($_GET['limit']) == 'max') {
			if($cids != ''){
				$count_sql = "SELECT count(shop_id) as num FROM `".DB_PRE."common_shoplist` WHERE `class` IN (".$cids.")";
			}else{
				$count_sql = "SELECT count(shop_id) as num FROM `".DB_PRE."common_shoplist` ";
			}
		}elseif ($cids != '') {
			$count_sql = "SELECT count(shop_id) as num FROM `".DB_PRE."common_shoplist` WHERE `shop_lat` > ".$range_array[0]." AND `shop_lat` < ".$range_array[1]." AND `shop_lng` > ".$range_array[2]." AND `shop_lng` < ".$range_array[3]." AND `class` IN (".$cids.")";
		} else {
			$count_sql = "SELECT count(shop_id) as num FROM `".DB_PRE."common_shoplist` WHERE `shop_lat` > ".$range_array[0]." AND `shop_lat` < ".$range_array[1]." AND `shop_lng` > ".$range_array[2]." AND `shop_lng` < ".$range_array[3];
		}
		$shop_num  = $db->fetch_all($count_sql);
		$count = $shop_num[0]['num']; 
		//处理数组
		$data_array    = array();//输出用数组
		$shop_list_tmp = array();//排序用临时数组
		if(is_array($shop_list)){
			$code = '200';
			if(!empty($shop_list)){
				foreach ($shop_list as $k=>$v){
					if($v['shop_pic'] != ''){//如果图片不为空则拼接完整图片url
						$shop_list[$k]['shop_pic'] = SHOP_PIC.'/'.$v['shop_pic'];
					}
					$s = getdistance($_GET['lat'], $_GET['lng'], $v['shop_lat'], $v['shop_lng']);//计算商家距离使用者的距离
					$s *= 1000;//将单位变为米
					$shop_list[$k]['distance'] = $s;
					$shop_list_tmp[$k] = $s;
					unset($s);
				}
			}
			if (trim($_GET['limit']) != 'max') {
				asort($shop_list_tmp);//按照距离从近到远进行排列	
			}
			if(!empty($shop_list_tmp)){
				foreach ($shop_list_tmp as $tk=>$tv){
					$data_array[] = $shop_list[$tk];//将商家信息放入输出数组中
				}
			}
		}else{
			$code = '500';
		}
		break;
	case 'shop_detail'://需要传一个shop_id（商家ID）
		$sql = "SELECT * FROM `".DB_PRE."common_shoplist` WHERE `shop_id` = '".intval($_GET['shop_id'])."'";
		$shop_info = $db->fetch_all($sql);
		$data_array = array();
		if(is_array($shop_info) && !empty($shop_info)){
			$code = '200';
			if($shop_info[0]['shop_pic'] != ''){
				$shop_info[0]['shop_pic'] = SHOP_PIC.'/'.$shop_info[0]['shop_pic'];
			}
			$data_array = $shop_info;
		}else{
			$code = '500';
		}
		break;
	case 'shop_class':
		$sql = "SELECT * FROM `".DB_PRE."shop_class_app`";
		$shop_class = $db->fetch_all($sql);		
		if (is_array($shop_class) && !empty($shop_class)) {
			$code = '200';
			$data_array = $shop_class;
		} else {
			$code = '500';
		}
		break;
	//发表评论
	case 'post':
		checklogin();
		$postinfo = $_POST;
		//判断是否是GBK编码的数据库
		if(strtoupper($dbcharset) == 'GBK'){
			if(!empty($postinfo)){
				foreach ($postinfo as $k=>$v){
					$postinfo[$k] = mb_convert_encoding($v,'GBK','UTF-8');
				}
			}
		}
		$postinfo['date']  = time();
		$postinfo['useip'] = getip(); 
		$sql = "INSERT INTO `".DB_PRE."comment_shop_app` (`shop_id`, `author`, `authorid`, `message`, `mark`, `dateline`, `useip`) VALUES ('".$_GET['shop_id']."', '".$postinfo['author']."', '".$postinfo['authorid']."', '".strtr(addslashes($postinfo['message']),array('('=>'\(',')'=>'\)'))."', '".$postinfo['mark']."', '".$postinfo['date']."', '".$postinfo['useip']."')";
		$result = $db->query($sql);
		if($result){
			$code = '200';
			$data_array[0] = array('result'=>'post succ');
		}else{
			$code = '500';
			$data_array[0] = array('result'=>'post failed');
		}		
		break;
	//取评论数据
	case 'get_post':
		$limit_param = getLimitParam(intval($_GET['pageno']),intval($_GET['pagesize']));
		$sql = "SELECT a.author,message,mark,dateline,b.avatarstatus,uid FROM `".DB_PRE."comment_shop_app` as a LEFT JOIN `".DB_PRE."common_member` as b ON a.authorid=b.uid WHERE a.shop_id=".$_GET['shop_id']." ORDER BY dateline desc LIMIT ".$limit_param[0].",".$limit_param[1];
//		$sql = "SELECT * FROM `".DB_PRE."comment_shop_app` WHERE `shop_id` = '".intval($_GET['shop_id'])."' order by dateline desc";
		$count_sql = "SELECT count(comment_id) as num FROM `".DB_PRE."comment_shop_app` WHERE `shop_id` = '".intval($_GET['shop_id'])."'";
		$shop_num  = $db->fetch_all($count_sql);
		$count = $shop_num[0]['num']; 
		$shop_info = $db->fetch_all($sql);
		$data_array = array();
		if(is_array($shop_info) && !empty($shop_info)){
			foreach ($shop_info as $k=>$v){
				//添加用户头像信息
				if($v['avatarstatus'] == '1'){//有头像
					$shop_info[$k]['avatar_url'] = getuseravatarurl($v['uid']);
				}else{//无头像则返回默认头像
					$shop_info[$k]['avatar_url'] = UC_URL.'/images/noavatar_small.gif';
				}
			}			
			$code = '200';
			$data_array = $shop_info;
		}else{
			$code = '500';
		}		
		break;		
	//用户发商家照片	
	case 'post_image':
		// checklogin();
		$postinfo = $_POST;
		$pic_array = upload_image($_FILES);
		if(!empty($pic_array)) {
			$shop_pic = $pic_array[0][0];
		} else {
			$shop_pic = '';
		}
		
		//判断是否是GBK编码的数据库
		if(strtoupper($dbcharset) == 'GBK'){
			if(!empty($postinfo)){
				foreach ($postinfo as $k=>$v){
					$postinfo[$k] = mb_convert_encoding($v,'GBK','UTF-8');
				}
			}
		}
		$postinfo['date']  = time();
		$postinfo['useip'] = getip();
		$sql = "INSERT INTO `".DB_PRE."comment_shop_pic_app` (`shop_id`, `author`, `authorid`, `message`, `shop_com_pic`, `dateline`, `useip`) VALUES ('".$_GET['shop_id']."', '".$postinfo['author']."', '".$postinfo['authorid']."','".strtr(addslashes($postinfo['message']),array('('=>'\(',')'=>'\)'))."','".$shop_pic."','".$postinfo['date']."','".$postinfo['useip']."')";
		$result = $db->query($sql);
		if($result){
			$code = '200';
			$data_array[0] = array('result'=>'post succ');
		}else{
			$code = '500';
			$data_array[0] = array('result'=>'post failed');
		}	
		break;
	//取回商家照片列表数据
	case 'get_image':
		$limit_param = getLimitParam(intval($_GET['pageno']),intval($_GET['pagesize']));
		//$sql = "SELECT *,b.avatarstatus,b.uid FROM `".DB_PRE."comment_shop_pic_app` as a LEFT JOIN `".DB_PRE."common_member` as b ON a.authorid=b.uid WHERE shop_id=".intval($_GET['shop_id'])." ORDER BY dateline desc LIMIT ".$limit_param[0].",".$limit_param[1];
		$sql = "SELECT *,b.avatarstatus,b.uid FROM `".DB_PRE."comment_shop_pic_app` as a LEFT JOIN `".DB_PRE."common_member` as b ON a.authorid=b.uid WHERE shop_id=".intval($_GET['shop_id'])." ORDER BY dateline desc ";
		$count_sql = "SELECT count(com_pic_id) as num FROM `".DB_PRE."comment_shop_pic_app` WHERE `shop_id` = '".intval($_GET['shop_id'])."'";
		$shop_num  = $db->fetch_all($count_sql);
		$count = $shop_num[0]['num']; 
		$shop_info = $db->fetch_all($sql);
		$data_array = array();
		if(is_array($shop_info) && !empty($shop_info)){	
			foreach ($shop_info as $k=>$v){
				$shop_info[$k]['shop_com_pic'] = SHOPPIC_URL.'/'.$shop_info[$k]['shop_com_pic'];
				if($shop_info[$k]['avatarstatus'] == '1'){//有头像
					$shop_info[$k]['avatar_url'] = getuseravatarurl($v['uid']);
				}else{//无头像则返回默认头像
					$shop_info[$k]['avatar_url'] = UC_URL.'/images/noavatar_small.gif';
				}
			}	
			$code = '200';
			$data_array = $shop_info;
		}else{
			$code = '500';
		}
		break;
	//单独商家照片展示
	case 'get_single_image':
		$sql = "SELECT a.*,b.avatarstatus FROM `".DB_PRE."comment_shop_pic_app` as a LEFT JOIN `".DB_PRE."common_member` as b ON a.authorid=b.uid WHERE com_pic_id = ".intval($_GET['com_pic_id']);
		$data_array = $db->fetch_all($sql);
		if(is_array($data_array) && !empty($data_array)){
			$code = '200';
			$data_array[0]['shop_com_pic'] = SHOPPIC_URL.'/'.$data_array[0]['shop_com_pic'];
			if($data_array[0]['avatarstatus'] == '1'){//有头像
				$data_array[0]['avatar_url'] = getuseravatarurl($v['uid']);
			}else{//无头像则返回默认头像
				$data_array[0]['avatar_url'] = UC_URL.'/images/noavatar_small.gif';
			}
		}else{
			$code = '500';
		}
		break;
	default:
		$code = '404';
		$data_array = array();
}
$json_string = $json->ArrayGetjson($data_array, $code, $count);
echo $json_string;
/**
 * 商圈经纬度范围计算函数(单位：米)
 * 
 * @param int $lat 纬度
 * @param int $lng 经度
 * @param int $raidus 半径
 * @return array (minlat,maxlat,minlng,maxlng)经纬度范围
 */
function getaround($lat,$lng,$raidus){
	$pi = 3.1415926;
	$degree = (24901*1609)/360.0;
	$dpmlat = 1/$degree;
	$raiduslat = $dpmlat*$raidus;
	$minlat = $lat-$raiduslat;
	$maxlat = $lat+$raiduslat;
	
	$mpdlng = $degree*cos($lat*($pi/180));
	$dpmlng = 1/$mpdlng;
	$raiduslng = $dpmlng*$raidus;
	$minlng = $lng-$raiduslng;
	$maxlng = $lng+$raiduslng;
	return array($minlat,$maxlat,$minlng,$maxlng);
}
/**
 * 计算两个坐标之间的距离（单位：千米）
 * 
 * @param $lat1,$lng1,$lat2,$lng2(两个坐标的经纬度)
 * @return $s距离
 */
function rad($d){  
    return $d * 3.1415926535898 / 180.0;  
} 
function getdistance($lat1, $lng1, $lat2, $lng2){
	$EARTH_RADIUS = 6378.137;  
	$radLat1 = rad($lat1);  
	$radLat2 = rad($lat2);  
	$a = $radLat1 - $radLat2;  
	$b = rad($lng1) - rad($lng2);  
	$s = 2 * asin(sqrt(pow(sin($a/2),2) +  
	cos($radLat1)*cos($radLat2)*pow(sin($b/2),2)));  
	$s = $s *$EARTH_RADIUS;  
	$s = round($s * 10000) / 10000;  
	return $s;  
}

function checklogin(){
	$login = new Login();
	$json = new JSON();
	if(!$login->check($_POST['sid'])){
		$code = '200';
		$data_array[0] = array('result'=>'login first');
		$json_string = $json->ArrayGetjson($data_array, $code);
		echo $json_string;die;
	}
	return true;
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

function getuseravatarurl($uid){
	$uid = abs(intval($uid));
	$uid = sprintf("%09d", $uid);
	$dir1 = substr($uid, 0, 3);
	$dir2 = substr($uid, 3, 2);
	$dir3 = substr($uid, 5, 2);
	$avatar_url = UC_URL.'/data/avatar/'.$dir1.'/'.$dir2.'/'.$dir3.'/'.substr($uid, -2).'_avatar_small.jpg';
	return $avatar_url;
}
//商圈上传照片
//此函数不可被评论拍照功能的以外的用途调用
function upload_image($file){
	require_once './class/upload.class.php';
	//$db_img = new DB();
	if(!empty($file)){
		$time = time();
		$year_month = date('Ym',$time);
		$day = date('d',$time);
		$uploaddir = SHOPCOMPIC_DIR;//注意不一样
		$pic_array = array();
		foreach ($file as $k=>$v){
			$upload = new UploadFile();
  			$upload->set('default_dir',$uploaddir);
			$result = $upload->upfile($k);
			if($result){
				$sizeinfo = getimagesize($uploaddir.DS.$upload->file_name);
				$pic_array[] = array($upload->file_name,$v['name'],$v['size'],$sizeinfo[0]);
				unset($sizeinfo);
			}
			unset($upload);
		}
    return $pic_array;
	}
  return array();
}

