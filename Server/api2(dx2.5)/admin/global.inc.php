<?php
	session_start();
	error_reporting(0);
	if(!$_SESSION["ShopNC_app_isLogin"] || empty($_SESSION['username']) ){
		header("Location:login.php");
	}
	
