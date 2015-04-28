<?php
require "global.inc.php";
$configfile = '../class/config.ini.php';
require_once($configfile);

if ($_POST['form_submit'] == 'ok' && is_array($_POST) && !empty($_POST)) {

  if (is_writable($configfile)) {
    //分别处理各项参数
    $discuz_dir = trim($_POST['discuz_dir']);
    $shop_pic_dir = trim($_POST['shop_pic_dir']);
    $shop_com_pic_dir = trim($_POST['shop_com_pic_dir']);
    $site_url = trim($_POST['site_url']);
    $shoplist_url = trim($_POST['shoplist_url']);
    $img_dir = trim($_POST['img_dir']);
    $ftp_img_dir = trim($_POST['ftp_img_dir']);
    $ucenter_url = trim($_POST['ucenter_url']);
    $smiley_typeid = trim($_POST['smiley_typeid']);
    $smiley_name = trim($_POST['smiley_name']);
    $shoppic_url = trim($_POST['shoppic_url']);
    $message_filter_method = $_POST['message_filter_method'];
    $filter_words = trim($_POST['filter_words']);
    $forbidden_time = trim($_POST['forbidden_time']);
    
    $fp = @fopen($configfile, 'r');
    $filecontent = @fread($fp, @filesize($configfile));
    @fclose($fp);

    $filecontent = preg_replace("/[$]discuz_dir\s*\=\s*[\"'].*?[\"']/is", "\$discuz_dir = '$discuz_dir'", $filecontent);
    $filecontent = preg_replace("/[$]shop_pic_dir\s*\=\s*[\"'].*?[\"']/is", "\$shop_pic_dir = '$shop_pic_dir'", $filecontent);
    $filecontent = preg_replace("/[$]shop_com_pic_dir\s*\=\s*[\"'].*?[\"']/is", "\$shop_com_pic_dir = '$shop_com_pic_dir'", $filecontent);
    $filecontent = preg_replace("/[$]shoplist_url\s*\=\s*[\"'].*?[\"']/is", "\$shoplist_url = '$shoplist_url'", $filecontent);
    $filecontent = preg_replace("/[$]site_url\s*\=\s*[\"'].*?[\"']/is", "\$site_url = '$site_url'", $filecontent);
    $filecontent = preg_replace("/[$]img_dir\s*\=\s*[\"'].*?[\"']/is", "\$img_dir = '$img_dir'", $filecontent);
    $filecontent = preg_replace("/[$]ftp_img_dir\s*\=\s*[\"'].*?[\"']/is", "\$ftp_img_dir = '$ftp_img_dir'", $filecontent);
    $filecontent = preg_replace("/[$]ucenter_url\s*\=\s*[\"'].*?[\"']/is", "\$ucenter_url = '$ucenter_url'", $filecontent);
    $filecontent = preg_replace("/[$]smiley_typeid\s*\=\s*[\"'].*?[\"']/is", "\$smiley_typeid = '$smiley_typeid'", $filecontent);
    $filecontent = preg_replace("/[$]smiley_name\s*\=\s*[\"'].*?[\"']/is", "\$smiley_name = '$smiley_name'", $filecontent);
    $filecontent = preg_replace("/[$]shoppic_url\s*\=\s*[\"'].*?[\"']/is", "\$shoppic_url = '$shoppic_url'", $filecontent);
    $filecontent = preg_replace("/[$]message_filter_method\s*\=\s*[\"'].*?[\"']/is", "\$message_filter_method = '$message_filter_method'", $filecontent);
    $filecontent = preg_replace("/[$]filter_words\s*\=\s*[\"'].*?[\"']/is", "\$filter_words = '$filter_words'", $filecontent);
    $filecontent = preg_replace("/[$]forbidden_time\s*\=\s*[\"'].*?[\"']/is", "\$forbidden_time = '$forbidden_time'", $filecontent);

    $fp = @fopen($configfile, 'w');
    @fwrite($fp, trim($filecontent));
    @fclose($fp);
    echo '<script>alert("设置成功");history.back();</script>';    
  }
  
}

