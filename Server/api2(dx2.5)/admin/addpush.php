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
//查询device token数组
$token_array = $db->fetch_all("SELECT * FROM `".DB_PRE."common_devicetoken`");
$token_num = count($token_array);

if($_POST['form_submit'] == 'ok'){
	//将推送新闻数据存储进数据库
	$db->query("INSERT INTO `".DB_PRE."common_pushinfo` (`tid`,`pushtitle`,`pushtime`) VALUES('".$_POST['tid']."','".$_POST['pushinfo']."','".time()."')");
	
	
	//进行ios端推送
	$errstrn = "";
	$err = "";
	$pass = "1234";
	$pushnum = 0;
	if(is_array($token_array) && !empty($token_array)){
		foreach ($token_array as $k=>$v){
			$deviceToken = $v['token'];
		    $body = array("aps" => array("alert" => $_POST['pushinfo'],"sound" => 'default'), "tid" => $_POST['tid']);
		    $ctx = stream_context_create();
		    stream_context_set_option($ctx, "ssl", "local_cert", "ck.pem");
		    stream_context_set_option($ctx, "ssl", 'passphrase', $pass);
		    $fp = stream_socket_client("ssl://gateway.sandbox.push.apple.com:2195", $err, $errstr, 60, STREAM_CLIENT_CONNECT, $ctx);
		    if (!$fp) {
		        //print "Failed to connect $err $errstrn";
		        return;
		    }
		    //print "Connection OK\n";
		    $payload = json_encode($body);
		    $msg = chr(0) . pack("n",32) . pack("H*", $deviceToken) . pack("n",strlen($payload)) . $payload;
		    //print "sending message :" . $payload . "\n";
		    fwrite($fp, $msg);
		    fclose($fp);
		    $pushnum++;
		    echo '<script>$(function(){ $("#push_tip").text("正在推送，请稍后 : '.$pushnum.'/'.$token_num.'"); });</script>';
		}
	}
	if($pushnum == $token_num){
		echo '<script>alert("全部设备推送成功！");history.back(-2);</script>';
	} else {
	  	echo "<script>alert('未能全部推送成功');history.back(-2);</script>";
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
      <h3>推送管理</h3>
      <ul class="tab-base">
        <li><a href="pushinfo_list.php"><span>推送新闻列表</span></a></li>
        <li><a href="javascript:void(0);" class="current"><span>新增推送新闻</span></a></li>
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
          <td colspan="2" class="required"><label for="tid">推送主题ID:</label></td>
        </tr>
        <tr class="noborder">
          <td class="vatop rowform"><input name="tid" id="tid" class="txt" type="text" value="" /></td>
          <td class="vatop tips">填写要推送新闻的主题ID</td>
        </tr>   
        <tr class="noborder">
          <td colspan="2" class="required"><label for="pushinfo">推送标题:</label></td>
        </tr>
        <tr class="noborder">
          <td class="vatop rowform"><textarea class="txt" style="height:100px" name="pushinfo" id="pushinfo"></textarea></td>
          <td class="vatop tips">填写推送信息（注意：请不要超过30字，否则将可能导致推送失败！）</td>
        </tr>                      
      </tbody>
      <tfoot>
        <tr class="tfoot">
          <td colspan="15">
          <a href="javascript:void(0);" class="btn" id="submitBtn"><span id="push_tip">开始推送！</span></a><span>（总共有<font style="color:red"><?php echo $token_num; ?></font>台ios设备会被推送）</span>
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
		$("#push_tip").text("正在推送，请稍后");
		$("#link_form").submit();
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