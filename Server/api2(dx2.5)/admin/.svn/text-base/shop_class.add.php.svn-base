<?php
require "global.inc.php";
require_once '../class/db.class.php';
$db    = new DB();

if ($_GET['shop_class_id']) {
	$sql = "SELECT * FROM `".DB_PRE."shop_class_app` WHERE `cid` =".$_GET['shop_class_id'];
	$data_array  = $db->fetch_all($sql);
	
}

	$sql = "SELECT * FROM `".DB_PRE."shop_class_app` WHERE `pid` =0";
	$p_array  = $db->fetch_all($sql);
	


if($_POST['form_submit'] == 'ok'){
	
	
  $name = trim($_POST['ac_name']);
  $sort = trim($_POST['ac_sort']);
  //判断是否是GBK编码的数据库
  if(strtoupper($dbcharset) == 'GBK'){
  	$name = mb_convert_encoding($name,'GBK','UTF-8');
  	$sort = mb_convert_encoding($sort,'GBK','UTF-8');
  }

  if ($_GET['shop_class_id'] != '') {
  	$insert_sql = "UPDATE `".DB_PRE."shop_class_app` SET `name` = '".$name."', `sort` = '".$sort."' WHERE `cid` =".$_GET['shop_class_id'];
  }
  $result = $db->query($insert_sql);

  if ($result) {
  	if ($_GET['shop_class_id'] != '') {
	 echo '<script>alert("编辑成功");history.back();</script>';
  	} else {
  	 echo "<script>alert('添加成功');history.back();</script>";
  	}
  } else {
    if ($_GET['shop_class_id'] != '') {
	 echo "<script>alert('编辑失败');history.back();</script>";
  	} else {
  	 echo "<script>alert('添加失败');history.back();</script>";
  	}
  }
}

?>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml"><head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>ShopNC商城系统演示站 - Powered by ShopNC</title>
<script type="text/javascript" src="shop_class.add.php_files/jquery_003.js"></script>
<script type="text/javascript" src="shop_class.add.php_files/jquery.js"></script>
<script type="text/javascript" src="shop_class.add.php_files/admincp.js"></script>
<script type="text/javascript" src="shop_class.add.php_files/jquery_002.js"></script>
<script type="text/javascript" src="shop_class.add.php_files/jquery_004.js"></script>
<link href="shop_class.add.php_files/skin_0.css" rel="stylesheet" type="text/css" id="cssfile2">
</head>
<body>

<div class="page">
  <div class="fixed-bar">
    <div class="item-title">
      <h3>新增分类</h3>
      <ul class="tab-base">
		<li><a href="shoplist.php"><span>商家管理</span></a></li>
        <li><a href="shoplist.add.php"><span>商家新增</span></a></li>
        <li><a href="shop_class.php?pid=0"><span>商家分类</span></a></li>
        <li><a href="javascript:void(0);" class="current"><span>编辑分类</span></a></li>
        <li><a href="shoppostlist.php"><span>商家评论</span></a></li>
      </ul>
    </div>
  </div>
  <div class="fixed-empty"></div>
  <form id="article_class_form" method="post">
    <input name="form_submit" value="ok" type="hidden">
    <table class="table tb-type2">
      <tbody>
        <tr class="noborder">
          <td colspan="2" class="required"><label for="ac_name">分类名称:</label></td>
        </tr>
        <tr class="noborder">
          <td class="vatop rowform"><input name="ac_name" value="<?php echo $data_array[0]['name']?>" id="ac_name" class="txt" type="text"></td>
          <td class="vatop tips"></td>
        </tr>
        <tr>
          <td colspan="2" class="required"><label for="ac_sort">排序:</label></td>
        </tr>
        <tr class="noborder">
          <td class="vatop rowform"><input value="<?php echo $data_array[0]['sort']?>" name="ac_sort" id="ac_sort" class="txt" type="text"></td>
          <td class="vatop tips"></td>
        </tr>
      </tbody>
      <tfoot>
        <tr class="tfoot">
          <td colspan="15"><a href="javascript:void(0);" class="btn" id="submitBtn"><span>提交</span></a></td>
        </tr>
      </tfoot>
    </table>
  </form>
</div>
<script>
//按钮先执行验证再提交表单
$(function(){$("#submitBtn").click(function(){
    if($("#article_class_form").valid()){
     $("#article_class_form").submit();
	}
	});
});
//
</script>
</body></html>