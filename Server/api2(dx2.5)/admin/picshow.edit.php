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
	//编辑图片新闻
	$title      = $_POST['thread_title'];
	$tid        = $_POST['tid'];
	$content    = $_POST['thread_message'];
	$username   = $_POST['thread_author'];
	$uid        = $_POST['uid'];
	$useascover = $_POST['useascover'];
	$update_sql = "UPDATE `".DB_PRE."common_picshow` SET `picshow_title` = '".$title."',`picshow_content` = '".$content."',`picshow_coverpic` = '".$useascover."' WHERE picshow_id = '".$_GET['picshow_id']."'";
	$result = $db->query($update_sql);
	if($result){
		//编辑图片信息
		$delpic = '';
		if(!empty($_POST['img'])){
			foreach ($_POST['img'] as $k=>$v){
				if(in_array($k,$_POST['del'])){
					$delpic .= $_POST['pic_id'][$k].',';
					continue;
				}else{
					$db->query("UPDATE `".DB_PRE."common_pic` SET `pic_message` = '".$_POST['imgmessage'][$k]."' WHERE pic_id = '".$_POST['pic_id'][$k]."'");
				}
			}
		}
		$delpic = trim($delpic,',');
		$delsql = "DELETE FROM `".DB_PRE."common_pic` WHERE pic_id IN (".$delpic.")";
		$db->query($delsql);
		echo '<script>alert("成功更新一条图片新闻信息");history.back();</script>';
	}else{
		echo '<script>alert("更新图片新闻信息失败");history.back();</script>';
	}
}
if($_GET['picshow_id'] == '' || $_GET['picshow_id'] == '0'){
	echo '<script>alert("参数错误");history.back();</script>';
}else{
	$sql = "SELECT * FROM `".DB_PRE."common_picshow` WHERE picshow_id = '".$_GET['picshow_id']."'";
	$picshow_info = $db->fetch_all($sql);
	if(empty($picshow_info)){
		echo '<script>alert("图片新闻信息为空");history.back();</script>';
	}else{
		$sql2 = "SELECT * FROM `".DB_PRE."common_pic` WHERE picshow_id = '".$_GET['picshow_id']."'";
		$picinfo = $db->fetch_all($sql2);
	}
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
        <li><a href="picshow.add.php"><span>新增图片新闻</span></a></li>
        <li><a href="javascript:void(0);" class="current"><span>编辑图片新闻</span></a></li>
      </ul>
    </div>
  </div>
  <!--  -->
  <div class="fixed-empty"></div>
  <form id="link_form" enctype="multipart/form-data" method="post">
    <input name="form_submit" value="ok" type="hidden" />
    <input name="tid" value="<?php echo $picshow_info[0]['tid'];?>" type="hidden" />
    <input name="uid" value="<?php echo $picshow_info[0]['authorid']; ?>" type="hidden" />
    <table class="table tb-type2 nobdb">
      <tbody id="tbody">
        <tr class="noborder">
          <td colspan="2" class="required"><label for="thread_title">帖子标题:</label></td>
        </tr>
        <tr class="noborder">
          <td class="vatop rowform"><input name="thread_title" id="thread_title" class="txt" type="text" value="<?php echo $picshow_info[0]['picshow_title'];?>" /></td>
          <td class="vatop tips"></td>
        </tr>
        <tr class="noborder">
          <td colspan="2" class="required"><label for="thread_message">帖子内容:</label></td>
        </tr>
        <tr class="noborder">
          <td class="vatop rowform"><textarea class="txt" style="height:100px" name="thread_message" id="thread_message"><?php echo $picshow_info[0]['picshow_content']; ?></textarea></td>
          <td class="vatop tips"></td>
        </tr>
        <tr class="noborder">
          <td colspan="2" class="required"><label for="thread_author">帖子作者:</label></td>
        </tr>
        <tr class="noborder">
          <td class="vatop rowform"><?php echo $picshow_info[0]['username'];?></td>
          <td class="vatop tips"></td>
        </tr>    
        <tr class="noborder">
          <td colspan="2" class="required"><label for="thread_author">图片信息:</label></td>
        </tr>
        <?php if(!empty($picinfo)){?>
        <?php foreach ($picinfo as $k=>$v){?>
        <tr class="noborder">
          <td class="vatop rowform"><img src="<?php echo IMG_PATH.'/forum/'.$v['pic_photo']; ?>" width="200" height="160"/><input type="hidden" name="img[]" value="<?php echo $v['pic_photo']; ?>" /><input type="hidden" name="pic_id[]" value="<?php echo $v['pic_id']; ?>" /></td>
          <td class="vatop tips"></td>
        </tr>
        <tr class="noborder">
          <td class="vatop rowform"><input name="imgmessage[]" id="imgmessage[]" class="txt" type="text" value="<?php echo $v['pic_message']; ?>" /></td>
          <td class="vatop tips">图片描述信息,如果不填写则默认使用帖子正文内容展示</td>
        </tr>
        <tr class="noborder">
          <td class="vatop rowform"><input type="radio" name="useascover" value="<?php echo $v['pic_photo']; ?>" <?php if($v['pic_photo'] == $picshow_info[0]['picshow_coverpic']){?>checked<?php } ?>/>设为封面<input type="checkbox" name="del[]" value="<?php echo $k; ?>"/>不采用此图</td>
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