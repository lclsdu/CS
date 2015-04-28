<?php
/**
 * Discuz!文章和帖子列表controler
 * $_GET['type']、$_GET['pageno']、$_GET['pagesize']为必须参数
 * 
 * ShopNC AlexLee 2012.2.27
 */
require_once './class/db.class.php';
require_once './class/topic.class.php';
require_once './class/json.class.php';
define('SITE_URL', $site_url);
define('DS', '/');
//参数处理
$type     = strtolower($_GET['type']);
$pageno   = $_GET['pageno']!=''?intval($_GET['pageno']):'';
$pagesize = $_GET['pagesize']!=''?intval($_GET['pagesize']):'';
$addtype  = $_GET['addtype']!=''?strtolower($_GET['addtype']):'';
$get_order_by = $_GET['orderby'] != '' ? strtolower($_GET['orderby']) : '';


//通过获取的
function requestOrderBy($get_order_by,$default_order_by) {
	$end_order_by = $get_order_by != '' ? $get_order_by : $default_order_by;
	switch ($get_order_by) {
		//发帖时间
		case 'dateline':
			$str = 'ORDER BY dateline desc';
			break;
		//回复/查看
		case 'replies':
			$str = 'ORDER BY replies desc,views asc';
			break;
		//查看
		case 'views':
			$str = 'ORDER BY views desc';
			break;
		//最后发表
		case 'lastpost':
			$str = 'ORDER BY lastpost desc';
			break;
		//热门
		case 'heats':
			$str = 'ORDER BY heats desc';
			break;
		//默认
		default:
			$str = 'ORDER BY lastpost desc';
			break;
	}
	return $str;
}

if($type == ''){
	echo 'param error';exit;
}
//实例化类
$topic = new Topic();
$db    = new DB();
$json  = new JSON();

$order_array = array('second1','second2','second3','second4','second5','second6','index2','index4','index5','third1','third2','third3','third4','third5','third6','thread_list','top_thread','digest_thread');



if($type == 'top_name_list'){
	echo $json->ArrayGetjson($name_array, '200');
	exit;
}

if($type == 'thread_detail' && $addtype == 'only_owner'){
	$authorid_sql = $topic->getSql('owner_authorid');
	$owner_info = $db->fetch_all($authorid_sql);
	$authorid = $owner_info[0]['authorid'];
	$_GET['authorid'] = $authorid;
}

if($type == 'thread_detail'){
	$sql = $topic->getSql('thread_detail_getpid', $pageno, $pagesize, '', $addtype);
}else{
	$sql = $topic->getSql($type, $pageno, $pagesize, '', $addtype);
}

if(in_array($type, $order_array)){
	switch ($type) {
		case 'index2':
			$default_order_by = INDEX2ORDER;
			break;	
		case 'index4':
			$default_order_by = INDEX4ORDER;
			break;	
		case 'index5':
			$default_order_by = INDEX5ORDER;
			break;									
		case 'second1':
			$default_order_by = SECOND1ORDER;
			break;
		case 'second2':
			$default_order_by = SECOND2ORDER;
			break;
		case 'second3':
			$default_order_by = SECOND3ORDER;
			break;
		case 'second4':
			$default_order_by = SECOND4ORDER;
			break;
		case 'second5':
			$default_order_by = SECOND5ORDER;
			break;	
		case 'second6':
			$default_order_by = SECOND6ORDER;
			break;		
		case 'third1':
			$default_order_by = THIRD1ORDER;
			break;	
		case 'third2':
			$default_order_by = THIRD2ORDER;
			break;	
		case 'third3':
			$default_order_by = THIRD3ORDER;
			break;	
		case 'third4':
			$default_order_by = THIRD4ORDER;
			break;	
		case 'third5':
			$default_order_by = THIRD5ORDER;
			break;	
		case 'third6':
			$default_order_by = THIRD6ORDER;
			break;																																	
		default:
			$default_order_by = SECOND1ORDER;
			break;
	}
	$get_order_by_str = requestOrderBy($get_order_by, $default_order_by);
	$sql = $topic->getSql($type, $pageno, $pagesize, '', $addtype, '', $get_order_by_str);	
}

