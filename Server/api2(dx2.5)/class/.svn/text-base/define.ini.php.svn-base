<?php
require_once('config.ini.php');

/**
 * 数据库部分
 */
//数据库地址(localhost)
define('DBSERVER',$dbserver);
//数据库端口(3306)
define('DBSERVER_PORT',$dbserver_port);
//数据库名
define('DBNAME',$dbname);
//数据库帐号
define('DBUSER',$dbuser);
//数据库密码
define('DBPASSWD',$dbpasswd);
//数据库连接类型(mysqli/mysql)
define('DBTYPE',$dbtype);
//数据库字符集(utf8/gbk)
define('DBCHARSET',$dbcharset);


//是否ucenter为独立数据库，独立则填1，不独立则填0
define('UCDBON', $isucenterdb);
//如果ucenter为独立数据库，请填写下面信息（若非，请保持下面数据信息为空）

//ucenter数据库地址(localhost)
define('UCSERVER',$ucserver);
//ucenter数据库端口(3306)
define('UCSERVER_PORT',$ucserver_port);
//ucenter数据库名
define('UCNAME',$ucname);
//ucenter数据库帐号
define('UCUSER',$ucuser);
//ucenter数据库密码
define('UCPASSWD',$ucpasswd);
//ucenter数据库连接类型(mysqli/mysql)
define('UCTYPE',$uctype);
//ucenter数据库字符集(utf8/gbk)
define('UCCHARSET',$uccharset);



//表前缀
define('DB_PRE',$db_pre);
//ucenter表前缀
define('UC_PRE', $uc_pre);

/**
 * 论坛目录部分
 */
//论坛服务器根目录
define('DISCUZ_DIR', $discuz_dir);
//商家图片目录
define('SHOPPIC_DIR', $shop_pic_dir);
//商家评论图片目录
define('SHOPCOMPIC_DIR', $shop_com_pic_dir);

/**
 * 论坛URL部分
 */
//论坛根URL
define('SITE_URL', $site_url);
//图片根URL
define('IMG_PATH', $img_dir);
//图片根URL
define('FTP_IMG_PATH', $ftp_img_dir);
//ucenter的url
define('UC_URL', $ucenter_url);
//商圈图片的url
define('SHOPLIST_URL', $shoplist_url);
//商圈图片的url
define('SHOPPIC_URL', $shoppic_url);

/**
 * 表情包部分
 */
//表情包ID
define('SMILEY_TYPEID', $smiley_typeid);
//表情包名称
define('SMILEY_NAME', $smiley_name);

/**
 * 论坛推送和板块配置
 */
//首页
//头条
//头条大图(推送)
define('TOPBID',$index_bigtt);
//头条小图（推送）
define('TOPSBID',$index_smalltt);
//话题
define('TOPICPICBID',$topic_pic_bid);
//话题
define('TOPICBID',$topic_bid);
//投票
define('POLLBID',$poll_bid);
//茶座（板块）
define('INDEX2',$index_2_fid);
define('INDEX2ORDER',$index_2_fid_order);
//焦点（推送）
define('INDEX3',$index_3);
//娱乐（板块）
define('INDEX4',$index_4_fid);
define('INDEX4ORDER',$index_4_fid_order);
//情感（板块）
define('INDEX5',$index_5_fid);
define('INDEX5ORDER',$index_5_fid_order);

//生活
//美食
define('SECOND1',$second_1_fid);
define('SECOND1ORDER',$second_1_fid_order);
//汽车
define('SECOND2',$second_2_fid);
define('SECOND2ORDER',$second_2_fid_order);
//房产
define('SECOND3',$second_3_fid);
define('SECOND3ORDER',$second_3_fid_order);
//家装
define('SECOND4',$second_4_fid);
define('SECOND4ORDER',$second_4_fid_order);
//婚嫁
define('SECOND5',$second_5_fid);
define('SECOND5ORDER',$second_5_fid_order);
//母婴
define('SECOND6',$second_6_fid);
define('SECOND6ORDER',$second_6_fid_order);

//安卓额外
//板块1
define('THIRD1',$third_1_fid);
define('THIRD1ORDER',$third_1_fid_order);
//板块2
define('THIRD2',$third_2_fid);
define('THIRD2ORDER',$third_2_fid_order);
//板块3
define('THIRD3',$third_3_fid);
define('THIRD3ORDER',$third_3_fid_order);
//板块4
define('THIRD4',$third_4_fid);
define('THIRD4ORDER',$third_4_fid_order);
//板块5
define('THIRD5',$third_5_fid);
define('THIRD5ORDER',$third_5_fid_order);
//板块6
define('THIRD6',$third_6_fid);
define('THIRD6ORDER',$third_6_fid_order);

/**
 * 其他属性
 */
define('DS',DIRECTORY_SEPARATOR);
error_reporting(0);

/**
 * app栏目名称
 */
$name_array = array();
$name_array[0]['index1'] = $index_bigtt_name;
$name_array[0]['index2'] = $index_2_fid_name;
$name_array[0]['index3'] = $index_3_name;
$name_array[0]['index4'] = $index_4_fid_name;
$name_array[0]['index5'] = $index_5_fid_name;
/*
$name_array[0]['second1'] = $second_1_fid_name;
$name_array[0]['second2'] = $second_2_fid_name;
$name_array[0]['second3'] = $second_3_fid_name;
$name_array[0]['second4'] = $second_4_fid_name;
$name_array[0]['second5'] = $second_5_fid_name;
$name_array[0]['second6'] = $second_6_fid_name;

$name_array[0]['third1'] = $third_1_fid_name;
$name_array[0]['third2'] = $third_2_fid_name;
$name_array[0]['third3'] = $third_3_fid_name;
$name_array[0]['third4'] = $third_4_fid_name;
$name_array[0]['third5'] = $third_5_fid_name;
$name_array[0]['third6'] = $third_6_fid_name;
*/
/**
 * 公共函数
 */

function orderByTag($tag) {
	//几种排序形式

	switch ($tag) {
		//发帖时间
		case '1':
			$str = 'ORDER BY dateline desc';
			break;
		//回复/查看
		case '2':
			$str = 'ORDER BY replies desc,views asc';
			break;
		//查看
		case '3':
			$str = 'ORDER BY views desc';
			break;
		//最后发表
		case '4':
			$str = 'ORDER BY lastpost desc';
			break;
		//热门
		case '5':
			$str = 'ORDER BY heats desc';
			break;
		//默认
		default:
			$str = 'ORDER BY lastpost desc';
			break;
	}
	return $str;

}









