<?php
/**
 * Discuz!帖子写入操作controler
 * $_GET['type']为必须参数
 * 
 * ShopNC AlexLee 2012.2.27
 */

require_once './class/db.class.php';
require_once './class/topic.class.php';
require_once './class/json.class.php';
require_once './class/login.class.php';

define('DISCUZ_DIR', $discuz_dir);
define('DS',DIRECTORY_SEPARATOR);
define('SITE_URL', $site_url);

//参数处理
$type = strtolower($_GET['type']);
//实例化类
$topic = new Topic();
$db    = new DB();
$json  = new JSON();

//验证登陆
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

//发帖操作
switch ($type){
	case 'thread_class':
		$sql = "SELECT threadtypes FROM `".DB_PRE."forum_forumfield` WHERE fid = ".$_GET['fid'];
		$tc_info = $db->fetch_all($sql);
		$tc_info = $tc_info[0]['threadtypes'];
		//判断是否是GBK编码的数据库
		if(strtoupper(DBCHARSET) == 'GBK'){
			$tc_info = mb_convert_encoding($tc_info,'GBK','UTF-8');
		}
		$tc = unserialize($tc_info);
		if(is_array($tc) && !empty($tc)){
			$code = '200';
			//判断是否是GBK编码的数据库
			if(strtoupper(DBCHARSET) == 'GBK'){
				if(!empty($tc['types'])){
					foreach ($tc['types'] as $k=>$v){
						$tc['types'][$k] = mb_convert_encoding($v,'UTF-8','GBK');
					}
				}
			}
			$data_array['types']    = $tc['types'];
			$data_array['types']['required'] = $tc['required']?'yes':'no';
		}else{
			$code = '500';
		}
		break;
	case 'post'://发帖,需要1个fid参数；$_POST参数包括author,authorid,subject,message,useip；图片上传$_FILE+需要1个参数img=1
		checklogin();
		$postinfo = $_POST;
		
		$configfile = './class/config.ini.php';
		require_once($configfile);
		//禁止发回贴时间段判断
		if($forbidden_time != ''){
			$time_sign = intimerange($forbidden_time);
			if($time_sign){
				$code = '500';
				$data_array[0] = array('result'=>'forbidden_time');
				break;
			}
		}
		//敏感词过滤
		if($filter_words != ''){
			$filter_array = explode(',', $filter_words);
		}else{
			$filter_array = array();
		}
		if($message_filter_method == '2'){//敏感词在app端进行提示
			$sign = true;
			if(!empty($filter_array)){
				foreach ($filter_array as $k=>$v){
					if(strpos($postinfo['message'],$v) !== false || strpos($postinfo['subject'],$v) !== false){
						$sign = false;
						break;
					}
				}
			}
			if(!$sign){
				$code = '500';
				$data_array[0] = array('result'=>'dangerous word');
				break;
			}
		}
			if($message_filter_method == '1'){//直接替换成***
				$filter_change_array = array();
				if(!empty($filter_array)){
					foreach ($filter_array as $k=>$v){
						$filter_change_array[$v] = '***';
					}
				}
				$postinfo['message'] = strtr($postinfo['message'],$filter_change_array);
				$postinfo['subject'] = strtr($postinfo['subject'],$filter_change_array);
			}
			
			//判断是否是GBK编码的数据库
			if(strtoupper($dbcharset) == 'GBK'){
				if(!empty($postinfo)){
					foreach ($postinfo as $k=>$v){
						$postinfo[$k] = mb_convert_encoding($v,'GBK','UTF-8');
					}
				}
			}
			$ff_info = $db->fetch_all("SELECT todayposts,threads,modnewposts FROM `".DB_PRE."forum_forum` WHERE fid = '".$_GET['fid']."'");
			$mg_info = $db->fetch_all("SELECT b.allowdirectpost FROM `".DB_PRE."common_member` as a LEFT JOIN `".DB_PRE."common_usergroup_field` as b ON a.groupid=b.groupid WHERE a.uid = '".$_POST['authorid']."'");
			if($ff_info[0]['modnewposts'] == '0'){
				$postinfo['verify'] = 0;
			}else{
				if($mg_info[0]['allowdirectpost'] == '2' || $mg_info[0]['allowdirectpost'] == '3'){
					$postinfo['verify'] = 0;
				}else{
					$postinfo['verify'] = -2;
				}
			}
			$postinfo['date']   = time();
			$postinfo['useip']  = getip();
			//手机端输入设备的判定
			switch ($_POST['status']){
				case 'i':
					$postinfo['status'] = '256';
					break;
				case 'a':
					$postinfo['status'] = '258';
					break;
				case 'w':
					$postinfo['status'] = '260';
					break;
			}
			//判断板块发帖是否需要审核
			//$need_verify = $db->query("SELECT "); 
			$sql_step1 = $topic->getSql('post_step1','','',$postinfo);
			$step1_result = $db->query($sql_step1);
			if($step1_result){
				$tid = $db->getLastId();
				$postinfo['tid'] = $tid;
				//更新post_tableid表
				$db->query("INSERT INTO `".DB_PRE."forum_post_tableid` (`pid`) VALUES('')");
				$postinfo['pid'] = $db->getLastId();
				$sql_step2 = $topic->getSql('post_step2','','',$postinfo);
				$step2_result = $db->query($sql_step2);
				if($step2_result){
					$pid = $postinfo['pid'];
					//更新forum_forum表的今天发帖数量+板块最后更新信息
					$todaypost = $ff_info[0]['todayposts'];
					$new_todaypost = $todaypost + 1;
					$threads = $ff_info[0]['threads'];
					$new_threads = $threads + 1;
					$lastpost = $tid."	".$postinfo['subject']."	".$postinfo['date']."	".$postinfo['author'];
					if(strtoupper($dbcharset) == 'GBK'){
						$lastpost = mb_convert_encoding($lastpost,'GBK','UTF-8');
					}
					$db->query("UPDATE `".DB_PRE."forum_forum` SET `lastpost` = '".$lastpost."',`todayposts` = '".$new_todaypost."',`threads` = '".$new_threads."' WHERE fid = '".$_GET['fid']."'");
					
					//处理上传的图片
					if($_GET['img'] == '1'){
						if($postinfo['ftpimgname1'] == ''){
							upload_image($_FILES, $tid, $pid,$postinfo['authorid']);
						}else{
							upload_image($_FILES, $tid, $pid,$postinfo['authorid'],false,$postinfo['ftpimgname']);
						}
					}
					//如果是需要审核的帖子则插入待审核表中
					if($postinfo['verify'] == '-2'){
						$db->query("INSERT INTO `".DB_PRE."common_moderate` (`id`,`idtype`,`status`,`dateline`) VALUES ('".$tid."','tid','0','".$postinfo['date']."')");
					}
					$code = '200';
					$data_array[0] = array('result'=>'post succ');
				}else{
					$code = '200';
					$data_array[0] = array('result'=>'post failed');
				}
			}else{
				$code = '500';
				$data_array[0] = array('result'=>'post failed');
			}
		break;
	case 'reply'://回帖，需要1个tid参数，1个fid参数；$_POST参数包括author,authorid,subject,message,useip；图片上传$_FILE+需要1个参数img=1
		checklogin();
		$postinfo = $_POST;
		//手机端输入设备的判定
		switch ($_POST['status']){
			case 'i':
				$postinfo['status'] = '256';
				break;
			case 'a':
				$postinfo['status'] = '258';
				break;
			case 'w':
				$postinfo['status'] = '260';
				break;
		}
		$configfile = './class/config.ini.php';
		require_once($configfile);
		//禁止发回贴时间段判断
		if($forbidden_time != ''){
			$time_sign = intimerange($forbidden_time);
			if($time_sign){
				$code = '500';
				$data_array[0] = array('result'=>'forbidden_time');
				break;
			}
		}
		//引用回复判断
		if($_GET['quote'] == '1'){
			$postinfo['bbcodeoff'] = 0;
		}else{
			$postinfo['bbcodeoff'] = -1;
		}
		//敏感词过滤
		if($filter_words != ''){
			$filter_array = explode(',', $filter_words);
		}else{
			$filter_array = array();
		}
		if($message_filter_method == '2'){//敏感词在app端进行提示
			$sign = true;
			if(!empty($filter_array)){
				foreach ($filter_array as $k=>$v){
					if(strpos($postinfo['message'],$v) !== false || strpos($postinfo['subject'],$v) !== false){
						$sign = false;
						break;
					}
				}
			}
			if(!$sign){
				$code = '500';
				$data_array[0] = array('result'=>'dangerous word');
				break;
			}
		}
		if($message_filter_method == '1'){//直接替换成***
			$filter_change_array = array();
			if(!empty($filter_array)){
				foreach ($filter_array as $k=>$v){
					$filter_change_array[$v] = '***';
				}
			}
			$postinfo['message'] = strtr($postinfo['message'],$filter_change_array);
			$postinfo['subject'] = strtr($postinfo['subject'],$filter_change_array);
		}
		//判断是否是GBK编码的数据库
		if(strtoupper($dbcharset) == 'GBK'){
			if(!empty($postinfo)){
				foreach ($postinfo as $k=>$v){
					$postinfo[$k] = mb_convert_encoding($v,'GBK','UTF-8');
				}
			}
		}
		$todaypost = $db->fetch_all("SELECT todayposts,modnewposts FROM `".DB_PRE."forum_forum` WHERE fid = '".$_GET['fid']."'");
		$mg_info = $db->fetch_all("SELECT b.allowdirectpost FROM `".DB_PRE."common_member` as a LEFT JOIN `".DB_PRE."common_usergroup_field` as b ON a.groupid=b.groupid WHERE a.uid = '".$_POST['authorid']."'");
		if($todaypost[0]['modnewposts'] == '0'){
			$postinfo['verify'] = 0;
		}else{
			if($todaypost[0]['modnewposts'] == '2'){
				if($mg_info[0]['allowdirectpost'] == '1' || $mg_info[0]['allowdirectpost'] == '3'){
					$postinfo['verify'] = 0;
				}else{
					$postinfo['verify'] = -2;
				}
			}
		}
		$postinfo['date']   = time();
		$postinfo['useip']  = getip();
		//更新post_tableid表
		$db->query("INSERT INTO `".DB_PRE."forum_post_tableid` (`pid`) VALUES('".$pid."')");
		$pid = $db->getLastId();
		$postinfo['pid'] = $pid;
		$sql = $topic->getSql('reply','','',$postinfo);
		$result = $db->query($sql);
		if($result){
			//更新forum_forum表的今天发帖数量+板块最后更新信息+帖子回复数
			$todaypost = $todaypost[0]['todayposts'];
			$new_todaypost = $todaypost + 1;
			$thread_info = $db->fetch_all("SELECT subject,replies FROM `".DB_PRE."forum_thread` WHERE tid = '".$_GET['tid']."'");
			$lastpost = $_GET['tid']."	".$thread_info[0]['subject']."	".$postinfo['date']."	".$postinfo['author'];
			if(strtoupper($dbcharset) == 'GBK'){
				$lastpost = mb_convert_encoding($lastpost,'GBK','UTF-8');
			}
			$db->query("UPDATE `".DB_PRE."forum_forum` SET `lastpost` = '".$lastpost."',`todayposts` = '".$new_todaypost."' WHERE fid = '".$_GET['fid']."'");
			$new_replies = $thread_info[0]['replies'] + 1;
			$db->query("UPDATE `".DB_PRE."forum_thread` SET `replies` = '".$new_replies."',`lastpost` = '".$postinfo['date']."',`lastposter` = '".$postinfo['author']."' WHERE tid = '".$_GET['tid']."'");
			
			//处理上传的图片
			if($_GET['img'] == '1'){
				if($postinfo['ftpimgname'] == ''){
					upload_image($_FILES, $_GET['tid'], $pid, $postinfo['authorid'], true);
				}else{
					upload_image($_FILES, $_GET['tid'], $pid, $postinfo['authorid'], true,$postinfo['ftpimgname']);
				}
			}
			//如果是需要审核的帖子则插入待审核表中
			if($postinfo['verify'] == '-2'){
				$db->query("INSERT INTO `".DB_PRE."common_moderate` (`id`,`idtype`,`status`,`dateline`) VALUES ('".$pid."','pid','0','".$postinfo['date']."')");
			}
			$code = '200';
			$data_array[0] = array('result'=>'reply succ'); 
		}else{
			$code = '500';
			$data_array[0] = array('result'=>'reply failed');
		}
		break;
	case 'smiley':
		$sql = $topic->getSql('smiley');
		$data_array  = $db->fetch_all($sql);
		if(is_array($data_array)){
			$code = '200';
			if(!empty($data_array)){
				foreach ($data_array as $k=>$v){
					$data_array[$k]['url'] = SITE_URL.'/'.'static'.'/'.'image'.'/'.'smiley'.'/'.SMILEY_NAME.'/'.$v['url'];
				}
			}
		}else{
			$code = '500';
		}
		break;
	case 'poll_post':
		//判断当前用户是否参与过投票
		$pd_sql  = "SELECT votes,polloption,voterids FROM `".DB_PRE."forum_polloption` WHERE tid = '".$_GET['tid']."' ORDER BY polloptionid asc";
		$pd_info = $db->fetch_all($pd_sql);
		$poll_state = true;
		if(!empty($pd_info)){
			foreach ($pd_info as $pdk=>$pdv){
				$tmp_poll_array = explode('	', $pdv['voterids']);
				if(in_array($_GET['uid'], $tmp_poll_array)){
				$poll_state = false;
				break;
			}
			unset($tmp_poll_array);
		 }
		}
		if($poll_state){
			$ori_info_sql = "SELECT a.votes,a.voterids,b.voters FROM `".DB_PRE."forum_polloption` as a LEFT JOIN `".DB_PRE."forum_poll` as b ON a.tid=b.tid WHERE a.tid = '".$_GET['tid']."' AND a.polloptionid = '".$_GET['polloptionid']."'";
			$ori_info = $db->fetch_all($ori_info_sql);
			$votes    = $ori_info[0]['votes'];
			$voterids = $ori_info[0]['voterids'];
			$voters   = $ori_info[0]['voters'];
			$votes += 1;
			$voters += 1;
			$voterids .= $_GET['uid'].'	';
			$update_sql_1 = "UPDATE `".DB_PRE."forum_poll` SET `voters` = '".$voters."' WHERE tid = '".$_GET['tid']."'";
			$update_sql_2 = "UPDATE `".DB_PRE."forum_polloption` SET `votes` = '".$votes."',`voterids` = '".$voterids."' WHERE polloptionid = '".$_GET['polloptionid']."'";
			$result_1 = $db->query($update_sql_1);
			$result_2 = $db->query($update_sql_2);
			if($result_1 && $result_2){
				$code = '200';
				$data_array[0] = array('result'=>'poll succ');
			}else{
				$code = '500';
				$data_array[0] = array('result'=>'poll failed');
			}
		}else{
			$code = '500';
			$data_array[0] = array('result'=>'have voted');
		}
		break;
	default:
		$code = '404';
		$data_array = array();
		
}
//print_r($data_array);die;
$json_string = $json->ArrayGetjson($data_array, $code);
echo $json_string;
/**
 * 帖子上传图片附件
 * 
 * @param $file 上传文件$_FILE
 * @param $tid 主题ID
 * @param $pid 帖子ID
 * @return BOOL
 */
