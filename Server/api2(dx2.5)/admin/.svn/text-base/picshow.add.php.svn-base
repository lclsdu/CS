<?php
require "global.inc.php";
require_once '../class/db.class.php';
$db    = new DB();

if ($_GET['shop_id']) {
	$sql = "SELECT * FROM `".DB_PRE."common_shoplist` WHERE `shop_id` =".$_GET['shop_id'];
	$data_array  = $db->fetch_all($sql);
}

//判断是否是GBK编码的数据库
if(strtoupper($dbcharset) == 'GBK'){
	if(!empty($_POST)){
		foreach ($_POST as $k=>$v){
			$_POST[$k] = mb_convert_encoding($v,'GBK','UTF-8');
		}
	}
}

if($_POST['form_submit'] == 'ok'){
  $shop_name = trim($_POST['shop_name']);
  $shop_info = trim($_POST['shop_info']);
  $shop_phone = trim($_POST['shop_phone']);
  $shop_address = trim($_POST['shop_address']);
  $shop_website = trim($_POST['shop_website']);
  $shop_lat = trim($_POST['shop_lat']);
  $shop_lng = trim($_POST['shop_lng']);
  $class = trim($_POST['class']);
  $fuwu = trim($_POST['fuwu']);
  $huanjing = trim($_POST['huanjing']);
  
  
	  $pic_array = upload_image($_FILES);
	  if ($pic_array) {
		$shop_pic = $pic_array[0][0];
	  } else {
	  	$shop_pic = $data_array[0]['shop_pic'] ? $data_array[0]['shop_pic'] : '';
	  }	
  
  
  
  
  if ($_GET['shop_id'] != '') {
  	$insert_sql = "UPDATE `".DB_PRE."common_shoplist` SET `shop_name` = '".$shop_name."', `shop_pic` = '".$shop_pic."', `shop_info` = '".$shop_info."', `shop_name` = '".$shop_name."', `shop_phone` = '".$shop_phone."', `shop_address` = '".$shop_address."', `shop_website` = '".$shop_website."', `shop_lat` = '".$shop_lat."', `shop_lng` = '".$shop_lng."', `class` = '".$class."', `fuwu` = '".$fuwu."', `huanjing` = '".$huanjing."' WHERE `shop_id` =".$_GET['shop_id'];
  } else {
  	$insert_sql = "INSERT INTO `".DB_PRE."common_shoplist` (`shop_id`, `shop_name`, `shop_pic`, `shop_info`, `shop_phone`, `shop_address`, `shop_website`, `shop_lat`, `shop_lng`, `class`, `fuwu`, `huanjing`) VALUES (NULL, '".$shop_name."', '".$shop_pic."', '".$shop_info."', '".$shop_phone."', '".$shop_address."', '".$shop_website."', '".$shop_lat."', '".$shop_lng."', '".$class."', '".$fuwu."', '".$huanjing."')";
  }
  $result = $db->query($insert_sql);

  if ($result) {
  	if ($_GET['shop_id'] != '') {
	 echo '<script>alert("编辑成功");history.back();</script>';
  	} else {
  	 echo "<script>alert('添加成功');history.back();</script>";
  	}
  } else {
    if ($_GET['shop_id'] != '') {
	 echo "<script>alert('编辑失败');history.back();</script>";
  	} else {
  	 echo "<script>alert('添加失败');history.back();</script>";
  	}
  }
}

	function upload_image($file){
		require_once '../class/upload.class.php';
		$db_img = new DB();
		if(!empty($file)){
			$time = time();
			$year_month = date('Ym',$time);
			$day = date('d',$time);
			$uploaddir = SHOPPIC_DIR;
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

	function getSelect($cid=0){
		require_once '../class/db.class.php';
		$db    = new DB();
		$sql = "select cid, name, concat(path, '-', cid) abspath from `".DB_PRE."shop_class_app` order by abspath,cid";
		$result=$db->fetch_all($sql);
		$html='<select name="class">';
		$html.='<option value="0">--根分类--</option>';

		foreach ($result as $val){
			if($cid==$val['cid'])
				$html.='<option selected value="'.$val['cid'].'">';
			else
				$html.='<option value="'.$val['cid'].'">';
			$num=count(explode('-', $val['abspath']))-2;
			$space=str_repeat("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;",$num);
			$html.=$space.'|-'.$val['name'];
			$html.='</option>';	
		}
		$html.='</select>';
		return $html;
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
    <table class="table tb-type2 nobdb">
      <tbody id="tbody">
        <tr class="noborder">
          <td colspan="2" class="required"><label for="shop_name">主题ID:</label></td>
        </tr>
        <tr class="noborder">
          <td class="vatop rowform"><input name="tid" id="tid" class="txt" type="text" value="<?php echo $data_array[0]['shop_name'];?>" /></td>
          <td class="vatop tips">选择要导入图片新闻的主题ID</td>
        </tr>                         
      </tbody>
      <tfoot>
        <tr class="tfoot">
          <td colspan="15">
          <a href="javascript:void(0);" class="btn" id="submitBtn"><span>导入</span></a>
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
		var tid = $("#tid").val();
     	var url = "picshow_importpost.php?tid="+tid;
     	window.location.href = url;
	});
});
</script> 
<script type="text/javascript">
$(function(){
var textButton="<input type='text' name='textfield' id='textfield1' class='type-file-text' /><input type='button' name='button' id='button1' value='' class='type-file-button' />"
$(textButton).insertBefore("#shop_pic");
$("#shop_pic").change(function(){
$("#textfield1").val($("#shop_pic").val());
});
});
</script> 
</body></html>