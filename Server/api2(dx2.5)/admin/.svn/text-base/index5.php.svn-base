<?php
require "global.inc.php";




?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml"><head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" charset="UTF-8">
<title>VeryNC App Admin - Powered by VeryNC</title>
<link href="css/skin_1.css" rel="stylesheet" type="text/css" id="cssfile">
<script type="text/javascript" src="js/jquery_003.js"></script>
<!--[if IE]>
<script src="js/html5.js"></script>
<![endif]-->
<script type="text/javascript" src="js/jquery.js"></script>
<script type="text/javascript" src="js/jquery_002.js"></script>
<script>
//
$(document).ready(function () {
    $('span.bar-btn').click(function () {
	$('ul.bar-list').toggle('fast');
    });
});

$(document).ready(function(){
	var pagestyle = function() {
		var iframe = $("#workspace");
		var h = $(window).height() - iframe.offset().top;
		var w = $(window).width() - iframe.offset().left;
		if(h < 300) h = 300;
		if(w < 973) w = 973;
		iframe.height(h);
		iframe.width(w);
	}
	pagestyle();
	$(window).resize(pagestyle);
	$('#mainMenu>ul').first().css('display','block');
	//第一次进入后台时，默认定到欢迎界面
	$('#item_welcome').addClass('selected');			
	$('#workspace').attr('src','pushinfo_list.php');

});

$(function(){
		bindAdminMenu();
		})
		function bindAdminMenu(){
		
		$("#mainMenu").find("ul").find("li").find("dl").find("dt").click(function(){
			dt = $(this);
			dd = $(this).next("dd");
			if(dd.css("display")=="none"){
				dd.slideDown("fast");
				dt.css("background-position","-322px -170px");
			}else{
				dd.slideUp("fast");
				dt.css("background-position","-483px -170px");
			}
		});
	}
</script>
<script type="text/javascript"> 
//显示灰色JS遮罩层 
function showBg(ct,content){ 
var bH=$("body").height(); 
var bW=$("body").width(); 
var objWH=getObjWh(ct); 
$("#pagemask").css({width:bW,height:bH,display:"none"}); 
var tbT=objWH.split("|")[0]+"px"; 
var tbL=objWH.split("|")[1]+"px"; 
$("#"+ct).css({top:tbT,left:tbL,display:"block"}); 
$(window).scroll(function(){resetBg()}); 
$(window).resize(function(){resetBg()}); 
} 
function getObjWh(obj){ 
var st=document.documentElement.scrollTop;//滚动条距顶部的距离 
var sl=document.documentElement.scrollLeft;//滚动条距左边的距离 
var ch=document.documentElement.clientHeight;//屏幕的高度 
var cw=document.documentElement.clientWidth;//屏幕的宽度 
var objH=$("#"+obj).height();//浮动对象的高度 
var objW=$("#"+obj).width();//浮动对象的宽度 
var objT=Number(st)+(Number(ch)-Number(objH))/2; 
var objL=Number(sl)+(Number(cw)-Number(objW))/2; 
return objT+"|"+objL; 
} 
function resetBg(){ 
var fullbg=$("#pagemask").css("display"); 
if(fullbg=="block"){ 
var bH2=$("body").height(); 
var bW2=$("body").width(); 
$("#pagemask").css({width:bW2,height:bH2}); 
var objV=getObjWh("dialog"); 
var tbT=objV.split("|")[0]+"px"; 
var tbL=objV.split("|")[1]+"px"; 
$("#dialog").css({top:tbT,left:tbL}); 
} 
} 

//关闭灰色JS遮罩层和操作窗口 
function closeBg(){ 
$("#pagemask").css("display","none"); 
$("#dialog").css("display","none"); 
} 
</script>
<script type="text/javascript"> 
$(function(){   
    var $li =$("#skin li");   
		$li.click(function(){   
		$("#"+this.id).addClass("selected").siblings().removeClass("selected");
		$("#cssfile").attr("href","css/"+ (this.id) +".css");   
        $.cookie( "MyCssSkin" ,  this.id , { path: '/', expires: 10 });  

        $('iframe').contents().find('#cssfile2').attr("href","css/"+ (this.id) +".css"); 
    });   

    var cookie_skin = $.cookie( "MyCssSkin");   
    if (cookie_skin) {   
		$("#"+cookie_skin).addClass("selected").siblings().removeClass("selected");
		$("#cssfile").attr("href","css/"+ cookie_skin +".css"); 
		$.cookie( "MyCssSkin" ,  cookie_skin  , { path: '/', expires: 10 }); 
    }   
});
</script>
</head>

<body style="margin: 0px;" scroll="no">
<div id="pagemask"></div>
<table style="width: 100%;" id="frametable" cellpadding="0" cellspacing="0" height="100%" width="100%">
  <tbody>
    <tr>
      <td colspan="2" class="mainhd" height="90"><div class="layout-header"> <!-- Title/Logo - can use text instead of image -->
          <div id="title"><a href="index.php"></a></div>
          <!-- Top navigation -->
          <div id="topnav" class="top-nav">
            <ul>
              <li class="adminid" title="您登录的身份是:admin">您登录的身份是&nbsp;:&nbsp;<strong><?php echo $_SESSION['username'];?></strong></li>
              <li><a href="logout.php" title="安全退出"><span>安全退出</span></a></li>
              <!-- <li><a href="#" target="_blank" title="商城首页"><span>商城首页</span></a></li> -->
            </ul>
          </div>
          <!-- End of Top navigation --> 
          <!-- Main navigation -->
          <nav id="nav" class="main-nav">
            <ul>
           <li><a class="link" id="nav_dashboard" href="index.php" onclick=""><span>接口</span></a></li>
            <li><a class="link" id="nav_setting" href="index2.php"><span>商圈(可选)</span></a></li>
            <li><a class="link" id="nav_setting" href="index3.php"><span>建议</span></a></li>
            <li><a class="link" id="nav_setting" href="index4.php"><span>图片新闻</span></a></li>
            <li><a class="link actived" id="nav_setting" href="index5.php"><span>推送</span></a></li>
            </ul>
          </nav>
          <div class="loca"><strong>您的位置:</strong>
            <div id="crumbs" class="crumbs"><span>推送</span><span class="arrow">&nbsp;</span><span>推送管理</span></div>
          </div>
        </div>
        <div> </div></td>
    </tr>
    <tr>
      <td class="menutd" valign="top" width="161"><div id="mainMenu" class="main-menu">
       
          <ul style="display: block;" id="sort_setting">
            <li>
              <dl>
                <dt>推送</dt>
                <dd>
                  <ol>
                    <li><a class="selected" href="javascript:void(0);" name="item_base_information" id="item_base_information" onclick="">推送管理</a></li>

                  </ol>
                </dd>
              </dl>
            </li>
          </ul>

        </div><div class="copyright">
        <p>Powered By <em><a href="http://www.verync.com/" target="_blank"><font class="blue">Very</font><font class="orange">NC</font></a><sup></sup></em></p>
        <p>©2007-2012 <a href="http://www.verync.com/" target="_blank">VeryNC Inc.</a></p></div></td>
      <td valign="top" width="100%"><iframe src="" id="workspace" name="workspace" style="overflow: visible; height: 620px; width: 1279px;" onload="window.parent" frameborder="0" height="100%" scrolling="yes" width="100%"></iframe></td>
    </tr>
  </tbody>
</table>


</body></html>