function upload_image($file,$tid,$pid,$uid,$is_reply=false,$ftpimgname=''){
	$time = time();
	$year_month = date('Ym',$time);
	$day = date('d',$time);
	$db_img = new DB();
	if($ftpimgname == ''){
				require_once './class/upload.class.php';
				
				//上传操作
				if(!empty($file)){
					
					$uploaddir = DISCUZ_DIR.DS.'data'.DS.'attachment'.DS.'forum'.DS.$year_month.DS.$day;//设置附件保存路径
					//echo $uploaddir;die;
					$pic_array = array();//成功保存的图片信息数组
					foreach ($file as $k=>$v){
						$upload = new UploadFile();
        				$upload->set('default_dir',$uploaddir);
        				$result = $upload->upfile($k);
        				if($result){
        					$sizeinfo = getimagesize($uploaddir.DS.$upload->file_name);//获取图片长宽信息
        					$pic_array[] = array($upload->file_name,$v['name'],$v['size'],$sizeinfo[0]);//（上传文件名，原始文件名，大小，宽度）
        					unset($sizeinfo);
        				}
        				unset($upload);
					}
				}
	}else{
		$pic_array = array();
		$pic_array[] = array($ftpimgname,'img1.jpg','0','0');
	}
				//print_r($pic_array);die;
				//将图片附件信息写入discuz!相关数据表
				if(!empty($pic_array)){
					$tid_s = (string)$tid;
					$tableid = intval($tid_s{strlen($tid_s)-1});
					$sql_attachment   = "INSERT INTO `".DB_PRE."forum_attachment` (`tid`,`pid`,`uid`,`tableid`) VALUES ";
					$sql_attachment_x = "INSERT INTO `".DB_PRE."forum_attachment_".$tableid."` (`aid`,`tid`,`pid`,`uid`,`dateline`,`filename`,`filesize`,`attachment`,`isimage`,`width`,`remote`) VALUES ";
					if(!$is_reply){$sql_threadimage  = "INSERT INTO `".DB_PRE."forum_threadimage` (`tid`,`attachment`,`remote`) VALUES ";}
					foreach ($pic_array as $k=>$v){
						$sql_attachment  .= "('".$tid."','".$pid."','".$uid."','".$tableid."'),";
						if(!$is_reply){
							if($ftpimgname == ''){
								$sql_threadimage .= "('".$tid."','".$year_month.'/'.$day.'/'.$v[0]."','0'),";
							}else{
								$sql_threadimage .= "('".$tid."','".$year_month.'/'.$day.'/'.$v[0]."','1'),";
							}
						}
					}
					if(!$is_reply){
						$img_sql_step_1 = trim($sql_attachment,',');
						$db_img->query($img_sql_step_1);
						$img_sql_step_1 = trim($sql_threadimage,',');
						$db_img->query($img_sql_step_1);
					}else{
						$img_sql_step_1 = trim($sql_attachment,',');
						$db_img->query($img_sql_step_1);
					}
					//查询刚刚插入的aid
					$aid_array = $db_img->fetch_all("SELECT aid FROM `".DB_PRE."forum_attachment` WHERE pid = '".$pid."'");
					if(!empty($aid_array)){
						foreach ($aid_array as $k=>$v){
							if($ftpimgname == ''){
								$sql_attachment_x .= "('".$v['aid']."','".$tid."','".$pid."','".$uid."','".$time."','".$pic_array[$k][1]."','".$pic_array[$k][2]."','".$year_month.'/'.$day.'/'.$pic_array[$k][0]."','1','".$pic_array[$k][3]."','0'),";
							}else{
								$sql_attachment_x .= "('".$v['aid']."','".$tid."','".$pid."','".$uid."','".$time."','".$pic_array[$k][1]."','".$pic_array[$k][2]."','".$year_month.'/'.$day.'/'.$pic_array[$k][0]."','1','".$pic_array[$k][3]."','1'),";
							}
						}
					}
					$sql_attachment_x = trim($sql_attachment_x,',');
					if($db_img->query($sql_attachment_x)){
						return true;
					}else{
						return false;
					}
				}
}
//获取请求终端IP地址
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
//判断当前时间是否在指定时间范围内
function intimerange($range_time){
	$range_time_array = explode('-', $range_time);
	$range_time_l_array = explode(':', $range_time_array[0]);
	$range_time_r_array = explode(':', $range_time_array[1]);
	$range_time_1 = mktime($range_time_l_array[0],$range_time_l_array[1]);
	$range_time_r = mktime($range_time_r_array[0],$range_time_r_array[1]);
	$nowtime = date('H:i',time());
	$nowtime_array = explode(':',$nowtime);
	$nowtime = mktime($nowtime_array[0],$nowtime_array[1]);
	if($range_time_1 < $range_time_r){
		if($range_time_1<$nowtime && $nowtime<$range_time_r){ $result = true; }else{ $result = false; }
	}elseif ($range_time_1 > $range_time_r){//跨零点
		$l_point = mktime(23,59);
		$r_point = mktime(0,0);
		if(($range_time_1<$nowtime && $nowtime<$l_point) || ($r_point<$nowtime && $nowtime<$range_time_r)){ $result = true; }else{ $result = false; }
	}else{
		$result = false;
	}
	return $result;
}