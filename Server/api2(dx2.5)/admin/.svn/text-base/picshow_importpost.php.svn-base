<?php
require "global.inc.php";
require_once '../class/db.class.php';
$db    = new DB();
//判断是否是GBK编码的数据库
if(strtoupper($dbcharset) == 'GBK'){
	if(!empty($_POST)){
		foreach ($_POST as $k=>$v){
			$_POST[$k] = mb_convert_encoding($v,'GBK','UTF-8');
		}
	}
}
if($_POST['form_submit'] == 'ok'){
	//判断是否同时选中了"设为封面"和"不采用此图"
	if(!empty($_POST['del'])){
		foreach ($_POST['del'] as $k=>$v){
			if($_POST['img'][$v] == $_POST['useascover']){
				echo '<script>alert("不能同时选中设为封面和不采用此图");history.back();</script>';die;
			}
		}
	}
	//存储图片新闻信息
	$title      = $_POST['thread_title'];
	$tid        = $_POST['tid'];
	$content    = $_POST['thread_message'];
	$username   = $_POST['thread_author'];
	$uid        = $_POST['uid'];
	$useascover = $_POST['useascover'];
	$addtime    = time();
	$insert_sql_1 = "INSERT INTO `".DB_PRE."common_picshow` (`picshow_title`,`picshow_coverpic`,`picshow_addtime`,`username`,`uid`,`tid`,`picshow_content`) VALUES ('".$title."','".$useascover."','".$addtime."','".$username."','".$uid."','".$tid."','".$content."')";
	$result  = $db->query($insert_sql_1);
	$picshow_id = $db->getLastId();
	if($result){
		//存储图片信息
		$insert_sql_2 = "INSERT INTO `".DB_PRE."common_pic` (`picshow_id`,`pic_message`,`pic_photo`,`pic_addtime`) VALUES ";
		if(!empty($_POST['img'])){
			foreach ($_POST['img'] as $k=>$v){
				if(!in_array($k,$_POST['del'])){
					$insert_sql_2 .= "('".$picshow_id."','".$_POST['imgmessage'][$k]."','".$v."','".$addtime."'),";
				}
			}
		}
		$insert_sql_2 = trim($insert_sql_2,',');
		$result2 = $db->query($insert_sql_2);
		echo '<script>alert("成功新增一条图片新闻!");window.location.href="picshow_list.php"</script>';die;
	}else{
		echo '<script>alert("新增一条图片新闻失败");history.back();</script>';die;
	}
}
if($_GET['tid'] == '' || $_GET['tid'] == '0'){
	echo '<script>alert("参数错误");history.back();</script>';
}else{
	$sql = "SELECT pid,author,authorid,subject,message FROM `".DB_PRE."forum_post` WHERE tid = '".$_GET['tid']."' ORDER BY pid asc LIMIT 0,1";
	$thread_info = $db->fetch_all($sql);
	if(empty($thread_info)){
		echo '<script>alert("帖子信息为空");history.back();</script>';
	}else{
		$picsql = "SELECT attachment FROM `".DB_PRE."forum_attachment_".gettableidbytid($_GET['tid'])."` WHERE pid = '".$thread_info[0]['pid']."'";
		$picinfo = $db->fetch_all($picsql);
	}
}

/**
 * 根据tid获取到附件表的tableid
 */
function gettableidbytid($tid){
	$tid_s   = (string)$tid;
	$tableid = intval($tid_s{strlen($tid_s)-1});
	return $tableid;
}
?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml"><head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>ShopNC商城系统演示站 - Powered by ShopNC</title>
<script type="text/javascript" src="js/jquery_004.js"></script>
<script type="text/javascript" src="js/jquery.js"></script>
<script type="text/javascript" src="js/admincp.js"></script>
<script type="text/javascript" src="js/jquery_002.js"></script>
<script type="text/javascript" src="js/jquery_003.js"></script>
<link href="css/skin_0.css" rel="stylesheet" type="text/css" id="cssfile2" />
</head>
<body>

<div class="page">
  <div class="fixed-bar">
    <div class="item-title">
      <h3>图片新闻管理</h3>
      <ul class="tab-base">
        <li><a href="picshow_list.php"><span>图片新闻管理</span></a></li>
        <li><a href="javascript:void(0);" class="current"><span>新增图片新闻</span></a></li>
      </ul>
    </div>
  </div>
  <!--  -->
  <div class="fixed-empty"></div>
  <form id="link_form" enctype="multipart/form-data" method="post">
    <input name="form_submit" value="ok" type="hidden" />
    <input name="tid" value="<?php echo $_GET['tid'];?>" type="hidden" />
    <input name="uid" value="<?php echo $thread_info[0]['authorid']; ?>" type="hidden" />
    <table class="table tb-type2 nobdb">
      <tbody id="tbody">
        <tr class="noborder">
          <td colspan="2" class="required"><label for="thread_title">帖子标题:</label></td>
        </tr>
        <tr class="noborder">
          <td class="vatop rowform"><input name="thread_title" id="thread_title" class="txt" type="text" value="<?php echo $thread_info[0]['subject'];?>" /></td>
          <td class="vatop tips"></td>
        </tr>
        <tr class="noborder">
          <td colspan="2" class="required"><label for="thread_message">帖子内容:</label></td>
        </tr>
        <tr class="noborder">
          <td class="vatop rowform"><textarea class="txt" style="height:100px" name="thread_message" id="thread_message"><?php echo $thread_info[0]['message']; ?></textarea></td>
          <td class="vatop tips"></td>
        </tr>
        <tr class="noborder">
          <td colspan="2" class="required"><label for="thread_author">帖子作者:</label></td>
        </tr>
        <tr class="noborder">
          <td class="vatop rowform"><input name="thread_author" id="thread_author" class="txt" type="text" value="<?php echo $thread_info[0]['author'];?>" /></td>
          <td class="vatop tips"></td>
        </tr>    
        <tr class="noborder">
          <td colspan="2" class="required"><label for="thread_author">图片信息:</label></td>
        </tr>
        <?php if(!empty($picinfo)){?>
        <?php foreach ($picinfo as $k=>$v){?>
        <tr class="noborder">
          <td class="vatop rowform"><img src="<?php echo IMG_PATH.'/forum/'.$v['attachment']; ?>" width="200" height="160"/><input type="hidden" name="img[]" value="<?php echo $v['attachment']; ?>" /></td>
          <td class="vatop tips"></td>
        </tr>
        <tr class="noborder">
          <td class="vatop rowform"><input name="imgmessage[]" id="imgmessage[]" class="txt" type="text" value="" /></td>
          <td class="vatop tips">图片描述信息,如果不填写则默认使用帖子正文内容展示</td>
        </tr>
        <tr class="noborder">
          <td class="vatop rowform"><input type="radio" name="useascover" value="<?php echo $v['attachment']; ?>" />设为封面<input type="checkbox" name="del[]" value="<?php echo $k; ?>"/>不采用此图</td>
          <td class="vatop tips"></td>
        </tr>
        <?php }} ?>                    
      </tbody>
      <tfoot>
        <tr class="tfoot">
          <td colspan="15">
          <a href="javascript:void(0);" class="btn" id=submitBtn><span>提交</span></a>
          </td>
        </tr>
      </tfoot>
    </table>
  </form>
</div>
<script>
//按钮先执行验证再提交表单
$(function(){
	$("#submitBtn").click(function(){
		$("#link_form").submit();
	});
});
</script>
</body></html>