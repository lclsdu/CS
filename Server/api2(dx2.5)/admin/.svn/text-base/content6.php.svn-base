<?php
require "global.inc.php";
$configfile = '../class/config.ini.php';
require_once($configfile);

if ($_POST['form_submit'] == 'ok' && is_array($_POST) && !empty($_POST)) {

  if (is_writable($configfile)) {
    //分别处理各项参数
    $topic_bid = trim($_POST['topic_bid']);
    $poll_bid = trim($_POST['poll_bid']);
    $topic_pic_bid = trim($_POST['topic_pic_bid']);       

    $fp = @fopen($configfile, 'r');
    $filecontent = @fread($fp, @filesize($configfile));
    @fclose($fp);

    $filecontent = preg_replace("/[$]topic_bid\s*\=\s*[\"'].*?[\"']/is", "\$topic_bid = '$topic_bid'", $filecontent);
    $filecontent = preg_replace("/[$]poll_bid\s*\=\s*[\"'].*?[\"']/is", "\$poll_bid = '$poll_bid'", $filecontent);
    $filecontent = preg_replace("/[$]topic_pic_bid\s*\=\s*[\"'].*?[\"']/is", "\$topic_pic_bid = '$topic_pic_bid'", $filecontent);  

    $fp = @fopen($configfile, 'w');
    @fwrite($fp, trim($filecontent));
    @fclose($fp);    
    echo '<script>alert("设置成功");history.back();</script>';
  }
}

?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml"><head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>ShopNC App - Powered by ShopNC</title>
<script type="text/javascript" src="js/jquery_004.js"></script>
<script type="text/javascript" src="js/jquery.js"></script>
<script type="text/javascript" src="js/admincp.js"></script>
<script type="text/javascript" src="js/jquery_002.js"></script>
<script type="text/javascript" src="js/jquery_003.js"></script>
<link href="css/skin_0.css" rel="stylesheet" type="text/css" id="cssfile2" />
<script type="text/javascript">
//换肤
cookie_skin = $.cookie("MyCssSkin");
if (cookie_skin) {
	$('#cssfile2').attr("href","css/"+ cookie_skin +".css");
} 
</script>
</head>
<body>
<div class="page">
  <div class="fixed-bar">
    <div class="item-title">
      <h3>接口设置</h3>
      <ul class="tab-base">
        <li><a href="content.php"><span>数据库配置</span></a></li>
        <li><a href="content2.php"><span>网站配置</span></a></li>
        <li><a href="content3.php"><span>首页配置</span></a></li>
        <!-- <li><a href="content4.php"><span>生活配置</span></a></li> -->
        <li><a href="javascript:void(0);" class="current"><span>其他配置</span></a></li>
        <!-- <li><a href="content5.php"><span>安卓额外</span></a></li> -->
        <li><a href="countlist.php"><span>装机数量</span></a></li>
      </ul>
    </div>
  </div>
  <div class="fixed-empty"></div>
  <form method="post" enctype="multipart/form-data" name="form1">
    <input name="form_submit" value="ok" type="hidden" />
    <table class="table tb-type2">
      <tbody>
      	<!-- 话题大图id -->
        <tr class="noborder">
          <td colspan="2" class="required"><label for="topic_pic_bid">话题大图id:</label></td>
        </tr>
        <tr class="noborder">
          <td class="vatop rowform"><input id="topic_pic_bid" name="topic_pic_bid" value="<?php echo $topic_pic_bid; ?>" class="txt" type="text" /></td>
          <td class="vatop tips"><span class="vatop rowform">请填入对应的论坛话题推送id，例如10（注意，不同于板块id，为推送id）</span></td>
        </tr>      
        <!-- 话题id -->
        <tr class="noborder">
          <td colspan="2" class="required"><label for="topic_bid">话题id:</label></td>
        </tr>
        <tr class="noborder">
          <td class="vatop rowform"><input id="topic_bid" name="topic_bid" value="<?php echo $topic_bid; ?>" class="txt" type="text" /></td>
          <td class="vatop tips"><span class="vatop rowform">请填入对应的论坛话题推送id，例如10（注意，不同于板块id，为推送id）</span></td>
        </tr>
        <!-- 投票id -->
        <tr class="noborder">
          <td colspan="2" class="required"><label for="poll_bid">投票id:</label></td>
        </tr>
        <tr class="noborder">
          <td class="vatop rowform"><input id="poll_bid" name="poll_bid" value="<?php echo $poll_bid; ?>" class="txt" type="text" /></td>
          <td class="vatop tips"><span class="vatop rowform">请填入对应的论坛投票推送id，例如10（注意，不同于板块id，为推送id）</span></td>
        </tr>
      </tbody>
      <tfoot>
        <tr class="tfoot">
          <td colspan="2"><a href="javascript:void(0);" class="btn" onclick="document.form1.submit()"><span>提交</span></a></td>
        </tr>
      </tfoot>
    </table>
  </form>
</div>
</body></html>