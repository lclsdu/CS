<?php
require "global.inc.php";
require_once '../class/db.class.php';
$db    = new DB();



	//分页
	$lnum = 10;

	$sql = "SELECT com_pic_id FROM  `".DB_PRE."comment_shop_pic_app` WHERE `message` LIKE '%".$_GET['shop_name']."%'";
	//$sql = "SELECT com_pic_id FROM  `".DB_PRE."comment_shop_pic_app`";
	$data_count  = $db->fetch_all($sql);
	
	$total = count($data_count);//总数
	$num = 6;                    //每页个数
	$pagenum = ceil($total/$num); //总页数
	$cpage = !empty($_GET["page"]) ? $_GET["page"] : 1 ;      //当前页

	if($cpage > $pagenum && $pagenum > 0)
		$cpage = $pagenum;

	$url="shoppiclist.php";                  //分页的URL
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
	$sql = "SELECT *,b.shop_name FROM `".DB_PRE."comment_shop_pic_app` as a LEFT JOIN `".DB_PRE."common_shoplist` as b ON a.shop_id=b.shop_id WHERE `message` LIKE '%".$_GET['shop_name']."%' ORDER BY com_pic_id DESC limit {$offset},{$num}";
} else {
	$sql = "SELECT *,b.shop_name FROM `".DB_PRE."comment_shop_pic_app` as a LEFT JOIN `".DB_PRE."common_shoplist` as b ON a.shop_id=b.shop_id ORDER BY com_pic_id DESC limit {$offset},{$num}";	
}
$data_array  = $db->fetch_all($sql);


if ($_POST['form_submit'] == 'ok' && $_POST['submit_type'] == 'delete') {
	if (!empty($_POST['shop_id'])) {
		$str = implode($_POST['shop_id'], ',');
		$sql = "DELETE FROM `".DB_PRE."comment_shop_pic_app` WHERE `com_pic_id` IN (".$str.")";
		$result = $db->query($sql);
		if ($result) {
			echo '<script>alert("删除成功");history.back();</script>';
		} else {
			echo '<script>alert("删除失败");history.back();</script>';
		}
	}	
}


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
      <h3>商家评论</h3>
      <ul class="tab-base">
        <li><a href="shoplist.php"><span>商家管理</span></a></li>
        <li><a href="shoplist.add.php"><span>商家新增</span></a></li>
        <li><a href="shop_class.php?pid=0"><span>商家分类</span></a></li>
        <li><a href="shoppostlist.php"><span>商家评论</span></a></li>
        <li><a href="javascript:void(0);" class="current"><span>商家图片</span></a></li>
      </ul>
    </div>
  </div>
  <div class="fixed-empty"></div>
  <form method="get" name="formSearch">
  <input name="page" value="1" type="hidden" />
    <table class="tb-type1 noborder search">
      <tbody>
        <tr>
          <th><label for="search_coupon_name">留言内容</label></th>
          <td><input name="shop_name" id="search_coupon_name" class="txt" type="text"></td>
          <td><a href="javascript:document.formSearch.submit();" class="btn-search tooltip" title="">&nbsp;</a></td>
        </tr>
      </tbody>
    </table>
  </form>
  <form method="post" id="formProcess">
    <input name="form_submit" value="ok" type="hidden">
    <input id="submit_type" name="submit_type" value="" type="hidden">
  <table class="table tb-type2" id="prompt">
    <tbody>
      <tr class="space odd">
        <th colspan="12"><div class="title"><h5>操作提示</h5><span class="arrow"></span></div></th>
      </tr>
      <tr class="odd">
        <td>
        <ul>
            <li>通过搜索留言内容以快速找到评论信息，并进行相关操作。</li>
          </ul></td>
      </tr>
    </tbody>
  </table>
    <table class="table tb-type2">
      <thead>        
        <tr class="thead">
          <th></th>
          <th>商家图片</th>
          <th class="align-center" width="30%">留言内容</th>
          <th class="align-center">商家名称</th>
          <th class="align-center">留言用户名</th>
          <th class="align-center">留言ip</th>
          <th class="align-center">时间</th>
        </tr>
      </thead>
      <tbody>
      <?php if (!empty($data_array)) {?>
      <?php foreach ($data_array as $val) {?>
		<tr class="hover edit">
          <td class="w24"><input name="shop_id[]" value="<?php echo $val['com_pic_id']?>" class="checkitem" type="checkbox"></td>
          <td class="name w300"><img src="<?php echo SHOPPIC_URL.'/'.$val['shop_com_pic']; ?>" border="0" width="250" height="200"/></td>
          <td class="align-center"><?php echo $val['message']; ?></td>
          <td class="align-center"><?php echo $val['shop_name']?></td>
          <td class="align-center"><?php echo $val['author']?></td>
          <td class="nowarp align-center"><p><?php echo $val['useip']?></p></td>
          <td class="nowarp align-center"><p><?php echo date('Y-m-d H:i',$val['dateline'])?></p></td>
        </tr>
        <?php }?>
        <?php } else {?>
        <tr class="no_data">
        	<td colspan="15">没有符合条件的记录</td>
      	</tr>
        <?php }?>        
		</tbody>
      <tfoot>
                <tr>
          <td class="w24"><input class="checkall" id="checkall_1" type="checkbox"></td>
          <td colspan="16"><label for="checkall_2">全选</label>
            &nbsp;&nbsp;<a href="javascript:void(0);" class="btn" onclick="if(confirm('您确定要删除吗?')){submit_form('delete');}"><span>删除</span></a>
            
            <div class="pagination">
             <?php echo "总计<b>{$total}</b>记录,当前显示<b>{$start}-{$end}</b>条，<b>{$cpage}/{$pagenum}</b> {$first} {$prev} {$list} {$next} {$last}";?> 
             </div></td>
        </tr>
              </tfoot>
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