<?php
require "global.inc.php";
$configfile = '../class/config.ini.php';
require_once($configfile);

if ($_POST['form_submit'] == 'ok' && is_array($_POST) && !empty($_POST)) {

  if (is_writable($configfile)) {
    //分别处理各项参数
    $dbserver = trim($_POST['dbserver']);
    $dbserver_port = trim($_POST['dbserver_port']);
    $dbname = trim($_POST['dbname']);
    $dbuser = trim($_POST['dbuser']);
    $dbpasswd = trim($_POST['dbpasswd']);
    $dbtype = trim($_POST['dbtype']);
    $dbcharset = trim($_POST['dbcharset']);
    $db_pre = trim($_POST['db_pre']);
    $uc_pre = trim($_POST['uc_pre']);

    $isucenterdb = trim($_POST['isucenterdb']);
    $ucserver = trim($_POST['ucserver']);
    $ucserver_port = trim($_POST['ucserver_port']);
    $ucname = trim($_POST['ucname']);
    $ucuser = trim($_POST['ucuser']);
    $ucpasswd = trim($_POST['ucpasswd']);
    $uctype = trim($_POST['uctype']);
    $uccharset = trim($_POST['uccharset']);


    $fp = @fopen($configfile, 'r');
    $filecontent = @fread($fp, @filesize($configfile));
    @fclose($fp);

    $filecontent = preg_replace("/[$]dbserver\s*\=\s*[\"'].*?[\"']/is", "\$dbserver = '$dbserver'", $filecontent);
    $filecontent = preg_replace("/[$]dbserver_port\s*\=\s*[\"'].*?[\"']/is", "\$dbserver_port = '$dbserver_port'", $filecontent);
    $filecontent = preg_replace("/[$]dbname\s*\=\s*[\"'].*?[\"']/is", "\$dbname = '$dbname'", $filecontent);
    $filecontent = preg_replace("/[$]dbuser\s*\=\s*[\"'].*?[\"']/is", "\$dbuser = '$dbuser'", $filecontent);
    $filecontent = preg_replace("/[$]dbpasswd\s*\=\s*[\"'].*?[\"']/is", "\$dbpasswd = '$dbpasswd'", $filecontent);
    $filecontent = preg_replace("/[$]dbtype\s*\=\s*[\"'].*?[\"']/is", "\$dbtype = '$dbtype'", $filecontent);
    $filecontent = preg_replace("/[$]dbcharset\s*\=\s*[\"'].*?[\"']/is", "\$dbcharset = '$dbcharset'", $filecontent);
    $filecontent = preg_replace("/[$]db_pre\s*\=\s*[\"'].*?[\"']/is", "\$db_pre = '$db_pre'", $filecontent);
    $filecontent = preg_replace("/[$]uc_pre\s*\=\s*[\"'].*?[\"']/is", "\$uc_pre = '$uc_pre'", $filecontent);

    $filecontent = preg_replace("/[$]isucenterdb\s*\=\s*[\"'].*?[\"']/is", "\$isucenterdb = '$isucenterdb'", $filecontent);
    $filecontent = preg_replace("/[$]ucserver\s*\=\s*[\"'].*?[\"']/is", "\$ucserver = '$ucserver'", $filecontent);
    $filecontent = preg_replace("/[$]ucserver_port\s*\=\s*[\"'].*?[\"']/is", "\$ucserver_port = '$ucserver_port'", $filecontent);
    $filecontent = preg_replace("/[$]ucname\s*\=\s*[\"'].*?[\"']/is", "\$ucname = '$ucname'", $filecontent);
    $filecontent = preg_replace("/[$]ucuser\s*\=\s*[\"'].*?[\"']/is", "\$ucuser = '$ucuser'", $filecontent);
    $filecontent = preg_replace("/[$]ucpasswd\s*\=\s*[\"'].*?[\"']/is", "\$ucpasswd = '$ucpasswd'", $filecontent);
    $filecontent = preg_replace("/[$]uctype\s*\=\s*[\"'].*?[\"']/is", "\$uctype = '$uctype'", $filecontent);
    $filecontent = preg_replace("/[$]uccharset\s*\=\s*[\"'].*?[\"']/is", "\$uccharset = '$uccharset'", $filecontent);

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
<link href="css/skin_0.css" rel="stylesheet" type="text/css" id="cssfile2">
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
        <li><a href="javascript:void(0);" class="current"><span>数据库配置</span></a></li>
        <li><a href="content2.php"><span>网站配置</span></a></li>
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
        <!-- 区间 -->
        <tr class="noborder">
          <td colspan="2" class="required"><label for="dbserver">数据库地址:</label></td>
        </tr>
        <tr class="noborder">
          <td class="vatop rowform"><input id="dbserver" name="dbserver" value="<?php echo $dbserver; ?>" class="txt" type="text"></td>
          <td class="vatop tips"><span class="vatop rowform">如 localhost</span></td>
        </tr>
        <!-- 数据库端口 -->
        <tr class="noborder">
          <td colspan="2" class="required"><label for="dbserver_port">数据库端口:</label></td>
        </tr>
        <tr class="noborder">
          <td class="vatop rowform"><input id="dbserver_port" name="dbserver_port" value="<?php echo $dbserver_port; ?>" class="txt" type="text"></td>
          <td class="vatop tips"><span class="vatop rowform">如 3306</span></td>
        </tr>
        <!-- 数据库名 -->
        <tr class="noborder">
          <td colspan="2" class="required"><label for="dbname">数据库名:</label></td>
        </tr>
        <tr class="noborder">
          <td class="vatop rowform"><input id="dbname" name="dbname" value="<?php echo $dbname; ?>" class="txt" type="text"></td>
          <td class="vatop tips"><span class="vatop rowform">如 discuzdb</span></td>
        </tr>
        <!-- 数据库帐号 -->
        <tr class="noborder">
          <td colspan="2" class="required"><label for="dbuser">数据库帐号:</label></td>
        </tr>
        <tr class="noborder">
          <td class="vatop rowform"><input id="dbuser" name="dbuser" value="<?php echo $dbuser; ?>" class="txt" type="text"></td>
          <td class="vatop tips"><span class="vatop rowform">如 admin</span></td>
        </tr>
        <!-- 数据库密码 -->
        <tr class="noborder">
          <td colspan="2" class="required"><label for="dbpasswd">数据库密码:</label></td>
        </tr>
        <tr class="noborder">
          <td class="vatop rowform"><input id="dbpasswd" name="dbpasswd" value="<?php echo $dbpasswd; ?>" class="txt" type="text"></td>
          <td class="vatop tips"><span class="vatop rowform">如 123456</span></td>
        </tr>
        <!-- 数据库连接类型 -->
        <tr class="noborder">
          <td colspan="2" class="required"><label for="dbtype">数据库连接类型:</label></td>
        </tr>
        <tr class="noborder">
          <td class="vatop rowform"><input id="dbtype" name="dbtype" value="<?php echo $dbtype; ?>" class="txt" type="text"></td>
          <td class="vatop tips"><span class="vatop rowform">可选 mysqli 或 mysql</span></td>
        </tr>
        <!-- 数据库字符集 -->
        <tr class="noborder">
          <td colspan="2" class="required"><label for="dbcharset">数据库字符集:</label></td>
        </tr>
        <tr class="noborder">
          <td class="vatop rowform"><input id="dbcharset" name="dbcharset" value="<?php echo $dbcharset; ?>" class="txt" type="text"></td>
          <td class="vatop tips"><span class="vatop rowform">可选 utf8 或 gbk</span></td>
        </tr>
        <!-- 表前缀 -->
        <tr class="noborder">
          <td colspan="2" class="required"><label for="db_pre">表前缀:</label></td>
        </tr>
        <tr class="noborder">
          <td class="vatop rowform"><input id="db_pre" name="db_pre" value="<?php echo $db_pre; ?>" class="txt" type="text"></td>
          <td class="vatop tips"><span class="vatop rowform">如 pre_</span></td>
        </tr>
        <!-- ucenter表前缀 -->
        <tr class="noborder">
          <td colspan="2" class="required"><label for="uc_pre">ucenter表前缀:</label></td>
        </tr>
        <tr class="noborder">
          <td class="vatop rowform"><input id="uc_pre" name="uc_pre" value="<?php echo $uc_pre; ?>" class="txt" type="text"></td>
          <td class="vatop tips"><span class="vatop rowform">如 pre_ucenter_ </span></td>
        </tr>
        <!-- 是否开启 -->
        <tr class="noborder">
          <td colspan="2" class="required"><label for="isucenterdb">是否ucenter为独立数据库:</label></td>
        </tr>
        <tr class="noborder">
          <td class="vatop rowform"><input id="isucenterdb" name="isucenterdb" value="<?php echo $isucenterdb; ?>" class="txt" type="text"></td>
          <td class="vatop tips"><span class="vatop rowform">是否ucenter为独立数据库，独立则填1，不独立则填0</span></td>
        </tr>   
        <!-- ucenter数据库地址 -->     
        <tr class="noborder">
          <td colspan="2" class="required"><label for="ucserver">ucenter数据库地址:</label></td>
        </tr>
        <tr class="noborder">
          <td class="vatop rowform"><input id="ucserver" name="ucserver" value="<?php echo $ucserver; ?>" class="txt" type="text"></td>
          <td class="vatop tips"><span class="vatop rowform">如 localhost</span></td>
        </tr>
        <!-- ucenter数据库端口 -->
        <tr class="noborder">
          <td colspan="2" class="required"><label for="ucserver_port">ucenter数据库端口:</label></td>
        </tr>
        <tr class="noborder">
          <td class="vatop rowform"><input id="ucserver_port" name="ucserver_port" value="<?php echo $ucserver_port; ?>" class="txt" type="text"></td>
          <td class="vatop tips"><span class="vatop rowform">如 3306</span></td>
        </tr>
        <!-- ucenter数据库名 -->
        <tr class="noborder">
          <td colspan="2" class="required"><label for="ucname">ucenter数据库名:</label></td>
        </tr>
        <tr class="noborder">
          <td class="vatop rowform"><input id="ucname" name="ucname" value="<?php echo $ucname; ?>" class="txt" type="text"></td>
          <td class="vatop tips"><span class="vatop rowform">如 discuzdb</span></td>
        </tr>
        <!-- ucenter数据库帐号 -->
        <tr class="noborder">
          <td colspan="2" class="required"><label for="ucuser">ucenter数据库帐号:</label></td>
        </tr>
        <tr class="noborder">
          <td class="vatop rowform"><input id="ucuser" name="ucuser" value="<?php echo $ucuser; ?>" class="txt" type="text"></td>
          <td class="vatop tips"><span class="vatop rowform">如 admin</span></td>
        </tr>
        <!-- ucenter数据库密码 -->
        <tr class="noborder">
          <td colspan="2" class="required"><label for="ucpasswd">ucenter数据库密码:</label></td>
        </tr>
        <tr class="noborder">
          <td class="vatop rowform"><input id="ucpasswd" name="ucpasswd" value="<?php echo $ucpasswd; ?>" class="txt" type="text"></td>
          <td class="vatop tips"><span class="vatop rowform">如 123456</span></td>
        </tr>
        <!-- ucenter数据库连接类型 -->
        <tr class="noborder">
          <td colspan="2" class="required"><label for="uctype">ucenter数据库连接类型:</label></td>
        </tr>
        <tr class="noborder">
          <td class="vatop rowform"><input id="uctype" name="uctype" value="<?php echo $uctype; ?>" class="txt" type="text"></td>
          <td class="vatop tips"><span class="vatop rowform">可选 mysqli 或 mysql</span></td>
        </tr>
        <!-- ucenter数据库字符集 -->
        <tr class="noborder">
          <td colspan="2" class="required"><label for="uccharset">ucenter数据库字符集:</label></td>
        </tr>
        <tr class="noborder">
          <td class="vatop rowform"><input id="uccharset" name="uccharset" value="<?php echo $uccharset; ?>" class="txt" type="text"></td>
          <td class="vatop tips"><span class="vatop rowform">可选 utf8 或 gbk</span></td>
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