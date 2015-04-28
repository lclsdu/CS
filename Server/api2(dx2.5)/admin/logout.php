<?php
	require "global.inc.php";

	$username = $_COOKIE["username"];
	$sid = session_id();
	$_SESSION=array();

	if (isset($_COOKIE[session_name()])) {
		setCookie(session_name(), '', time()-3600, '/');
	}
	session_destroy();
	header("Location:login.php");
