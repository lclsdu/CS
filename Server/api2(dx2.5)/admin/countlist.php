<?php
require "global.inc.php";
require_once '../class/db.class.php';
$db    = new DB();



	//分页
	$lnum = 10;

	$sql = "SELECT vid FROM  `".DB_PRE."advice_app` WHERE `message` LIKE '%".$_GET['shop_name']."%'";
	$data_count  = $db->fetch_all($sql);
	
	$total = count($data_count);//总数
	$num = 10;                    //每页个数
	$pagenum = ceil($total/$num); //总页数
	$cpage = !empty($_GET["page"]) ? $_GET["page"] : 1 ;      //当前页

	if($cpage > $pagenum && $pagenum > 0)
		$cpage = $pagenum;

	$url="advicelist.php";                  //分页的URL
	$start = ($cpage-1)*$num+1;                        //
	$end = $pagenum==$cpage ? $total : $cpage*$num; //
	$offset = ($cpage-1)*$num;

	$first = ($cpage==1) ? "" : "<a href='{$url}?page=1&shop_name={$_GET['shop_name']}'>首页</a>";

	$last = ($cpage==$pagenum || $pagenum == 0) ? "" : "<a href='{$url}?page={$pagenum}&shop_name={$_GET['shop_name']}'>尾页</a>";

	if($cpage == 1){
		$prev="";
	}else{
		$pr=$cpage-1;
		$prev="<a href='{$url}?page={$pr}&shop_name={$_GET['shop_name']}'>上一页</a>";
	}
	
	if($cpage==$pagenum || $pagenum == 0){
		$next="";
	}else{
		$nt=$cpage+1;
		$next="<a href='{$url}?page={$nt}&shop_name={$_GET['shop_name']}'>下一页</a>";
	}
	
	$list="";
	
	if($pagenum!=1){

	$hou=floor($lnum/2);

	for($i=$hou; $i>=1; $i--){
		$page=$cpage-$i;
		if($page >= 1)
			$list.="<a href='{$url}?page={$page}&shop_name={$_GET['shop_name']}'>{$page}</a>&nbsp;";
	}

	$list.=$cpage.'&nbsp;';

	for($i=1; $i<=$hou; $i++){
		$page=$cpage+$i;
		if($page <= $pagenum)
			$list.="<a href='{$url}?page={$page}&shop_name={$_GET['shop_name']}'>{$page}</a>&nbsp;";
	}

	}

//商家信息列表

if ($_GET['shop_name'] != '') {
	$sql = "SELECT * FROM `".DB_PRE."advice_app` WHERE `message` LIKE '%".$_GET['shop_name']."%' ORDER BY vid DESC limit {$offset},{$num}";
} else {
	$sql = "SELECT * FROM `".DB_PRE."advice_app` ORDER BY vid DESC limit {$offset},{$num}";	
}
$data_array  = $db->fetch_all($sql);


if ($_POST['form_submit'] == 'ok' && $_POST['submit_type'] == 'delete') {
	if (!empty($_POST['shop_id'])) {
		$str = implode($_POST['shop_id'], ',');
		$sql = "DELETE FROM `".DB_PRE."advice_app` WHERE `vid` IN (".$str.")";
		$result = $db->query($sql);
		if ($result) {
			echo '<script>alert("删除成功");history.back();</script>';
		} else {
			echo '<script>alert("删除失败");history.back();</script>';
		}
	}	
}

  //

  $sql = "SELECT count(aid) as cnum FROM `".DB_PRE."count_install_app`";
  $count_all  = $db->fetch_all($sql);  
  $num_all = $count_all[0]['cnum'];
  $sql = "SELECT count(aid) as cnum FROM `".DB_PRE."count_install_app` WHERE `hardtype` = '1'";
  $count_iphone  = $db->fetch_all($sql);  
  $num_iphone = $count_iphone[0]['cnum'];
  $sql = "SELECT count(aid) as cnum FROM `".DB_PRE."count_install_app` WHERE `hardtype` = '2'";
  $count_android  = $db->fetch_all($sql);  
  $num_android = $count_android[0]['cnum'];



?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml"><head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>ShopNC商城系统演示站 - Powered by ShopNC</title>
<script type="text/javascript" src="js/jquery_005.js"></script>
<script type="text/javascript" src="js/jquery.js"></script>
<script type="text/javascript" src="js/admincp.js"></script>
<script type="text/javascript" src="js/jquery_002.js"></script>
<script type="text/javascript" src="js/jquery_004.js"></script>
<link href="css/skin_0.css" rel="stylesheet" type="text/css" id="cssfile2">
</head>
<body>