if($sql == 'none'){
	$code = '404';
	$data_array = array();
}else{
	$data_array  = $db->fetch_all($sql);
	if(is_array($data_array)){
		$code = '200';
		if($type == 'top' || $type == 'tops' || $type == 'index2' || $type == 'index3' || $type == 'index4' || $type == 'index5'){
			foreach ($data_array as $key=>$value){
				foreach ($value as $k=>$val){
					if($k == 'pic'){
						$data_array[$key][$k] = IMG_PATH.'/'.$val;
					}
				}
			}
		}elseif($type == 'forum_list'){
		//根据用户组权限为板块信息添加读写标识
			//$gid = intval($_GET['groupid']);
			if(is_array($data_array) && !empty($data_array)){
				//获取用户信息，如果是游客则为空数组
				$is_member  = true;
				$memberinfo = array();
				if($_GET['uid'] != ''){
					$memberinfo_sql  = $topic->getSql('memberinfo');
					$memberinfo = $db->fetch_all($memberinfo_sql);
					if(is_array($memberinfo)){
						$memberinfo = $memberinfo[0];
					}else{
						$memberinfo['groupid'] = 7;
						$is_member = false;
					}
				}else{
					$memberinfo['groupid'] = 7;
					$is_member = false;
				}
				$userallowforum = '';
				if($is_member){
					//调取用户权限信息
					$userright_sql = "SELECT fid,allowview,allowpost,allowreply,allowpostimage FROM `".DB_PRE."forum_access` WHERE uid = '".$_GET['uid']."'";
					$userright = $db->fetch_all($userright_sql);
					//判断板块是否会显示,如果不需要显示则从数组中将其去除（单独用户判断）
					if(!empty($userright)){
						foreach ($userright as $k=>$v){
							if($v['allowview'] == '-1'){
								foreach ($data_array as $dk=>$dv){
									if($v['fid'] == $dv['fid']){
										unset($data_array[$dk]);
										break;
									}
								}
							}
							if($v['allowview'] == '1'){
								$userallowforum .= $v['fid'].',';
							}
						}
					}
					$userallowforum = trim($userallowforum,',');
				}
				//print_r($userright);die;
				//print_r($data_array);die;
				//echo $userallowforum;die;
				/**板块数组处理**/
				foreach ($data_array as $k=>$v){
					$data_array[$k]['name'] = replaceHtmlAndJs($data_array[$k]['name']);//过滤html标签
					
					//判断板块是否会显示,如果不需要显示则从数组中将其去除（用户组判断）
					if(forumviewperm($memberinfo,$v,$userallowforum) === false){
							unset($data_array[$k]);
							continue;
					}
					unset($data_array[$k]['formulaperm']);
					//判断当前用户是否具有对此板块的写权限操作（发帖/回帖）
					/*发帖*/
					if($v['postperm'] == ''){
						if($memberinfo['groupid'] == 7){
							$data_array[$k]['ispost'] = 0;
						}else{
							$data_array[$k]['ispost'] = 1;
						}
					}else{
						$tmp_postperm = explode('	', $v['postperm']);
						if(in_array($memberinfo['groupid'], $tmp_postperm)){
							$data_array[$k]['ispost'] = 1;
						}else{ 
							$data_array[$k]['ispost'] = 0;
						}
					}
					/*回帖*/
					if($v['replyperm'] == ''){
						if($memberinfo['groupid'] == 7){
							$data_array[$k]['isreply'] = 0;
						}else{
							$data_array[$k]['isreply'] = 1;
						}
					}else{
						$tmp_replyperm = explode('	', $v['replyperm']);
						if(in_array($memberinfo['groupid'], $tmp_replyperm)){
							$data_array[$k]['isreply'] = 1;
						}else{
							$data_array[$k]['isreply'] = 0;
						}
					}
					/*上传图片*/
					if($v['postimageperm'] == ''){
						if($memberinfo['groupid'] == 7){
							$data_array[$k]['ispostimage'] = 0;
						}else{
							$data_array[$k]['ispostimage'] = 1;
						}
					}else{
						$tmp_postimageperm = explode('	', $v['postimageperm']);
						if(in_array($memberinfo['groupid'], $tmp_postimageperm)){
							$data_array[$k]['ispostimage'] = 1;
						}else{
							$data_array[$k]['ispostimage'] = 0;
						}
					}
					//单独用户权限判断
					if(!empty($userright) && $is_member){
						foreach ($userright as $uk=>$uv){
								if($v['fid'] == $uv['fid']){
									switch ($uv['allowpost']){
										case '1':
											$data_array[$k]['ispost'] = 1;
											break;
										case '-1':
											$data_array[$k]['ispost'] = 0;
											break;
									}
									switch ($uv['allowreply']){
										case '1':
											$data_array[$k]['isreply'] = 1;
											break;
										case '-1':
											$data_array[$k]['isreply'] = 0;
											break;
									}
									switch ($uv['allowpostimage']){
										case '1':
											$data_array[$k]['ispostimage'] = 1;
											break;
										case '-1':
											$data_array[$k]['ispostimage'] = 0;
											break;
									}
									break;
								}
						}
					}
				}
				
				//对分区进行显示判断
				if(!empty($data_array)){
					foreach ($data_array as $k=>$v){
						if($v['fup'] == '0'){//如果分区未被隐藏则判断其下是否有需要显示的板块，如果没有则隐藏该分区
							$show = false;
							foreach ($data_array as $fk=>$fv){
								if($fv['fup'] == $v['fid']){
									$show = true;
									break;
								}
							}
							if(!$show){
								unset($data_array[$k]);
							}
						}else{//如果是板块的话则查找所属分区是否被隐藏，如果隐藏则也隐藏此板块
							$show = false;
							foreach ($data_array as $sk=>$sv){
								if($sv['fid'] == $v['fup']){
									$show = true;
									break;
								}
							}
							if(!$show){
								unset($data_array[$k]);
							}
						}
					}
				}
			}
		}elseif($type == 'thread_detail'){
			$pid_list = '';
			if(!empty($data_array)){
				foreach ($data_array as $k=>$v){
					$pid_list .= $v['pid'].',';
				}
			}
			$pid_list = trim($pid_list,',');
			//获取楼层详细信息
			$detail_sql = $topic->getSql('thread_detail','','','',$addtype,$pid_list);
			$data_array = $db->fetch_all($detail_sql);
			//获取楼层总数
			$count_sql  = $topic->getSql('postcount','','','',$addtype);
			$count_info = $db->fetch_all($count_sql);
			$count = $count_info[0]['num'];
			//数组信息处理
			/*加载表情替换数组缓存文件*/
			$cache_file = './cache/discuz_smiley_filter.php';
			if(file_exists($cache_file)){//加载表情信息缓存
				require_once ($cache_file);
			}else{//如果没有则添加
				$smiley_list_sql = $topic->getSql('all_smiley');
				$smiley_list = $db->fetch_all($smiley_list_sql);
				//生成文件
				$tmp .= "<?php \r\n";
				$tmp .= '$smiley_filter = array('."\r\n";
				if(!empty($smiley_list)){
					foreach ($smiley_list as $k=>$v){
						$url = '[ncsmiley]'.SITE_URL.'/static/image/smiley/'.$v['directory'].'/'.$v['url'].'[/ncsmiley]';
						$tmp .= "\t\t'".addslashes($v['code'])."'=>'".addslashes($url)."'".",\r\n";
						unset($url);
					}
				}
				$tmp .= ');';
				//写入文件
				$fp = @fopen($cache_file,'wb+');
				@fwrite($fp,$tmp);
				@fclose($fp);
				require_once ($cache_file);
			}
			/*处理帖子数组*/
			//print_r($data_array);die;
			$tmp_data_array = array();
			if(!empty($data_array)){
				foreach ($data_array as $k=>$v){
					if($v['attachment'] != ''){
						$tmp_attchment_array = explode('/', $data_array[$k]['attachment']);
						$first_c = substr($tmp_attchment_array[2],0,1);
						if($v['remote'] == '0'){
							if($first_c == 'm'){//手机上传的图片
								$data_array[$k]['attachment'] = SITE_URL.'/data/attachment/forum/'.$v['attachment'];
							}else{//非手机上传的图片
								$data_array[$k]['attachment'] = IMG_PATH.'/forum/'.$v['attachment'];
							}
						}else{//采用了ftp远程图片服务器
							$data_array[$k]['attachment'] = FTP_IMG_PATH.'/forum/'.$v['attachment'];
						}
						
					}
					if(empty($tmp_data_array)){
						$tmp_data_array[$v['pid']] = $data_array[$k];
					}else{
						$sign = true;
						foreach ($tmp_data_array as $tk=>$tv){
							if($tk == $v['pid']){
								$sign = false;
								if($data_array[$k]['attachment'] != ''){
									$tmp_data_array[$tk]['attachment'] = $tmp_data_array[$tk]['attachment'] != ''?$tmp_data_array[$tk]['attachment'].','.$data_array[$k]['attachment']:$data_array[$k]['attachment'];//将图片加入attachment	
								}
								break;
							}
						}
						if($sign){
							$tmp_data_array[$v['pid']] = $data_array[$k];
						}
					}
					unset($tmp_attchment_array);
					unset($first_c);
				}
			}
			$data_array = $tmp_data_array;
			$tableid = gettableidbytid(intval($_GET['tid']));
			if(!empty($data_array)){
				foreach ($data_array as $k=>$v){
					//添加用户头像信息
					if($v['avatarstatus'] == '1' && $v['anonymous'] == '0'){//有头像
						$data_array[$k]['avatar_url'] = getuseravatarurl($v['uid']);
					}else{//无头像则返回默认头像
						$data_array[$k]['avatar_url'] = UC_URL.'/images/noavatar_small.gif';
					}
					//对用户名进行匿名和游客的判断
					if($v['uid'] == 0){
						$data_array[$k]['author'] = '游客';
					}
					if($v['anonymous'] == '1'){
						$data_array[$k]['author'] = '匿名';
						$data_array[$k]['uid'] = 0;
					}
					//替换帖子内容中的表情代码
					$data_array[$k]['message'] = strtr($v['message'],$smiley_filter);
					//设置客户端提示语内容
					switch ($v['status']){
						case '-1':
							$data_array[$k]['status'] = '';
							$data_array[$k]['message'] = '提示: 该帖被管理员或版主屏蔽';
							break;
						case '1':
							$data_array[$k]['status'] = '';
							$data_array[$k]['message'] = '提示: 该帖被管理员或版主屏蔽';
							break;
						case '113':
							$data_array[$k]['status'] = '';
							$data_array[$k]['message'] = '提示: 该帖被管理员或版主屏蔽';
							break;
						case '81':
							$data_array[$k]['status'] = '';
							$data_array[$k]['message'] = '提示: 该帖被管理员或版主屏蔽';
							break;
						case '97':
							$data_array[$k]['status'] = '';
							$data_array[$k]['message'] = '提示: 该帖被管理员或版主屏蔽';
							break;
						case '256':
							$data_array[$k]['status'] = $iphone_tip;
							break;
						case '258':
							$data_array[$k]['status'] = $android_tip;
							break;
						case '260':
							$data_array[$k]['status'] = $wp_tip;
							break;
					}
					if(empty($_GET['dev']) || $_GET['dev'] != 'iphone'){
						$data_array[$k]['message'] = replaceHtmlAndJs($data_array[$k]['message']);
					}
				}
			}
		}elseif($type == 'thread_list'){
			$count_sql  = $topic->getSql('threadcount');
			$count_info = $db->fetch_all($count_sql);
			$count = $count_info[0]['num'];
		}elseif($type == 'top_thread'){
			$count_sql  = $topic->getSql('top_thread_count');
			$count_info = $db->fetch_all($count_sql);
			$count = $count_info[0]['num'];
		}elseif($type == 'digest_thread'){
			$count_sql  = $topic->getSql('digest_thread_count');
			$count_info = $db->fetch_all($count_sql);
			$count = $count_info[0]['num'];
		}elseif($type == 'search_thread'){
			$count_sql  = $topic->getSql('search_thread_count');
			$count_info = $db->fetch_all($count_sql);
			$count = $count_info[0]['num'];
		}elseif($type == 'picshow_pic_info'){
			if(!empty($data_array)){
				foreach ($data_array as $k=>$v){
					$data_array[$k]['pic_photo'] = IMG_PATH.'/forum/'.$data_array[$k]['pic_photo'];
					//如果图片信息为空则采用帖子内容替代
					if($v['pic_message'] == ''){
						$data_array[$k]['pic_message'] = $v['picshow_content'];
					}
				}
			}
		}elseif($type == 'picshow_info'){
			if(!empty($data_array)){
				foreach ($data_array as $k=>$v){
					$data_array[$k]['picshow_coverpic'] = IMG_PATH.'/forum/'.$data_array[$k]['picshow_coverpic'];
				}
			}
		}elseif($type == 'topic_pic' || $type == 'poll'){
			if(!empty($data_array)){
				foreach ($data_array as $k=>$v){
					$data_array[$k]['pic'] = IMG_PATH.'/'.$data_array[$k]['pic'];
				}
			}
			//如果是投票则判断当前用户是否已经参与
			if($type == 'poll'){
				if($_GET['uid'] == ''){
					$count   = 'no vote';
				}else{
					$pd_sql  = "SELECT votes,polloption,voterids FROM `".DB_PRE."forum_polloption` WHERE tid = '".$data_array[0]['id']."' ORDER BY polloptionid asc";
					$pd_info = $db->fetch_all($pd_sql);
					$count   = 'no vote';
					if(!empty($pd_info)){
						foreach ($pd_info as $pdk=>$pdv){
							$tmp_poll_array = explode('	', $pdv['voterids']);
							if(in_array($_GET['uid'], $tmp_poll_array)){
								$count = 'have voted';
								break;
							}
							unset($tmp_poll_array);
						}
					}
				}
			}
		}elseif($type == 'poll_detail'){
			$count = 0;
			if(!empty($data_array)){
				foreach ($data_array as $k=>$v){
					$count += $v['votes'];
				}
			}
		}elseif($type == 'poll_result'){
			if(!empty($data_array)){
				foreach ($data_array as $k=>$v){
					//统计投票数百分比
					$data_array[$k]['percent'] = round($v['votes']/$v['voters']*100).'%';
					//统计手机端统计柱状条点阵长度
					$data_array[$k]['line'] = round($v['votes']/$v['voters']*250);
				}
			}
		}
	}else{
		$code = '500';
	}
}
//print_r($data_array);die;
//生成json字符串
if(isset($count) && $count != ''){
	$json_string = $json->ArrayGetjson($data_array, $code, $count);
}else{
	$json_string = $json->ArrayGetjson($data_array, $code);
}
header('Content-type: application/json');
echo parse($json_string);