?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml"><head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>ShopNC App - Powered by ShopNC</title>
<script type="text/javascript" src="js/jquery_004.js"></script>
<script type="text/javascript" src="js/jquery.js"></script>
<script type="text/javascript" src="js/admincp.js"></script>
<script type="text/javascript" src="js/jquery_002.js"></script>
<script type="text/javascript" src="js/jquery_003.js"></script>
<link href="css/skin_0_500.css" rel="stylesheet" type="text/css" id="cssfile2">
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
        <li><a href="javascript:void(0);" class="current"><span>网站配置</span></a></li>
        <li><a href="content3.php"><span>首页配置</span></a></li>
        <!-- <li><a href="content4.php"><span>生活配置</span></a></li> -->
        <li><a href="content6.php"><span>其他配置</span></a></li>
        <!-- <li><a href="content5.php"><span>安卓额外</span></a></li> -->
        <li><a href="countlist.php"><span>装机数量</span></a></li>
      </ul>
    </div>
  </div>
  <div class="fixed-empty"></div>
  <form method="post" enctype="multipart/form-data" name="form1">
    <input name="form_submit" value="ok" type="hidden">
    <table class="table tb-type2">
      <tbody>
        <!-- 论坛服务器根目录 -->
        <tr class="noborder">
          <td colspan="2" class="required"><label for="discuz_dir">论坛服务器根目录:</label></td>
        </tr>
        <tr class="noborder">
          <td class="vatop rowform"><input id="discuz_dir" name="discuz_dir" value="<?php echo $discuz_dir; ?>" class="txt" type="text"></td>
          <td class="vatop tips"><span class="vatop rowform">论坛根目录，如/www/discuz（注意windows服务器和linux服务器路径不同）</span></td>
        </tr>
        <!-- 商家图片目录 -->
        <tr class="noborder">
          <td colspan="2" class="required"><label for="shop_pic_dir">商家图片上传目录:</label></td>
        </tr>
        <tr class="noborder">
          <td class="vatop rowform"><input id="shop_pic_dir" name="shop_pic_dir" value="<?php echo $shop_pic_dir; ?>" class="txt" type="text"></td>
          <td class="vatop tips"><span class="vatop rowform">商圈上传图片的目录，如/www/discuz/data/attachment/shoplist</span></td>
        </tr>
        <!-- 商家评论图片目录 -->
        <tr class="noborder">
          <td colspan="2" class="required"><label for="shop_com_pic_dir">商家评论图片上传目录:</label></td>
        </tr>
        <tr class="noborder">
          <td class="vatop rowform"><input id="shop_com_pic_dir" name="shop_com_pic_dir" value="<?php echo $shop_com_pic_dir; ?>" class="txt" type="text"></td>
          <td class="vatop tips"><span class="vatop rowform">商圈评论图片上传的目录，如/www/discuz/data/attachment/shoppics</span></td>
        </tr>
        <!-- 商家图片URL -->
        <tr class="noborder">
          <td colspan="2" class="required"><label for="shoplist_url">商家图片URL:</label></td>
        </tr>
        <tr class="noborder">
          <td class="vatop rowform"><input id="shoplist_url" name="shoplist_url" value="<?php echo $shoplist_url; ?>" class="txt" type="text"></td>
          <td class="vatop tips"><span class="vatop rowform">商圈商家图片的url根，如http://discuz.net/data/attachment/shoplist</span></td>
        </tr>   
        <!-- 商家图片评论URL -->
        <tr class="noborder">
          <td colspan="2" class="required"><label for="shoppic_url">商家图片评论URL:</label></td>
        </tr>
        <tr class="noborder">
          <td class="vatop rowform"><input id="shoppic_url" name="shoppic_url" value="<?php echo $shoppic_url; ?>" class="txt" type="text"></td>
          <td class="vatop tips"><span class="vatop rowform">商圈商家图片评论的url根，如http://discuz.net/data/attachment/shoppic_url</span></td>
        </tr>                
        <!-- 论坛根URL -->
        <tr class="noborder">
          <td colspan="2" class="required"><label for="site_url">论坛根URL:</label></td>
        </tr>
        <tr class="noborder">
          <td class="vatop rowform"><input id="site_url" name="site_url" value="<?php echo $site_url; ?>" class="txt" type="text"></td>
          <td class="vatop tips"><span class="vatop rowform">论坛网址，如http://discuz.net</span></td>
        </tr>
        <!-- 图片根URL -->
        <tr class="noborder">
          <td colspan="2" class="required"><label for="img_dir">图片根URL:</label></td>
        </tr>
        <tr class="noborder">
          <td class="vatop rowform"><input id="img_dir" name="img_dir" value="<?php echo $img_dir; ?>" class="txt" type="text"></td>
          <td class="vatop tips"><span class="vatop rowform">论坛图片URL根，如http://discuz.net/data/attachment</span></td>
        </tr>
        <!-- 远程ftp图片根URL -->
        <tr class="noborder">
          <td colspan="2" class="required"><label for="img_dir">远程ftp图片根URL:</label></td>
        </tr>
        <tr class="noborder">
          <td class="vatop rowform"><input id="ftp_img_dir" name="ftp_img_dir" value="<?php echo $ftp_img_dir; ?>" class="txt" type="text"></td>
          <td class="vatop tips"><span class="vatop rowform">论坛远程ftp图片URL根，如http://61.24.56.78</span></td>
        </tr>
        <!-- ucenter的url -->
        <tr class="noborder">
          <td colspan="2" class="required"><label for="ucenter_url">ucenter的url:</label></td>
        </tr>
        <tr class="noborder">
          <td class="vatop rowform"><input id="ucenter_url" name="ucenter_url" value="<?php echo $ucenter_url; ?>" class="txt" type="text"></td>
          <td class="vatop tips"><span class="vatop rowform">论坛ucenter URL根，如http://discuz.net/uc_server</span></td>
        </tr>
        <!-- 表情包ID -->
        <tr class="noborder">
          <td colspan="2" class="required"><label for="smiley_typeid">表情包ID:</label></td>
        </tr>
        <tr class="noborder">
          <td class="vatop rowform"><input id="smiley_typeid" name="smiley_typeid" value="<?php echo $smiley_typeid; ?>" class="txt" type="text"></td>
          <td class="vatop tips"><span class="vatop rowform">请输入数据库中表情包的id值，如1</span></td>
        </tr>
        <!-- 表情包名称 -->
        <tr class="noborder">
          <td colspan="2" class="required"><label for="smiley_name">表情包名称:</label></td>
        </tr>
        <tr class="noborder">
          <td class="vatop rowform"><input id="smiley_name" name="smiley_name" value="<?php echo $smiley_name; ?>" class="txt" type="text"></td>
          <td class="vatop tips"><span class="vatop rowform">请输入数据库中表情包的名称，如default</span></td>
        </tr>
        <!-- 区间 -->
        <!--
        <tr class="noborder">
          <td colspan="2" class="required"><label for="dbserver">数据库地址:</label></td>
        </tr>
        <tr class="noborder">
          <td class="vatop rowform"><input id="dbserver" name="dbserver" value="<?php echo $dbserver; ?>" class="txt" type="text"></td>
          <td class="vatop tips"><span class="vatop rowform"></span></td>
        </tr>
      -->
      <tr class="noborder">
          <td colspan="2" class="required"><label for="index_2_fid_order">敏感词过滤方式:</label></td>
        </tr>        
        <tr class="noborder">
          <td class="vatop rowform">
            <select name="message_filter_method" id="message_filter_method">
            <option value="0" <?php if($message_filter_method == '0'){echo 'selected="selected"';} ?>>不进行过滤</option>
            <option value="1" <?php if($message_filter_method == '1'){echo 'selected="selected"';} ?>>帖子内容中的敏感词直接替换成***</option>
            <option value="2" <?php if($message_filter_method == '2'){echo 'selected="selected"';} ?>>手机端发回帖时对用户提示</option>
            </select>
          </td>
          <td class="vatop tips">设置手机端发回贴时对于包含敏感词情况的处理方式</td>
        </tr> 
        <tr class="noborder">
          <td colspan="2" class="required"><label for="filter_words">敏感词设置:</label></td>
        </tr>
        <tr class="noborder">
          <td class="vatop rowform"><input id="filter_words" name="filter_words" value="<?php echo $filter_words; ?>" class="txt" type="text"></td>
          <td class="vatop tips"><span class="vatop rowform">多个时请以英文逗号“,”进行分割</span></td>
        </tr> 
        <tr class="noborder">
          <td colspan="2" class="required"><label for="forbidden_time">禁止发回帖时间段:</label></td>
        </tr>
        <tr class="noborder">
          <td class="vatop rowform"><input id="forbidden_time" name="forbidden_time" value="<?php echo $forbidden_time; ?>" class="txt" type="text"></td>
          <td class="vatop tips"><span class="vatop rowform">每天该时间段内用户不能发回帖,格式例如:23:25-5:05</span></td>
        </tr>
        <tr class="noborder">
          <td colspan="2" class="required"><label for="iphone_tip">iPhone端发回贴提示语:</label></td>
        </tr>
        <tr class="noborder">
          <td class="vatop rowform"><input id="iphone_tip" name="iphone_tip" value="<?php echo $iphone_tip; ?>" class="txt" type="text"></td>
          <td class="vatop tips"><span class="vatop rowform">例如：来自iPhone手机客户端</span></td>
        </tr>
        <tr class="noborder">
          <td colspan="2" class="required"><label for="android_tip">Android端发回贴提示语:</label></td>
        </tr>
        <tr class="noborder">
          <td class="vatop rowform"><input id="android_tip" name="android_tip" value="<?php echo $android_tip; ?>" class="txt" type="text"></td>
          <td class="vatop tips"><span class="vatop rowform">例如：来自Android手机客户端</span></td>
        </tr>
        <tr class="noborder">
          <td colspan="2" class="required"><label for="wp_tip">Windows Phone端发回贴提示语:</label></td>
        </tr>
        <tr class="noborder">
          <td class="vatop rowform"><input id="wp_tip" name="wp_tip" value="<?php echo $wp_tip; ?>" class="txt" type="text"></td>
          <td class="vatop tips"><span class="vatop rowform">例如：来自Windows Phone手机客户端</span></td>
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
</script>
</body></html>