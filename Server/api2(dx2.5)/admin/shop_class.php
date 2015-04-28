<?php
require "global.inc.php";
require_once '../class/db.class.php';
$db    = new DB();




//商家分类

	if ($_GET['type']=='delete' && $_GET['cid']!='') {
		
		$sql = "DELETE FROM `".DB_PRE."shop_class_app` WHERE `cid` IN (".trim($_GET['cid']).")";		
		$result = $db->query($sql);
		$sql2 = "DELETE FROM `".DB_PRE."shop_class_app` WHERE `pid` IN (".trim($_GET['cid']).")";		
		$result2 = $db->query($sql2);
		if ($result && $result2) {
			echo '<script>alert("删除成功");history.back();</script>';
		} else {
			echo '<script>alert("删除失败");history.back();</script>';
		}		
	}	

	$pid = !empty($_GET["pid"]) ? $_GET["pid"] : 0;

	//添加新分类	
	if(isset($_POST["sub"])){
		if (empty($_POST['name'])) {
			echo "<script>alert('分类名称不能为空');history.back();</script>";
		}
				
		if($pid!=0){  
			$sql = "select path from `".DB_PRE."shop_class_app` where cid='{$pid}'";
			$line=$db->fetch_all($sql);
			$path=$line[0]['path'].'-'.$pid;  //组合 path
		}else{
			$path='0';
		}
		//判断是否是GBK编码的数据库
		if(strtoupper($dbcharset) == 'GBK'){
			$_POST['name'] = mb_convert_encoding($_POST['name'],'GBK','UTF-8');
		}
		//插入语句执行
		$insert_sql = "INSERT INTO `".DB_PRE."shop_class_app` (`name`, `pid`, `sort`, `path`) VALUES ('".$_POST['name']."', '".$pid."', '255', '".$path."')";
		$result = $db->query($insert_sql);
		if ($result) {
		  	 	echo "<script>alert('添加成功');history.back();</script>";
		  } else {
		  	 	echo "<script>alert('添加失败');history.back();</script>";
		  }
	}
	
			//设置导向
	$dh='<a href="shop_class.php?pid=0">全部分类</a>';
	if($pid!=0) {
		$sql ="select path from `".DB_PRE."shop_class_app` where cid='{$pid}'";
		$rows=$db->fetch_all($sql);		
		$sql = "select cid, name from `".DB_PRE."shop_class_app` where cid in(".str_replace("-", ",", $rows[0]['path']).",{$pid})";
		$result3=$db->fetch_all($sql);		
		//输出
	foreach ($result3 as $val){
		
			$dh .= ' > ';
			$dh .='<a href="shop_class.php?pid='.$val['cid'].'">'.$val['name'].'</a>';
		}
	}


?>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml"><head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>ShopNC商城系统演示站 - Powered by ShopNC</title>
<script type="text/javascript" src="shop_class.php_files/jquery_004.js"></script>
<script type="text/javascript" src="shop_class.php_files/jquery.js"></script>
<script type="text/javascript" src="shop_class.php_files/admincp.js"></script>
<script type="text/javascript" src="shop_class.php_files/jquery_003.js"></script>
<script type="text/javascript" src="shop_class.php_files/jquery_006.js"></script>
<link href="shop_class.php_files/skin_0.css" rel="stylesheet" type="text/css" id="cssfile2">
</head>
<body>

<div class="page">
  <div class="fixed-bar">
    <div class="item-title">
      <h3>商家分类</h3>
      <ul class="tab-base">
		<li><a href="shoplist.php"><span>商家管理</span></a></li>
        <li><a href="shoplist.add.php"><span>商家新增</span></a></li>
        <li><a href="javascript:void(0);" class="current"><span>商家分类</span></a></li>
        <li><a href="shoppostlist.php"><span>商家评论</span></a></li>
        <li><a href="shoppiclist.php"><span>商家图片</span></a></li>
      </ul>
    </div>
  </div>
  <div class="fixed-empty"></div>
  <table class="table tb-type2" id="prompt">
    <tbody>
      <tr class="space odd">
        <th class="nobg" colspan="12"><div class="title">
            <h5>操作提示</h5>
            <span class="arrow"></span></div></th>
      </tr>
      <tr class="odd">
        <td><ul>
            <li>通过分类导航来快速新增、管理分类。</li>
          </ul></td>
      </tr>
    </tbody>
  </table>
  <form method="post">
    <input name="form_submit" value="ok" type="hidden">
    <table class="table tb-type2">
      <thead>
        <tr class="thead">
        <h5> <?php echo $dh;?></h5>
          <th class="w36"></th>
          <th class="w48">排序</th>
          <th>分类名称</th>
          <th class="w96 align-center">操作</th>
        </tr>
      </thead>
      <tbody id="treet1">
      <?php 	
		$result = $db->fetch_all("select * from `".DB_PRE."shop_class_app` where pid='".$pid."' order by sort asc");
		if (!empty($result)){
		foreach ($result as $val) {
      ?>
		<tr class="hover edit">
          <td>
            </td>
          <td class="sort"><span><?php echo $val['sort']?></span></td>
          <td class="name"><span><?php if (count($result3) < 1){?><a href="shop_class.php?pid=<?php echo $val['cid'];?>"><?php }?>    <?php echo $val['name']; ?></span> <?php if (count($result3) < 1){ ?></a> <?php } ?></td>
          <td class="align-center"><a href="shop_class.add.php?shop_class_id=<?php echo $val['cid']?>">编辑</a> / <a href="javascript:if(confirm('确定删除'))window.location = 'shop_class.php?type=delete&cid=<?php echo $val['cid']?>';">删除</a>
            </td>
            </tr>
        <?php 	
		}
		}
        ?>
      
                      </tbody>
	<tfoot>
		<tr>
          <td colspan="16">	
        <?php if (count($result3) < 2){?>  
          <form action="shop_class.php?pid=<?php echo $pid  ?>" method="post">
		类名: <input type="text" value="" name="name"> 
		<input type="submit" name="sub" value="添加"><br>
		</form>
		<?php }?>
	
	</td>
        </tr>
	</tfoot>
    </table>
  </form>
</div>
<script type="text/javascript" src="shop_class.php_files/jquery_005.js" charset="utf-8"></script> 
<script type="text/javascript" src="shop_class.php_files/jquery_002.js" charset="utf-8"></script> 

</body></html>