//
function parse($text) {
    $text = str_replace("\r\n", "\n", $text);
    $text = str_replace("\r", "\n", $text);
    $text = str_replace("\n", "\\n", $text);
    return $text;
}

//
function parseString($string) {
        $string = str_replace("\\", "\\\\", $string);
        $string = str_replace('/', "\\/", $string);
        $string = str_replace('"', "\\".'"', $string);
        $string = str_replace("\b", "\\b", $string);
        $string = str_replace("\t", "\\t", $string);
        $string = str_replace("\n", "\\n", $string);
        $string = str_replace("\f", "\\f", $string);
        $string = str_replace("\r", "\\r", $string);
        $string = str_replace("\u", "\\u", $string);
        return '"'.$string.'"';
}


/**
 * 根据tid获取到附件表的tableid
 */
function gettableidbytid($tid){
	$tid_s   = (string)$tid;
	$tableid = intval($tid_s{strlen($tid_s)-1});
	return $tableid;
}
/**
 * 获取用户头像url
 * 
 * @param $uid 用户ID
 * @return $avatar_url 头像URL
 */
function getuseravatarurl($uid){
	$uid = abs(intval($uid));
	$uid = sprintf("%09d", $uid);
	$dir1 = substr($uid, 0, 3);
	$dir2 = substr($uid, 3, 2);
	$dir3 = substr($uid, 5, 2);
	$avatar_url = UC_URL.'/data/avatar/'.$dir1.'/'.$dir2.'/'.$dir3.'/'.substr($uid, -2).'_avatar_small.jpg';
	return $avatar_url;
}
/**
 * 判断论坛板块是否可见
 * 
 * @param $memberinfo 用户的基本信息数组
 * @param $foruminfo 论坛的基本权限信息
 * @param $userallowview 针对用户设置的浏览权限
 * @return BOOL
 */