<div class="page">
  <div class="fixed-bar">
    <div class="item-title">
      <h3>安装数量</h3>
      <ul class="tab-base">
        <li><a href="content.php"><span>数据库配置</span></a></li>
        <li><a href="content2.php"><span>网站配置</span></a></li>
        <li><a href="content3.php"><span>首页配置</span></a></li>
        <!-- <li><a href="content4.php"><span>生活配置</span></a></li> -->
        <li><a href="content6.php"><span>其他配置</span></a></li>
        <!-- <li><a href="content5.php"><span>安卓额外</span></a></li> -->
        <li><a href="javascript:void(0);" class="current"><span>装机数量</span></a></li>        
      </ul>
    </div>
  </div>
  <div class="fixed-empty"></div>
  <!-- 
  <form method="get" name="formSearch">
  <input name="page" value="1" type="hidden" />
    <table class="tb-type1 noborder search">
      <tbody>
        <tr>
          <th><label for="search_coupon_name">信息内容</label></th>
          <td><input name="shop_name" id="search_coupon_name" class="txt" type="text"></td>
          <td><a href="javascript:document.formSearch.submit();" class="btn-search tooltip" title="">&nbsp;</a></td>
        </tr>
      </tbody>
    </table>
  </form>
-->
  <form method="post" id="formProcess">
    <input name="form_submit" value="ok" type="hidden">
    <input id="submit_type" name="submit_type" value="" type="hidden">
    <!--
  <table class="table tb-type2" id="prompt">
    <tbody>
      <tr class="space odd">
        <th colspan="12"><div class="title"><h5>操作提示</h5><span class="arrow"></span></div></th>
      </tr>
      <tr class="odd">
        <td>
        <ul>
            <li>通过搜索商家名称以快速找到商家信息，并进行相关操作。</li>
          </ul></td>
      </tr>
    </tbody>
  </table>
-->
    <table class="table tb-type2">
      <thead>        
        <tr class="thead">
          <th>总安装数量</th>
          <th class="align-center">iPhone安装量</th>
          <th class="align-center">Android安装量</th>
        </tr>
      </thead>
      <tbody>
      <?php if (!empty($num_all)) {?>
    
		<tr class="hover edit">
          <td class="name w300"><?php echo $num_all?></td>
          <td class="align-center"><?php echo $num_iphone?></td>
          <td class="align-center"><?php echo $num_android?></td>
        </tr>
        <?php } else {?>
        <tr class="no_data">
        	<td colspan="15">没有符合条件的记录</td>
      	</tr>
        <?php }?>        
		</tbody>
    <!--
      <tfoot>
                <tr>
          <td class="w24"><input class="checkall" id="checkall_1" type="checkbox"></td>
          <td colspan="16"><label for="checkall_2">全选</label>
            &nbsp;&nbsp;<a href="javascript:void(0);" class="btn" onclick="if(confirm('您确定要删除吗??')){submit_form('delete');}"><span>删除</span></a>
            
            <div class="pagination">
             <?php echo "总计<b>{$total}</b>记录,当前显示<b>{$start}-{$end}</b>条，<b>{$cpage}/{$pagenum}</b> {$first} {$prev} {$list} {$next} {$last}";?> 
             </div></td>
        </tr>
              </tfoot>
            -->
    </table>
  </form>
</div>
<script type="text/javascript" src="js/jquery_003.js" charset="utf-8"></script> 
<script type="text/javascript" src="js/zh-CN.js" charset="utf-8"></script>
<link type="text/css" rel="stylesheet" href="css/jquery.css">
<script>
$(function(){

	$('#time_from').datepicker({onSelect:function(dateText,inst){
    	var year2 = dateText.split('-') ;
    	$('#time_to').datepicker( "option", "minDate", new Date(parseInt(year2[0]),parseInt(year2[1])-1,parseInt(year2[2])) );
    }});
    $('#time_to').datepicker({onSelect:function(dateText,inst){
    	var year1 = dateText.split('-') ;
    	$('#time_from').datepicker( "option", "maxDate", new Date(parseInt(year1[0]),parseInt(year1[1])-1,parseInt(year1[2])) );
    }})
	
})

//提交方法
function submit_form(type){
	$('#submit_type').val(type);
	$('#formProcess').submit();
}

//select all
$('.checkall').click(function(){
$('.checkall').attr('checked',$(this).attr('checked'));
$('.checkitem').each(function(){
$(this).attr('checked',$('.checkall').attr('checked'));
}); 
})
</script> 
<div id="ui-datepicker-div" class="ui-datepicker ui-widget ui-widget-content ui-helper-clearfix ui-corner-all ui-helper-hidden-accessible"></div></body></html>