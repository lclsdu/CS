<?php
//登陆

//过滤GET和POST，不符合要求也返回404

//http://localhost/dx2app/app2/login.php?type=onlinedo&useracc=admin&userpw=21232f297a57a5a743894a0e4a801fc3

$acc = trim($_POST['useracc']);
$pw = trim($_POST['userpw']);//md5($pw)

//
//验证表单
if($_GET['type']=='onlinedo' && !empty($acc) && !empty($pw))
{

	require_once './class/login.class.php';
	$login = new Login();
	$login->doLogin($acc,$pw);

}