function forumviewperm($memberinfo,$foruminfo,$userallowview){
	$formula     = unserialize($foruminfo['formulaperm']);
	$permusers   = $formula['users'];
	$formulatext = $formula[0];
	$formula     = $formula[1];
	
	//判断当前板块是否设置了对当前用户可见
	$tmp_userallowview = explode(',', $userallowview);
	if(in_array($foruminfo['fid'], $tmp_userallowview)){
		return true;
	}
	
	//如果是系统管理员、论坛版块斑竹、或是没有板块权限规则信息则被认为可以被浏览
	if($memberinfo['adminid'] == 1 || ($memberinfo['username'] != '' && in_array($memberinfo['username'], explode("\t", $foruminfo['moderators'])) )|| $foruminfo['formulaperm'] == '') {
		return true;
	}
	//判断所在用户组是否有浏览权限
	if($foruminfo['viewperm'] != ''){
		$tmp_viewperm = explode('	',$foruminfo['viewperm']);
		if(!in_array($memberinfo['groupid'], $tmp_viewperm)){
			return false;
		}
	}
	/*查看板块帖子列表的条件的判定*/
	//如果有允许用户列表，则判断当前用户是否在其中
	if($permusers != ''){
		$permusers = str_replace(array("\r\n", "\r"), array("\n", "\n"), $permusers);
		$permusers = explode("\n", trim($permusers));
		if(!in_array($memberinfo['username'], $permusers)) {
			return false;
		}
	}
	/*进行公式计算*/
	//没有公式则可以浏览
	if($formula == ''){
		return true;
	}
	//如果所在用户组属于不受限制则无须进行公式计算可以浏览
	if(in_array($memberinfo['groupid'], explode("\t", $foruminfo['spviewperm']))){
		return true;
	}
	if(strexists($formula, '$memberformula[')) {
		preg_match_all("/\\\$memberformula\['(\w+?)'\]/", $formula, $a);
		$fields = $profilefields = array();
		$mfadd = array();
		foreach($a[1] as $field) {
			switch($field) {
				case 'regdate':
					$formula = preg_replace("/\{(\d{4})\-(\d{1,2})\-(\d{1,2})\}/e", "'\'\\1-'.sprintf('%02d', '\\2').'-'.sprintf('%02d', '\\3').'\''", $formula);
				case 'regday':
					$fields[] = 'm.regdate';break;
				case 'regip':
				case 'lastip':
					$formula = preg_replace("/\{([\d\.]+?)\}/", "'\\1'", $formula);
					$formula = preg_replace('/(\$memberformula\[\'(regip|lastip)\'\])\s*=+\s*\'([\d\.]+?)\'/', "strpos(\\1, '\\3')===0", $formula);
				case 'buyercredit':
				case 'sellercredit':
					$mfadd['ms'] = " LEFT JOIN ".DB_PRE."common_member_status as ms ON m.uid=ms.uid";
					$fields[] = 'ms.'.$field;break;
				case substr($field, 0, 5) == 'field':
					$mfadd['mp'] = " LEFT JOIN ".DB_PRE."common_member_profile as mp ON m.uid=mp.uid";
					$fields[] = 'mp.field'.intval(substr($field, 5));
					$profilefields[] = $field;break;
			}
		}
		$memberformula = array();
		$db = new DB();
		if($memberinfo['uid']) {
			$memberformula = $db->fetch_all("SELECT ".implode(',', $fields)." FROM ".DB_PRE."common_member as m ".implode('', $mfadd)." WHERE m.uid='$memberinfo[uid]'");
			$memberformula = $memberformula[0];
			if(in_array('regday', $a[1])) {
				$memberformula['regday'] = intval((TIMESTAMP - $memberformula['regdate']) / 86400);
			}
			if(in_array('regdate', $a[1])) {
				$memberformula['regdate'] = date('Y-m-d', $memberformula['regdate']);
			}
			$memberformula['lastip'] = $memberformula['lastip'] ? $memberformula['lastip'] : $memberinfo['clientip'];
		} else {
			if(isset($memberformula['regip'])) {
				$memberformula['regip'] = $memberinfo['clientip'];
			}
			if(isset($memberformula['lastip'])) {
				$memberformula['lastip'] = $memberinfo['clientip'];
			}
		}
	}
	@eval("\$formulaperm = ($formula) ? TRUE : FALSE;");
	if(!$formulaperm){
		return false;
	}else{
		return true;
	}
}
/**
 * 
 * 获取用户资料函数（配合forumviewperm函数使用）
 * @param string $field 要获取信息的字段名
 */
