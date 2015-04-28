<?php
/**
 * 
 * Discuz!论坛帖子SQL类
 *
 * ShopNC AlexLee 2012.2.27
 */

class Topic{
	//limit参数
	function getLimitParam($pageno,$pagesize){
		$limit_param = array();
		$limit_param[0] = ($pageno-1)*$pagesize;
		$limit_param[1] = $pagesize;
		return $limit_param;
	}
	//根据tid获取tableid的函数
	function gettableidbytid($tid){
		$tid_s   = (string)$tid;
		$tableid = intval($tid_s{strlen($tid_s)-1});
		return $tableid;
	}
	//得到论坛主题列表的ORDER BY字符串
	function getorderby($orderby,$ascdesc){
		$orderby_string = '';
		switch ($orderby){
			case 'lastpost':
				$orderby_string = " ORDER BY lastpost ".$ascdesc;
				break;
			case 'dateline':
				$orderby_string = " ORDER BY dateline ".$ascdesc;
				break;
			case 'replies';
				$orderby_string = " ORDER BY replies ".$ascdesc;
				break;
			case 'views':
				$orderby_string = " ORDER BY views ".$ascdesc;
				break;
		}
		return $orderby_string;
	}

	//获取不同的列表形式
	function getSql($type,$pageno='',$pagesize='',$postinfo='',$addtype='',$pid_list='',$get_order_by_str='') {
		require_once './class/db.class.php';
		$sql = '';
		if (!empty($type)) {
			switch ($type) {
				//首页
				case 'top'://头条大图
					$limit_param  = $this->getLimitParam($pageno,$pagesize);
					$sql = "SELECT a.title,a.pic,a.summary,a.idtype,a.id,b.closed FROM `".DB_PRE."common_block_item_data` as a LEFT JOIN `".DB_PRE."forum_thread` as b ON a.id=b.tid WHERE a.bid=".TOPBID." ORDER BY a.dateline desc LIMIT ".$limit_param[0].",".$limit_param[1];
					break;
				case 'tops'://头条小图
					$limit_param  = $this->getLimitParam($pageno,$pagesize);
					$sql = "SELECT a.title,a.pic,a.summary,a.idtype,a.id,b.closed FROM `".DB_PRE."common_block_item_data` as a LEFT JOIN `".DB_PRE."forum_thread` as b ON a.id=b.tid WHERE a.bid=".TOPSBID." ORDER BY a.dateline desc LIMIT ".$limit_param[0].",".$limit_param[1];
					break;
				case 'topic_pic'://话题大图
					$limit_param  = $this->getLimitParam($pageno,$pagesize);
					$sql = "SELECT title,pic,idtype,id FROM `".DB_PRE."common_block_item_data` WHERE bid=".TOPICPICBID." ORDER BY dateline desc LIMIT ".$limit_param[0].",".$limit_param[1];
					break;
				case 'topic'://话题
					$limit_param  = $this->getLimitParam($pageno,$pagesize);
					$sql = "SELECT a.title,a.pic,a.idtype,a.id,a.dateline,c.name FROM `".DB_PRE."common_block_item_data` as a LEFT JOIN `".DB_PRE."forum_thread` as b ON a.id = b.tid LEFT JOIN `".DB_PRE."forum_forum` as c ON b.fid = c.fid WHERE a.bid=".TOPICBID." ORDER BY a.dateline desc LIMIT ".$limit_param[0].",".$limit_param[1];
					break;
				case 'poll'://投票
					$limit_param  = $this->getLimitParam($pageno,$pagesize);
					$sql = "SELECT a.title,a.pic,a.idtype,a.id,b.subject,b.dateline,c.expiration FROM `".DB_PRE."common_block_item_data` as a LEFT JOIN `".DB_PRE."forum_thread` as b ON a.id = b.tid LEFT JOIN `".DB_PRE."forum_poll` as c ON a.id = c.tid WHERE a.bid=".POLLBID." ORDER BY a.dateline desc LIMIT ".$limit_param[0].",".$limit_param[1];
					break;
				case 'poll_detail'://投票详情
					$sql = "SELECT votes,polloption,polloptionid FROM `".DB_PRE."forum_polloption` WHERE tid = '".$_GET['tid']."' ORDER BY polloptionid asc";
					break;
				case 'poll_result'://投票结果统计
					$sql = "SELECT a.votes,a.polloption,b.voters FROM `".DB_PRE."forum_polloption` as a LEFT JOIN `".DB_PRE."forum_poll` as b ON a.tid=b.tid WHERE a.tid = '".$_GET['tid']."' ORDER BY a.polloptionid asc";
					break;
				case 'allpoll':
					$sql = "SELECT title FROM `".DB_PRE."common_block_item_data` WHERE bid=".POLLBID." ORDER BY dateline desc";
					break;
				case 'index2'://茶座
					$limit_param  = $this->getLimitParam($pageno,$pagesize);
					$sql = "SELECT a.title,a.pic,a.summary,a.idtype,a.id,b.closed FROM `".DB_PRE."common_block_item_data` as a LEFT JOIN `".DB_PRE."forum_thread` as b ON a.id=b.tid WHERE a.bid=".INDEX2." ORDER BY a.dateline desc LIMIT ".$limit_param[0].",".$limit_param[1];
					break;				
				case 'index3'://焦点
					$limit_param  = $this->getLimitParam($pageno,$pagesize);
					$sql = "SELECT a.title,a.pic,a.summary,a.idtype,a.id,b.closed FROM `".DB_PRE."common_block_item_data` as a LEFT JOIN `".DB_PRE."forum_thread` as b ON a.id=b.tid WHERE a.bid=".INDEX3." ORDER BY a.dateline desc LIMIT ".$limit_param[0].",".$limit_param[1];
					break;
				case 'index4'://娱乐
					$limit_param  = $this->getLimitParam($pageno,$pagesize);
					$sql = "SELECT a.title,a.pic,a.summary,a.idtype,a.id,b.closed FROM `".DB_PRE."common_block_item_data` as a LEFT JOIN `".DB_PRE."forum_thread` as b ON a.id=b.tid WHERE a.bid=".INDEX4." ORDER BY a.dateline desc LIMIT ".$limit_param[0].",".$limit_param[1];
					break;	
				case 'index5'://情感
					$limit_param  = $this->getLimitParam($pageno,$pagesize);
					$sql = "SELECT a.title,a.pic,a.summary,a.idtype,a.id,b.closed FROM `".DB_PRE."common_block_item_data` as a LEFT JOIN `".DB_PRE."forum_thread` as b ON a.id=b.tid WHERE a.bid=".INDEX5." ORDER BY a.dateline desc LIMIT ".$limit_param[0].",".$limit_param[1];
					break;	
				//生活	
				case 'second1'://美食
					$limit_param  = $this->getLimitParam($pageno,$pagesize);
					$sql = "SELECT subject,author,dateline,views,replies,tid,fid,closed FROM `".DB_PRE."forum_thread` WHERE `displayorder` = '0' AND `fid` = '".SECOND1."' ".$get_order_by_str." LIMIT ".$limit_param[0].",".$limit_param[1];
					break;	
				case 'second2'://汽车
					$limit_param  = $this->getLimitParam($pageno,$pagesize);
					$sql = "SELECT subject,author,dateline,views,replies,tid,fid,closed FROM `".DB_PRE."forum_thread` WHERE `displayorder` = '0' AND `fid` = '".SECOND2."' ".$get_order_by_str." LIMIT ".$limit_param[0].",".$limit_param[1];
					break;	
				case 'second3'://房产
					$limit_param  = $this->getLimitParam($pageno,$pagesize);
					$sql = "SELECT subject,author,dateline,views,replies,tid,fid,closed FROM `".DB_PRE."forum_thread` WHERE `displayorder` = '0' AND `fid` = '".SECOND3."' ".$get_order_by_str." LIMIT ".$limit_param[0].",".$limit_param[1];
					break;	
				case 'second4'://家装
					$limit_param  = $this->getLimitParam($pageno,$pagesize);
					$sql = "SELECT subject,author,dateline,views,replies,tid,fid,closed FROM `".DB_PRE."forum_thread` WHERE `displayorder` = '0' AND `fid` = '".SECOND4."' ".$get_order_by_str." LIMIT ".$limit_param[0].",".$limit_param[1];
					break;	
				case 'second5'://婚姻
					$limit_param  = $this->getLimitParam($pageno,$pagesize);
					$sql = "SELECT subject,author,dateline,views,replies,tid,fid,closed FROM `".DB_PRE."forum_thread` WHERE `displayorder` = '0' AND `fid` = '".SECOND5."' ".$get_order_by_str." LIMIT ".$limit_param[0].",".$limit_param[1];
					break;	
				case 'second6'://母婴
					$limit_param  = $this->getLimitParam($pageno,$pagesize);
					$sql = "SELECT subject,author,dateline,views,replies,tid,fid,closed FROM `".DB_PRE."forum_thread` WHERE `displayorder` = '0' AND `fid` = '".SECOND6."' ".$get_order_by_str." LIMIT ".$limit_param[0].",".$limit_param[1];
					break;	
				//安卓额外	
				case 'third1'://板块1
					$limit_param  = $this->getLimitParam($pageno,$pagesize);
					$sql = "SELECT subject,author,dateline,views,replies,tid,fid,closed FROM `".DB_PRE."forum_thread` WHERE `displayorder` = '0' AND `fid` = '".THIRD1."' ".$get_order_by_str." LIMIT ".$limit_param[0].",".$limit_param[1];
					break;	
				case 'third2'://板块1
					$limit_param  = $this->getLimitParam($pageno,$pagesize);
					$sql = "SELECT subject,author,dateline,views,replies,tid,fid,closed FROM `".DB_PRE."forum_thread` WHERE `displayorder` = '0' AND `fid` = '".THIRD2."' ".$get_order_by_str." LIMIT ".$limit_param[0].",".$limit_param[1];
					break;	
				case 'third3'://板块1
					$limit_param  = $this->getLimitParam($pageno,$pagesize);
					$sql = "SELECT subject,author,dateline,views,replies,tid,fid,closed FROM `".DB_PRE."forum_thread` WHERE `displayorder` = '0' AND `fid` = '".THIRD3."' ".$get_order_by_str." LIMIT ".$limit_param[0].",".$limit_param[1];
					break;	
				case 'third4'://板块1
					$limit_param  = $this->getLimitParam($pageno,$pagesize);
					$sql = "SELECT subject,author,dateline,views,replies,tid,fid,closed FROM `".DB_PRE."forum_thread` WHERE `displayorder` = '0' AND `fid` = '".THIRD4."' ".$get_order_by_str." LIMIT ".$limit_param[0].",".$limit_param[1];
					break;	
				case 'third5'://板块1
					$limit_param  = $this->getLimitParam($pageno,$pagesize);
					$sql = "SELECT subject,author,dateline,views,replies,tid,fid,closed FROM `".DB_PRE."forum_thread` WHERE `displayorder` = '0' AND `fid` = '".THIRD5."' ".$get_order_by_str." LIMIT ".$limit_param[0].",".$limit_param[1];
					break;	
				case 'third6'://板块1
					$limit_param  = $this->getLimitParam($pageno,$pagesize);
					$sql = "SELECT subject,author,dateline,views,replies,tid,fid,closed FROM `".DB_PRE."forum_thread` WHERE `displayorder` = '0' AND `fid` = '".THIRD6."' ".$get_order_by_str." LIMIT ".$limit_param[0].",".$limit_param[1];
					break;						

				//论坛部分		
				case 'forum_list'://论坛板块列表
					$sql = "SELECT a.fid,a.fup,a.type,a.name,a.status,b.viewperm,b.postperm,b.replyperm,b.postimageperm,b.formulaperm,b.moderators,b.spviewperm FROM `".DB_PRE."forum_forum` as a LEFT JOIN `".DB_PRE."forum_forumfield` as b ON a.fid=b.fid WHERE a.status = 1 ORDER BY a.displayorder asc";
					break;				
				case 'thread_list'://板块帖子列表（需要传一个fid参数）
					//调取板块默认排序方式
					$orderby = '';
					$ascdesc = '';
					$forums_sql = "SELECT * FROM `".DB_PRE."common_syscache` WHERE cname = 'forums'";
					$db = new DB();
					$forums_info = $db->fetch_all($forums_sql);
					$forums_string = $forums_info[0]['data'];
					if(strtoupper(DBCHARSET) == 'GBK'){
						$forums_string = mb_convert_encoding($forums_string,'GBK','UTF-8');
					}
					$forums = unserialize($forums_string);
					if(!empty($forums)){
						foreach ($forums as $k=>$v){
							if($v['fid'] == $_GET['fid']){
								$orderby = $v['orderby'];
								$ascdesc = $v['ascdesc'];
								break;
							}
						}
					}
					$orderby = $this->getorderby($orderby, $ascdesc);
					$limit_param  = $this->getLimitParam($pageno,$pagesize);
					if($_GET['orderby'] == ''){
						$sql = "SELECT subject,author,dateline,views,replies,tid,fid,closed FROM `".DB_PRE."forum_thread` WHERE displayorder != '-1' AND fid=".$_GET['fid'].$orderby." LIMIT ".$limit_param[0].",".$limit_param[1];
					}else{
						$sql = "SELECT subject,author,dateline,views,replies,tid,fid,closed FROM `".DB_PRE."forum_thread` WHERE displayorder != '-1' AND fid=".$_GET['fid']." ".$get_order_by_str." LIMIT ".$limit_param[0].",".$limit_param[1];
					}
					break;
				case 'threadcount':
					$sql = "SELECT count(tid) as num FROM `".DB_PRE."forum_thread` WHERE displayorder = '0' AND fid=".$_GET['fid'];
					break;
				case 'thread_detail_getpid':
					$limit_param  = $this->getLimitParam($pageno,$pagesize);
					if($addtype == 'only_owner'){//只看楼主
						$sql = "SELECT pid FROM `".DB_PRE."forum_post` WHERE tid = '".$_GET['tid']."' AND invisible = '0' AND authorid = '".$_GET['authorid']."' GROUP BY pid ORDER BY dateline asc LIMIT ".$limit_param[0].",".$limit_param[1];
					}elseif($addtype == 'last_post'){//最新回复
						$sql = "SELECT pid FROM `".DB_PRE."forum_post` WHERE tid = '".$_GET['tid']."' AND invisible = '0' GROUP BY pid ORDER BY dateline desc LIMIT ".$limit_param[0].",".$limit_param[1];
					}else{
						$sql = "SELECT pid FROM `".DB_PRE."forum_post` WHERE tid = '".$_GET['tid']."' AND invisible = '0' GROUP BY pid ORDER BY dateline asc LIMIT ".$limit_param[0].",".$limit_param[1];
					}
					break;
				case 'thread_detail'://帖子详细（需要传一个tid参数）
					//$limit_param  = $this->getLimitParam($pageno,$pagesize);
					if($addtype == 'only_owner'){//只看楼主
						$sql = "SELECT a.status,a.anonymous,a.pid,subject,message,a.dateline,a.tid,author,b.uid,fid,avatarstatus,c.attachment,c.remote FROM `".DB_PRE."forum_post` as a LEFT JOIN `".DB_PRE."common_member` as b ON a.authorid=b.uid LEFT JOIN `".DB_PRE."forum_attachment_".gettableidbytid($_GET['tid'])."` as c ON a.pid=c.pid WHERE a.pid IN (".$pid_list.") ORDER BY dateline asc";
					}elseif($addtype == 'last_post'){//最新回复
						$sql = "SELECT a.status,a.anonymous,a.pid,subject,message,a.dateline,a.tid,author,b.uid,fid,avatarstatus,c.attachment,c.remote FROM `".DB_PRE."forum_post` as a LEFT JOIN `".DB_PRE."common_member` as b ON a.authorid=b.uid LEFT JOIN `".DB_PRE."forum_attachment_".gettableidbytid($_GET['tid'])."` as c ON a.pid=c.pid WHERE a.pid IN (".$pid_list.") ORDER BY dateline desc";
					}else{
						$sql = "SELECT a.status,a.anonymous,a.pid,subject,message,a.dateline,a.tid,author,b.uid,fid,avatarstatus,c.attachment,c.remote FROM `".DB_PRE."forum_post` as a LEFT JOIN `".DB_PRE."common_member` as b ON a.authorid=b.uid LEFT JOIN `".DB_PRE."forum_attachment_".gettableidbytid($_GET['tid'])."` as c ON a.pid=c.pid WHERE a.pid IN (".$pid_list.") ORDER BY dateline asc";
					}
					break;
				case 'owner_authorid':
					$sql = "SELECT authorid FROM `".DB_PRE."forum_post` WHERE tid=".$_GET['tid']." AND first = '1'";
					break;
				case 'postcount'://帖子楼层总数
					if($addtype == 'only_owner'){//只看楼主
						$sql = "SELECT count(pid) as num FROM `".DB_PRE."forum_post` WHERE invisible = '0' AND tid=".$_GET['tid']." AND authorid=".$_GET['authorid'];
					}else{
						$sql = "SELECT count(pid) as num FROM `".DB_PRE."forum_post` WHERE invisible = '0' AND tid=".$_GET['tid'];
					}
					break;
				case 'top_thread'://置顶帖子（需要传一个fid参数）
					$limit_param  = $this->getLimitParam($pageno,$pagesize);
					$sql = "SELECT subject,author,dateline,views,replies,tid,fid FROM `".DB_PRE."forum_thread` WHERE displayorder>0 AND fid=".$_GET['fid']." LIMIT ".$limit_param[0].",".$limit_param[1];
					break;
				case 'top_thread_count'://置顶帖子数量
					$sql = "SELECT count(tid) as num FROM `".DB_PRE."forum_thread` WHERE displayorder>0 AND fid=".$_GET['fid']." ORDER BY dateline desc";
					break;
				case 'digest_thread'://精华帖（需要传一个fid参数）
					$limit_param  = $this->getLimitParam($pageno,$pagesize);
					$sql = "SELECT subject,author,dateline,views,replies,tid,fid FROM `".DB_PRE."forum_thread` WHERE digest!=0 AND fid=".$_GET['fid']." LIMIT ".$limit_param[0].",".$limit_param[1]." ORDER BY dateline desc";
					break;
				case 'digest_thread_count'://精华帖子数量
					$sql = "SELECT count(tid) as num FROM `".DB_PRE."forum_thread` WHERE digest!=0 AND fid=".$_GET['fid'];
					break;
				case 'search_thread'://搜索帖子（需要传一个fid参数+一个keyword参数<经过url编码过的>）
					$limit_param  = $this->getLimitParam($pageno,$pagesize);
					$sql = "SELECT subject,author,dateline,views,replies,tid,fid FROM `".DB_PRE."forum_thread` WHERE subject like '%".urldecode($_GET['keyword'])."%' AND fid=".$_GET['fid']." LIMIT ".$limit_param[0].",".$limit_param[1];
					break;
				case 'search_thread_count'://搜索结果帖子数量
					$sql = "SELECT count(tid) as num FROM `".DB_PRE."forum_thread` WHERE subject like '%".urldecode($_GET['keyword'])."%' AND fid=".$_GET['fid'];
					break;
				case 'post_step1'://发帖插入主题表（需要传一个fid参数）
					if($_GET['img'] == '1'){
						$sql = "INSERT INTO `".DB_PRE."forum_thread` (`fid`,`author`,`authorid`,`subject`,`dateline`,`lastpost`,`lastposter`,`views`,`attachment`,`typeid`,`displayorder`) VALUES ('".$_GET['fid']."','".$postinfo['author']."','".$postinfo['authorid']."','".$postinfo['subject']."','".$postinfo['date']."','".$postinfo['date']."','".$postinfo['author']."','1','2','".$postinfo['typeid']."','".$postinfo['verify']."')";
					}else{
						$sql = "INSERT INTO `".DB_PRE."forum_thread` (`fid`,`author`,`authorid`,`subject`,`dateline`,`lastpost`,`lastposter`,`views`,`typeid`,`displayorder`) VALUES ('".$_GET['fid']."','".$postinfo['author']."','".$postinfo['authorid']."','".$postinfo['subject']."','".$postinfo['date']."','".$postinfo['date']."','".$postinfo['author']."','1','".$postinfo['typeid']."','".$postinfo['verify']."')";
					}
					break;
				case 'post_step2'://发帖插入帖子表（需要传一个fid参数）
					if($_GET['img'] == '1'){
						$sql = "INSERT INTO `".DB_PRE."forum_post` (`pid`,`fid`,`tid`,`first`,`author`,`authorid`,`subject`,`dateline`,`message`,`useip`,`bbcodeoff`,`smileyoff`,`usesig`,`attachment`,`invisible`,`status`) VALUES ('".$postinfo['pid']."','".$_GET['fid']."','".$postinfo['tid']."','1','".$postinfo['author']."','".$postinfo['authorid']."','".$postinfo['subject']."','".$postinfo['date']."','".strtr(addslashes($postinfo['message']),array('('=>'\(',')'=>'\)'))."','".$postinfo['useip']."','-1','0','1','2','".$postinfo['verify']."','".$postinfo['status']."')";
					}else{
						$sql = "INSERT INTO `".DB_PRE."forum_post` (`pid`,`fid`,`tid`,`first`,`author`,`authorid`,`subject`,`dateline`,`message`,`useip`,`bbcodeoff`,`smileyoff`,`usesig`,`invisible`,`status`) VALUES ('".$postinfo['pid']."','".$_GET['fid']."','".$postinfo['tid']."','1','".$postinfo['author']."','".$postinfo['authorid']."','".$postinfo['subject']."','".$postinfo['date']."','".strtr(addslashes($postinfo['message']),array('('=>'\(',')'=>'\)'))."','".$postinfo['useip']."','-1','0','1','".$postinfo['verify']."','".$postinfo['status']."')";
					}
					
					break;
				case 'reply'://回帖（需要传一个tid参数）
					if($_GET['img'] == '1'){
						$sql = "INSERT INTO `".DB_PRE."forum_post` (`pid`,`fid`,`tid`,`first`,`author`,`authorid`,`subject`,`dateline`,`message`,`useip`,`bbcodeoff`,`smileyoff`,`usesig`,`attachment`,`invisible`,`status`) VALUES ('".$postinfo['pid']."','".$_GET['fid']."','".$_GET['tid']."','0','".$postinfo['author']."','".$postinfo['authorid']."','".$postinfo['subject']."','".$postinfo['date']."','".strtr(addslashes($postinfo['message']),array('('=>'\(',')'=>'\)'))."','".$postinfo['useip']."','".$postinfo['bbcodeoff']."','0','1','2','".$postinfo['verify']."','".$postinfo['status']."')";
					}else{
						$sql = "INSERT INTO `".DB_PRE."forum_post` (`pid`,`fid`,`tid`,`first`,`author`,`authorid`,`subject`,`dateline`,`message`,`useip`,`bbcodeoff`,`smileyoff`,`usesig`,`invisible`,`status`) VALUES ('".$postinfo['pid']."','".$_GET['fid']."','".$_GET['tid']."','0','".$postinfo['author']."','".$postinfo['authorid']."','".$postinfo['subject']."','".$postinfo['date']."','".strtr(addslashes($postinfo['message']),array('('=>'\(',')'=>'\)'))."','".$postinfo['useip']."','".$postinfo['bbcodeoff']."','0','1','".$postinfo['verify']."','".$postinfo['status']."')";
					}
					break;
				case 'smiley':
					$sql = "SELECT code,url FROM `".DB_PRE."common_smiley` WHERE type='smiley' AND typeid='".SMILEY_TYPEID."' ORDER BY displayorder asc";
					break;
				case 'all_smiley':
					$sql = "SELECT code,url,directory FROM `".DB_PRE."common_smiley` as a LEFT JOIN `".DB_PRE."forum_imagetype` as b ON a.typeid=b.typeid WHERE a.type='smiley' AND b.available != '0'";
					break;
				case 'memberinfo':
					$sql = "SELECT username,adminid,groupid FROM `".DB_PRE."common_member` WHERE uid = ".intval($_GET['uid']);
					break;
				case 'picshow_info':
					$limit_param  = $this->getLimitParam($pageno,$pagesize);
					$sql = "SELECT a.picshow_id,a.picshow_title,a.picshow_coverpic,a.tid,b.fid FROM `".DB_PRE."common_picshow` as a LEFT JOIN `".DB_PRE."forum_thread` as b ON a.tid=b.tid ORDER BY a.picshow_addtime desc LIMIT ".$limit_param[0].",".$limit_param[1];
					break;
				case 'picshow_pic_info':
					$sql = "SELECT a.*,b.picshow_title,b.picshow_content FROM `".DB_PRE."common_pic` as a LEFT JOIN `".DB_PRE."common_picshow` as b ON a.picshow_id=b.picshow_id WHERE a.picshow_id = '".$_GET['picshow_id']."'";
					break;
				default:
					$sql = "none";
			}
			return $sql;
		}
	}
}