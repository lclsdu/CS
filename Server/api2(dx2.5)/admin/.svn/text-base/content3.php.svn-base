<?php
require "global.inc.php";
$configfile = '../class/config.ini.php';
require_once($configfile);

if ($_POST['form_submit'] == 'ok' && is_array($_POST) && !empty($_POST)) {

  if (is_writable($configfile)) {
    //分别处理各项参数
    $index_bigtt = trim($_POST['index_bigtt']);
    $index_smalltt = trim($_POST['index_smalltt']);
    $index_2_fid = trim($_POST['index_2_fid']);
    $index_3 = trim($_POST['index_3']);
    $index_4_fid = trim($_POST['index_4_fid']);
    $index_5_fid = trim($_POST['index_5_fid']);
    //分别处理各项排序参数
    $index_2_fid_order = trim($_POST['index_2_fid_order']);
    $index_4_fid_order = trim($_POST['index_4_fid_order']);
    $index_5_fid_order = trim($_POST['index_5_fid_order']);  
    //分别处理各项名称
    $index_bigtt_name = trim($_POST['index_bigtt_name']);
    $index_2_fid_name = trim($_POST['index_2_fid_name']);
    $index_3_name = trim($_POST['index_3_name']);
    $index_4_fid_name = trim($_POST['index_4_fid_name']);
    $index_5_fid_name = trim($_POST['index_5_fid_name']);        

    $fp = @fopen($configfile, 'r');
    $filecontent = @fread($fp, @filesize($configfile));
    @fclose($fp);

    $filecontent = preg_replace("/[$]index_bigtt\s*\=\s*[\"'].*?[\"']/is", "\$index_bigtt = '$index_bigtt'", $filecontent);
    $filecontent = preg_replace("/[$]index_smalltt\s*\=\s*[\"'].*?[\"']/is", "\$index_smalltt = '$index_smalltt'", $filecontent);
    $filecontent = preg_replace("/[$]index_2_fid\s*\=\s*[\"'].*?[\"']/is", "\$index_2_fid = '$index_2_fid'", $filecontent);
    $filecontent = preg_replace("/[$]index_3\s*\=\s*[\"'].*?[\"']/is", "\$index_3 = '$index_3'", $filecontent);
    $filecontent = preg_replace("/[$]index_4_fid\s*\=\s*[\"'].*?[\"']/is", "\$index_4_fid = '$index_4_fid'", $filecontent);
    $filecontent = preg_replace("/[$]index_5_fid\s*\=\s*[\"'].*?[\"']/is", "\$index_5_fid = '$index_5_fid'", $filecontent);

    $filecontent = preg_replace("/[$]index_2_fid_order\s*\=\s*[\"'].*?[\"']/is", "\$index_2_fid_order = '$index_2_fid_order'", $filecontent);
    $filecontent = preg_replace("/[$]index_4_fid_order\s*\=\s*[\"'].*?[\"']/is", "\$index_4_fid_order = '$index_4_fid_order'", $filecontent);
    $filecontent = preg_replace("/[$]index_5_fid_order\s*\=\s*[\"'].*?[\"']/is", "\$index_5_fid_order = '$index_5_fid_order'", $filecontent);            

    $filecontent = preg_replace("/[$]index_bigtt_name\s*\=\s*[\"'].*?[\"']/is", "\$index_bigtt_name = '$index_bigtt_name'", $filecontent);
    $filecontent = preg_replace("/[$]index_2_fid_name\s*\=\s*[\"'].*?[\"']/is", "\$index_2_fid_name = '$index_2_fid_name'", $filecontent);
    $filecontent = preg_replace("/[$]index_3_name\s*\=\s*[\"'].*?[\"']/is", "\$index_3_name = '$index_3_name'", $filecontent);
    $filecontent = preg_replace("/[$]index_4_fid_name\s*\=\s*[\"'].*?[\"']/is", "\$index_4_fid_name = '$index_4_fid_name'", $filecontent);
    $filecontent = preg_replace("/[$]index_5_fid_name\s*\=\s*[\"'].*?[\"']/is", "\$index_5_fid_name = '$index_5_fid_name'", $filecontent);    

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
        <li><a href="content.php"><span>数据库配置</span></a></li>
        <li><a href="content2.php"><span>网站配置</span></a></li>
        <li><a href="javascript:void(0);" class="current"><span>首页配置</span></a></li>
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
        <!-- 推送1 名称 -->
        <tr class="noborder">
          <td colspan="2" class="required"><label for="index_bigtt_name">推送1 名称:</label></td>
        </tr>
        <tr class="noborder">
          <td class="vatop rowform"><input id="index_bigtt_name" name="index_bigtt_name" value="<?php echo $index_bigtt_name; ?>" class="txt" type="text"></td>
          <td class="vatop tips"><span class="vatop rowform">请填入对应的论坛推送名称，例如头条</span></td>
        </tr>        
        <!-- 推送1 id -->
        <tr class="noborder">
          <td colspan="2" class="required"><label for="index_bigtt">推送1(大图) id:</label></td>
        </tr>
        <tr class="noborder">
          <td class="vatop rowform"><input id="index_bigtt" name="index_bigtt" value="<?php echo $index_bigtt; ?>" class="txt" type="text"></td>
          <td class="vatop tips"><span class="vatop rowform">请填入对应的论坛推送id，例如10（注意，不同于板块id，为推送id）</span></td>
        </tr>
        <!-- 推送1' id -->
        <tr class="noborder">
          <td colspan="2" class="required"><label for="index_smalltt">推送1'(小图) id:</label></td>
        </tr>
        <tr class="noborder">
          <td class="vatop rowform"><input id="index_smalltt" name="index_smalltt" value="<?php echo $index_smalltt; ?>" class="txt" type="text"></td>
          <td class="vatop tips"><span class="vatop rowform">请填入对应的论坛推送id，例如10（注意，不同于板块id，为推送id）</span></td>
        </tr>
        <!-- 板块2 名称 -->
        <tr class="noborder">
          <td colspan="2" class="required"><label for="index_2_fid_name">推送2 名称:</label></td>
        </tr>
        <tr class="noborder">
          <td class="vatop rowform"><input id="index_2_fid_name" name="index_2_fid_name" value="<?php echo $index_2_fid_name; ?>" class="txt" type="text"></td>
          <td class="vatop tips"><span class="vatop rowform">请填入对应的论坛推送名称</span></td>
        </tr>         
        <!-- 板块2 id -->
        <tr class="noborder">
          <td colspan="2" class="required"><label for="index_2_fid">推送2 id:</label></td>
        </tr>
        <tr class="noborder">
          <td class="vatop rowform"><input id="index_2_fid" name="index_2_fid" value="<?php echo $index_2_fid; ?>" class="txt" type="text"></td>
          <td class="vatop tips"><span class="vatop rowform">请填入对应的论坛推送id，例如52（注意，不同于板块id，为推送id）</span></td>
        </tr> 
        <!-- 板块2 排序  
        <tr class="noborder">
          <td colspan="2" class="required"><label for="index_2_fid_order">板块2 排序方式:</label></td>
        </tr>        
        <tr class="noborder">
          <td class="vatop rowform">
            <select name="index_2_fid_order" id="index_2_fid_order">
            <option value="0" <?php if($index_2_fid_order == '0'){echo 'selected="selected"';} ?>>请选择...</option>
            <option value="1" <?php if($index_2_fid_order == '1'){echo 'selected="selected"';} ?>>发帖时间</option>
            <option value="2" <?php if($index_2_fid_order == '2'){echo 'selected="selected"';} ?>>回复/查看</option>
            <option value="3" <?php if($index_2_fid_order == '3'){echo 'selected="selected"';} ?>>查看</option>
            <option value="4" <?php if($index_2_fid_order == '4'){echo 'selected="selected"';} ?>>最后发表</option>
            <option value="5" <?php if($index_2_fid_order == '5'){echo 'selected="selected"';} ?>>热门</option>
            </select>
          </td>
          <td class="vatop tips">设置板块的排序方式</td>
        </tr>        
        <!-- 推送3 名称 -->
        <tr class="noborder">
          <td colspan="2" class="required"><label for="index_3_name">推送3 名称:</label></td>
        </tr>
        <tr class="noborder">
          <td class="vatop rowform"><input id="index_3_name" name="index_3_name" value="<?php echo $index_3_name; ?>" class="txt" type="text"></td>
          <td class="vatop tips"><span class="vatop rowform">请填入对应的论坛推送名称，例如焦点</span></td>
        </tr>            
        <!-- 推送3 id -->
        <tr class="noborder">
          <td colspan="2" class="required"><label for="index_3">推送3 id:</label></td>
        </tr>
        <tr class="noborder">
          <td class="vatop rowform"><input id="index_3" name="index_3" value="<?php echo $index_3; ?>" class="txt" type="text"></td>
          <td class="vatop tips"><span class="vatop rowform">请填入对应的论坛推送id，例如10（注意，不同于板块id，为推送id）</span></td>
        </tr>  
        <!-- 板块4 名称 -->
        <tr class="noborder">
          <td colspan="2" class="required"><label for="index_4_fid_name">推送4 名称:</label></td>
        </tr>
        <tr class="noborder">
          <td class="vatop rowform"><input id="index_4_fid_name" name="index_4_fid_name" value="<?php echo $index_4_fid_name; ?>" class="txt" type="text"></td>
          <td class="vatop tips"><span class="vatop rowform">请填入对应的论坛推送名称</span></td>
        </tr>                
        <!-- 板块4 id -->
        <tr class="noborder">
          <td colspan="2" class="required"><label for="index_4_fid">推送4 id:</label></td>
        </tr>
        <tr class="noborder">
          <td class="vatop rowform"><input id="index_4_fid" name="index_4_fid" value="<?php echo $index_4_fid; ?>" class="txt" type="text"></td>
          <td class="vatop tips"><span class="vatop rowform">请填入对应的论坛推送id，例如52（注意，不同于板块id，为推送id）</span></td>
        </tr>  
        <!-- 板块4 排序
        <tr class="noborder">
          <td colspan="2" class="required"><label for="index_4_fid_order">板块4 排序方式:</label></td>
        </tr>        
        <tr class="noborder">
          <td class="vatop rowform">
            <select name="index_4_fid_order" id="index_4_fid_order">
            <option value="0" <?php if($index_4_fid_order == '0'){echo 'selected="selected"';} ?>>请选择...</option>
            <option value="1" <?php if($index_4_fid_order == '1'){echo 'selected="selected"';} ?>>发帖时间</option>
            <option value="2" <?php if($index_4_fid_order == '2'){echo 'selected="selected"';} ?>>回复/查看</option>
            <option value="3" <?php if($index_4_fid_order == '3'){echo 'selected="selected"';} ?>>查看</option>
            <option value="4" <?php if($index_4_fid_order == '4'){echo 'selected="selected"';} ?>>最后发表</option>
            <option value="5" <?php if($index_4_fid_order == '5'){echo 'selected="selected"';} ?>>热门</option>
            </select>
          </td>
          <td class="vatop tips">设置板块的排序方式</td>
        </tr>     
        <!-- 板块5 名称 -->
        <tr class="noborder">
          <td colspan="2" class="required"><label for="index_5_fid_name">推送5 名称:</label></td>
        </tr>
        <tr class="noborder">
          <td class="vatop rowform"><input id="index_5_fid_name" name="index_5_fid_name" value="<?php echo $index_5_fid_name; ?>" class="txt" type="text"></td>
          <td class="vatop tips"><span class="vatop rowform">请填入对应的论坛推送名称</span></td>
        </tr>               
        <!-- 板块5 id -->
        <tr class="noborder">
          <td colspan="2" class="required"><label for="index_5_fid">推送5 id:</label></td>
        </tr>
        <tr class="noborder">
          <td class="vatop rowform"><input id="index_5_fid" name="index_5_fid" value="<?php echo $index_5_fid; ?>" class="txt" type="text"></td>
          <td class="vatop tips"><span class="vatop rowform">请填入对应的论坛板块id，例如52（注意，不同于板块id，为推送id）</span></td>
        </tr>  
        <!-- 板块5排序
        <tr class="noborder">
          <td colspan="2" class="required"><label for="index_5_fid_order">板块5 排序方式:</label></td>
        </tr>        
        <tr class="noborder">
          <td class="vatop rowform">
            <select name="index_5_fid_order" id="index_5_fid_order">
            <option value="0" <?php if($index_5_fid_order == '0'){echo 'selected="selected"';} ?>>请选择...</option>
            <option value="1" <?php if($index_5_fid_order == '1'){echo 'selected="selected"';} ?>>发帖时间</option>
            <option value="2" <?php if($index_5_fid_order == '2'){echo 'selected="selected"';} ?>>回复/查看</option>
            <option value="3" <?php if($index_5_fid_order == '3'){echo 'selected="selected"';} ?>>查看</option>
            <option value="4" <?php if($index_5_fid_order == '4'){echo 'selected="selected"';} ?>>最后发表</option>
            <option value="5" <?php if($index_5_fid_order == '5'){echo 'selected="selected"';} ?>>热门</option>
            </select>
          </td>
          <td class="vatop tips">设置板块的排序方式</td>
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