function getuserprofile($field) {
	$db = new DB();
	static $tablefields = array(
		'count'		=> array('extcredits1','extcredits2','extcredits3','extcredits4','extcredits5','extcredits6','extcredits7','extcredits8','friends','posts','threads','digestposts','doings','blogs','albums','sharings','attachsize','views','oltime','todayattachs','todayattachsize'),
		'status'	=> array('regip','lastip','lastvisit','lastactivity','lastpost','lastsendmail','invisible','buyercredit','sellercredit','favtimes','sharetimes','profileprogress'),
		'field_forum'	=> array('publishfeed','customshow','customstatus','medals','sightml','groupterms','authstr','groups','attentiongroup'),
		'field_home'	=> array('videophoto','spacename','spacedescription','domain','addsize','addfriend','menunum','theme','spacecss','blockposition','recentnote','spacenote','privacy','feedfriend','acceptemail','magicgift','stickblogs'),
		'profile'	=> array('realname','gender','birthyear','birthmonth','birthday','constellation','zodiac','telephone','mobile','idcardtype','idcard','address','zipcode','nationality','birthprovince','birthcity','resideprovince','residecity','residedist','residecommunity','residesuite','graduateschool','company','education','occupation','position','revenue','affectivestatus','lookingfor','bloodtype','height','weight','alipay','icq','qq','yahoo','msn','taobao','site','bio','interest','field1','field2','field3','field4','field5','field6','field7','field8'),
		'verify'	=> array('verify1', 'verify2', 'verify3', 'verify4', 'verify5', 'verify6', 'verify7'),
	);
	$profiletable = '';
	foreach($tablefields as $table => $fields) {
		if(in_array($field, $fields)) {
			$profiletable = $table;
			break;
		}
	}
	if($profiletable) {
		$data = array();
		if($_GET['uid']) {
			$sql = "SELECT ".implode(', ', $tablefields[$profiletable])." FROM `".DB_PRE."common_member_".$profiletable."` WHERE uid=".$_GET['uid'];
			$data = $db->fetch_all($sql);
			$data = $data[0];
		}
		if(!$data) {
			foreach($tablefields[$profiletable] as $k) {
				$data[$k] = '';
			}
		}
		return $data[$field];
	}
}
function strexists($string, $find) {
	return !(strpos($string, $find) === FALSE);
}
function replaceHtmlAndJs($document)

{

$document = trim($document);

if (strlen($document) <= 0)

{

  return $document;

}

$search = array ("'<script[^>]*?>.*?</script>'si",  // 去掉 javascript

                  "'<[\/\!]*?[^<>]*?>'si",          // 去掉 HTML 标记

                  "'&(amp|#38);'i",

                  "'&(lt|#60);'i",

                  "'&(gt|#62);'i",

                  "'&(nbsp|#160);'i"

                  );                    // 作为 PHP 代码运行

$replace = array ("",

                   "",

                   "&",

                   "<",

                   ">",

                   " "

                   );

return @preg_replace ($search, $replace, $document);

}