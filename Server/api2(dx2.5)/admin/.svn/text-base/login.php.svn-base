<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml"><head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>您需要登录后才可以使用本功能 - VeryNC App Admin - Powered by VeryNC</title>
<script type="text/javascript" src="js/jquery_002.js"></script>
<script type="text/javascript" src="js/jquery.js"></script>
<script type="text/javascript" src="js/jquery_003.js"></script>
<link href="css/login.css" rel="stylesheet" type="text/css">
</head>
<body>

<div id="loginBox">
  <form method="post" id="form_login" action="logincheck.php">
    <input name="form_submit" value="ok" type="hidden">
    <div class="username">
      <h5>用户名:</h5>
      <input class="text" id="user_name" name="user_name" value="UCenterAdministrator" autocomplete="off" style="width: 300px;" type="text">
    </div>
    <div class="password">
      <h5>密　码:</h5>
      <input class="text" name="password" id="password" autocomplete="off" style="width: 300px;" type="password">
    </div>
    <div class="code">
      <h5>验证码:</h5>
      <input class="text" name="captcha" id="captcha" autocomplete="off" style="width: 120px; text-transform: uppercase;" type="text">
      <span>
        <a href="javascript:void(0);" onclick="javascript:document.getElementById('codeimage').src='./verify.php?' + Math.random();">
          <img src="verify.php" title="看不清,点击更换验证码" name="codeimage" id="codeimage" onclick="this.src='./verify.php?' + Math.random()" border="0" height="20" width="60">
        </a>
      </span>
    </div>
    <div class="button">
      <input class="btnEnter" value="" type="submit">
    </div>
    <!--
    <div class="back"><a href="#" target="_blank">返回商城首页</a></div>
    -->
  </form>
  <div class="copyright">Copyright 2007-2012 <a href="http://www.verync.com/" target="_blank">VeryNC</a>, All Rights Reserved <br>
  天津市网城创想科技有限责任公司</div>
</div>
<script>
$(document).ready(function(){
  if(top.location!=this.location) top.location=this.location;//跳出框架在主窗口登录
  $('#password').focus();
});
</script>
<iframe id="TSLOGINI" style="display: none;" src=""></iframe></body></html>