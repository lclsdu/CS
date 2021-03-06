<?php
require "global.inc.php";
$configfile = '../class/config.ini.php';
require_once($configfile);

if ($_POST['form_submit'] == 'ok' && is_array($_POST) && !empty($_POST)) {

  if (is_writable($configfile)) {
    //分别处理各项参数
    $third_1_fid = trim($_POST['third_1_fid']);
    $third_2_fid = trim($_POST['third_2_fid']);
    $third_3_fid = trim($_POST['third_3_fid']);
    $third_4_fid = trim($_POST['third_4_fid']);
    $third_5_fid = trim($_POST['third_5_fid']);
    $third_6_fid = trim($_POST['third_6_fid']);
    //分别处理各项排序参数
    $third_1_fid_order = trim($_POST['third_1_fid_order']);
    $third_2_fid_order = trim($_POST['third_2_fid_order']);
    $third_3_fid_order = trim($_POST['third_3_fid_order']);
    $third_4_fid_order = trim($_POST['third_4_fid_order']);
    $third_5_fid_order = trim($_POST['third_5_fid_order']);
    $third_6_fid_order = trim($_POST['third_6_fid_order']);
    //分别处理各项名称
    $third_1_fid_name = trim($_POST['third_1_fid_name']);
    $third_2_fid_name = trim($_POST['third_2_fid_name']);
    $third_3_fid_name = trim($_POST['third_3_fid_name']);
    $third_4_fid_name = trim($_POST['third_4_fid_name']);
    $third_5_fid_name = trim($_POST['third_5_fid_name']);
    $third_6_fid_name = trim($_POST['third_6_fid_name']);    

    $fp = @fopen($configfile, 'r');
    $filecontent = @fread($fp, @filesize($configfile));
    @fclose($fp);

    $filecontent = preg_replace("/[$]third_1_fid_name\s*\=\s*[\"'].*?[\"']/is", "\$third_1_fid_name = '$third_1_fid_name'", $filecontent);
    $filecontent = preg_replace("/[$]third_2_fid_name\s*\=\s*[\"'].*?[\"']/is", "\$third_2_fid_name = '$third_2_fid_name'", $filecontent);
    $filecontent = preg_replace("/[$]third_3_fid_name\s*\=\s*[\"'].*?[\"']/is", "\$third_3_fid_name = '$third_3_fid_name'", $filecontent);
    $filecontent = preg_replace("/[$]third_4_fid_name\s*\=\s*[\"'].*?[\"']/is", "\$third_4_fid_name = '$third_4_fid_name'", $filecontent);
    $filecontent = preg_replace("/[$]third_5_fid_name\s*\=\s*[\"'].*?[\"']/is", "\$third_5_fid_name = '$third_5_fid_name'", $filecontent);
    $filecontent = preg_replace("/[$]third_6_fid_name\s*\=\s*[\"'].*?[\"']/is", "\$third_6_fid_name = '$third_6_fid_name'", $filecontent);    

    $filecontent = preg_replace("/[$]third_1_fid\s*\=\s*[\"'].*?[\"']/is", "\$third_1_fid = '$third_1_fid'", $filecontent);
    $filecontent = preg_replace("/[$]third_2_fid\s*\=\s*[\"'].*?[\"']/is", "\$third_2_fid = '$third_2_fid'", $filecontent);
    $filecontent = preg_replace("/[$]third_3_fid\s*\=\s*[\"'].*?[\"']/is", "\$third_3_fid = '$third_3_fid'", $filecontent);
    $filecontent = preg_replace("/[$]third_4_fid\s*\=\s*[\"'].*?[\"']/is", "\$third_4_fid = '$third_4_fid'", $filecontent);
    $filecontent = preg_replace("/[$]third_5_fid\s*\=\s*[\"'].*?[\"']/is", "\$third_5_fid = '$third_5_fid'", $filecontent);
    $filecontent = preg_replace("/[$]third_6_fid\s*\=\s*[\"'].*?[\"']/is", "\$third_6_fid = '$third_6_fid'", $filecontent);

    $filecontent = preg_replace("/[$]third_1_fid_order\s*\=\s*[\"'].*?[\"']/is", "\$third_1_fid_order = '$third_1_fid_order'", $filecontent);
    $filecontent = preg_replace("/[$]third_2_fid_order\s*\=\s*[\"'].*?[\"']/is", "\$third_2_fid_order = '$third_2_fid_order'", $filecontent);
    $filecontent = preg_replace("/[$]third_3_fid_order\s*\=\s*[\"'].*?[\"']/is", "\$third_3_fid_order = '$third_3_fid_order'", $filecontent);
    $filecontent = preg_replace("/[$]third_4_fid_order\s*\=\s*[\"'].*?[\"']/is", "\$third_4_fid_order = '$third_4_fid_order'", $filecontent);
    $filecontent = preg_replace("/[$]third_5_fid_order\s*\=\s*[\"'].*?[\"']/is", "\$third_5_fid_order = '$third_5_fid_order'", $filecontent);
    $filecontent = preg_replace("/[$]third_6_fid_order\s*\=\s*[\"'].*?[\"']/is", "\$third_6_fid_order = '$third_6_fid_order'", $filecontent);    

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
        <li><a href="content3.php"><span>首页配置</span></a></li>
        <li><a href="content4.php"><span>生活配置</span></a></li>
        <li><a href="content6.php"><span>其他配置</span></a></li>
        <li><a href="javascript:void(0);" class="current"><span>安卓额外</span></a></li>
        <li><a href="countlist.php"><span>装机数量</span></a></li>
      </ul>
    </div>
  </div>
  <div class="fixed-empty"></div>
  <form method="post" enctype="multipart/form-data" name="form1">
    <input name="form_submit" value="ok" type="hidden">
    <table class="table tb-type2">
      <tbody>
        <!-- 板块1 名称 -->
        <tr class="noborder">
          <td colspan="2" class="required"><label for="third_1_fid_name">板块1 名称:</label></td>
        </tr>
        <tr class="noborder">
          <td class="vatop rowform"><input id="third_1_fid_name" name="third_1_fid_name" value="<?php echo $third_1_fid_name; ?>" class="txt" type="text"></td>
          <td class="vatop tips"><span class="vatop rowform">请填入对应的论坛板块名称，例如美食</span></td>
        </tr>        
        <!-- 板块1 id -->
        <tr class="noborder">
          <td colspan="2" class="required"><label for="third_1_fid">板块1 id:</label></td>
        </tr>
        <tr class="noborder">
          <td class="vatop rowform"><input id="third_1_fid" name="third_1_fid" value="<?php echo $third_1_fid; ?>" class="txt" type="text"></td>
          <td class="vatop tips"><span class="vatop rowform">请填入对应的论坛板块id，例如52</span></td>
        </tr>
        <!-- 板块1排序 -->  
        <tr class="noborder">
          <td colspan="2" class="required"><label for="third_1_fid_order">板块1 排序方式:</label></td>
        </tr>        
        <tr class="noborder">
          <td class="vatop rowform">
            <select name="third_1_fid_order" id="third_1_fid_order">
            <option value="0" <?php if($third_1_fid_order == '0'){echo 'selected="selected"';} ?>>请选择...</option>
            <option value="1" <?php if($third_1_fid_order == '1'){echo 'selected="selected"';} ?>>发帖时间</option>
            <option value="2" <?php if($third_1_fid_order == '2'){echo 'selected="selected"';} ?>>回复/查看</option>
            <option value="3" <?php if($third_1_fid_order == '3'){echo 'selected="selected"';} ?>>查看</option>
            <option value="4" <?php if($third_1_fid_order == '4'){echo 'selected="selected"';} ?>>最后发表</option>
            <option value="5" <?php if($third_1_fid_order == '5'){echo 'selected="selected"';} ?>>热门</option>
            </select>
          </td>
          <td class="vatop tips">设置板块的排序方式</td>
        </tr>
        <!-- 板块2 名称 -->
        <tr class="noborder">
          <td colspan="2" class="required"><label for="third_2_fid_name">板块2 名称:</label></td>
        </tr>
        <tr class="noborder">
          <td class="vatop rowform"><input id="third_2_fid_name" name="third_2_fid_name" value="<?php echo $third_2_fid_name; ?>" class="txt" type="text"></td>
          <td class="vatop tips"><span class="vatop rowform">请填入对应的论坛板块名称，例如美食</span></td>
        </tr>            
        <!-- 板块2 id -->
        <tr class="noborder">
          <td colspan="2" class="required"><label for="third_2_fid">板块2 id:</label></td>
        </tr>
        <tr class="noborder">
          <td class="vatop rowform"><input id="third_2_fid" name="third_2_fid" value="<?php echo $third_2_fid; ?>" class="txt" type="text"></td>
          <td class="vatop tips"><span class="vatop rowform">请填入对应的论坛板块id，例如52</span></td>
        </tr>  
        <!-- 板块2排序 -->  
        <tr class="noborder">
          <td colspan="2" class="required"><label for="third_2_fid_order">板块2 排序方式:</label></td>
        </tr>        
        <tr class="noborder">
          <td class="vatop rowform">
            <select name="third_2_fid_order" id="third_2_fid_order">
            <option value="0" <?php if($third_2_fid_order == '0'){echo 'selected="selected"';} ?>>请选择...</option>
            <option value="1" <?php if($third_2_fid_order == '1'){echo 'selected="selected"';} ?>>发帖时间</option>
            <option value="2" <?php if($third_2_fid_order == '2'){echo 'selected="selected"';} ?>>回复/查看</option>
            <option value="3" <?php if($third_2_fid_order == '3'){echo 'selected="selected"';} ?>>查看</option>
            <option value="4" <?php if($third_2_fid_order == '4'){echo 'selected="selected"';} ?>>最后发表</option>
            <option value="5" <?php if($third_2_fid_order == '5'){echo 'selected="selected"';} ?>>热门</option>
            </select>
          </td>
          <td class="vatop tips">设置板块的排序方式</td>
        </tr>       
        <!-- 板块3 名称 -->
        <tr class="noborder">
          <td colspan="2" class="required"><label for="third_3_fid_name">板块3 名称:</label></td>
        </tr>
        <tr class="noborder">
          <td class="vatop rowform"><input id="third_3_fid_name" name="third_3_fid_name" value="<?php echo $third_3_fid_name; ?>" class="txt" type="text"></td>
          <td class="vatop tips"><span class="vatop rowform">请填入对应的论坛板块名称，例如美食</span></td>
        </tr>              
        <!-- 板块3 id -->
        <tr class="noborder">
          <td colspan="2" class="required"><label for="third_3_fid">板块3 id:</label></td>
        </tr>
        <tr class="noborder">
          <td class="vatop rowform"><input id="third_3_fid" name="third_3_fid" value="<?php echo $third_3_fid; ?>" class="txt" type="text"></td>
          <td class="vatop tips"><span class="vatop rowform">请填入对应的论坛板块id，例如52</span></td>
        </tr>  
        <!-- 板块3排序 -->  
        <tr class="noborder">
          <td colspan="2" class="required"><label for="third_3_fid_order">板块3 排序方式:</label></td>
        </tr>        
        <tr class="noborder">
          <td class="vatop rowform">
            <select name="third_3_fid_order" id="third_3_fid_order">
            <option value="0" <?php if($third_3_fid_order == '0'){echo 'selected="selected"';} ?>>请选择...</option>
            <option value="1" <?php if($third_3_fid_order == '1'){echo 'selected="selected"';} ?>>发帖时间</option>
            <option value="2" <?php if($third_3_fid_order == '2'){echo 'selected="selected"';} ?>>回复/查看</option>
            <option value="3" <?php if($third_3_fid_order == '3'){echo 'selected="selected"';} ?>>查看</option>
            <option value="4" <?php if($third_3_fid_order == '4'){echo 'selected="selected"';} ?>>最后发表</option>
            <option value="5" <?php if($third_3_fid_order == '5'){echo 'selected="selected"';} ?>>热门</option>
            </select>
          </td>
          <td class="vatop tips">设置板块的排序方式</td>
        </tr>       
        <!-- 板块4 名称 -->
        <tr class="noborder">
          <td colspan="2" class="required"><label for="third_4_fid_name">板块4 名称:</label></td>
        </tr>
        <tr class="noborder">
          <td class="vatop rowform"><input id="third_4_fid_name" name="third_4_fid_name" value="<?php echo $third_4_fid_name; ?>" class="txt" type="text"></td>
          <td class="vatop tips"><span class="vatop rowform">请填入对应的论坛板块名称，例如美食</span></td>
        </tr>  
        <!-- 板块4 id -->
        <tr class="noborder">
          <td colspan="2" class="required"><label for="third_4_fid">板块4 id:</label></td>
        </tr>
        <tr class="noborder">
          <td class="vatop rowform"><input id="third_4_fid" name="third_4_fid" value="<?php echo $third_4_fid; ?>" class="txt" type="text"></td>
          <td class="vatop tips"><span class="vatop rowform">请填入对应的论坛板块id，例如52</span></td>
        </tr>  
        <!-- 板块4排序 -->  
        <tr class="noborder">
          <td colspan="2" class="required"><label for="third_4_fid_order">板块4 排序方式:</label></td>
        </tr>        
        <tr class="noborder">
          <td class="vatop rowform">
            <select name="third_4_fid_order" id="third_4_fid_order">
            <option value="0" <?php if($third_4_fid_order == '0'){echo 'selected="selected"';} ?>>请选择...</option>
            <option value="1" <?php if($third_4_fid_order == '1'){echo 'selected="selected"';} ?>>发帖时间</option>
            <option value="2" <?php if($third_4_fid_order == '2'){echo 'selected="selected"';} ?>>回复/查看</option>
            <option value="3" <?php if($third_4_fid_order == '3'){echo 'selected="selected"';} ?>>查看</option>
            <option value="4" <?php if($third_4_fid_order == '4'){echo 'selected="selected"';} ?>>最后发表</option>
            <option value="5" <?php if($third_4_fid_order == '5'){echo 'selected="selected"';} ?>>热门</option>
            </select>
          </td>
          <td class="vatop tips">设置板块的排序方式</td>
        </tr>     
        <!-- 板块5 名称 -->
        <tr class="noborder">
          <td colspan="2" class="required"><label for="third_5_fid_name">板块5 名称:</label></td>
        </tr>
        <tr class="noborder">
          <td class="vatop rowform"><input id="third_5_fid_name" name="third_5_fid_name" value="<?php echo $third_5_fid_name; ?>" class="txt" type="text"></td>
          <td class="vatop tips"><span class="vatop rowform">请填入对应的论坛板块名称，例如美食</span></td>
        </tr>            
        <!-- 板块5 id -->
        <tr class="noborder">
          <td colspan="2" class="required"><label for="third_5_fid">板块5 id:</label></td>
        </tr>
        <tr class="noborder">
          <td class="vatop rowform"><input id="third_5_fid" name="third_5_fid" value="<?php echo $third_5_fid; ?>" class="txt" type="text"></td>
          <td class="vatop tips"><span class="vatop rowform">请填入对应的论坛板块id，例如52</span></td>
        </tr>  
        <!-- 板块5排序 -->  
        <tr class="noborder">
          <td colspan="2" class="required"><label for="third_5_fid_order">板块5排序方式:</label></td>
        </tr>        
        <tr class="noborder">
          <td class="vatop rowform">
            <select name="third_5_fid_order" id="third_5_fid_order">
            <option value="0" <?php if($third_5_fid_order == '0'){echo 'selected="selected"';} ?>>请选择...</option>
            <option value="1" <?php if($third_5_fid_order == '1'){echo 'selected="selected"';} ?>>发帖时间</option>
            <option value="2" <?php if($third_5_fid_order == '2'){echo 'selected="selected"';} ?>>回复/查看</option>
            <option value="3" <?php if($third_5_fid_order == '3'){echo 'selected="selected"';} ?>>查看</option>
            <option value="4" <?php if($third_5_fid_order == '4'){echo 'selected="selected"';} ?>>最后发表</option>
            <option value="5" <?php if($third_5_fid_order == '5'){echo 'selected="selected"';} ?>>热门</option>
            </select>
          </td>
          <td class="vatop tips">设置板块的排序方式</td>
        </tr>      
        <!-- 板块6 名称 -->
        <tr class="noborder">
          <td colspan="2" class="required"><label for="third_6_fid_name">板块6 名称:</label></td>
        </tr>
        <tr class="noborder">
          <td class="vatop rowform"><input id="third_6_fid_name" name="third_6_fid_name" value="<?php echo $third_6_fid_name; ?>" class="txt" type="text"></td>
          <td class="vatop tips"><span class="vatop rowform">请填入对应的论坛板块名称，例如美食</span></td>
        </tr>            
        <!-- 板块6 id -->
        <tr class="noborder">
          <td colspan="2" class="required"><label for="third_6_fid">板块6 id:</label></td>
        </tr>
        <tr class="noborder">
          <td class="vatop rowform"><input id="third_6_fid" name="third_6_fid" value="<?php echo $third_6_fid; ?>" class="txt" type="text"></td>
          <td class="vatop tips"><span class="vatop rowform">请填入对应的论坛板块id，例如52</span></td>
        </tr>         
        <!-- 板块6排序 -->  
        <tr class="noborder">
          <td colspan="2" class="required"><label for="third_6_fid_order">板块6 排序方式:</label></td>
        </tr>        
        <tr class="noborder">
          <td class="vatop rowform">
            <select name="third_6_fid_order" id="third_6_fid_order">
            <option value="0" <?php if($third_6_fid_order == '0'){echo 'selected="selected"';} ?>>请选择...</option>
            <option value="1" <?php if($third_6_fid_order == '1'){echo 'selected="selected"';} ?>>发帖时间</option>
            <option value="2" <?php if($third_6_fid_order == '2'){echo 'selected="selected"';} ?>>回复/查看</option>
            <option value="3" <?php if($third_6_fid_order == '3'){echo 'selected="selected"';} ?>>查看</option>
            <option value="4" <?php if($third_6_fid_order == '4'){echo 'selected="selected"';} ?>>最后发表</option>
            <option value="5" <?php if($third_6_fid_order == '5'){echo 'selected="selected"';} ?>>热门</option>
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